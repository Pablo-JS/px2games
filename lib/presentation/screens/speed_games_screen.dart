// lib/presentation/screens/speed_games_screen.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_router.dart';
import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';
import '../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../widgets/common_widgets.dart';

class SpeedGamesScreen extends ConsumerStatefulWidget {
  const SpeedGamesScreen({super.key});

  @override
  ConsumerState<SpeedGamesScreen> createState() => _SpeedGamesScreenState();
}

class _SpeedGamesScreenState extends ConsumerState<SpeedGamesScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _cardAnimationController;
  late AnimationController _statsAnimationController;

  @override
  void initState() {
    super.initState();
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    
    _statsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _statsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(gameConfigNotifierProvider);
    
    return configAsync.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
      data: (config) => _buildSpeedGamesScreen(context, config),
    );
  }

  Widget _buildSpeedGamesScreen(BuildContext context, GameConfig config) {
    final isDesktop = AppTheme.isDesktop(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: _buildHeader(context, config, isDesktop),
              ),
              
              // Speed games stats
              SliverToBoxAdapter(
                child: _buildSpeedStats(context, config),
              ),
              
              // Game selection cards
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 64 : 24,
                  vertical: 32,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 3 : 1,
                    childAspectRatio: isDesktop ? 1.0 : 1.5,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildGameCard(
                      context,
                      config,
                      'balloonPop',
                      delay: 0,
                    ),
                    _buildGameCard(
                      context,
                      config,
                      'sequence',
                      delay: 150,
                    ),
                    _buildGameCard(
                      context,
                      config,
                      'quickTap',
                      delay: 300,
                    ),
                  ]),
                ),
              ),
              
              // Best scores section
              SliverToBoxAdapter(
                child: _buildBestScores(context, config),
              ),
              
              // Tips section
              SliverToBoxAdapter(
                child: _buildTipsSection(context, config),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GameConfig config, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
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
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => context.go('/'),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => context.goToAdmin(),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Game title with animation
          Hero(
            tag: 'speed_title',
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '⚡',
                    style: TextStyle(fontSize: isDesktop ? 48 : 40),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .scale(
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.2, 1.2),
                      )
                      .then()
                      .scale(
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(0.8, 0.8),
                      ),
                  
                  const SizedBox(width: 16),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Juegos de Velocidad',
                        style: TextStyle(
                          fontSize: isDesktop ? 32 : 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'GameFont',
                        ),
                      ),
                      Text(
                        'Pon a prueba tus reflejos',
                        style: TextStyle(
                          fontSize: isDesktop ? 18 : 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3),
        ],
      ),
    );
  }

  Widget _buildSpeedStats(BuildContext context, GameConfig config) {
    final speedGames = config.gameStats.speedGames;
    
    return AnimatedBuilder(
      animation: _statsAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _statsAnimationController.value)),
          child: Opacity(
            opacity: _statsAnimationController.value,
            child: Container(
              margin: const EdgeInsets.all(24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatColumn(
                    '🎮',
                    speedGames.length.toString(),
                    'Partidas',
                  ),
                  _buildStatColumn(
                    '🏆',
                    _getBestScore(speedGames).toString(),
                    'Mejor Puntuación',
                  ),
                  _buildStatColumn(
                    '⚡',
                    _getAverageScore(speedGames).toString(),
                    'Promedio',
                  ),
                  _buildStatColumn(
                    '🎯',
                    _getTotalPoints(speedGames).toString(),
                    'Puntos Totales',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatColumn(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'GameFont',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    GameConfig config,
    String gameType,
    {required int delay}
  ) {
    final gameConfig = DefaultData.speedGamesConfig[gameType]!;
    
    return AnimatedBuilder(
      animation: _cardAnimationController,
      builder: (context, child) {
        final delayedProgress = ((_cardAnimationController.value * 3) - (delay / 150)).clamp(0.0, 1.0);
        
        return Transform.translate(
          offset: Offset(0, 100 * (1 - delayedProgress)),
          child: Transform.scale(
            scale: 0.8 + (0.2 * delayedProgress),
            child: Opacity(
              opacity: delayedProgress,
              child: _SpeedGameCard(
                gameType: gameType,
                gameConfig: gameConfig,
                colorPalette: config.colorPalette,
                onTap: () => context.goToSpeedGame(gameType),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBestScores(BuildContext context, GameConfig config) {
    final speedGames = config.gameStats.speedGames;
    if (speedGames.isEmpty) return const SizedBox.shrink();
    
    final bestScoresByGame = _getBestScoresByGame(speedGames);
    
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🏆 Mejores Puntuaciones',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'GameFont',
            ),
          ),
          const SizedBox(height: 16),
          ...bestScoresByGame.entries.map((entry) {
            final gameType = entry.key;
            final score = entry.value;
            final gameConfig = DefaultData.speedGamesConfig[gameType]!;
            
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    gameConfig['emoji'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          gameConfig['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Nivel ${score.level} • ${_formatDuration(score.duration)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${score.score} pts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade300,
                      fontFamily: 'GameFont',
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTipsSection(BuildContext context, GameConfig config) {
    final speedTips = [
      '⚡ Mantén los dedos relajados y listos para reaccionar',
      '👀 Enfócate en el centro de la pantalla para detectar cambios',
      '🧠 No pienses demasiado, confía en tus reflejos',
      '💪 Practica regularmente para mejorar tus tiempos',
      '🎯 La precisión es tan importante como la velocidad',
    ];
    
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡 Consejos para Velocidad',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'GameFont',
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: PageView.builder(
              itemCount: speedTips.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      speedTips[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Helper methods
  int _getBestScore(List<SpeedGameScore> games) {
    if (games.isEmpty) return 0;
    return games.map((g) => g.score).reduce((a, b) => a > b ? a : b);
  }

  int _getAverageScore(List<SpeedGameScore> games) {
    if (games.isEmpty) return 0;
    final total = games.fold(0, (sum, game) => sum + game.score);
    return (total / games.length).round();
  }

  int _getTotalPoints(List<SpeedGameScore> games) {
    return games.fold(0, (sum, game) => sum + game.score);
  }

  Map<String, SpeedGameScore> _getBestScoresByGame(List<SpeedGameScore> games) {
    final result = <String, SpeedGameScore>{};
    
    for (final gameType in DefaultData.speedGamesConfig.keys) {
      final gameScores = games.where((g) => g.gameType == gameType).toList();
      if (gameScores.isNotEmpty) {
        gameScores.sort((a, b) => b.score.compareTo(a.score));
        result[gameType] = gameScores.first;
      }
    }
    
    return result;
  }

  String _formatDuration(Duration duration) {
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }
}

// ===== SPEED GAME CARD =====
class _SpeedGameCard extends StatefulWidget {
  final String gameType;
  final Map<String, dynamic> gameConfig;
  final ColorPalette colorPalette;
  final VoidCallback onTap;

  const _SpeedGameCard({
    required this.gameType,
    required this.gameConfig,
    required this.colorPalette,
    required this.onTap,
  });

  @override
  State<_SpeedGameCard> createState() => _SpeedGameCardState();
}

class _SpeedGameCardState extends State<_SpeedGameCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 16.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameColors = _getGameColors(widget.gameType);
    
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTapDown: (_) => _onPress(),
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: gameColors,
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                  boxShadow: [
                    BoxShadow(
                      color: gameColors.first.withOpacity(0.3),
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value / 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                    onTap: widget.onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Game icon with animation
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                widget.gameConfig['emoji'],
                                style: const TextStyle(fontSize: 40),
                              ),
                            ),
                          ).animate(onPlay: (controller) => controller.repeat())
                              .scale(
                                duration: 2000.ms,
                                curve: Curves.easeInOut,
                                begin: const Offset(0.9, 0.9),
                                end: const Offset(1.1, 1.1),
                              )
                              .then()
                              .scale(
                                duration: 2000.ms,
                                curve: Curves.easeInOut,
                                begin: const Offset(1.1, 1.1),
                                end: const Offset(0.9, 0.9),
                              ),
                          
                          const SizedBox(height: 16),
                          
                          // Game name
                          Text(
                            widget.gameConfig['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'GameFont',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Description
                          Text(
                            widget.gameConfig['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Game info
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _getGameInfo(widget.gameType, widget.gameConfig),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Quick play button
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Jugar',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Color> _getGameColors(String gameType) {
    switch (gameType) {
      case 'balloonPop':
        return [Colors.red.shade400, Colors.pink.shade400];
      case 'sequence':
        return [Colors.blue.shade400, Colors.indigo.shade400];
      case 'quickTap':
        return [Colors.green.shade400, Colors.teal.shade400];
      default:
        return [Colors.grey.shade400, Colors.grey.shade600];
    }
  }

  String _getGameInfo(String gameType, Map<String, dynamic> config) {
    switch (gameType) {
      case 'balloonPop':
        return '${config['duration']}s • Globos rápidos';
      case 'sequence':
        return '${config['rounds']} rondas • Memoria';
      case 'quickTap':
        return '${config['rounds']} rondas • Reflejos';
      default:
        return 'Juego de velocidad';
    }
  }

  void _onHover(bool isHovered) {
    if (isHovered) {
      _hoverController.forward();
      HapticFeedback.lightImpact();
    } else {
      _hoverController.reverse();
    }
  }

  void _onPress() {
    HapticFeedback.mediumImpact();
  }
}

// ===== SPEED GAME SCREEN (Individual Games) =====
class SpeedGameScreen extends ConsumerStatefulWidget {
  final String gameType;

  const SpeedGameScreen({
    super.key,
    required this.gameType,
  });

  @override
  ConsumerState<SpeedGameScreen> createState() => _SpeedGameScreenState();
}

class _SpeedGameScreenState extends ConsumerState<SpeedGameScreen>
    with TickerProviderStateMixin {
  
  // Game state
  bool _isGameStarted = false;
  bool _isGameActive = false;
  bool _isGameCompleted = false;
  int _score = 0;
  int _level = 1;
  int _timeLeft = 0;
  Timer? _gameTimer;
  Timer? _countdownTimer;

  // Balloon Pop specific
  List<_Balloon> _balloons = [];
  Timer? _balloonSpawnTimer;

  // Sequence specific
  List<int> _currentSequence = [];
  List<int> _playerSequence = [];
  int _sequenceIndex = 0;
  bool _showingSequence = false;

  // Quick Tap specific
  Color? _targetColor;
  int _round = 0;
  int _correctTaps = 0;
  Timer? _colorTimer;

  // Animations
  late AnimationController _countdownController;
  late AnimationController _scoreController;
  late AnimationController _gameOverController;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _countdownTimer?.cancel();
    _balloonSpawnTimer?.cancel();
    _colorTimer?.cancel();
    _countdownController.dispose();
    _scoreController.dispose();
    _gameOverController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _countdownController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _gameOverController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
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
    final gameConfig = DefaultData.speedGamesConfig[widget.gameType]!;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, config, gameConfig),
              
              // Game area
              Expanded(
                child: _buildGameArea(context, config, gameConfig),
              ),
              
              // Controls
              if (!_isGameActive && !_isGameCompleted)
                _buildControls(context, config),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GameConfig config, Map<String, dynamic> gameConfig) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => context.go('/speed-games'),
              ),
              Expanded(
                child: Text(
                  '${gameConfig['emoji']} ${gameConfig['name']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'GameFont',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.white),
                onPressed: _isGameActive ? null : _resetGame,
              ),
            ],
          ),
          
          if (_isGameActive || _isGameCompleted) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('🎯', _score.toString(), 'Puntos'),
                _buildStatItem('📊', _level.toString(), 'Nivel'),
                if (_timeLeft > 0)
                  _buildStatItem('⏱️', _timeLeft.toString(), 'Tiempo'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'GameFont',
              ),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildGameArea(BuildContext context, GameConfig config, Map<String, dynamic> gameConfig) {
    if (!_isGameStarted) {
      return _buildInstructions(context, config, gameConfig);
    }

    if (_isGameCompleted) {
      return _buildGameCompleted(context, config);
    }

    switch (widget.gameType) {
      case 'balloonPop':
        return _buildBalloonPopGame(context, config);
      case 'sequence':
        return _buildSequenceGame(context, config);
      case 'quickTap':
        return _buildQuickTapGame(context, config);
      default:
        return _buildInstructions(context, config, gameConfig);
    }
  }

  Widget _buildInstructions(BuildContext context, GameConfig config, Map<String, dynamic> gameConfig) {
    String instructions;
    switch (widget.gameType) {
      case 'balloonPop':
        instructions = 'Toca los globos que aparecen antes de que desaparezcan.\n¡Cuantos más toques, más puntos obtienes!';
        break;
      case 'sequence':
        instructions = 'Memoriza la secuencia de colores y repítela.\nLa secuencia se hace más larga en cada ronda.';
        break;
      case 'quickTap':
        instructions = 'Toca el color que se indica lo más rápido posible.\n¡La velocidad cuenta para obtener más puntos!';
        break;
      default:
        instructions = 'Juego de velocidad y reflejos.';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gameConfig['emoji'],
              style: const TextStyle(fontSize: 120),
            ).animate(onPlay: (controller) => controller.repeat())
                .scale(duration: 2000.ms, curve: Curves.easeInOut),
            
            const SizedBox(height: 32),
            
            Text(
              gameConfig['name'],
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'GameFont',
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            Text(
              instructions,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalloonPopGame(BuildContext context, GameConfig config) {
    return Stack(
      children: [
        // Background
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade400,
              ],
            ),
          ),
        ),
        
        // Balloons
        ..._balloons.map((balloon) => Positioned(
          left: balloon.x,
          top: balloon.y,
          child: GestureDetector(
            onTap: () => _popBalloon(balloon),
            child: _BalloonWidget(
              color: balloon.color,
              size: balloon.size,
            ),
          ),
        )),
        
        // Countdown overlay
        if (_timeLeft > 0 && _timeLeft <= 3)
          Center(
            child: Text(
              _timeLeft.toString(),
              style: const TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'GameFont',
              ),
            ).animate().scale(duration: 1000.ms, curve: Curves.elasticOut),
          ),
      ],
    );
  }

  Widget _buildSequenceGame(BuildContext context, GameConfig config) {
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];
    
    return Column(
      children: [
        // Sequence display
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _showingSequence ? 'Memoriza la secuencia' : 'Repite la secuencia',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                if (_currentSequence.isNotEmpty)
                  Text(
                    'Secuencia de ${_currentSequence.length} colores',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
              ],
            ),
          ),
        ),
        
        // Color buttons
        Expanded(
          flex: 3,
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: colors.length,
            itemBuilder: (context, index) {
                final color = colors[index];
                final isHighlighted = _showingSequence && 
                    _sequenceIndex < _currentSequence.length && 
                    _currentSequence[_sequenceIndex] == index;
                
                return GestureDetector(
                  onTap: _showingSequence ? null : () => _onSequenceColorTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                      border: Border.all(
                        color: isHighlighted ? Colors.white : Colors.transparent,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.5),
                          blurRadius: isHighlighted ? 20 : 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ).animate(target: isHighlighted ? 1 : 0)
                    .scale(duration: 200.ms, curve: Curves.easeInOut);
              },
            ),
          ),
        
      ],
    );
  }

  Widget _buildQuickTapGame(BuildContext context, GameConfig config) {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    return Column(
      children: [
        // Instructions
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusLG),
          ),
          child: Column(
            children: [
              Text(
                'Ronda ${_round + 1} de ${DefaultData.speedGamesConfig['quickTap']!['rounds']}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              if (_targetColor != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Toca el color: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: _targetColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        
        // Color grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final color = colors[index];
              
              return GestureDetector(
                onTap: () => _onQuickTapColorTap(color),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGameCompleted(BuildContext context, GameConfig config) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '🏆',
              style: const TextStyle(fontSize: 120),
            ).animate().scale(duration: 1000.ms, curve: Curves.elasticOut),
            
            const SizedBox(height: 32),
            
            Text(
              '¡Juego Completado!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'GameFont',
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 24),
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              ),
              child: Column(
                children: [
                  _buildStatRow('🎯 Puntuación Final', _score.toString()),
                  const SizedBox(height: 12),
                  _buildStatRow('📊 Nivel Alcanzado', _level.toString()),
                  if (widget.gameType == 'quickTap') ...[
                    const SizedBox(height: 12),
                    _buildStatRow('✅ Toques Correctos', '$_correctTaps / ${_round + 1}'),
                  ],
                ],
              ),
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
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'GameFont',
          ),
        ),
      ],
    );
  }

  Widget _buildControls(BuildContext context, GameConfig config) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: GameButton(
              text: '🚀 Comenzar Juego',
              onPressed: _startGame,
              color: AppTheme.parseColor(config.colorPalette.primary),
            ),
          ),
          const SizedBox(height: 16),
          GameButton(
            text: '🏠 Volver',
            onPressed: () => context.go('/speed-games'),
            color: Colors.grey.shade600,
          ),
        ],
      ),
    );
  }

  // Game logic methods
  void _startGame() {
    setState(() {
      _isGameStarted = true;
      _isGameActive = true;
      _score = 0;
      _level = 1;
    });

    _startCountdown();
  }

  void _startCountdown() {
    _timeLeft = 3;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
      });

      if (_timeLeft <= 0) {
        timer.cancel();
        _startActualGame();
      }
    });
  }

  void _startActualGame() {
    switch (widget.gameType) {
      case 'balloonPop':
        _startBalloonPopGame();
        break;
      case 'sequence':
        _startSequenceGame();
        break;
      case 'quickTap':
        _startQuickTapGame();
        break;
    }
  }

  void _startBalloonPopGame() {
    final config = DefaultData.speedGamesConfig['balloonPop']!;
    _timeLeft = config['duration'];
    
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeLeft--;
      });

      if (_timeLeft <= 0) {
        _endGame();
      }
    });

    _spawnBalloons();
  }

  void _spawnBalloons() {
    final config = DefaultData.speedGamesConfig['balloonPop']!;
    
    _balloonSpawnTimer = Timer.periodic(
      Duration(milliseconds: Random().nextInt((config['maxSpawnTime'] - config['minSpawnTime']) + config['minSpawnTime']).toInt()),
      (timer) {
        if (_isGameActive) {
          _addBalloon();
        }
      },
    );
  }

  void _addBalloon() {
    final colors = DefaultData.speedGamesConfig['balloonPop']!['colors'] as List<String>;
    final screenSize = MediaQuery.of(context).size;
    
    final balloon = _Balloon(
      id: DateTime.now().millisecondsSinceEpoch,
      x: Random().nextDouble() * (screenSize.width - 100),
      y: Random().nextDouble() * (screenSize.height - 300) + 100,
      color: AppTheme.parseColor(colors[Random().nextInt(colors.length)]),
      size: 60 + Random().nextDouble() * 40,
    );

    setState(() {
      _balloons.add(balloon);
    });

    // Remove balloon after lifetime
    Timer(Duration(milliseconds: DefaultData.speedGamesConfig['balloonPop']!['balloonLifetime']), () {
      setState(() {
        _balloons.removeWhere((b) => b.id == balloon.id);
      });
    });
  }

  void _popBalloon(_Balloon balloon) {
    setState(() {
      _balloons.removeWhere((b) => b.id == balloon.id);
      _score += (100 / balloon.size * 60).round(); // Smaller balloons = more points
    });

    HapticFeedback.lightImpact();
    _scoreController.forward().then((_) => _scoreController.reverse());
  }

  void _startSequenceGame() {
    _generateSequence();
    _showSequence();
  }

  void _generateSequence() {
    _currentSequence = List.generate(
      3 + _level - 1, // Start with 3, increase by level
      (_) => Random().nextInt(4),
    );
    _playerSequence.clear();
  }

  void _showSequence() {
    setState(() {
      _showingSequence = true;
      _sequenceIndex = 0;
    });

    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (_sequenceIndex >= _currentSequence.length) {
        timer.cancel();
        setState(() {
          _showingSequence = false;
        });
      } else {
        setState(() {
          _sequenceIndex++;
        });
      }
    });
  }

  void _onSequenceColorTap(int colorIndex) {
    _playerSequence.add(colorIndex);
    
    if (_playerSequence.length == _currentSequence.length) {
      // Check if sequence is correct
      bool isCorrect = true;
      for (int i = 0; i < _currentSequence.length; i++) {
        if (_playerSequence[i] != _currentSequence[i]) {
          isCorrect = false;
          break;
        }
      }

      if (isCorrect) {
        _score += 100 * _level;
        _level++;
        
        if (_level > DefaultData.speedGamesConfig['sequence']!['rounds']) {
          _endGame();
        } else {
          _generateSequence();
          _showSequence();
        }
      } else {
        _endGame();
      }
    } else if (_playerSequence.last != _currentSequence[_playerSequence.length - 1]) {
      // Wrong color, end game
      _endGame();
    }

    HapticFeedback.lightImpact();
  }

  void _startQuickTapGame() {
    _round = 0;
    _correctTaps = 0;
    _nextQuickTapRound();
  }

  void _nextQuickTapRound() {
    if (_round >= DefaultData.speedGamesConfig['quickTap']!['rounds']) {
      _endGame();
      return;
    }

    final colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple, Colors.orange];
    
    setState(() {
      _targetColor = colors[Random().nextInt(colors.length)];
    });

    final startTime = DateTime.now();
    
    _colorTimer = Timer(Duration(milliseconds: DefaultData.speedGamesConfig['quickTap']!['timeWindow']), () {
      // Time's up, move to next round
      _round++;
      _nextQuickTapRound();
    });
  }

  void _onQuickTapColorTap(Color tappedColor) {
    _colorTimer?.cancel();
    
    if (tappedColor == _targetColor) {
      _correctTaps++;
      _score += 100;
      HapticFeedback.mediumImpact();
    } else {
      HapticFeedback.heavyImpact();
    }

    _round++;
    _nextQuickTapRound();
  }

  void _endGame() {
    setState(() {
      _isGameActive = false;
      _isGameCompleted = true;
    });

    _gameTimer?.cancel();
    _balloonSpawnTimer?.cancel();
    _colorTimer?.cancel();

    // Save score
    final speedScore = SpeedGameScore(
      gameType: widget.gameType,
      score: _score,
      level: _level,
      duration: Duration(seconds: 60), // Default duration
      timestamp: DateTime.now(),
      metadata: {
        'finalLevel': _level,
        if (widget.gameType == 'quickTap') 'correctTaps': _correctTaps,
        if (widget.gameType == 'balloonPop') 'balloonsPopped': _score ~/ 100,
      },
    );

    ref.read(gameConfigNotifierProvider.notifier)
        .addGameScore('speed', speedScore.toJson());

    _gameOverController.forward();
  }

  void _resetGame() {
    setState(() {
      _isGameStarted = false;
      _isGameActive = false;
      _isGameCompleted = false;
      _score = 0;
      _level = 1;
      _timeLeft = 0;
      _balloons.clear();
      _currentSequence.clear();
      _playerSequence.clear();
      _round = 0;
      _correctTaps = 0;
      _targetColor = null;
    });

    _gameTimer?.cancel();
    _balloonSpawnTimer?.cancel();
    _colorTimer?.cancel();
    _countdownTimer?.cancel();
    
    _countdownController.reset();
    _scoreController.reset();
    _gameOverController.reset();
  }
}

// ===== BALLOON WIDGET =====
class _Balloon {
  final int id;
  final double x;
  final double y;
  final Color color;
  final double size;

  _Balloon({
    required this.id,
    required this.x,
    required this.y,
    required this.color,
    required this.size,
  });
}

class _BalloonWidget extends StatefulWidget {
  final Color color;
  final double size;

  const _BalloonWidget({
    required this.color,
    required this.size,
  });

  @override
  State<_BalloonWidget> createState() => _BalloonWidgetState();
}

class _BalloonWidgetState extends State<_BalloonWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 2000 + Random().nextInt(1000)),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(
      begin: -5,
      end: 5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: widget.size * 0.3,
                height: widget.size * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}