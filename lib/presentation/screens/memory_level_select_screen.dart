// lib/presentation/screens/memory_level_select_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_router.dart';
import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';
import '../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../widgets/common_widgets.dart';

class MemoryLevelSelectScreen extends ConsumerStatefulWidget {
  const MemoryLevelSelectScreen({super.key});

  @override
  ConsumerState<MemoryLevelSelectScreen> createState() => _MemoryLevelSelectScreenState();
}

class _MemoryLevelSelectScreenState extends ConsumerState<MemoryLevelSelectScreen>
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
      data: (config) => _buildLevelSelectScreen(context, config),
    );
  }

  Widget _buildLevelSelectScreen(BuildContext context, GameConfig config) {
    final isDesktop = AppTheme.isDesktop(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Custom app bar
              SliverToBoxAdapter(
                child: _buildHeader(context, config, isDesktop),
              ),
              
              // Memory stats
              SliverToBoxAdapter(
                child: _buildMemoryStats(context, config),
              ),
              
              // Level selection cards
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 64 : 24,
                  vertical: 32,
                ),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isDesktop ? 3 : 1,
                    childAspectRatio: isDesktop ? 1.0 : 1.8,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildLevelCard(
                      context,
                      config,
                      DifficultyLevel.easy,
                      delay: 0,
                    ),
                    _buildLevelCard(
                      context,
                      config,
                      DifficultyLevel.medium,
                      delay: 150,
                    ),
                    _buildLevelCard(
                      context,
                      config,
                      DifficultyLevel.hard,
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
            tag: 'memory_title',
            child: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🧠',
                    style: TextStyle(fontSize: isDesktop ? 48 : 40),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .shimmer(duration: 2000.ms)
                      .scale(
                        duration: 1000.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.1, 1.1),
                      )
                      .then()
                      .scale(
                        duration: 1000.ms,
                        curve: Curves.easeInOut,
                        begin: const Offset(1.1, 1.1),
                        end: const Offset(0.9, 0.9),
                      ),
                  
                  const SizedBox(width: 16),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Memory Temático',
                        style: TextStyle(
                          fontSize: isDesktop ? 32 : 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'GameFont',
                        ),
                      ),
                      Text(
                        'Encuentra los pares de ${config.honoredPerson}',
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

  Widget _buildMemoryStats(BuildContext context, GameConfig config) {
    final memoryGames = config.gameStats.memoryGames;
    
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
                    memoryGames.length.toString(),
                    'Partidas',
                  ),
                  _buildStatColumn(
                    '⭐',
                    _getTotalStars(memoryGames).toString(),
                    'Estrellas',
                  ),
                  _buildStatColumn(
                    '⏱️',
                    _getBestTime(memoryGames),
                    'Mejor Tiempo',
                  ),
                  _buildStatColumn(
                    '🎯',
                    _getBestMoves(memoryGames).toString(),
                    'Menos Movs',
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

  Widget _buildLevelCard(
    BuildContext context,
    GameConfig config,
    DifficultyLevel difficulty,
    {required int delay}
  ) {
    final difficultyConfig = DefaultData.difficultyConfigs[difficulty]!;
    final memoryConfig = MemoryGameConfig.presets[difficulty]!;
    final levelStats = _getLevelStats(config.gameStats.memoryGames, difficulty);
    
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
              child: _LevelCard(
                difficulty: difficulty,
                config: memoryConfig,
                colorPalette: config.colorPalette,
                stats: levelStats,
                onTap: () => context.goToMemoryGame(difficulty.name),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBestScores(BuildContext context, GameConfig config) {
    final memoryGames = config.gameStats.memoryGames;
    if (memoryGames.isEmpty) return const SizedBox.shrink();
    
    final bestScores = _getBestScoresByDifficulty(memoryGames);
    
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
          ...bestScores.entries.map((entry) {
            final difficulty = entry.key;
            final score = entry.value;
            final difficultyConfig = DefaultData.difficultyConfigs[difficulty]!;
            
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
                    difficultyConfig['emoji'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          difficultyConfig['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${score.moves} movimientos • ${_formatDuration(score.time)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(3, (index) {
                      return Text(
                        index < score.stars ? '⭐' : '☆',
                        style: const TextStyle(fontSize: 20),
                      );
                    }),
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
    final memoryTips = [
      '💡 Concéntrate en las esquinas y bordes primero',
      '🧠 Crea patrones mentales para recordar posiciones',
      '⏱️ No te apresures, la precisión es más importante que la velocidad',
      '👀 Observa bien durante el preview inicial',
      '🎯 Intenta completar un área antes de pasar a otra',
    ];
    
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💭 Consejos para Memory',
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
              itemCount: memoryTips.length,
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
                      memoryTips[index],
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
  int _getTotalStars(List<MemoryGameScore> games) {
    return games.fold(0, (sum, game) => sum + game.stars);
  }

  String _getBestTime(List<MemoryGameScore> games) {
    if (games.isEmpty) return '--:--';
    final bestTime = games.map((g) => g.time).reduce((a, b) => a < b ? a : b);
    return _formatDuration(bestTime);
  }

  int _getBestMoves(List<MemoryGameScore> games) {
    if (games.isEmpty) return 0;
    return games.map((g) => g.moves).reduce((a, b) => a < b ? a : b);
  }

  Map<String, dynamic> _getLevelStats(List<MemoryGameScore> games, DifficultyLevel difficulty) {
    final levelGames = games.where((g) => g.level == difficulty).toList();
    
    return {
      'played': levelGames.length,
      'bestTime': levelGames.isEmpty ? null : levelGames.map((g) => g.time).reduce((a, b) => a < b ? a : b),
      'bestMoves': levelGames.isEmpty ? null : levelGames.map((g) => g.moves).reduce((a, b) => a < b ? a : b),
      'totalStars': levelGames.fold(0, (sum, game) => sum + game.stars),
      'maxStars': levelGames.length * 3,
    };
  }

  Map<DifficultyLevel, MemoryGameScore> _getBestScoresByDifficulty(List<MemoryGameScore> games) {
    final result = <DifficultyLevel, MemoryGameScore>{};
    
    for (final difficulty in DifficultyLevel.values) {
      final levelGames = games.where((g) => g.level == difficulty).toList();
      if (levelGames.isNotEmpty) {
        // Best score = least moves, then fastest time
        levelGames.sort((a, b) {
          final moveComparison = a.moves.compareTo(b.moves);
          if (moveComparison != 0) return moveComparison;
          return a.time.compareTo(b.time);
        });
        result[difficulty] = levelGames.first;
      }
    }
    
    return result;
  }

  String _formatDuration(Duration duration) {
    final mins = duration.inMinutes;
    final secs = duration.inSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

// ===== LEVEL CARD COMPONENT =====
class _LevelCard extends StatefulWidget {
  final DifficultyLevel difficulty;
  final MemoryGameConfig config;
  final ColorPalette colorPalette;
  final Map<String, dynamic> stats;
  final VoidCallback onTap;

  const _LevelCard({
    required this.difficulty,
    required this.config,
    required this.colorPalette,
    required this.stats,
    required this.onTap,
  });

  @override
  State<_LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<_LevelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

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
    final difficultyConfig = DefaultData.difficultyConfigs[widget.difficulty]!;
    final difficultyColor = AppTheme.parseColor(difficultyConfig['color']);
    
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
                    colors: [
                      difficultyColor,
                      difficultyColor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                  boxShadow: [
                    BoxShadow(
                      color: difficultyColor.withOpacity(0.3),
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
                          // Difficulty icon and badge
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    difficultyConfig['emoji'],
                                    style: const TextStyle(fontSize: 40),
                                  ),
                                ),
                              ),
                              
                              // Stars badge
                              if (widget.stats['totalStars'] > 0)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${widget.stats['totalStars']}⭐',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Difficulty name
                          Text(
                            difficultyConfig['name'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'GameFont',
                            ),
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Description
                          Text(
                            difficultyConfig['description'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Grid info
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
                              '${widget.config.rows}×${widget.config.cols} • ${widget.config.totalPairs} pares',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Stats
                          if (widget.stats['played'] > 0) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildStatChip(
                                  '🎮 ${widget.stats['played']}',
                                  'Jugadas',
                                ),
                                const SizedBox(width: 8),
                                if (widget.stats['bestMoves'] != null)
                                  _buildStatChip(
                                    '🎯 ${widget.stats['bestMoves']}',
                                    'Mejor',
                                  ),
                              ],
                            ),
                          ] else ...[
                            Text(
                              '¡Nuevo nivel!',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.8),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
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

  Widget _buildStatChip(String text, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });

    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  void _onPress() {
    // Add haptic feedback or press animation here
  }
}