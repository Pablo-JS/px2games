// lib/presentation/screens/memory_game_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../data/models/game_models.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/default_data.dart';
import '../providers/game_providers.dart';
import '../widgets/common_widgets.dart';
import '../flame_components/memory_flame_game.dart';

class MemoryGameScreen extends ConsumerStatefulWidget {
  final String difficulty;

  const MemoryGameScreen({
    super.key,
    required this.difficulty,
  });

  @override
  ConsumerState<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends ConsumerState<MemoryGameScreen>
    with TickerProviderStateMixin {
  
  late MemoryFlameGame _game;
  late DifficultyLevel _difficultyLevel;
  late AnimationController _statsController;
  late AnimationController _completionController;
  
  bool _isGameStarted = false;
  bool _isGameCompleted = false;
  bool _showingPreview = true;
  int _currentMoves = 0;
  int _currentTime = 0;
  MemoryGameScore? _finalScore;

  @override
  void initState() {
    super.initState();
    
    // Parse difficulty
    _difficultyLevel = DifficultyLevel.values.firstWhere(
      (d) => d.name == widget.difficulty,
      orElse: () => DifficultyLevel.easy,
    );
    
    _statsController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _completionController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _initializeGame();
  }

  @override
  void dispose() {
    _statsController.dispose();
    _completionController.dispose();
    super.dispose();
  }

  void _initializeGame() {
    final configAsync = ref.read(gameConfigNotifierProvider);
    configAsync.whenData((config) {
      _game = MemoryFlameGame();
      _game.configure(
        difficulty: _difficultyLevel,
        colorPalette: config.colorPalette,
        onGameCompleted: _onGameCompleted,
        onGameStateChanged: _onGameStateChanged,
        onGamePaused: _onGamePaused,
        onGameResumed: _onGameResumed,
      );
      
      // Start preview countdown
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showingPreview = false;
            _isGameStarted = true;
          });
        }
      });
    });
  }

  void _onGameCompleted(MemoryGameScore score) {
    setState(() {
      _isGameCompleted = true;
      _finalScore = score;
    });
    
    _completionController.forward();
    
    // Save score to provider
    ref.read(gameConfigNotifierProvider.notifier)
        .addGameScore('memory', score.toJson());
    
    // Show completion after animation
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _showCompletionDialog();
      }
    });
  }

  void _onGameStateChanged(int moves, int time) {
    setState(() {
      _currentMoves = moves;
      _currentTime = time;
    });
    _statsController.forward().then((_) => _statsController.reverse());
  }

  void _onGamePaused() {
    HapticFeedback.mediumImpact();
  }

  void _onGameResumed() {
    HapticFeedback.lightImpact();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(gameConfigNotifierProvider);
    
    return configAsync.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
      data: (config) => _buildGameScreen(context, config),
    );
  }

  Widget _buildGameScreen(BuildContext context, GameConfig config) {
    final isDesktop = AppTheme.isDesktop(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom header
              _buildGameHeader(context, config, isDesktop),
              
              // Game stats bar
              _buildStatsBar(context, config),
              
              // Game area
              Expanded(
                child: Stack(
                  children: [
                    // Flame game
                    if (!_showingPreview)
                      GameWidget<MemoryFlameGame>.controlled(
                        gameFactory: () => _game,
                      ),
                    
                    // Preview overlay
                    if (_showingPreview)
                      _buildPreviewOverlay(config),
                    
                    // Pause controls
                    if (_isGameStarted && !_isGameCompleted)
                      _buildGameControls(context, config),
                  ],
                ),
              ),
              
              // Bottom controls
              if (!_isGameCompleted)
                _buildBottomControls(context, config),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameHeader(BuildContext context, GameConfig config, bool isDesktop) {
    final difficultyConfig = DefaultData.difficultyConfigs[_difficultyLevel]!;
    final memoryConfig = MemoryGameConfig.presets[_difficultyLevel]!;
    
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 16),
      decoration: BoxDecoration(
        gradient: AppTheme.createPrimaryGradient(config.colorPalette),
        boxShadow: [
          BoxShadow(
            color: AppTheme.parseColor(config.colorPalette.primary).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back button
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => _onBackPressed(context),
          ),
          
          const SizedBox(width: 16),
          
          // Game info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      difficultyConfig['emoji'],
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Memory ${difficultyConfig['name']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'GameFont',
                      ),
                    ),
                  ],
                ),
                Text(
                  '${memoryConfig.rows}×${memoryConfig.cols} • ${memoryConfig.totalPairs} pares',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Menu button
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => _showGameMenu(context, config),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBar(BuildContext context, GameConfig config) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            '⏱️',
            _formatTime(_currentTime),
            'Tiempo',
            config.colorPalette,
          ),
          _buildStatItem(
            '🎯',
            _currentMoves.toString(),
            'Movimientos',
            config.colorPalette,
          ),
          _buildStatItem(
            '🏆',
            '${(_game.progress * 100).toInt()}%',
            'Progreso',
            config.colorPalette,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label, ColorPalette palette) {
    return AnimatedBuilder(
      animation: _statsController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_statsController.value * 0.1),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'GameFont',
                      shadows: [
                        Shadow(
                          color: AppTheme.parseColor(palette.primary).withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreviewOverlay(GameConfig config) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                boxShadow: AppTheme.createElevatedShadow(config.colorPalette),
              ),
              child: Column(
                children: [
                  Text(
                    '👀',
                    style: const TextStyle(fontSize: 64),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .scale(duration: 1000.ms, curve: Curves.easeInOut)
                      .then()
                      .scale(begin: const Offset(1.2, 1.2), end: const Offset(1.0, 1.0)),
                  
                  const SizedBox(height: 16),
                  
                  Text(
                    '¡Memoriza las cartas!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.parseColor(config.colorPalette.primary),
                      fontFamily: 'GameFont',
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'El juego comenzará en un momento...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  LinearProgressIndicator(
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.parseColor(config.colorPalette.primary),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 1500.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameControls(BuildContext context, GameConfig config) {
    return Positioned(
      top: 16,
      right: 16,
      child: Column(
        children: [
          FloatingActionButton.small(
            heroTag: "pause_btn",
            onPressed: () => _game.pauseGame(),
            backgroundColor: AppTheme.parseColor(config.colorPalette.secondary),
            child: const Icon(Icons.pause, color: Colors.white),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: "hint_btn",
            onPressed: () => (),// TODO::_game._showHint(),
            backgroundColor: AppTheme.parseColor(config.colorPalette.accent),
            child: const Icon(Icons.lightbulb, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(BuildContext context, GameConfig config) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: GameButton(
              text: 'Pausar',
              icon: Icons.pause,
              onPressed: () => _game.pauseGame(),
              color: AppTheme.parseColor(config.colorPalette.secondary),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GameButton(
              text: 'Reiniciar',
              icon: Icons.refresh,
              onPressed: () => _showRestartConfirmation(context, config),
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    if (_finalScore == null) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _CompletionDialog(
        score: _finalScore!,
        colorPalette: ref.read(gameConfigNotifierProvider).value!.colorPalette,
        onPlayAgain: () {
          Navigator.of(context).pop();
          _game.resetGame();
          setState(() {
            _isGameCompleted = false;
            _finalScore = null;
            _currentMoves = 0;
            _currentTime = 0;
          });
        },
        onBackToMenu: () {
          Navigator.of(context).pop();
          context.go('/memory/level-select');
        },
        onHome: () {
          Navigator.of(context).pop();
          context.go('/');
        },
      ),
    );
  }

  void _showGameMenu(BuildContext context, GameConfig config) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Opciones del Juego',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.parseColor(config.colorPalette.primary),
                fontFamily: 'GameFont',
              ),
            ),
            const SizedBox(height: 24),
            _buildMenuOption(
              'Pausar Juego',
              Icons.pause,
              () {
                Navigator.pop(context);
                _game.pauseGame();
              },
            ),
            _buildMenuOption(
              'Reiniciar',
              Icons.refresh,
              () {
                Navigator.pop(context);
                _showRestartConfirmation(context, config);
              },
            ),
            _buildMenuOption(
              'Cambiar Dificultad',
              Icons.tune,
              () {
                Navigator.pop(context);
                context.go('/memory/level-select');
              },
            ),
            _buildMenuOption(
              'Menú Principal',
              Icons.home,
              () {
                Navigator.pop(context);
                context.go('/');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
    );
  }

  void _showRestartConfirmation(BuildContext context, GameConfig config) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: '¿Reiniciar juego?',
        message: 'Se perderá el progreso actual. ¿Estás seguro?',
        confirmText: 'Reiniciar',
        cancelText: 'Cancelar',
        confirmColor: Colors.orange,
        icon: Icons.refresh,
        onConfirm: () {
          _game.resetGame();
          setState(() {
            _currentMoves = 0;
            _currentTime = 0;
          });
        },
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (_isGameStarted && !_isGameCompleted) {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: '¿Salir del juego?',
          message: 'Se perderá el progreso actual. ¿Estás seguro?',
          confirmText: 'Salir',
          cancelText: 'Continuar',
          confirmColor: Colors.red,
          icon: Icons.exit_to_app,
          onConfirm: () => context.go('/memory/level-select'),
        ),
      );
    } else {
      context.go('/memory/level-select');
    }
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

// ===== COMPLETION DIALOG =====
class _CompletionDialog extends StatefulWidget {
  final MemoryGameScore score;
  final ColorPalette colorPalette;
  final VoidCallback onPlayAgain;
  final VoidCallback onBackToMenu;
  final VoidCallback onHome;

  const _CompletionDialog({
    required this.score,
    required this.colorPalette,
    required this.onPlayAgain,
    required this.onBackToMenu,
    required this.onHome,
  });

  @override
  State<_CompletionDialog> createState() => _CompletionDialogState();
}

class _CompletionDialogState extends State<_CompletionDialog>
    with TickerProviderStateMixin {
  late AnimationController _confettiController;
  late AnimationController _starsController;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _starsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _starsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusXXL),
          boxShadow: AppTheme.createElevatedShadow(widget.colorPalette, elevation: 16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Celebration emoji
            Text(
              '🎉',
              style: const TextStyle(fontSize: 64),
            ).animate(onPlay: (controller) => controller.repeat())
                .rotate(duration: 2000.ms, curve: Curves.easeInOut)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
            
            const SizedBox(height: 16),
            
            // Title
            Text(
              '¡Felicitaciones!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppTheme.parseColor(widget.colorPalette.primary),
                fontFamily: 'GameFont',
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: -0.3),
            
            const SizedBox(height: 24),
            
            // Stars
            AnimatedBuilder(
              animation: _starsController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    final delay = index * 0.2;
                    final progress = ((_starsController.value - delay) / 0.8).clamp(0.0, 1.0);
                    final scale = progress > 0 ? 1.0 + (1.0 - progress) * 0.5 : 0.0;
                    
                    return Transform.scale(
                      scale: scale,
                      child: Text(
                        index < widget.score.stars ? '⭐' : '☆',
                        style: const TextStyle(fontSize: 32),
                      ),
                    );
                  }),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Stats
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.parseColor(widget.colorPalette.background),
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              ),
              child: Column(
                children: [
                  _buildStatRow('⏱️ Tiempo', _formatDuration(widget.score.time)),
                  const SizedBox(height: 12),
                  _buildStatRow('🎯 Movimientos', widget.score.moves.toString()),
                  const SizedBox(height: 12),
                  _buildStatRow('📊 Eficiencia', '${_calculateEfficiency()}%'),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Buttons
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: GameButton(
                    text: '🔄 Jugar de Nuevo',
                    onPressed: widget.onPlayAgain,
                    color: AppTheme.parseColor(widget.colorPalette.primary),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: GameButton(
                        text: '📊 Niveles',
                        onPressed: widget.onBackToMenu,
                        color: AppTheme.parseColor(widget.colorPalette.secondary),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GameButton(
                        text: '🏠 Inicio',
                        onPressed: widget.onHome,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.parseColor(widget.colorPalette.primary),
            fontFamily: 'GameFont',
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final mins = duration.inMinutes;
    final secs = duration.inSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  int _calculateEfficiency() {
    final config = MemoryGameConfig.presets[widget.score.level]!;
    final optimalMoves = config.totalPairs;
    final efficiency = (optimalMoves / widget.score.moves * 100).round();
    return efficiency.clamp(0, 100);
  }
}