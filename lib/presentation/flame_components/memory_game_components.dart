// lib/presentation/flame_components/memory_game_components.dart
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../../data/models/game_models.dart';
import '../../core/theme/app_theme.dart';

// ===== BASE GAME COMPONENT =====
abstract class BaseGameComponent extends RectangleComponent 
    with HasGameRef, TapCallbacks {
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await setupComponent();
  }

  Future<void> setupComponent();
  void onGameEvent(String event, Map<String, dynamic> data);
}

class RoundedRectComponent extends RectangleComponent {
  final double radius;
  
  RoundedRectComponent({
    required Vector2 size,
    required this.radius,
    Paint? paint,
  }) : super(size: size, paint: paint);
  
  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, paint);
  }
}

// ===== MEMORY CARD COMPONENT =====
class MemoryCardComponent extends BaseGameComponent {
  final MemoryCard cardData;
  final ColorPalette colorPalette;
  final VoidCallback? onTap;
  final double cardWidth;
  final double cardHeight;
  
  late RectangleComponent _frontCard;
  late RectangleComponent _backCard;
  late TextComponent _emojiText;
  late bool _isAnimating;

  MemoryCardComponent({
    required this.cardData,
    required this.colorPalette,
    required this.cardWidth,
    required this.cardHeight,
    this.onTap,
  }) : _isAnimating = false;

  @override
  Future<void> setupComponent() async {
    size = Vector2(cardWidth, cardHeight);
    
    // Configurar carta trasera (oculta)
    // ✅ Usar RoundedRectangleComponent:
    _backCard = RoundedRectComponent(
      size: size,
      radius: size.x * 0.1,  // Bordes redondeados
      paint: Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(size.x, size.y),
          [
            AppTheme.parseColor(colorPalette.primary),
            AppTheme.parseColor(colorPalette.secondary),
          ],
        ),
    );

    
    // Configurar carta frontal (revelada)
    _frontCard = RoundedRectComponent(
      size: size,
      radius: size.x * 0.1,  // Bordes redondeados
      paint: Paint()..color = AppTheme.parseColor(colorPalette.surface),
    );
    
    // Configurar texto del emoji
    _emojiText = TextComponent(
      text: cardData.emoji,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: cardWidth * 0.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    _emojiText.anchor = Anchor.center;
    _emojiText.position = size / 2;
    
    // ✅ Para sombras, usar efectos:
    _frontCard.add(ScaleEffect.to(
      Vector2.all(1.0),
      EffectController(duration: 0),
    ));
    
    // Estado inicial
    _updateCardState();
    
    add(_backCard);
    add(_frontCard);
    _frontCard.add(_emojiText);
  }

  void _updateCardState() {
    if (cardData.isFlipped || cardData.isMatched) {
      _frontCard.opacity = 1.0;
      _backCard.opacity = 0.0;
    } else {
      _frontCard.opacity = 0.0;
      _backCard.opacity = 1.0;
    }
    
    // Efecto especial para cartas emparejadas
    if (cardData.isMatched) {
      _frontCard.paint.color = AppTheme.parseColor(colorPalette.accent);
      _addMatchEffect();
    }
  }

  void _addMatchEffect() {
    // Efecto de brillo para cartas emparejadas
    final glowEffect = ColorEffect(
      Colors.white.withOpacity(0.3),
      EffectController(
        duration: 0.5,
        curve: Curves.easeInOut,
        infinite: true,
        alternate: true,
      ),
    );
    _frontCard.add(glowEffect);
    
    // Partículas de celebración
    _addCelebrationParticles();
  }

  void _addCelebrationParticles() {
    final particleSystem = ParticleSystemComponent(
      particle: Particle.generate(
        count: 20,
        lifespan: 2.0,
        generator: (i) => AcceleratedParticle(
          acceleration: Vector2(0, 50),
          child: CircleParticle(
            radius: 2.0,
            paint: Paint()..color = AppTheme.parseColor(colorPalette.accent),
          ),
          speed: Vector2.random() * 100,
        ),
      ),
    );
    particleSystem.position = size / 2;
    add(particleSystem);
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (_isAnimating || cardData.isMatched) return false;
    
    _playFlipSound();
    _animateFlip();
    onTap?.call();
    
    return true;
  }

