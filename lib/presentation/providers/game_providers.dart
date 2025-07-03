// lib/presentation/providers/game_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

import '../../data/models/game_models.dart';
import '../../core/constants/default_data.dart';

part 'game_providers.g.dart';

// ===== CORE PROVIDERS =====
@riverpod
Future<SharedPreferences> sharedPreferences(SharedPreferencesRef ref) async {
  return await SharedPreferences.getInstance();
}

// ===== GAME CONFIG PROVIDER =====
@riverpod
class GameConfigNotifier extends _$GameConfigNotifier {
  static const String _configKey = 'game_config';

  @override
  Future<GameConfig> build() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final configJson = prefs.getString(_configKey);
    
    if (configJson != null) {
      try {
        final configMap = json.decode(configJson) as Map<String, dynamic>;
        return GameConfig.fromJson(configMap);
      } catch (e) {
        // Si hay error al parsear, devolver configuración inicial
        return GameConfig.initial();
      }
    }
    
    return GameConfig.initial();
  }

  Future<void> updateEventName(String name) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      eventName: name,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> updateHonoredPerson(String person) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      honoredPerson: person,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> updateEventType(EventType type) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      eventType: type,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> updateEventDate(String date) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      eventDate: date,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> updateColorPalette(ColorPalette palette) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      colorPalette: palette,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> updateCustomImages(List<String> images) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      customImages: images,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> updateTriviaQuestions(List<TriviaQuestion> questions) async {
    final currentConfig = await future;
    final newConfig = currentConfig.copyWith(
      triviaQuestions: questions,
      lastModified: DateTime.now(),
    );
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> addGameScore(String gameType, Map<String, dynamic> scoreData) async {
    final currentConfig = await future;
    final currentStats = currentConfig.gameStats;
    
    GameStats newStats;
    
    switch (gameType) {
      case 'memory':
        final score = MemoryGameScore.fromJson(scoreData);
        newStats = currentStats.copyWith(
          memoryGames: [...currentStats.memoryGames, score],
          totalGamesPlayed: currentStats.totalGamesPlayed + 1,
          totalTimeSpent: currentStats.totalTimeSpent + score.time.inSeconds,
        );
        break;
      case 'trivia':
        final score = TriviaGameScore.fromJson(scoreData);
        newStats = currentStats.copyWith(
          triviaGames: [...currentStats.triviaGames, score],
          totalGamesPlayed: currentStats.totalGamesPlayed + 1,
          totalTimeSpent: currentStats.totalTimeSpent + score.totalTime.inSeconds,
        );
        break;
      case 'speed':
        final score = SpeedGameScore.fromJson(scoreData);
        newStats = currentStats.copyWith(
          speedGames: [...currentStats.speedGames, score],
          totalGamesPlayed: currentStats.totalGamesPlayed + 1,
          totalTimeSpent: currentStats.totalTimeSpent + score.duration.inSeconds,
        );
        break;
      default:
        return; // Tipo de juego no reconocido
    }

    final newConfig = currentConfig.copyWith(
      gameStats: newStats,
      lastModified: DateTime.now(),
    );
    
    await _saveConfig(newConfig);
    state = AsyncValue.data(newConfig);
  }

  Future<void> importConfig(Map<String, dynamic> configData) async {
    try {
      final importedConfig = GameConfig.fromJson(configData);
      await _saveConfig(importedConfig);
      state = AsyncValue.data(importedConfig);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> resetConfig() async {
    final initialConfig = GameConfig.initial();
    await _saveConfig(initialConfig);
    state = AsyncValue.data(initialConfig);
  }

  Future<void> _saveConfig(GameConfig config) async {
    final prefs = await ref.read(sharedPreferencesProvider.future);
    final configJson = json.encode(config.toJson());
    await prefs.setString(_configKey, configJson);
  }
}

// ===== TRIVIA PROVIDERS =====
@riverpod
class TriviaQuestionsNotifier extends _$TriviaQuestionsNotifier {
  @override
  List<TriviaQuestion> build() {
    // Obtener preguntas del config
    final config = ref.watch(gameConfigNotifierProvider);
    return config.maybeWhen(
      data: (config) => config.triviaQuestions,
      orElse: () => DefaultData.defaultTriviaQuestions,
    );
  }

  void addQuestion(TriviaQuestion question) {
    final currentQuestions = state;
    final newQuestions = [...currentQuestions, question];
    
    // Actualizar en el config global
    ref.read(gameConfigNotifierProvider.notifier)
        .updateTriviaQuestions(newQuestions);
  }

  void updateQuestion(String questionId, TriviaQuestion updatedQuestion) {
    final currentQuestions = state;
    final newQuestions = currentQuestions.map((q) => 
        q.id == questionId ? updatedQuestion : q).toList();
    
    ref.read(gameConfigNotifierProvider.notifier)
        .updateTriviaQuestions(newQuestions);
  }

  void removeQuestion(String questionId) {
    final currentQuestions = state;
    final newQuestions = currentQuestions.where((q) => q.id != questionId).toList();
    
    ref.read(gameConfigNotifierProvider.notifier)
        .updateTriviaQuestions(newQuestions);
  }

  void reorderQuestions(int oldIndex, int newIndex) {
    final currentQuestions = [...state];
    if (newIndex > oldIndex) newIndex--;
    
    final question = currentQuestions.removeAt(oldIndex);
    currentQuestions.insert(newIndex, question);
    
    ref.read(gameConfigNotifierProvider.notifier)
        .updateTriviaQuestions(currentQuestions);
  }
}

// ===== MEMORY GAME PROVIDERS =====
@riverpod
class MemoryGameNotifier extends _$MemoryGameNotifier {
  @override
  GameState build() {
    return GameState.initial().copyWith(currentGame: GameType.memory);
  }

  void startGame(DifficultyLevel difficulty) {
    state = state.copyWith(
      status: GameStatus.playing,
      score: 0,
      moves: 0,
      timeElapsed: 0,
      gameStartedAt: DateTime.now(),
      gameData: {
        'difficulty': difficulty.name,
        'cards': _generateCards(difficulty),
        'flippedCards': <String>[],
        'matchedPairs': <String>[],
      },
    );
  }

  void flipCard(String cardId) {
    if (state.status != GameStatus.playing) return;
    
    final gameData = Map<String, dynamic>.from(state.gameData ?? {});
    final cards = List<MemoryCard>.from(
        gameData['cards']?.map((c) => MemoryCard.fromJson(c)) ?? []);
    final flippedCards = List<String>.from(gameData['flippedCards'] ?? []);
    
    final cardIndex = cards.indexWhere((c) => c.id == cardId);
    if (cardIndex == -1) return;
    
    final card = cards[cardIndex];
    if (card.isFlipped || card.isMatched || flippedCards.length >= 2) return;
    
    // Voltear carta
    cards[cardIndex] = card.copyWith(isFlipped: true);
    flippedCards.add(cardId);
    
    gameData['cards'] = cards.map((c) => c.toJson()).toList();
    gameData['flippedCards'] = flippedCards;
    
    state = state.copyWith(gameData: gameData);
    
    if (flippedCards.length == 2) {
      _checkMatch();
    }
  }

  void _checkMatch() {
    final gameData = Map<String, dynamic>.from(state.gameData ?? {});
    final cards = List<MemoryCard>.from(
        gameData['cards']?.map((c) => MemoryCard.fromJson(c)) ?? []);
    final flippedCards = List<String>.from(gameData['flippedCards'] ?? []);
    final matchedPairs = List<String>.from(gameData['matchedPairs'] ?? []);
    
    if (flippedCards.length != 2) return;
    
    final card1 = cards.firstWhere((c) => c.id == flippedCards[0]);
    final card2 = cards.firstWhere((c) => c.id == flippedCards[1]);
    
    state = state.copyWith(moves: state.moves + 1);
    
    if (card1.emoji == card2.emoji) {
      // Match encontrado
      for (int i = 0; i < cards.length; i++) {
        if (cards[i].id == card1.id || cards[i].id == card2.id) {
          cards[i] = cards[i].copyWith(isMatched: true);
        }
      }
      matchedPairs.add(card1.emoji);
      
      // Verificar si el juego terminó
      final totalPairs = MemoryGameConfig.presets[
          DifficultyLevel.values.firstWhere((d) => 
              d.name == gameData['difficulty'])]?.totalPairs ?? 6;
      
      if (matchedPairs.length >= totalPairs) {
        _completeGame();
      }
    } else {
      // No match - voltear de vuelta después de un delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        final updatedCards = List<MemoryCard>.from(cards);
        for (int i = 0; i < updatedCards.length; i++) {
          if (updatedCards[i].id == card1.id || updatedCards[i].id == card2.id) {
            updatedCards[i] = updatedCards[i].copyWith(isFlipped: false);
          }
        }
        
        final updatedGameData = Map<String, dynamic>.from(gameData);
        updatedGameData['cards'] = updatedCards.map((c) => c.toJson()).toList();
        updatedGameData['flippedCards'] = <String>[];
        updatedGameData['matchedPairs'] = matchedPairs;
        
        state = state.copyWith(gameData: updatedGameData);
      });
      return;
    }
    
    gameData['cards'] = cards.map((c) => c.toJson()).toList();
    gameData['flippedCards'] = <String>[];
    gameData['matchedPairs'] = matchedPairs;
    
    state = state.copyWith(gameData: gameData);
  }

  void _completeGame() {
    final duration = state.gameStartedAt != null 
        ? DateTime.now().difference(state.gameStartedAt!)
        : Duration.zero;
    
    final difficulty = DifficultyLevel.values.firstWhere(
        (d) => d.name == state.gameData?['difficulty'],
        orElse: () => DifficultyLevel.easy);
    
    final score = MemoryGameScore(
      level: difficulty,
      moves: state.moves,
      time: duration,
      timestamp: DateTime.now(),
      stars: _calculateStars(state.moves, difficulty),
    );
    
    // Guardar puntuación
    ref.read(gameConfigNotifierProvider.notifier)
        .addGameScore('memory', score.toJson());
    
    state = state.copyWith(status: GameStatus.completed);
  }

  int _calculateStars(int moves, DifficultyLevel difficulty) {
    final config = MemoryGameConfig.presets[difficulty]!;
    final optimalMoves = config.totalPairs;
    final efficiency = optimalMoves / moves;
    
    if (efficiency >= 0.9) return 3;
    if (efficiency >= 0.7) return 2;
    return 1;
  }

  List<Map<String, dynamic>> _generateCards(DifficultyLevel difficulty) {
    final config = MemoryGameConfig.presets[difficulty]!;
    final emojis = DefaultData.defaultEmojis.take(config.totalPairs).toList();
    
    final cards = <MemoryCard>[];
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
    
    return cards.map((c) => c.toJson()).toList();
  }

  void pauseGame() {
    if (state.status == GameStatus.playing) {
      state = state.copyWith(status: GameStatus.paused);
    }
  }

  void resumeGame() {
    if (state.status == GameStatus.paused) {
      state = state.copyWith(status: GameStatus.playing);
    }
  }

  void resetGame() {
    state = GameState.initial().copyWith(currentGame: GameType.memory);
  }
}

