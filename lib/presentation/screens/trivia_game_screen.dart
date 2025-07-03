// lib/presentation/screens/trivia_game_screen.dart
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

class TriviaGameScreen extends ConsumerStatefulWidget {
  const TriviaGameScreen({super.key});

  @override
  ConsumerState<TriviaGameScreen> createState() => _TriviaGameScreenState();
}

class _TriviaGameScreenState extends ConsumerState<TriviaGameScreen>
    with TickerProviderStateMixin {
  
  // Game state
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _timeLeft = 30;
  int? _selectedAnswer;
  bool _showResult = false;
  bool _isGameCompleted = false;
  List<TriviaAnswer> _answers = [];
  Timer? _timer;

  // Animations
  late AnimationController _questionController;
  late AnimationController _timerController;
  late AnimationController _resultController;
  late AnimationController _confettiController;
  late AnimationController _scoreController;

  // Animations
  late Animation<double> _questionSlideAnimation;
  late Animation<double> _questionFadeAnimation;
  late Animation<double> _timerPulseAnimation;
  late Animation<double> _resultScaleAnimation;
  late Animation<Color?> _resultColorAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startGame();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _questionController.dispose();
    _timerController.dispose();
    _resultController.dispose();
    _confettiController.dispose();
    _scoreController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _timerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _resultController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _questionSlideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _questionController,
      curve: Curves.easeInOutCubic,
    ));

    _questionFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _questionController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    ));

    _timerPulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _timerController,
      curve: Curves.easeInOut,
    ));

    _resultScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _resultController,
      curve: Curves.elasticOut,
    ));

    _resultColorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.white,
    ).animate(_resultController);
  }

  void _startGame() {
    _questionController.forward();
    _startTimer();
  }

  void _startTimer() {
    _timeLeft = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _timeLeft--;
        });

        if (_timeLeft <= 5) {
          _timerController.repeat(reverse: true);
          HapticFeedback.lightImpact();
        }

        if (_timeLeft <= 0) {
          _handleAnswer(-1); // Time's up
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(gameConfigNotifierProvider);
    final triviaGameState = ref.watch(triviaGameNotifierProvider);
    
    return configAsync.when(
      loading: () => const LoadingScreen(),
      error: (error, stack) => ErrorScreen(error: error.toString()),
      data: (config) => _buildTriviaScreen(context, config),
    );
  }

  Widget _buildTriviaScreen(BuildContext context, GameConfig config) {
    final questions = config.triviaQuestions.isNotEmpty 
        ? config.triviaQuestions 
        : DefaultData.defaultTriviaQuestions;

    if (questions.isEmpty) {
      return _buildNoQuestionsScreen(context, config);
    }

    if (_isGameCompleted) {
      return _buildCompletionScreen(context, config, questions);
    }

    final currentQuestion = questions[_currentQuestionIndex];
    final isDesktop = AppTheme.isDesktop(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with progress
              _buildHeader(context, config, questions, isDesktop),
              
              // Timer and score bar
              _buildStatsBar(context, config),
              
              // Question area
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isDesktop ? 32 : 24),
                  child: Column(
                    children: [
                      // Question card
                      _buildQuestionCard(context, config, currentQuestion),
                      
                      const SizedBox(height: 32),
                      
                      // Answer options
                      _buildAnswerOptions(context, config, currentQuestion),
                      
                      // Result feedback
                      if (_showResult)
                        _buildResultFeedback(context, config, currentQuestion),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, GameConfig config, List<TriviaQuestion> questions, bool isDesktop) {
    final progress = (_currentQuestionIndex + 1) / questions.length;
    
    return Container(
      padding: EdgeInsets.all(isDesktop ? 24 : 20),
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
                onPressed: () => _onBackPressed(context),
              ),
              Expanded(
                child: Text(
                  '🎯 Trivia Familiar',
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'GameFont',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () => _showGameMenu(context, config),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Progress bar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pregunta ${_currentQuestionIndex + 1} de ${questions.length}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Puntos: $_score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ),
            ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Timer with pulse animation
          AnimatedBuilder(
            animation: _timerController,
            builder: (context, child) {
              return Transform.scale(
                scale: _timeLeft <= 5 ? _timerPulseAnimation.value : 1.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _timeLeft <= 5 ? Colors.red.shade600 : AppTheme.parseColor(config.colorPalette.secondary),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: _timeLeft <= 5 ? [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ] : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_timeLeft}s',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'GameFont',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, GameConfig config, TriviaQuestion question) {
    return AnimatedBuilder(
      animation: _questionController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_questionSlideAnimation.value * MediaQuery.of(context).size.width, 0),
          child: Opacity(
            opacity: _questionFadeAnimation.value,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                boxShadow: AppTheme.createElevatedShadow(config.colorPalette, elevation: 12),
              ),
              child: Column(
                children: [
                  // Category and difficulty
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.parseColor(config.colorPalette.primary).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '📂 ${question.category}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.parseColor(config.colorPalette.primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(question.difficulty).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '📊 ${question.difficulty.name}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _getDifficultyColor(question.difficulty),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Question emoji
                  Text(
                    '❓',
                    style: const TextStyle(fontSize: 48),
                  ).animate(onPlay: (controller) => controller.repeat())
                      .rotate(duration: 2000.ms, curve: Curves.easeInOut)
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
                  
                  const SizedBox(height: 24),
                  
                  // Question text
                  Text(
                    question.question.replaceAll('[NOMBRE]', ref.read(gameConfigNotifierProvider).value?.honoredPerson ?? 'la persona'),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.parseColor(config.colorPalette.primary),
                      fontFamily: 'GameFont',
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  // Question image if available
                  if (question.imageUrl != null && question.imageUrl!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                      child: Image.network(
                        question.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                            ),
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 48),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnswerOptions(BuildContext context, GameConfig config, TriviaQuestion question) {
    return Column(
      children: question.options.asMap().entries.map((entry) {
        final index = entry.key;
        final option = entry.value;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: _AnswerOptionButton(
            index: index,
            text: option,
            isSelected: _selectedAnswer == index,
            isCorrect: _showResult ? index == question.correctAnswer : null,
            isWrong: _showResult && _selectedAnswer == index && index != question.correctAnswer,
            colorPalette: config.colorPalette,
            onTap: _showResult ? null : () => _handleAnswer(index),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildResultFeedback(BuildContext context, GameConfig config, TriviaQuestion question) {
    final isCorrect = _selectedAnswer == question.correctAnswer;
    
    return AnimatedBuilder(
      animation: _resultController,
      builder: (context, child) {
        return Transform.scale(
          scale: _resultScaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.only(top: 32),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isCorrect ? Colors.green.shade100 : Colors.red.shade100,
              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              border: Border.all(
                color: isCorrect ? Colors.green : Colors.red,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Text(
                  isCorrect ? '🎉 ¡Correcto!' : _selectedAnswer == -1 ? '⏰ ¡Tiempo agotado!' : '❌ ¡Incorrecto!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                    fontFamily: 'GameFont',
                  ),
                ),
                
                if (isCorrect && _timeLeft > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Bonus de tiempo: +${_timeLeft * 2} puntos',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                
                if (question.explanation != null && question.explanation!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    question.explanation!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoQuestionsScreen(BuildContext context, GameConfig config) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '❓',
                  style: const TextStyle(fontSize: 120),
                ).animate(onPlay: (controller) => controller.repeat())
                    .scale(duration: 2000.ms, curve: Curves.easeInOut),
                
                const SizedBox(height: 32),
                
                Text(
                  'No hay preguntas configuradas',
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
                  'Ve al Panel de Administración para agregar preguntas de trivia personalizadas.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 48),
                
                Row(
                  children: [
                    Expanded(
                      child: GameButton(
                        text: '⚙️ Administración',
                        onPressed: () => context.goToAdmin(tab: 'trivia'),
                        color: AppTheme.parseColor(config.colorPalette.primary),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GameButton(
                        text: '🏠 Inicio',
                        onPressed: () => context.go('/'),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen(BuildContext context, GameConfig config, List<TriviaQuestion> questions) {
    final correctAnswers = _answers.where((a) => a.isCorrect).length;
    final accuracy = (correctAnswers / questions.length * 100).round();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.createBackgroundGradient(config.colorPalette),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Completion animation
                Text(
                  '🏆',
                  style: const TextStyle(fontSize: 120),
                ).animate()
                    .scale(duration: 1000.ms, curve: Curves.elasticOut)
                    .then()
                    .shimmer(duration: 2000.ms),
                
                const SizedBox(height: 32),
                
                Text(
                  '¡Juego Completado!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'GameFont',
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 32),
                
                // Stats container
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                    boxShadow: AppTheme.createElevatedShadow(config.colorPalette),
                  ),
                  child: Column(
                    children: [
                      _buildStatRow('🎯 Puntuación Total', '$_score'),
                      const SizedBox(height: 16),
                      _buildStatRow('✅ Respuestas Correctas', '$correctAnswers / ${questions.length}'),
                      const SizedBox(height: 16),
                      _buildStatRow('📊 Precisión', '$accuracy%'),
                      const SizedBox(height: 16),
                      _buildStatRow('⏱️ Preguntas Respondidas', '${questions.length}'),
                    ],
                  ),
                ),
                
                const SizedBox(height: 48),
                
                // Action buttons
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: GameButton(
                        text: '🔄 Jugar de Nuevo',
                        onPressed: _restartGame,
                        color: AppTheme.parseColor(config.colorPalette.primary),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: GameButton(
                            text: '📊 Ver Respuestas',
                            onPressed: () => _showAnswersReview(context, config, questions),
                            color: AppTheme.parseColor(config.colorPalette.secondary),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GameButton(
                            text: '🏠 Inicio',
                            onPressed: () => context.go('/'),
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
            fontSize: 18,
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.parseColor(ref.read(gameConfigNotifierProvider).value!.colorPalette.primary),
            fontFamily: 'GameFont',
          ),
        ),
      ],
    );
  }

  void _handleAnswer(int selectedAnswer) {
    if (_showResult) return;

    _timer?.cancel();
    _timerController.stop();
    _timerController.reset();

    setState(() {
      _selectedAnswer = selectedAnswer;
      _showResult = true;
    });

    final config = ref.read(gameConfigNotifierProvider).value!;
    final questions = config.triviaQuestions.isNotEmpty 
        ? config.triviaQuestions 
        : DefaultData.defaultTriviaQuestions;
    final currentQuestion = questions[_currentQuestionIndex];

    final isCorrect = selectedAnswer == currentQuestion.correctAnswer;
    final points = isCorrect ? currentQuestion.points + (_timeLeft * 2) : -25;

    final answer = TriviaAnswer(
      questionId: currentQuestion.id,
      selectedAnswer: selectedAnswer,
      correctAnswer: currentQuestion.correctAnswer,
      isCorrect: isCorrect,
      points: points,
      timeLeft: _timeLeft,
      timestamp: DateTime.now(),
    );

    _answers.add(answer);

    if (isCorrect) {
      _score += points;
      _scoreController.forward().then((_) => _scoreController.reverse());
      HapticFeedback.mediumImpact();
      _confettiController.forward().then((_) => _confettiController.reset());
    } else {
      _score = max(0, _score + points); // Don't go below 0
      HapticFeedback.heavyImpact();
    }

    _resultController.forward();

    // Move to next question after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _resultController.reverse();
        
        if (_currentQuestionIndex + 1 >= questions.length) {
          _completeGame();
        } else {
          _nextQuestion();
        }
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _showResult = false;
    });

    _questionController.reset();
    _questionController.forward();
    _startTimer();
  }

  void _completeGame() {
    setState(() {
      _isGameCompleted = true;
    });

    final config = ref.read(gameConfigNotifierProvider).value!;
    final questions = config.triviaQuestions.isNotEmpty 
        ? config.triviaQuestions 
        : DefaultData.defaultTriviaQuestions;

    final correctAnswers = _answers.where((a) => a.isCorrect).length;
    
    final triviaScore = TriviaGameScore(
      score: _score,
      correctAnswers: correctAnswers,
      totalQuestions: questions.length,
      totalTime: Duration(seconds: questions.length * 30 - _timeLeft),
      timestamp: DateTime.now(),
      answers: _answers,
    );

    // Save score
    ref.read(gameConfigNotifierProvider.notifier)
        .addGameScore('trivia', triviaScore.toJson());
  }

  void _restartGame() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _showResult = false;
      _isGameCompleted = false;
      _answers.clear();
    });

    _questionController.reset();
    _resultController.reset();
    _confettiController.reset();
    _scoreController.reset();

    _startGame();
  }

  void _showGameMenu(BuildContext context, GameConfig config) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
            _buildMenuOption('Reiniciar Juego', Icons.refresh, () {
              Navigator.pop(context);
              _showRestartConfirmation(context);
            }),
            _buildMenuOption('Administrar Preguntas', Icons.edit, () {
              Navigator.pop(context);
              context.goToAdmin(tab: 'trivia');
            }),
            _buildMenuOption('Menú Principal', Icons.home, () {
              Navigator.pop(context);
              context.go('/');
            }),
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

  void _showRestartConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: '¿Reiniciar juego?',
        message: 'Se perderá el progreso actual. ¿Estás seguro?',
        confirmText: 'Reiniciar',
        cancelText: 'Cancelar',
        confirmColor: Colors.orange,
        icon: Icons.refresh,
        onConfirm: _restartGame,
      ),
    );
  }

  void _showAnswersReview(BuildContext context, GameConfig config, List<TriviaQuestion> questions) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Revisión de Respuestas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.parseColor(config.colorPalette.primary),
                      fontFamily: 'GameFont',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _answers.length,
                    itemBuilder: (context, index) {
                      final answer = _answers[index];
                      final question = questions.firstWhere((q) => q.id == answer.questionId);
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: answer.isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMD),
                          border: Border.all(
                            color: answer.isCorrect ? Colors.green : Colors.red,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pregunta ${index + 1}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: answer.isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              question.question.replaceAll('[NOMBRE]', config.honoredPerson),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tu respuesta: ${answer.selectedAnswer >= 0 ? question.options[answer.selectedAnswer] : "Sin respuesta (tiempo agotado)"}',
                              style: TextStyle(
                                fontSize: 14,
                                color: answer.isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                              ),
                            ),
                            if (!answer.isCorrect) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Respuesta correcta: ${question.options[answer.correctAnswer]}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Text(
                              'Puntos: ${answer.points > 0 ? '+' : ''}${answer.points}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: answer.points > 0 ? Colors.green.shade700 : Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onBackPressed(BuildContext context) {
    if (!_isGameCompleted && _currentQuestionIndex > 0) {
      showDialog(
        context: context,
        builder: (context) => ConfirmationDialog(
          title: '¿Salir del juego?',
          message: 'Se perderá el progreso actual. ¿Estás seguro?',
          confirmText: 'Salir',
          cancelText: 'Continuar',
          confirmColor: Colors.red,
          icon: Icons.exit_to_app,
          onConfirm: () => context.go('/'),
        ),
      );
    } else {
      context.go('/');
    }
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

// ===== ANSWER OPTION BUTTON =====
class _AnswerOptionButton extends StatefulWidget {
  final int index;
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final bool isWrong;
  final ColorPalette colorPalette;
  final VoidCallback? onTap;

  const _AnswerOptionButton({
    required this.index,
    required this.text,
    required this.isSelected,
    required this.isCorrect,
    required this.isWrong,
    required this.colorPalette,
    this.onTap,
  });

  @override
  State<_AnswerOptionButton> createState() => _AnswerOptionButtonState();
}

class _AnswerOptionButtonState extends State<_AnswerOptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color borderColor;
    Color textColor;
    Widget? trailingIcon;

    if (widget.isCorrect == true) {
      backgroundColor = Colors.green.shade100;
      borderColor = Colors.green;
      textColor = Colors.green.shade700;
      trailingIcon = const Icon(Icons.check_circle, color: Colors.green, size: 24);
    } else if (widget.isWrong) {
      backgroundColor = Colors.red.shade100;
      borderColor = Colors.red;
      textColor = Colors.red.shade700;
      trailingIcon = const Icon(Icons.cancel, color: Colors.red, size: 24);
    } else if (widget.isSelected) {
      backgroundColor = AppTheme.parseColor(widget.colorPalette.primary).withOpacity(0.1);
      borderColor = AppTheme.parseColor(widget.colorPalette.primary);
      textColor = AppTheme.parseColor(widget.colorPalette.primary);
    } else {
      backgroundColor = Colors.white;
      borderColor = Colors.grey.shade300;
      textColor = Colors.grey.shade700;
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) => _animationController.reverse(),
              onTapCancel: () => _animationController.reverse(),
              borderRadius: BorderRadius.circular(AppTheme.radiusLG),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLG),
                  border: Border.all(color: borderColor, width: 2),
                  boxShadow: widget.isSelected ? [
                    BoxShadow(
                      color: borderColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ] : null,
                ),
                child: Row(
                  children: [
                    // Option letter
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: borderColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + widget.index), // A, B, C, D
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    // Option text
                    Expanded(
                      child: Text(
                        widget.text,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    ),
                    
                    // Result icon
                    if (trailingIcon != null) ...[
                      const SizedBox(width: 16),
                      trailingIcon,
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}