  void _animateFlip() {
    if (_isAnimating) return;
    
    _isAnimating = true;
    
    // Animación de volteo 3D
    final scaleDown = ScaleEffect.to(
      Vector2(0.0, 1.0),
      EffectController(duration: 0.15, curve: Curves.easeIn),
    );
    
    scaleDown.onComplete = () {
      _updateCardState();
      
      final scaleUp = ScaleEffect.to(
        Vector2(1.0, 1.0),
        EffectController(duration: 0.15, curve: Curves.easeOut),
      );
      
      scaleUp.onComplete = () {
        _isAnimating = false;
      };
      
      add(scaleUp);
    };
    
    add(scaleDown);
    
    // Efecto de elevación durante el volteo
    final elevateEffect = MoveEffect.by(
      Vector2(0, -5),
      EffectController(
        duration: 0.3,
        curve: Curves.easeInOut,
        alternate: true,
      ),
    );
    add(elevateEffect);
  }

  void _playFlipSound() {
    try {
      FlameAudio.play('flip.wav', volume: 0.3);
    } catch (e) {
      // Fallback con sonido sintético
      _playSyntheticSound('flip');
    }
  }

  void _playSyntheticSound(String type) {
    // Aquí se podría implementar generación de sonido sintético
    // usando el sistema de audio del dispositivo
  }

  void updateCard(MemoryCard newCardData) {
    final oldData = cardData;
    // Note: En una implementación real, necesitarías actualizar cardData
    // pero como es final, necesitarías recrear el componente o usar un enfoque diferente
    
    if (oldData.isFlipped != newCardData.isFlipped ||
        oldData.isMatched != newCardData.isMatched) {
      _updateCardState();
    }
  }

  @override
  void onGameEvent(String event, Map<String, dynamic> data) {
    switch (event) {
      case 'card_match':
        if (data['cardId'] == cardData.id) {
          _addMatchEffect();
        }
        break;
      case 'card_mismatch':
        if (data['cardId'] == cardData.id) {
          _addShakeEffect();
        }
        break;
    }
  }

  void _addShakeEffect() {
    final shakeEffect = MoveEffect.by(
      Vector2(5, 0),
      EffectController(
        duration: 0.1,
        curve: Curves.easeInOut,
        alternate: true,
        repeatCount: 3,
      ),
    );
    add(shakeEffect);
  }
}

// ===== GAME TIMER COMPONENT =====
class GameTimerComponent extends TextComponent with HasGameRef {
  int _timeElapsed = 0;
  late TimerComponent _timer;
  final ColorPalette colorPalette;
  final Function(int)? onTimeUpdate;

  GameTimerComponent({
    required this.colorPalette,
    this.onTimeUpdate,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppTheme.parseColor(colorPalette.primary),
        fontFamily: 'GameFont',
      ),
    );
    
    _updateTimerDisplay();
    
    // ✅ Usar TimerComponent:
    _timer = TimerComponent(
      period: 1.0,
      repeat: true,
      onTick: () {
        _timeElapsed++;
        _updateTimerDisplay();
        onTimeUpdate?.call(_timeElapsed);
      },
    );
    
    add(_timer);
  }

  void _updateTimerDisplay() {
    final minutes = _timeElapsed ~/ 60;
    final seconds = _timeElapsed % 60;
    text = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void pauseTimer() {
    _timer.timer.stop();
  }

  void resumeTimer() {
    _timer.timer.start();
  }

  void resetTimer() {
    _timeElapsed = 0;
    _updateTimerDisplay();
    _timer.timer.stop();
    _timer.timer.start();
  }

  int get timeElapsed => _timeElapsed;
}

