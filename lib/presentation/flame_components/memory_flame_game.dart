// lib/presentation/flame_components/memory_flame_game.dart
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';
import 'memory_game_components.dart';

class MemoryFlameGame extends FlameGame 
    with HasKeyboardHandlerComponents {
  
  // ===== GAME STATE =====
  late DifficultyLevel difficulty;
  late ColorPalette colorPalette;
  late MemoryGameConfig config;
  late List<MemoryCard> cards;
  late List<MemoryCardComponent> cardComponents;
  
  // ===== GAME LOGIC =====
  List<String> flippedCards = [];
  List<String> matchedPairs = [];
  int moves = 0;
  int timeElapsed = 0;
  bool isGameStarted = false;
  bool isGameCompleted = false;
  bool isGamePaused = false;
  
  // ===== UI COMPONENTS =====
  late GameTimerComponent timerComponent;
  late ScoreDisplayComponent scoreComponent;
  late MovesCounterComponent movesComponent;
  late HintSystemComponent hintComponent;
  PauseOverlayComponent? pauseOverlay;
  
  // ===== CALLBACKS =====
  Function(MemoryGameScore)? onGameCompleted;
  Function(int moves, int time)? onGameStateChanged;
  VoidCallback? onGamePaused;
  VoidCallback? onGameResumed;
  
  // ===== LAYOUT =====
  late double cardWidth;
  late double cardHeight;
  late double gridStartX;
  late double gridStartY;
  late double cardSpacing;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _initializeGame();
  }

  // ===== INITIALIZATION =====
  Future<void> _initializeGame() async {
    // Configurar layout responsivo
    _calculateLayout();
    
    // Crear componentes UI
    await _createUIComponents();
    
    // Generar y mezclar cartas
    _generateCards();
    
    // Crear componentes de cartas
    await _createCardComponents();
    
    // Mostrar preview inicial
    _showInitialPreview();
  }

  void _calculateLayout() {
    final gameWidth = size.x;
    final gameHeight = size.y;
    
    // Reservar espacio para UI superior
    const uiHeight = 120.0;
    final availableHeight = gameHeight - uiHeight;
    
    // Calcular dimensiones de carta basado en grid
    final cols = config.cols;
    final rows = config.rows;
    
    cardSpacing = 8.0;
    
    // Calcular tamaño máximo de carta que cabe en pantalla
    final maxCardWidth = (gameWidth - (cols + 1) * cardSpacing) / cols;
    final maxCardHeight = (availableHeight - (rows + 1) * cardSpacing) / rows;
    
    // Usar el menor para mantener aspecto cuadrado
    final cardSize = min(maxCardWidth, maxCardHeight) * 0.9;
    cardWidth = cardSize;
    cardHeight = cardSize;
    
    // Centrar grid
    final gridWidth = cols * cardWidth + (cols - 1) * cardSpacing;
    final gridHeight = rows * cardHeight + (rows - 1) * cardSpacing;
    
    gridStartX = (gameWidth - gridWidth) / 2;
    gridStartY = uiHeight + (availableHeight - gridHeight) / 2;
  }

  Future<void> _createUIComponents() async {
    // Timer
    timerComponent = GameTimerComponent(
      colorPalette: colorPalette,
      onTimeUpdate: (time) {
        timeElapsed = time;
        onGameStateChanged?.call(moves, timeElapsed);
      },
    );
    timerComponent.position = Vector2(20, 20);
    add(timerComponent);
    
    // Score (si es necesario para el futuro)
    scoreComponent = ScoreDisplayComponent(colorPalette: colorPalette);
    scoreComponent.position = Vector2(size.x / 2, 20);
    scoreComponent.anchor = Anchor.topCenter;
    add(scoreComponent);
    
    // Moves counter
    movesComponent = MovesCounterComponent(colorPalette: colorPalette);
    movesComponent.position = Vector2(size.x - 20, 20);
    movesComponent.anchor = Anchor.topRight;
    add(movesComponent);
    
    // Hint system
    hintComponent = HintSystemComponent(
      colorPalette: colorPalette,
      onHintRequested: _showHint,
    );
    hintComponent.position = Vector2(size.x - 140, 70);
    add(hintComponent);
  }

  void _generateCards() {
    final emojis = DefaultData.defaultEmojis.take(config.totalPairs).toList();
    cards = [];
    
    // Crear pares de cartas
    for (int i = 0; i < emojis.length; i++) {
      final emoji = emojis[i];
      cards.add(MemoryCard(
        id: '${i}_1',
        imageUrl: '',
        emoji: emoji,
      ));
      cards.add(MemoryCard(
        id: '${i}_2', 
        imageUrl: '',
        emoji: emoji,
      ));
    }
    
    // Mezclar cartas
    cards.shuffle(Random());
  }

  Future<void> _createCardComponents() async {
    cardComponents = [];
    
    for (int i = 0; i < cards.length; i++) {
      final row = i ~/ config.cols;
      final col = i % config.cols;
      
      final cardComponent = MemoryCardComponent(
        cardData: cards[i],
        colorPalette: colorPalette,
        cardWidth: cardWidth,
        cardHeight: cardHeight,
        onTap: () => _onCardTapped(cards[i].id),
      );
      
      cardComponent.position = Vector2(
        gridStartX + col * (cardWidth + cardSpacing),
        gridStartY + row * (cardHeight + cardSpacing),
      );
      
      cardComponents.add(cardComponent);
      add(cardComponent);
    }
  }

  void _showInitialPreview() {
    // Mostrar todas las cartas por 3 segundos
    for (final card in cardComponents) {
      // Temporalmente mostrar todas las cartas
      final tempCard = cards.firstWhere((c) => c.id == card.cardData.id);
      final previewCard = tempCard.copyWith(isFlipped: true);
      card.updateCard(previewCard);
    }
    
    // Ocultar después de 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      for (int i = 0; i < cards.length; i++) {
        final hiddenCard = cards[i].copyWith(isFlipped: false);
        cards[i] = hiddenCard;
        cardComponents[i].updateCard(hiddenCard);
      }
      _startGame();
    });
  }

  // ===== GAME LOGIC =====
  void _startGame() {
    isGameStarted = true;
    timerComponent.resetTimer();
    
    // Mostrar hint después de 30 segundos
    Future.delayed(const Duration(seconds: 30), () {
      if (!isGameCompleted && !isGamePaused) {
        hintComponent.showHint();
      }
    });
  }

  void _onCardTapped(String cardId) {
    if (!isGameStarted || isGamePaused || isGameCompleted) return;
    
    final cardIndex = cards.indexWhere((c) => c.id == cardId);
    if (cardIndex == -1) return;
    
    final card = cards[cardIndex];
    if (card.isFlipped || card.isMatched || flippedCards.length >= 2) return;
    
    // Voltear carta
    cards[cardIndex] = card.copyWith(isFlipped: true);
    cardComponents[cardIndex].updateCard(cards[cardIndex]);
    flippedCards.add(cardId);
    
    _playSound('flip');
    
    if (flippedCards.length == 2) {
      moves++;
      movesComponent.incrementMoves();
      onGameStateChanged?.call(moves, timeElapsed);
      
      // Verificar match después de un breve delay
      Future.delayed(const Duration(milliseconds: 500), () {
        _checkMatch();
      });
    }
  }

  void _checkMatch() {
    if (flippedCards.length != 2) return;
    
    final card1Index = cards.indexWhere((c) => c.id == flippedCards[0]);
    final card2Index = cards.indexWhere((c) => c.id == flippedCards[1]);
    
    final card1 = cards[card1Index];
    final card2 = cards[card2Index];
    
    if (card1.emoji == card2.emoji) {
      // Match encontrado
      cards[card1Index] = card1.copyWith(isMatched: true);
      cards[card2Index] = card2.copyWith(isMatched: true);
      
      cardComponents[card1Index].updateCard(cards[card1Index]);
      cardComponents[card2Index].updateCard(cards[card2Index]);
      
      matchedPairs.add(card1.emoji);
      flippedCards.clear();
      
      _playSound('match');
      
      // Notificar componentes sobre el match
      for (final component in cardComponents) {
        component.onGameEvent('card_match', {'cardId': card1.id});
        component.onGameEvent('card_match', {'cardId': card2.id});
      }
      
      // Verificar si el juego terminó
      if (matchedPairs.length >= config.totalPairs) {
        _completeGame();
      }
    } else {
      // No match - voltear de vuelta
      _playSound('mismatch');
      
      Future.delayed(const Duration(milliseconds: 1500), () {
        cards[card1Index] = card1.copyWith(isFlipped: false);
        cards[card2Index] = card2.copyWith(isFlipped: false);
        
        cardComponents[card1Index].updateCard(cards[card1Index]);
        cardComponents[card2Index].updateCard(cards[card2Index]);
        
        flippedCards.clear();
        
        // Notificar componentes sobre mismatch
        for (final component in cardComponents) {
          component.onGameEvent('card_mismatch', {'cardId': card1.id});
          component.onGameEvent('card_mismatch', {'cardId': card2.id});
        }
      });
    }
  }

  void _completeGame() {
    isGameCompleted = true;
    timerComponent.pauseTimer();
    
    _playSound('completion');
    
    // Añadir celebración
    final celebration = CompletionCelebrationComponent(
      colorPalette: colorPalette,
      gameSize: size,
    );
    add(celebration);
    
    // Calcular puntuación
    final stars = _calculateStars();
    final score = MemoryGameScore(
      level: difficulty,
      moves: moves,
      time: Duration(seconds: timeElapsed),
      timestamp: DateTime.now(),
      stars: stars,
    );
    
    // Notificar completación
    Future.delayed(const Duration(seconds: 2), () {
      onGameCompleted?.call(score);
    });
  }

  int _calculateStars() {
    final optimalMoves = config.totalPairs;
    final efficiency = optimalMoves / moves;
    
    if (efficiency >= 0.9) return 3;
    if (efficiency >= 0.7) return 2;
    return 1;
  }

  void _showHint() {
    if (flippedCards.isNotEmpty || isGameCompleted) return;
    
    // Mostrar brevemente dos cartas que hacen match
    final unmatched = cards.where((c) => !c.isMatched).toList();
    if (unmatched.length >= 2) {
      // Encontrar dos cartas con el mismo emoji
      for (int i = 0; i < unmatched.length; i++) {
        for (int j = i + 1; j < unmatched.length; j++) {
          if (unmatched[i].emoji == unmatched[j].emoji) {
            _showHintCards([unmatched[i].id, unmatched[j].id]);
            return;
          }
        }
      }
    }
  }

  void _showHintCards(List<String> cardIds) {
    // Mostrar cartas por 1 segundo
    for (final cardId in cardIds) {
      final cardIndex = cards.indexWhere((c) => c.id == cardId);
      if (cardIndex != -1) {
        final hintCard = cards[cardIndex].copyWith(isFlipped: true);
        cardComponents[cardIndex].updateCard(hintCard);
      }
    }
    
    // Ocultar después de 1 segundo
    Future.delayed(const Duration(seconds: 1), () {
      for (final cardId in cardIds) {
        final cardIndex = cards.indexWhere((c) => c.id == cardId);
        if (cardIndex != -1 && !cards[cardIndex].isMatched) {
          final hiddenCard = cards[cardIndex].copyWith(isFlipped: false);
          cardComponents[cardIndex].updateCard(hiddenCard);
        }
      }
    });
    
    hintComponent.hideHint();
  }

  // ===== GAME CONTROL =====
  void pauseGame() {
    if (!isGameStarted || isGameCompleted || isGamePaused) return;
    
    isGamePaused = true;
    timerComponent.pauseTimer();
    
    pauseOverlay = PauseOverlayComponent(
      colorPalette: colorPalette,
      onResume: resumeGame,
    );
    add(pauseOverlay!);
    
    onGamePaused?.call();
  }

  void resumeGame() {
    if (!isGamePaused) return;
    
    isGamePaused = false;
    timerComponent.resumeTimer();
    
    if (pauseOverlay != null) {
      pauseOverlay!.removeFromParent();
      pauseOverlay = null;
    }
    
    onGameResumed?.call();
  }

  void resetGame() {
    // Limpiar estado
    flippedCards.clear();
    matchedPairs.clear();
    moves = 0;
    timeElapsed = 0;
    isGameStarted = false;
    isGameCompleted = false;
    isGamePaused = false;
    
    // Remover componentes existentes
    for (final component in cardComponents) {
      component.removeFromParent();
    }
    cardComponents.clear();
    
    if (pauseOverlay != null) {
      pauseOverlay!.removeFromParent();
      pauseOverlay = null;
    }
    
    // Reinicializar
    movesComponent.resetMoves();
    hintComponent.hideHint();
    
    // Regenerar cartas
    _generateCards();
    _createCardComponents();
    _showInitialPreview();
  }

