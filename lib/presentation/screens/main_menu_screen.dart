// lib/presentation/screens/main_menu_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';
import '../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../widgets/common_widgets.dart';

class MainMenuScreen extends ConsumerStatefulWidget {
  const MainMenuScreen({super.key});

  @override
  ConsumerState<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends ConsumerState<MainMenuScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _cardsController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(gameConfigNotifierProvider);
    
    return configAsync.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
      data: (config) => _buildMainMenu(context, config),
    );
  }

  Widget _buildMainMenu(BuildContext context, GameConfig config) {
    final theme = Theme.of(context);
    final isDesktop = AppTheme.isDesktop(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: Stack(
          children: [
            // Animated background
            _buildAnimatedBackground(config),
            
            // Main content
            SafeArea(
              child: CustomScrollView(
                slivers: [
                  // Header
                  SliverToBoxAdapter(
                    child: _buildHeader(context, config, isDesktop),
                  ),
                  
                  // Game cards
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 64 : 24,
                      vertical: 32,
                    ),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isDesktop ? 3 : 1,
                        childAspectRatio: isDesktop ? 1.2 : 2.5,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                      ),
                      delegate: SliverChildListDelegate([
                        _buildGameCard(
                          context,
                          config,
                          title: 'Memory Temático',
                          subtitle: 'Encuentra los pares',
                          icon: '🧠',
                          gradient: _createGameGradient(['#FF6B6B', '#4ECDC4']),
                          onTap: () => context.go('/memory/level-select'),
                          delay: 0,
                        ),
                        _buildGameCard(
                          context,
                          config,
                          title: 'Trivia Familiar',
                          subtitle: 'Preguntas personalizadas',
                          icon: '🎯',
                          gradient: _createGameGradient(['#4ECDC4', '#45B7D1']),
                          onTap: () => context.go('/trivia'),
                          delay: 150,
                        ),
                        _buildGameCard(
                          context,
                          config,
                          title: 'Juegos de Velocidad',
                          subtitle: 'Pon a prueba tus reflejos',
                          icon: '⚡',
                          gradient: _createGameGradient(['#45B7D1', '#96CEB4']),
                          onTap: () => context.go('/speed-games'),
                          delay: 300,
                        ),
                      ]),
                    ),
                  ),
                  
                  // Admin and stats section
                  SliverToBoxAdapter(
                    child: _buildBottomSection(context, config, isDesktop),
                  ),
                  
                  // Footer
                  SliverToBoxAdapter(
                    child: _buildFooter(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground(GameConfig config) {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return CustomPaint(
            painter: FloatingShapesPainter(
              animation: _backgroundController,
              colorPalette: config.colorPalette,
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GameConfig config, bool isDesktop) {
    return Container(
      padding: EdgeInsets.all(isDesktop ? 48 : 32),
      child: Column(
        children: [
          // Event title with hero animation
          Hero(
            tag: 'event_title',
            child: Material(
              color: Colors.transparent,
              child: Text(
                config.eventName,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontSize: isDesktop ? 42 : 32,
                  shadows: [
                    Shadow(
                      color: AppTheme.parseColor(config.colorPalette.primary)
                          .withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.5),
          
          const SizedBox(height: 16),
          
          // Honored person with emoji
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DefaultData.eventTypeEmojis[config.eventType] ?? '🎉',
                style: TextStyle(fontSize: isDesktop ? 32 : 24),
              ),
              const SizedBox(width: 12),
              Text(
                '¡Para ${config.honoredPerson}!',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: isDesktop ? 24 : 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                DefaultData.eventTypeEmojis[config.eventType] ?? '🎉',
                style: TextStyle(fontSize: isDesktop ? 32 : 24),
              ),
            ],
          ).animate(delay: 300.ms).fadeIn(duration: 600.ms).slideY(begin: 0.3),
          
          const SizedBox(height: 24),
          
          // Game stats row
          _buildStatsRow(context, config).animate(delay: 600.ms)
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, GameConfig config) {
    final stats = config.gameStats;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
          '🎮',
          stats.totalGamesPlayed.toString(),
          'Partidas',
        ),
        _buildStatItem(
          '⏱️',
          _formatTime(stats.totalTimeSpent),
          'Tiempo Total',
        ),
        _buildStatItem(
          '🏆',
          '${stats.memoryGames.length + stats.triviaGames.length + stats.speedGames.length}',
          'Completadas',
        ),
      ],
    );
  }

  Widget _buildStatItem(String emoji, String value, String label) {
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
    GameConfig config, {
    required String title,
    required String subtitle,
    required String icon,
    required LinearGradient gradient,
    required VoidCallback onTap,
    required int delay,
  }) {
    return GameCard(
      title: title,
      subtitle: subtitle,
      icon: icon,
      gradient: gradient,
      onTap: onTap,
      colorPalette: config.colorPalette,
    ).animate(delay: Duration(milliseconds: delay))
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3)
        .scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildBottomSection(BuildContext context, GameConfig config, bool isDesktop) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 64 : 24,
        vertical: 24,
      ),
      child: Column(
        children: [
          // Quick access buttons
          Row(
            children: [
              Expanded(
                child: _buildQuickAccessButton(
                  context,
                  '⚙️ Administración',
                  'Personalizar juegos',
                  () => context.go('/admin'),
                  isPrimary: false,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickAccessButton(
                  context,
                  '📊 Estadísticas',
                  'Ver progreso',
                  () => context.go('/admin?tab=stats'),
                  isPrimary: false,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Tips carousel
          _buildTipsCarousel(config),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(
    BuildContext context,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isPrimary = true,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isPrimary ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusLG),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipsCarousel(GameConfig config) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        itemCount: DefaultData.gameTips.length,
        itemBuilder: (context, index) {
          final tip = DefaultData.gameTips[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                tip,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            'Suite de Juegos para Eventos v2.0',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Desarrollado con Flutter & Flame Engine',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  LinearGradient _createGameGradient(List<String> colors) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors.map((c) => AppTheme.parseColor(c)).toList(),
    );
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m';
    } else {
      return '${seconds}s';
    }
  }
}

// ===== FLOATING SHAPES PAINTER =====
class FloatingShapesPainter extends CustomPainter {
  final Animation<double> animation;
  final ColorPalette colorPalette;

  FloatingShapesPainter({
    required this.animation,
    required this.colorPalette,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    
    // Draw floating circles
    for (int i = 0; i < 8; i++) {
      final progress = (animation.value + i * 0.125) % 1.0;
      final x = size.width * (0.1 + 0.8 * ((i * 0.3) % 1.0));
      final y = size.height * progress;
      final radius = 20 + (i % 3) * 15;
      
      paint.color = AppTheme.parseColor(colorPalette.accent)
          .withOpacity(0.1 - progress * 0.1);
      
      canvas.drawCircle(Offset(x, y), radius.toDouble(), paint);
    }
    
    // Draw floating emojis (as circles for now)
    for (int i = 0; i < 5; i++) {
      final progress = (animation.value * 0.5 + i * 0.2) % 1.0;
      final x = size.width * (0.2 + 0.6 * ((i * 0.4) % 1.0));
      final y = size.height * (1.0 - progress);
      final radius = 15 + (i % 2) * 10;
      
      paint.color = AppTheme.parseColor(colorPalette.secondary)
          .withOpacity(0.08 - progress * 0.08);
      
      canvas.drawCircle(Offset(x, y), radius.toDouble(), paint);
    }
  }

  @override
  bool shouldRepaint(FloatingShapesPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}