// ===== SCORE DISPLAY COMPONENT =====
class ScoreDisplayComponent extends TextComponent with HasGameRef {
  int _score = 0;
  final ColorPalette colorPalette;

  ScoreDisplayComponent({required this.colorPalette});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    textRenderer = TextPaint(
      style: AppTheme.createScoreTextStyle(colorPalette),
    );
    
    _updateScoreDisplay();
  }

  void updateScore(int newScore) {
    if (newScore != _score) {
      final oldScore = _score;
      _score = newScore;
      _updateScoreDisplay();
      
      if (newScore > oldScore) {
        _animateScoreIncrease();
      }
    }
  }

  void _updateScoreDisplay() {
    text = 'Puntuación: $_score';
  }

  void _animateScoreIncrease() {
    // Efecto de escala para mostrar incremento
    final scaleEffect = ScaleEffect.to(
      Vector2.all(1.2),
      EffectController(
        duration: 0.2,
        curve: Curves.easeOut,
        alternate: true,
      ),
    );
    add(scaleEffect);
    
    // Efecto de color
    final colorEffect = ColorEffect(
      AppTheme.parseColor(colorPalette.accent),
      EffectController(
        duration: 0.3,
        curve: Curves.easeInOut,
        alternate: true,
      ),
    );
    add(colorEffect);
  }
}

// ===== MOVES COUNTER COMPONENT =====
class MovesCounterComponent extends TextComponent with HasGameRef {
  int _moves = 0;
  final ColorPalette colorPalette;

  MovesCounterComponent({required this.colorPalette});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.parseColor(colorPalette.primary),
        fontFamily: 'GameFont',
      ),
    );
    
    _updateMovesDisplay();
  }

  void incrementMoves() {
    _moves++;
    _updateMovesDisplay();
    _animateMoveIncrement();
  }

  void resetMoves() {
    _moves = 0;
    _updateMovesDisplay();
  }

  void _updateMovesDisplay() {
    text = 'Movimientos: $_moves';
  }

  void _animateMoveIncrement() {
    final bounceEffect = ScaleEffect.to(
      Vector2.all(1.1),
      EffectController(
        duration: 0.15,
        curve: Curves.elasticOut,
        alternate: true,
      ),
    );
    add(bounceEffect);
  }

  int get moves => _moves;
}

// ===== COMPLETION CELEBRATION COMPONENT =====
class CompletionCelebrationComponent extends Component with HasGameRef {
  final ColorPalette colorPalette;
  final Vector2 gameSize;

  CompletionCelebrationComponent({
    required this.colorPalette,
    required this.gameSize,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _startCelebration();
  }

  void _startCelebration() {
    // Confetti desde múltiples puntos
    for (int i = 0; i < 5; i++) {
      final confettiSystem = ParticleSystemComponent(
        particle: Particle.generate(
          count: 50,
          lifespan: 3.0,
          generator: (i) => AcceleratedParticle(
            acceleration: Vector2(0, 100),
            child: CircleParticle(
              paint: Paint()..color = _getRandomCelebrationColor(),
            ),
            speed: Vector2(
              (Random().nextDouble() - 0.5) * 200,
              -Random().nextDouble() * 300 - 100,
            ),
          ),
        ),
      );
      
      confettiSystem.position = Vector2(
        gameSize.x * (i / 4),
        0,
      );
      
      add(confettiSystem);
    }
    
    // Fuegos artificiales centrales
    _addFireworks();
    
    // Remover automáticamente después de la animación
    Future.delayed(const Duration(seconds: 3), () {
      removeFromParent();
    });
  }

  void _addFireworks() {
    final fireworksSystem = ParticleSystemComponent(
      particle: Particle.generate(
        count: 100,
        lifespan: 2.0,
        generator: (i) => AcceleratedParticle(
          acceleration: Vector2(0, 50),
          child: CircleParticle(
            radius: 3.0,
            paint: Paint()..color = _getRandomCelebrationColor(),
          ),
          speed: Vector2.random() * 300,
        ),
      ),
    );
    
    fireworksSystem.position = gameSize / 2;
    add(fireworksSystem);
  }

  Color _getRandomCelebrationColor() {
    final colors = [
      AppTheme.parseColor(colorPalette.primary),
      AppTheme.parseColor(colorPalette.secondary),
      AppTheme.parseColor(colorPalette.accent),
      Colors.amber,
      Colors.white,
    ];
    return colors[Random().nextInt(colors.length)];
  }
}

// ===== HINT SYSTEM COMPONENT =====
class HintSystemComponent extends RectangleComponent with HasGameRef, TapCallbacks {
  final ColorPalette colorPalette;
  final Function()? onHintRequested;
  