// ===== TRIVIA GAME PROVIDER =====
@riverpod
class TriviaGameNotifier extends _$TriviaGameNotifier {
  @override
  GameState build() {
    return GameState.initial().copyWith(currentGame: GameType.trivia);
  }

  void startGame() {
    final questions = ref.read(triviaQuestionsNotifierProvider);
    if (questions.isEmpty) return;
    
    state = state.copyWith(
      status: GameStatus.playing,
      score: 0,
      gameStartedAt: DateTime.now(),
      gameData: {
        'questions': questions.map((q) => q.toJson()).toList(),
        'currentQuestionIndex': 0,
        'answers': <Map<String, dynamic>>[],
        'timeLeft': 30,
      },
    );
  }

  void answerQuestion(int selectedAnswer) {
    if (state.status != GameStatus.playing) return;
    
    final gameData = Map<String, dynamic>.from(state.gameData ?? {});
    final questions = List<TriviaQuestion>.from(
        gameData['questions']?.map((q) => TriviaQuestion.fromJson(q)) ?? []);
    final currentIndex = gameData['currentQuestionIndex'] ?? 0;
    final answers = List<Map<String, dynamic>>.from(gameData['answers'] ?? []);
    final timeLeft = gameData['timeLeft'] ?? 0;
    
    if (currentIndex >= questions.length) return;
    
    final currentQuestion = questions[currentIndex];
    final isCorrect = selectedAnswer == currentQuestion.correctAnswer;
    final points = isCorrect ? currentQuestion.points + (timeLeft * 2) : -25;
    
    final answer = TriviaAnswer(
      questionId: currentQuestion.id,
      selectedAnswer: selectedAnswer,
      correctAnswer: currentQuestion.correctAnswer,
      isCorrect: isCorrect,
      points: points.toInt(),
      timeLeft: timeLeft,
      timestamp: DateTime.now(),
    );
    
    answers.add(answer.toJson());
    
    state = state.copyWith(
      score: state.score + points.toInt(),
      gameData: {
        ...gameData,
        'answers': answers,
      },
    );
    
    // Esperar un momento y avanzar a la siguiente pregunta
    Future.delayed(const Duration(seconds: 2), () {
      if (currentIndex + 1 >= questions.length) {
        _completeGame();
      } else {
        _nextQuestion();
      }
    });
  }

