// lib/presentation/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';
import '../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../widgets/common_widgets.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
        );

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(gameConfigNotifierProvider);

    return configAsync.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
      data: (config) => _buildSettingsScreen(context, config),
    );
  }

  Widget _buildSettingsScreen(BuildContext context, GameConfig config) {
    final isDesktop = AppTheme.isDesktop(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // Header
                _buildHeader(context, config),

                // Settings content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isDesktop ? 32 : 24),
                    child: Column(
                      children: [
                        // Audio & Visual Settings
                        _buildAudioVisualSection(context, config),

                        const SizedBox(height: 24),

                        // Display Settings
                        _buildDisplaySection(context, config),

                        const SizedBox(height: 24),

                        // Game Preferences
                        _buildGamePreferencesSection(context, config),

                        const SizedBox(height: 24),

                        // Data & Privacy
                        _buildDataPrivacySection(context, config),

                        const SizedBox(height: 24),

                        // About Section
                        _buildAboutSection(context, config),

                        const SizedBox(height: 32),

                        // Reset Button
                        _buildResetSection(context, config),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GameConfig config) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppTheme.createPrimaryGradient(config.colorPalette),
        boxShadow: [
          BoxShadow(
            color: AppTheme.parseColor(
              config.colorPalette.primary,
            ).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚙️ Configuración',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'GameFont',
                  ),
                ),
                Text(
                  'Personaliza tu experiencia',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline, color: Colors.white),
            onPressed: () => _showAppInfo(context, config),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioVisualSection(BuildContext context, GameConfig config) {
    return _buildSettingsCard('🔊 Audio y Visuales', [
      _buildSwitchSetting(
        '🔊 Efectos de Sonido',
        'Sonidos para acciones y eventos',
        config.soundEnabled,
        (value) => _updateSoundEnabled(value),
        icon: Icons.volume_up,
      ),

      _buildSliderSetting(
        '🔊 Volumen General',
        'Controla el volumen de todos los sonidos',
        config.volume,
        (value) => _updateVolume(value),
        enabled: config.soundEnabled,
        icon: Icons.volume_up,
      ),

      _buildSwitchSetting(
        '✨ Animaciones',
        'Efectos visuales y transiciones',
        config.animationsEnabled,
        (value) => _updateAnimationsEnabled(value),
        icon: Icons.auto_awesome,
      ),

      _buildDropdownSetting<String>(
        '🎨 Tema Visual',
        'Selecciona el estilo visual',
        config.colorPalette.name,
        DefaultData.extendedColorPalettes.map((p) => p.name).toList(),
        (value) => _updateColorPalette(value!),
        icon: Icons.palette,
      ),
    ]);
  }

  Widget _buildDisplaySection(BuildContext context, GameConfig config) {
    return _buildSettingsCard('🖥️ Pantalla', [
      _buildActionSetting(
        '📱 Pantalla Completa',
        'Alternar modo pantalla completa',
        () => _toggleFullscreen(),
        icon: Icons.fullscreen,
      ),

      _buildActionSetting(
        '🖼️ Siempre Visible',
        'Mantener ventana siempre visible',
        () => _toggleAlwaysOnTop(),
        icon: Icons.push_pin,
      ),

      _buildDropdownSetting<String>(
        '📏 Tamaño de Ventana',
        'Tamaño predefinido de la ventana',
        'Normal',
        ['Pequeña', 'Normal', 'Grande', 'Máxima'],
        (value) => _setWindowSize(value!),
        icon: Icons.aspect_ratio,
      ),
    ]);
  }

  Widget _buildGamePreferencesSection(BuildContext context, GameConfig config) {
    return _buildSettingsCard('🎮 Preferencias de Juego', [
      _buildDropdownSetting<String>(
        '🎯 Dificultad por Defecto',
        'Nivel de dificultad inicial',
        'Normal',
        ['Fácil', 'Normal', 'Difícil'],
        (value) => {},
        icon: Icons.tune,
      ),

      _buildSwitchSetting(
        '💡 Consejos Automáticos',
        'Mostrar consejos durante los juegos',
        true,
        (value) => {},
        icon: Icons.lightbulb,
      ),

      _buildSwitchSetting(
        '📊 Guardar Estadísticas',
        'Registrar progreso y puntuaciones',
        true,
        (value) => {},
        icon: Icons.analytics,
      ),

      _buildSwitchSetting(
        '🕐 Pausar en Segundo Plano',
        'Pausar juegos al cambiar de ventana',
        true,
        (value) => {},
        icon: Icons.pause_circle,
      ),
    ]);
  }

  Widget _buildDataPrivacySection(BuildContext context, GameConfig config) {
    return _buildSettingsCard('🔒 Datos y Privacidad', [
      _buildActionSetting(
        '📤 Exportar Datos',
        'Crear respaldo de configuración',
        () => _exportData(config),
        icon: Icons.upload,
      ),

      _buildActionSetting(
        '📥 Importar Datos',
        'Restaurar desde respaldo',
        () => _importData(),
        icon: Icons.download,
      ),

      _buildActionSetting(
        '🗑️ Borrar Estadísticas',
        'Eliminar historial de juegos',
        () => _clearStats(),
        icon: Icons.delete_sweep,
        isDestructive: true,
      ),

      _buildInfoSetting(
        '🔐 Privacidad',
        'Todos los datos se almacenan localmente',
        icon: Icons.privacy_tip,
      ),
    ]);
  }

  Widget _buildAboutSection(BuildContext context, GameConfig config) {
    return _buildSettingsCard('ℹ️ Acerca de', [
      _buildInfoSetting(
        '📱 Versión',
        '2.0.0 (Flutter Desktop)',
        icon: Icons.info,
      ),

      _buildInfoSetting(
        '🛠️ Motor de Juegos',
        'Flame Engine 1.18+',
        icon: Icons.videogame_asset,
      ),

      _buildActionSetting(
        '⭐ Calificar App',
        'Comparte tu experiencia',
        () => _showRatingDialog(context, config),
        icon: Icons.star,
      ),

      _buildActionSetting(
        '📧 Soporte',
        'Contactar desarrolladores',
        () => _showSupportDialog(context, config),
        icon: Icons.support,
      ),
    ]);
  }

  Widget _buildResetSection(BuildContext context, GameConfig config) {
    return _buildSettingsCard('🔄 Restaurar', [
      _buildActionSetting(
        '🔄 Restaurar Configuración',
        'Volver a valores por defecto',
        () => _showResetDialog(context, config),
        icon: Icons.restore,
        isDestructive: true,
      ),
    ]);
  }

  Widget _buildSettingsCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'GameFont',
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.2);
  }

  Widget _buildSwitchSetting(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged, {
    IconData? icon,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.parseColor(
          ref.read(gameConfigNotifierProvider).value?.colorPalette.primary ??
              '#3182CE',
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSliderSetting(
    String title,
    String subtitle,
    double value,
    ValueChanged<double> onChanged, {
    bool enabled = true,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: icon != null ? Icon(icon) : null,
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(subtitle),
          trailing: Text(
            '${(value * 100).round()}%',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        Slider(
          value: value,
          onChanged: enabled ? onChanged : null,
          activeColor: AppTheme.parseColor(
            ref.read(gameConfigNotifierProvider).value?.colorPalette.primary ??
                '#3182CE',
          ),
          inactiveColor: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget _buildDropdownSetting<T>(
    String title,
    String subtitle,
    T value,
    List<T> options,
    ValueChanged<T?> onChanged, {
    IconData? icon,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: options
            .map(
              (option) => DropdownMenuItem<T>(
                value: option,
                child: Text(option.toString()),
              ),
            )
            .toList(),
        underline: const SizedBox(),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildActionSetting(
    String title,
    String subtitle,
    VoidCallback onTap, {
    IconData? icon,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, color: isDestructive ? Colors.red : null)
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildInfoSetting(String title, String value, {IconData? icon}) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: Text(
        value,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w500,
        ),
      ),
      contentPadding: EdgeInsets.zero,
    );
  }

  // Settings actions
  void _updateSoundEnabled(bool enabled) {
    // TODO: Implement sound enabled update
    HapticFeedback.lightImpact();
  }

  void _updateVolume(double volume) {
    // TODO: Implement volume update
  }

  void _updateAnimationsEnabled(bool enabled) {
    // TODO: Implement animations enabled update
  }

  void _updateColorPalette(String paletteName) {
    final palette = DefaultData.extendedColorPalettes.firstWhere(
      (p) => p.name == paletteName,
      orElse: () => DefaultData.extendedColorPalettes.first,
    );

    ref.read(gameConfigNotifierProvider.notifier).updateColorPalette(palette);
  }

  Future<void> _toggleFullscreen() async {
    try {
      final isFullscreen = await WindowManager.instance.isFullScreen();
      await WindowManager.instance.setFullScreen(!isFullscreen);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFullscreen
                ? 'Modo ventana activado'
                : 'Pantalla completa activada',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cambiar modo de pantalla')),
      );
    }
  }

  Future<void> _toggleAlwaysOnTop() async {
    try {
      final isAlwaysOnTop = await WindowManager.instance.isAlwaysOnTop();
      await WindowManager.instance.setAlwaysOnTop(!isAlwaysOnTop);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isAlwaysOnTop ? 'Ventana normal' : 'Ventana siempre visible',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al cambiar configuración de ventana'),
        ),
      );
    }
  }

  Future<void> _setWindowSize(String size) async {
    Size windowSize;

    switch (size) {
      case 'Pequeña':
        windowSize = const Size(800, 600);
        break;
      case 'Normal':
        windowSize = const Size(1024, 768);
        break;
      case 'Grande':
        windowSize = const Size(1280, 960);
        break;
      case 'Máxima':
        await WindowManager.instance.maximize();
        return;
      default:
        windowSize = const Size(1024, 768);
    }

    try {
      await WindowManager.instance.setSize(windowSize);
      await WindowManager.instance.center();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tamaño de ventana cambiado a $size'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al cambiar tamaño de ventana')),
      );
    }
  }

  void _exportData(GameConfig config) {
    // TODO: Implement data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de exportación en desarrollo')),
    );
  }

  void _importData() {
    // TODO: Implement data import
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de importación en desarrollo')),
    );
  }

  void _clearStats() {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: '¿Borrar estadísticas?',
        message:
            'Se eliminarán todas las puntuaciones y progreso. Esta acción no se puede deshacer.',
        confirmText: 'Borrar',
        cancelText: 'Cancelar',
        confirmColor: Colors.red,
        icon: Icons.delete_forever,
        onConfirm: () {
          // TODO: Implement clear stats
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Estadísticas eliminadas')),
          );
        },
      ),
    );
  }

  void _showAppInfo(BuildContext context, GameConfig config) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🎮', style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'Suite de Juegos para Eventos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.parseColor(config.colorPalette.primary),
                  fontFamily: 'GameFont',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Versión 2.0.0',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              Text(
                'Desarrollado con Flutter y Flame Engine para crear experiencias de juego únicas en eventos especiales.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              GameButton(
                text: 'Cerrar',
                onPressed: () => Navigator.of(context).pop(),
                color: AppTheme.parseColor(config.colorPalette.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRatingDialog(BuildContext context, GameConfig config) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('⭐', style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                '¿Te gusta la app?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.parseColor(config.colorPalette.primary),
                  fontFamily: 'GameFont',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Tu opinión nos ayuda a mejorar y crear mejores experiencias de juego.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GameButton(
                      text: 'Más tarde',
                      onPressed: () => Navigator.of(context).pop(),
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GameButton(
                      text: 'Calificar',
                      onPressed: () {
                        Navigator.of(context).pop();
                        // TODO: Open rating system
                      },
                      color: AppTheme.parseColor(config.colorPalette.primary),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSupportDialog(BuildContext context, GameConfig config) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('📧', style: const TextStyle(fontSize: 64)),
              const SizedBox(height: 16),
              Text(
                'Soporte Técnico',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.parseColor(config.colorPalette.primary),
                  fontFamily: 'GameFont',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '¿Tienes algún problema o sugerencia? Estamos aquí para ayudarte.',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: const Text('soporte@eventgames.com'),
                    onTap: () {
                      // TODO: Open email client
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bug_report),
                    title: const Text('Reportar Error'),
                    subtitle: const Text('Enviar reporte de problema'),
                    onTap: () {
                      // TODO: Open bug report
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text('Documentación'),
                    subtitle: const Text('Guías y tutoriales'),
                    onTap: () {
                      // TODO: Open documentation
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              GameButton(
                text: 'Cerrar',
                onPressed: () => Navigator.of(context).pop(),
                color: AppTheme.parseColor(config.colorPalette.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog(BuildContext context, GameConfig config) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: '¿Restaurar configuración?',
        message:
            'Se perderán todas las configuraciones personalizadas y volverán a los valores por defecto.',
        confirmText: 'Restaurar',
        cancelText: 'Cancelar',
        confirmColor: Colors.red,
        icon: Icons.restore,
        onConfirm: () {
          ref.read(gameConfigNotifierProvider.notifier).resetConfig();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Configuración restaurada a valores por defecto'),
            ),
          );
        },
      ),
    );
  }
}