  late TextComponent _hintText;
  bool _isVisible = false;

  HintSystemComponent({
    required this.colorPalette,
    this.onHintRequested,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = Vector2(120, 40);
    paint = Paint()
      ..color = AppTheme.parseColor(colorPalette.secondary).withOpacity(0.8);
    
    //decorator.addLast(PaintDecorator.roundRectangle(size.y / 2));
    
    _hintText = TextComponent(
      text: '💡 Pista',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppTheme.parseColor(colorPalette.onSecondary),
        ),
      ),
    );
    _hintText.anchor = Anchor.center;
    _hintText.position = size / 2;
    
    add(_hintText);
    
    opacity = 0.0;
  }

  void showHint() {
    if (!_isVisible) {
      _isVisible = true;
      final fadeIn = OpacityEffect.to(
        1.0,
        EffectController(duration: 0.3, curve: Curves.easeIn),
      );
      add(fadeIn);
    }
  }

  void hideHint() {
    if (_isVisible) {
      _isVisible = false;
      final fadeOut = OpacityEffect.to(
        0.0,
        EffectController(duration: 0.3, curve: Curves.easeOut),
      );
      add(fadeOut);
    }
  }

  @override
  bool onTapDown(TapDownEvent event) {
    if (_isVisible) {
      onHintRequested?.call();
      _animateTap();
      return true;
    }
    return false;
  }

  void _animateTap() {
    final scaleEffect = ScaleEffect.to(
      Vector2.all(0.9),
      EffectController(
        duration: 0.1,
        curve: Curves.easeInOut,
        alternate: true,
      ),
    );
    add(scaleEffect);
  }
}

// ===== PAUSE OVERLAY COMPONENT =====
class PauseOverlayComponent extends RectangleComponent with HasGameRef {
  final ColorPalette colorPalette;
  final VoidCallback? onResume;
  
  late TextComponent _pauseText;
  late RectangleComponent _resumeButton;

  PauseOverlayComponent({
    required this.colorPalette,
    this.onResume,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    size = gameRef.size;
    paint = Paint()..color = Colors.black.withOpacity(0.7);
    
    // Texto de pausa
    _pauseText = TextComponent(
      text: '⏸️ PAUSADO',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'GameFont',
        ),
      ),
    );
    _pauseText.anchor = Anchor.center;
    _pauseText.position = size / 2 - Vector2(0, 40);
    
    // Botón de reanudar
    _resumeButton = RoundedRectComponent(
      size: Vector2(200, 60),
      radius: 30.0,
      paint: Paint()
        ..shader = ui.Gradient.linear(
          Offset.zero,
          const Offset(200, 60),
          [
            AppTheme.parseColor(colorPalette.primary),
            AppTheme.parseColor(colorPalette.secondary),
          ],
        ),
    );
    _resumeButton.anchor = Anchor.center;
    _resumeButton.position = size / 2 + Vector2(0, 40);
    
    final resumeText = TextComponent(
      text: '▶️ Continuar',
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
    resumeText.anchor = Anchor.center;
    resumeText.position = _resumeButton.size / 2;
    
    _resumeButton.add(resumeText);
    
    add(_pauseText);
    add(_resumeButton);
  }
}