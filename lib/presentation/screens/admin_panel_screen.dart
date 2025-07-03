// lib/presentation/screens/admin_panel_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';

import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';
import '../../core/theme/app_theme.dart';
import '../providers/game_providers.dart';
import '../widgets/common_widgets.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  final String? initialTab;

  const AdminPanelScreen({
    super.key,
    this.initialTab,
  });

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen>
    with TickerProviderStateMixin {
  
  late TabController _tabController;
  int _currentTabIndex = 0;

  final List<_AdminTab> _tabs = [
    _AdminTab('general', 'General', Icons.settings, '⚙️'),
    _AdminTab('trivia', 'Trivia', Icons.quiz, '🎯'),
    _AdminTab('design', 'Diseño', Icons.palette, '🎨'),
    _AdminTab('stats', 'Estadísticas', Icons.bar_chart, '📊'),
    _AdminTab('backup', 'Respaldo', Icons.backup, '💾'),
  ];

  @override
  void initState() {
    super.initState();
    
    // Find initial tab index
    if (widget.initialTab != null) {
      final index = _tabs.indexWhere((tab) => tab.id == widget.initialTab);
      _currentTabIndex = index >= 0 ? index : 0;
    }
    
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: _currentTabIndex,
    );
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(gameConfigNotifierProvider);
    
    return configAsync.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
      data: (config) => _buildAdminPanel(context, config),
    );
  }

  Widget _buildAdminPanel(BuildContext context, GameConfig config) {
    final isDesktop = AppTheme.isDesktop(context);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, config),
              
              // Tab Bar
              _buildTabBar(context, config, isDesktop),
              
              // Tab Content
              Expanded(
                child: _buildTabContent(context, config, isDesktop),
              ),
            ],
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
            color: AppTheme.parseColor(config.colorPalette.primary).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            onPressed: () => context.go('/'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚙️ Panel de Administración',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'GameFont',
                  ),
                ),
                Text(
                  'Personaliza tu experiencia de juego',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () => _showHelpDialog(context, config),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, GameConfig config, bool isDesktop) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: isDesktop 
          ? _buildDesktopTabBar(context, config)
          : _buildMobileTabBar(context, config),
    );
  }

  Widget _buildDesktopTabBar(BuildContext context, GameConfig config) {
    return Row(
      children: _tabs.asMap().entries.map((entry) {
        final index = entry.key;
        final tab = entry.value;
        final isSelected = index == _currentTabIndex;
        
        return Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _tabController.animateTo(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected 
                          ? Colors.white 
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      tab.emoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tab.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMobileTabBar(BuildContext context, GameConfig config) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == _currentTabIndex;
          
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _tabController.animateTo(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected 
                          ? Colors.white 
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tab.emoji,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      tab.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, GameConfig config, bool isDesktop) {
    return TabBarView(
      controller: _tabController,
      children: [
        _GeneralTab(config: config),
        _TriviaTab(config: config),
        _DesignTab(config: config),
        _StatsTab(config: config),
        _BackupTab(config: config),
      ],
    );
  }

  void _showHelpDialog(BuildContext context, GameConfig config) {
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
              Text(
                '❓ Ayuda del Panel',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.parseColor(config.colorPalette.primary),
                  fontFamily: 'GameFont',
                ),
              ),
              const SizedBox(height: 16),
              ..._tabs.map((tab) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Text(tab.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tab.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _getTabDescription(tab.id),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
              const SizedBox(height: 24),
              GameButton(
                text: 'Entendido',
                onPressed: () => Navigator.of(context).pop(),
                color: AppTheme.parseColor(config.colorPalette.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTabDescription(String tabId) {
    switch (tabId) {
      case 'general':
        return 'Configuración básica del evento y juegos';
      case 'trivia':
        return 'Administrar preguntas y categorías de trivia';
      case 'design':
        return 'Personalizar colores y tema visual';
      case 'stats':
        return 'Ver estadísticas y progreso de juegos';
      case 'backup':
        return 'Exportar, importar y respaldar configuración';
      default:
        return '';
    }
  }
}

// ===== TAB DATA CLASS =====
class _AdminTab {
  final String id;
  final String name;
  final IconData icon;
  final String emoji;

  _AdminTab(this.id, this.name, this.icon, this.emoji);
}

// ===== GENERAL TAB =====
class _GeneralTab extends ConsumerStatefulWidget {
  final GameConfig config;

  const _GeneralTab({required this.config});

  @override
  ConsumerState<_GeneralTab> createState() => _GeneralTabState();
}

class _GeneralTabState extends ConsumerState<_GeneralTab> {
  late TextEditingController _eventNameController;
  late TextEditingController _honoredPersonController;
  late EventType _selectedEventType;
  late String _selectedDate;
  
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController(text: widget.config.eventName);
    _honoredPersonController = TextEditingController(text: widget.config.honoredPerson);
    _selectedEventType = widget.config.eventType;
    _selectedDate = widget.config.eventDate;
    
    _eventNameController.addListener(_onTextChanged);
    _honoredPersonController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _honoredPersonController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _hasUnsavedChanges = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppTheme.isDesktop(context);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Information Section
          _buildSectionCard(
            '📝 Información del Evento',
            [
              _buildTextField(
                'Nombre del Evento',
                _eventNameController,
                'Mi Evento Especial',
                Icons.event,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Persona Homenajeada',
                _honoredPersonController,
                'Nombre de la persona',
                Icons.person,
              ),
              const SizedBox(height: 16),
              _buildEventTypeSelector(),
              const SizedBox(height: 16),
              _buildDateSelector(),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Game Settings Section
          _buildSectionCard(
            '🎮 Configuración de Juegos',
            [
              _buildGameToggle(
                '🧠 Memory Game',
                'Juego de memoria con cartas',
                true, // Always enabled for now
                null, // Can't disable
              ),
              const SizedBox(height: 12),
              _buildGameToggle(
                '🎯 Trivia Game',
                'Preguntas y respuestas personalizadas',
                widget.config.triviaQuestions.isNotEmpty,
                () {
                  // Navigate to trivia tab
                  DefaultTabController.of(context).animateTo(1);
                },
              ),
              const SizedBox(height: 12),
              _buildGameToggle(
                '⚡ Speed Games',
                'Juegos de velocidad y reflejos',
                true, // Always enabled
                null,
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Audio & Performance Settings
          _buildSectionCard(
            '🔧 Configuración Avanzada',
            [
              _buildSwitchTile(
                '🔊 Sonidos del Juego',
                'Efectos de sonido y música',
                widget.config.soundEnabled,
                (value) => _updateConfig(soundEnabled: value),
              ),
              _buildSwitchTile(
                '✨ Animaciones',
                'Efectos visuales y transiciones',
                widget.config.animationsEnabled,
                (value) => _updateConfig(animationsEnabled: value),
              ),
              _buildVolumeSlider(),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Save Button
          if (_hasUnsavedChanges)
            SizedBox(
              width: double.infinity,
              child: GameButton(
                text: '💾 Guardar Cambios',
                onPressed: _saveChanges,
                color: AppTheme.parseColor(widget.config.colorPalette.primary),
              ),
            ).animate().fadeIn().slideY(begin: 0.3),
        ],
      ),
    );
  }

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLG),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.parseColor(widget.config.colorPalette.primary),
                fontFamily: 'GameFont',
              ),
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
              borderSide: BorderSide(
                color: AppTheme.parseColor(widget.config.colorPalette.primary),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tipo de Evento',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<EventType>(
          value: _selectedEventType,
          decoration: InputDecoration(
            prefixIcon: Text(
              DefaultData.eventTypeEmojis[_selectedEventType] ?? '🎉',
              style: const TextStyle(fontSize: 20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            ),
          ),
          items: EventType.values.map((type) => DropdownMenuItem(
            value: type,
            child: Row(
              children: [
                Text(
                  DefaultData.eventTypeEmojis[type] ?? '🎉',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 12),
                Text(DefaultData.eventTypeNames[type] ?? type.name),
              ],
            ),
          )).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedEventType = value;
                _hasUnsavedChanges = true;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fecha del Evento',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.tryParse(_selectedDate) ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            
            if (date != null) {
              setState(() {
                _selectedDate = date.toIso8601String().split('T')[0];
                _hasUnsavedChanges = true;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(AppTheme.radiusMD),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 12),
                Text(
                  _selectedDate.isNotEmpty 
                      ? _formatDate(_selectedDate)
                      : 'Seleccionar fecha',
                  style: TextStyle(
                    fontSize: 16,
                    color: _selectedDate.isNotEmpty 
                        ? Colors.black87 
                        : Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameToggle(
    String title,
    String subtitle,
    bool isEnabled,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isEnabled 
              ? AppTheme.parseColor(widget.config.colorPalette.primary).withOpacity(0.1)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(AppTheme.radiusSM),
        ),
        child: Icon(
          isEnabled ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isEnabled 
              ? AppTheme.parseColor(widget.config.colorPalette.primary)
              : Colors.grey.shade400,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: onTap != null ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: AppTheme.parseColor(widget.config.colorPalette.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
      ),
    );
  }

  Widget _buildVolumeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '🔊 Volumen',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Slider(
          value: widget.config.volume,
          min: 0.0,
          max: 1.0,
          divisions: 10,
          label: '${(widget.config.volume * 100).round()}%',
          onChanged: widget.config.soundEnabled 
              ? (value) => _updateConfig(volume: value)
              : null,
          activeColor: AppTheme.parseColor(widget.config.colorPalette.primary),
        ),
      ],
    );
  }

  void _updateConfig({
    bool? soundEnabled,
    bool? animationsEnabled,
    double? volume,
  }) {
    final notifier = ref.read(gameConfigNotifierProvider.notifier);
    
    if (soundEnabled != null) {
      // Update sound enabled
    }
    if (animationsEnabled != null) {
      // Update animations enabled
    }
    if (volume != null) {
      // Update volume
    }
  }

  void _saveChanges() {
    final notifier = ref.read(gameConfigNotifierProvider.notifier);
    
    notifier.updateEventName(_eventNameController.text);
    notifier.updateHonoredPerson(_honoredPersonController.text);
    notifier.updateEventType(_selectedEventType);
    notifier.updateEventDate(_selectedDate);
    
    setState(() {
      _hasUnsavedChanges = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('¡Configuración guardada exitosamente!'),
        backgroundColor: AppTheme.parseColor(widget.config.colorPalette.primary),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}

// ===== TRIVIA TAB =====
class _TriviaTab extends ConsumerStatefulWidget {
  final GameConfig config;

  const _TriviaTab({required this.config});

  @override
  ConsumerState<_TriviaTab> createState() => _TriviaTabState();
}

class _TriviaTabState extends ConsumerState<_TriviaTab> {
  bool _showAddForm = false;
  TriviaQuestion? _editingQuestion;

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(triviaQuestionsNotifierProvider);
    final isDesktop = AppTheme.isDesktop(context);
    
    return SingleChildScrollView(
      padding: EdgeInsets.all(isDesktop ? 32 : 24),
      child: Column(
        children: [
          // Header with stats
          _buildTriviaHeader(questions),
          
          const SizedBox(height: 24),
          
          // Add question button
          if (!_showAddForm && _editingQuestion == null)
            SizedBox(
              width: double.infinity,
              child: GameButton(
                text: '➕ Agregar Nueva Pregunta',
                onPressed: () => setState(() => _showAddForm = true),
                color: AppTheme.parseColor(widget.config.colorPalette.primary),
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Add/Edit form
          if (_showAddForm || _editingQuestion != null)
            _TriviaQuestionForm(
              question: _editingQuestion,
              colorPalette: widget.config.colorPalette,
              honoredPerson: widget.config.honoredPerson,
              onSave: (question) {
                if (_editingQuestion != null) {
                  ref.read(triviaQuestionsNotifierProvider.notifier)
                      .updateQuestion(_editingQuestion!.id, question);
                } else {
                  ref.read(triviaQuestionsNotifierProvider.notifier)
                      .addQuestion(question);
                }
                setState(() {
                  _showAddForm = false;
                  _editingQuestion = null;
                });
              },
              onCancel: () {
                setState(() {
                  _showAddForm = false;
                  _editingQuestion = null;
                });
              },
            ),
          
          const SizedBox(height: 24),
          
          // Questions list
          _buildQuestionsList(questions),
        ],
      ),
    );
  }

  Widget _buildTriviaHeader(List<TriviaQuestion> questions) {
    final categoryCounts = <String, int>{};
    final difficultyCounts = <DifficultyLevel, int>{};
    
    for (final question in questions) {
      categoryCounts[question.category] = (categoryCounts[question.category] ?? 0) + 1;
      difficultyCounts[question.difficulty] = (difficultyCounts[question.difficulty] ?? 0) + 1;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '🎯 Gestión de Trivia',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.parseColor(widget.config.colorPalette.primary),
                fontFamily: 'GameFont',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatColumn('📝', questions.length.toString(), 'Preguntas'),
                _buildStatColumn('📂', categoryCounts.length.toString(), 'Categorías'),
                _buildStatColumn('🎯', difficultyCounts.length.toString(), 'Niveles'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.parseColor(widget.config.colorPalette.primary),
            fontFamily: 'GameFont',
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionsList(List<TriviaQuestion> questions) {
    if (questions.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            children: [
              Text(
                '❓',
                style: const TextStyle(fontSize: 64),
              ),
              const SizedBox(height: 16),
              Text(
                'No hay preguntas aún',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '¡Agrega tu primera pregunta para comenzar!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preguntas Existentes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.parseColor(widget.config.colorPalette.primary),
            fontFamily: 'GameFont',
          ),
        ),
        const SizedBox(height: 16),
        ...questions.asMap().entries.map((entry) {
          final index = entry.key;
          final question = entry.value;
          
          return _TriviaQuestionCard(
            question: question,
            index: index + 1,
            colorPalette: widget.config.colorPalette,
            honoredPerson: widget.config.honoredPerson,
            onEdit: () => setState(() => _editingQuestion = question),
            onDelete: () => _deleteQuestion(question),
          );
        }).toList(),
      ],
    );
  }

  void _deleteQuestion(TriviaQuestion question) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: '¿Eliminar pregunta?',
        message: 'Esta acción no se puede deshacer.',
        confirmText: 'Eliminar',
        cancelText: 'Cancelar',
        confirmColor: Colors.red,
        icon: Icons.delete,
        onConfirm: () {
          ref.read(triviaQuestionsNotifierProvider.notifier)
              .removeQuestion(question.id);
        },
      ),
    );
  }
}

// ===== TRIVIA QUESTION CARD =====
class _TriviaQuestionCard extends StatelessWidget {
  final TriviaQuestion question;
  final int index;
  final ColorPalette colorPalette;
  final String honoredPerson;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _TriviaQuestionCard({
    required this.question,
    required this.index,
    required this.colorPalette,
    required this.honoredPerson,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.parseColor(colorPalette.primary),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.parseColor(colorPalette.primary).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              question.category,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.parseColor(colorPalette.primary),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(question.difficulty).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              question.difficulty.name,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getDifficultyColor(question.difficulty),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Question
            Text(
              question.question.replaceAll('[NOMBRE]', honoredPerson),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Options
            ...question.options.asMap().entries.map((entry) {
              final optionIndex = entry.key;
              final option = entry.value;
              final isCorrect = optionIndex == question.correctAnswer;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + optionIndex),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isCorrect ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isCorrect ? FontWeight.w600 : FontWeight.normal,
                          color: isCorrect ? Colors.green.shade700 : Colors.grey.shade700,
                        ),
                      ),
                    ),
                    if (isCorrect)
                      const Icon(Icons.check_circle, color: Colors.green, size: 16),
                  ],
                ),
              );
            }).toList(),
            
            // Points
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  '${question.points} puntos',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.easy:
        return Colors.green;
      case DifficultyLevel.medium:
        return Colors.orange;
      case DifficultyLevel.hard:
        return Colors.red;
    }
  }
}

// ===== TRIVIA QUESTION FORM =====
class _TriviaQuestionForm extends StatefulWidget {
  final TriviaQuestion? question;
  final ColorPalette colorPalette;
  final String honoredPerson;
  final Function(TriviaQuestion) onSave;
  final VoidCallback onCancel;

  const _TriviaQuestionForm({
    this.question,
    required this.colorPalette,
    required this.honoredPerson,
    required this.onSave,
    required this.onCancel,
  });

  @override
  State<_TriviaQuestionForm> createState() => _TriviaQuestionFormState();
}

class _TriviaQuestionFormState extends State<_TriviaQuestionForm> {
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  late int _correctAnswer;
  late String _selectedCategory;
  late DifficultyLevel _selectedDifficulty;
  late int _points;

  @override
  void initState() {
    super.initState();
    
    _questionController = TextEditingController(
      text: widget.question?.question ?? '',
    );
    
    _optionControllers = List.generate(4, (index) {
      return TextEditingController(
        text: widget.question?.options[index] ?? '',
      );
    });
    
    _correctAnswer = widget.question?.correctAnswer ?? 0;
    _selectedCategory = widget.question?.category ?? DefaultData.triviaCategories.first;
    _selectedDifficulty = widget.question?.difficulty ?? DifficultyLevel.easy;
    _points = widget.question?.points ?? 100;
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (final controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question != null ? '✏️ Editar Pregunta' : '➕ Nueva Pregunta',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.parseColor(widget.colorPalette.primary),
                fontFamily: 'GameFont',
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Question field
            TextField(
              controller: _questionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Pregunta (usa [NOMBRE] para el nombre del homenajeado)',
                hintText: '¿Cuál es el color favorito de [NOMBRE]?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Options
            Text(
              'Opciones de Respuesta',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            ...List.generate(4, (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Radio<int>(
                    value: index,
                    groupValue: _correctAnswer,
                    onChanged: (value) => setState(() => _correctAnswer = value!),
                    activeColor: AppTheme.parseColor(widget.colorPalette.primary),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _optionControllers[index],
                      decoration: InputDecoration(
                        labelText: 'Opción ${String.fromCharCode(65 + index)}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                        ),
                        suffixIcon: _correctAnswer == index 
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            
            const SizedBox(height: 20),
            
            // Category and Difficulty
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: InputDecoration(
                      labelText: 'Categoría',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                      ),
                    ),
                    items: DefaultData.triviaCategories.map((category) => 
                      DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    ).toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value!),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<DifficultyLevel>(
                    value: _selectedDifficulty,
                    decoration: InputDecoration(
                      labelText: 'Dificultad',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                      ),
                    ),
                    items: DifficultyLevel.values.map((difficulty) => 
                      DropdownMenuItem(
                        value: difficulty,
                        child: Text(difficulty.name),
                      ),
                    ).toList(),
                    onChanged: (value) => setState(() => _selectedDifficulty = value!),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Points
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Puntos',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                ),
              ),
              controller: TextEditingController(text: _points.toString()),
              onChanged: (value) => _points = int.tryParse(value) ?? 100,
            ),
            
            const SizedBox(height: 24),
            
            // Buttons
            Row(
              children: [
                Expanded(
                  child: GameButton(
                    text: 'Cancelar',
                    onPressed: widget.onCancel,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GameButton(
                    text: widget.question != null ? 'Actualizar' : 'Guardar',
                    onPressed: _saveQuestion,
                    color: AppTheme.parseColor(widget.colorPalette.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveQuestion() {
    if (_questionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('La pregunta no puede estar vacía')),
      );
      return;
    }

    for (int i = 0; i < 4; i++) {
      if (_optionControllers[i].text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('La opción ${String.fromCharCode(65 + i)} no puede estar vacía')),
        );
        return;
      }
    }

    final question = TriviaQuestion(
      id: widget.question?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      question: _questionController.text.trim(),
      options: _optionControllers.map((c) => c.text.trim()).toList(),
      correctAnswer: _correctAnswer,
      category: _selectedCategory,
      difficulty: _selectedDifficulty,
      points: _points,
    );

    widget.onSave(question);
  }
}

// Placeholder tabs - these would be fully implemented
class _DesignTab extends StatelessWidget {
  final GameConfig config;
  const _DesignTab({required this.config});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Design Tab - Color palettes, themes, etc.'),
    );
  }
}

class _StatsTab extends StatelessWidget {
  final GameConfig config;
  const _StatsTab({required this.config});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Stats Tab - Game statistics and analytics'),
    );
  }
}

class _BackupTab extends StatelessWidget {
  final GameConfig config;
  const _BackupTab({required this.config});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Backup Tab - Export/Import configurations'),
    );
  }
}