// ===== KEYBOARD CONTROLS =====
@override
KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  if (event is KeyDownEvent) {
    if (keysPressed.contains(LogicalKeyboardKey.space)) {
      if (isGamePaused) {
        resumeGame();
      } else {
        pauseGame();
      }
      return KeyEventResult.handled;  // ← Cambio aquí
    }
    
    if (keysPressed.contains(LogicalKeyboardKey.keyR)) {
      resetGame();
      return KeyEventResult.handled;  // ← Cambio aquí
    }
    
    if (keysPressed.contains(LogicalKeyboardKey.keyH)) {
      _showHint();
      return KeyEventResult.handled;  // ← Cambio aquí
    }
  }
  
  return super.onKeyEvent(event, keysPressed);  // ← Llamada obligatoria
}

  // ===== AUDIO =====
  void _playSound(String soundType) {
    // Implementar sistema de sonido
    // Por ahora placeholder - se implementaría con flame_audio
    try {
      // FlameAudio.play('$soundType.wav');
    } catch (e) {
      // Fallback silencioso
    }
  }

  // ===== CONFIGURATION =====
  void configure({
    required DifficultyLevel difficulty,
    required ColorPalette colorPalette,
    Function(MemoryGameScore)? onGameCompleted,
    Function(int moves, int time)? onGameStateChanged,
    VoidCallback? onGamePaused,
    VoidCallback? onGameResumed,
  }) {
    this.difficulty = difficulty;
    this.colorPalette = colorPalette;
    this.config = MemoryGameConfig.presets[difficulty]!;
    this.onGameCompleted = onGameCompleted;
    this.onGameStateChanged = onGameStateChanged;
    this.onGamePaused = onGamePaused;
    this.onGameResumed = onGameResumed;
  }

  // ===== GETTERS =====
  bool get isPlaying => isGameStarted && !isGamePaused && !isGameCompleted;
  double get progress => matchedPairs.length / config.totalPairs;
  
  Map<String, dynamic> get gameStats => {
    'moves': moves,
    'timeElapsed': timeElapsed,
    'matchedPairs': matchedPairs.length,
    'totalPairs': config.totalPairs,
    'progress': progress,
    'isCompleted': isGameCompleted,
  };
}