  void _nextQuestion() {
    final gameData = Map<String, dynamic>.from(state.gameData ?? {});
    final currentIndex = gameData['currentQuestionIndex'] ?? 0;
    
    state = state.copyWith(
      gameData: {
        ...gameData,
        'currentQuestionIndex': currentIndex + 1,
        'timeLeft': 30,
      },
    );
  }

  void _completeGame() {
    final gameData = state.gameData ?? {};
    final answers = List<Map<String, dynamic>>.from(gameData['answers'] ?? []);
    final questions = List<TriviaQuestion>.from(
        gameData['questions']?.map((q) => TriviaQuestion.fromJson(q)) ?? []);
    
    final duration = state.gameStartedAt != null 
        ? DateTime.now().difference(state.gameStartedAt!)
        : Duration.zero;
    
    final correctAnswers = answers.where((a) => 
        TriviaAnswer.fromJson(a).isCorrect).length;
    
    final score = TriviaGameScore(
      score: state.score,
      correctAnswers: correctAnswers,
      totalQuestions: questions.length,
      totalTime: duration,
      timestamp: DateTime.now(),
      answers: answers.map((a) => TriviaAnswer.fromJson(a)).toList(),
    );
    
    // Guardar puntuación
    ref.read(gameConfigNotifierProvider.notifier)
        .addGameScore('trivia', score.toJson());
    
    state = state.copyWith(status: GameStatus.completed);
  }

  void updateTimeLeft(int timeLeft) {
    if (state.status != GameStatus.playing) return;
    
    final gameData = Map<String, dynamic>.from(state.gameData ?? {});
    state = state.copyWith(
      gameData: {
        ...gameData,
        'timeLeft': timeLeft,
      },
    );
    
    if (timeLeft <= 0) {
      answerQuestion(-1); // Respuesta incorrecta por tiempo agotado
    }
  }

  void resetGame() {
    state = GameState.initial().copyWith(currentGame: GameType.trivia);
  }
}

// ===== CURRENT GAME PROVIDER =====
@riverpod
class CurrentGameNotifier extends _$CurrentGameNotifier {
  @override
  GameType build() {
    return GameType.memory;
  }

  void setGame(GameType game) {
    state = game;
  }
}