// lib/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/screens/main_menu_screen.dart';
import '../presentation/screens/memory_game_screen.dart';
import '../presentation/screens/memory_level_select_screen.dart';
import '../presentation/screens/trivia_game_screen.dart';
import '../presentation/screens/speed_games_screen.dart';
import '../presentation/screens/admin_panel_screen.dart';
import '../presentation/screens/settings_screen.dart';
import '../presentation/widgets/common_widgets.dart';

// ===== ROUTER PROVIDER =====
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // ===== MAIN MENU =====
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => _buildPage(
          context,
          state,
          const MainMenuScreen(),
        ),
      ),

      // ===== MEMORY GAME ROUTES =====
      GoRoute(
        path: '/memory',
        redirect: (context, state) => '/memory/level-select',
      ),
      
      GoRoute(
        path: '/memory/level-select',
        name: 'memory-level-select',
        pageBuilder: (context, state) => _buildPage(
          context,
          state,
          const MemoryLevelSelectScreen(),
        ),
      ),
      
      GoRoute(
        path: '/memory/game/:difficulty',
        name: 'memory-game',
        pageBuilder: (context, state) {
          final difficulty = state.pathParameters['difficulty'] ?? 'easy';
          return _buildPage(
            context,
            state,
            MemoryGameScreen(difficulty: difficulty),
          );
        },
      ),

      // ===== TRIVIA GAME ROUTES =====
      GoRoute(
        path: '/trivia',
        name: 'trivia',
        pageBuilder: (context, state) => _buildPage(
          context,
          state,
          const TriviaGameScreen(),
        ),
      ),

      // ===== SPEED GAMES ROUTES =====
      GoRoute(
        path: '/speed-games',
        name: 'speed-games',
        pageBuilder: (context, state) => _buildPage(
          context,
          state,
          const SpeedGamesScreen(),
        ),
      ),
      
      GoRoute(
        path: '/speed-games/:gameType',
        name: 'speed-game',
        pageBuilder: (context, state) {
          final gameType = state.pathParameters['gameType'] ?? 'balloonPop';
          return _buildPage(
            context,
            state,
            SpeedGameScreen(gameType: gameType),
          );
        },
      ),

      // ===== ADMIN PANEL ROUTES =====
      GoRoute(
        path: '/admin',
        name: 'admin',
        pageBuilder: (context, state) {
          final tab = state.uri.queryParameters['tab'];
          return _buildPage(
            context,
            state,
            AdminPanelScreen(initialTab: tab),
          );
        },
      ),

      // ===== SETTINGS ROUTES =====
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => _buildPage(
          context,
          state,
          const SettingsScreen(),
        ),
      ),

      // ===== ERROR ROUTES =====
      GoRoute(
        path: '/error',
        name: 'error',
        pageBuilder: (context, state) {
          final error = state.uri.queryParameters['message'] ?? 'Error desconocido';
          return _buildPage(
            context,
            state,
            ErrorScreen(error: error),
          );
        },
      ),
    ],
    
    // ===== ERROR HANDLING =====
    errorPageBuilder: (context, state) => _buildPage(
      context,
      state,
      ErrorScreen(
        error: 'Página no encontrada: ${state.uri}',
        onRetry: () => context.go('/'),
      ),
    ),
    
    // ===== REDIRECT LOGIC =====
    redirect: (context, state) {
      // Add any global redirect logic here if needed
      return null;
    },
  );
});

// ===== PAGE BUILDER HELPER =====
Page<void> _buildPage(
  BuildContext context,
  GoRouterState state,
  Widget child, {
  String? name,
  bool maintainState = true,
  bool fullscreenDialog = false,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    name: name ?? state.name,
    child: child,
    maintainState: maintainState,
    fullscreenDialog: fullscreenDialog,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Custom page transitions
      return _buildPageTransition(
        context,
        animation,
        secondaryAnimation,
        child,
        state.uri.path,
      );
    },
  );
}

// ===== PAGE TRANSITIONS =====
Widget _buildPageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
  String path,
) {
  // Different transitions for different route types
  if (path.contains('/game/') || path.contains('/trivia') || path.contains('/speed-games/')) {
    // Game screens - slide from right
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
      ),
      child: child,
    );
  } else if (path.contains('/admin') || path.contains('/settings')) {
    // Admin/Settings screens - slide from bottom
    return SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
      ),
      child: child,
    );
  } else if (path.contains('/level-select')) {
    // Level select screens - scale and fade
    return ScaleTransition(
      scale: animation.drive(
        Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  } else {
    // Default transition - fade
    return FadeTransition(
      opacity: animation.drive(
        CurveTween(curve: Curves.easeInOut),
      ),
      child: child,
    );
  }
}

// ===== NAVIGATION EXTENSIONS =====
extension AppRouterExtension on BuildContext {
  // Convenience methods for navigation
  void goToMemoryGame(String difficulty) {
    go('/memory/game/$difficulty');
  }
  
  void goToSpeedGame(String gameType) {
    go('/speed-games/$gameType');
  }
  
  void goToAdmin({String? tab}) {
    final uri = tab != null ? '/admin?tab=$tab' : '/admin';
    go(uri);
  }
  
  void goHome() {
    go('/');
  }
  
  void goBack() {
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

// ===== ROUTE INFORMATION =====
class AppRoutes {
  static const String home = '/';
  static const String memoryLevelSelect = '/memory/level-select';
  static const String trivia = '/trivia';
  static const String speedGames = '/speed-games';
  static const String admin = '/admin';
  static const String settings = '/settings';
  static const String error = '/error';
  
  // Parameterized routes
  static String memoryGame(String difficulty) => '/memory/game/$difficulty';
  static String speedGame(String gameType) => '/speed-games/$gameType';
  static String adminWithTab(String tab) => '/admin?tab=$tab';
}

// ===== NAVIGATION GUARD =====
class NavigationGuard {
  static bool canNavigateToGame(BuildContext context) {
    // Add any game navigation logic here
    // For example, check if configuration is complete
    return true;
  }
  
  static bool canNavigateToAdmin(BuildContext context) {
    // Add any admin navigation logic here
    return true;
  }
}