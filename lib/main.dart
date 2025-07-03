// lib/main.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'core/theme/app_theme.dart';
import 'data/models/game_models.dart';
import 'presentation/providers/game_providers.dart';
import 'router/app_router.dart';

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize desktop window if running on desktop
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await _initializeDesktopWindow();
  }
  
  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  
  // Set preferred orientations (mainly for mobile, but good to have)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Run the app with Riverpod
  runApp(
    const ProviderScope(
      child: EventGameSuiteApp(),
    ),
  );
}

Future<void> _initializeDesktopWindow() async {
  await windowManager.ensureInitialized();
  
  const windowOptions = WindowOptions(
    size: Size(1024, 768),
    minimumSize: Size(800, 600),
    maximumSize: Size(1920, 1080),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    windowButtonVisibility: true,
  );
  
  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setTitle('Suite de Juegos para Eventos');
  });
}

class EventGameSuiteApp extends ConsumerWidget {
  const EventGameSuiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final configAsync = ref.watch(gameConfigNotifierProvider);
    
    return configAsync.when(
      loading: () => MaterialApp(
        title: 'Suite de Juegos - Cargando',
        theme: AppTheme.createTheme(ColorPalette.sunset),
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      error: (error, stack) => MaterialApp(
        title: 'Suite de Juegos - Error',
        theme: AppTheme.createTheme(ColorPalette.sunset),
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error al cargar la aplicación',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app by invalidating the provider
                    ref.invalidate(gameConfigNotifierProvider);
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        ),
      ),
      data: (config) => MaterialApp.router(
        title: 'Suite de Juegos para Eventos',
        
        // Theme configuration
        theme: AppTheme.createTheme(config.colorPalette),
        
        // Router configuration
        routerConfig: router,
        
        // Debug configuration
        debugShowCheckedModeBanner: false,
        
        // Localization (for future use)
        locale: const Locale('es', 'AR'),
        
        // Scroll behavior for desktop
        scrollBehavior: const _DesktopScrollBehavior(),
        
        // Builder for global configurations
        builder: (context, child) {
          return _AppWrapper(
            config: config,
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}

class _AppWrapper extends StatelessWidget {
  final GameConfig config;
  final Widget child;

  const _AppWrapper({
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppTheme.parseColor(config.colorPalette.background),
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0, // Prevent text scaling for consistent UI
        ),
        child: child,
      ),
    );
  }
}

class _DesktopScrollBehavior extends ScrollBehavior {
  const _DesktopScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }
}