// lib/data/models/game_models.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'game_models.freezed.dart';
part 'game_models.g.dart';

// ===== ENUMS =====
enum GameType {
  @JsonValue('memory')
  memory,
  @JsonValue('trivia') 
  trivia,
  @JsonValue('speed')
  speed,
  @JsonValue('message_creator')
  messageCreator
}

enum EventType {
  @JsonValue('birthday')
  birthday,
  @JsonValue('wedding')
  wedding,
  @JsonValue('graduation')
  graduation,
  @JsonValue('anniversary')
  anniversary,
  @JsonValue('baby_shower')
  babyShower,
  @JsonValue('corporate')
  corporate,
  @JsonValue('celebration')
  celebration
}

enum DifficultyLevel {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard
}

enum GameStatus {
  @JsonValue('idle')
  idle,
  @JsonValue('playing')
  playing,
  @JsonValue('paused')
  paused,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed
}

// ===== TRIVIA MODELS =====
@freezed
class TriviaQuestion with _$TriviaQuestion {
  const factory TriviaQuestion({
    required String id,
    required String question,
    required List<String> options,
    required int correctAnswer,
    required String category,
    required DifficultyLevel difficulty,
    String? imageUrl,
    String? explanation,
    @Default(100) int points,
  }) = _TriviaQuestion;

  factory TriviaQuestion.fromJson(Map<String, dynamic> json) =>
      _$TriviaQuestionFromJson(json);
}

@freezed
class TriviaAnswer with _$TriviaAnswer {
  const factory TriviaAnswer({
    required String questionId,
    required int selectedAnswer,
    required int correctAnswer,
    required bool isCorrect,
    required int points,
    required int timeLeft,
    required DateTime timestamp,
  }) = _TriviaAnswer;

  factory TriviaAnswer.fromJson(Map<String, dynamic> json) =>
      _$TriviaAnswerFromJson(json);
}

// ===== MEMORY GAME MODELS =====
@freezed
class MemoryCard with _$MemoryCard {
  const factory MemoryCard({
    required String id,
    required String imageUrl,
    required String emoji,
    @Default(false) bool isFlipped,
    @Default(false) bool isMatched,
    @Default(false) bool isAnimating,
    String? customImagePath,
  }) = _MemoryCard;

  factory MemoryCard.fromJson(Map<String, dynamic> json) =>
      _$MemoryCardFromJson(json);
}

@freezed
class MemoryGameConfig with _$MemoryGameConfig {
  const factory MemoryGameConfig({
    required DifficultyLevel difficulty,
    required int rows,
    required int cols,
    required int totalPairs,
    @Default(600) int flipDuration,
    @Default(1000) int showDuration,
    @Default(1500) int mismatchDelay,
  }) = _MemoryGameConfig;

  factory MemoryGameConfig.fromJson(Map<String, dynamic> json) =>
      _$MemoryGameConfigFromJson(json);

  static const Map<DifficultyLevel, MemoryGameConfig> presets = {
    DifficultyLevel.easy: MemoryGameConfig(
      difficulty: DifficultyLevel.easy,
      rows: 4,
      cols: 3,
      totalPairs: 6,
    ),
    DifficultyLevel.medium: MemoryGameConfig(
      difficulty: DifficultyLevel.medium,
      rows: 5,
      cols: 4,
      totalPairs: 10,
    ),
    DifficultyLevel.hard: MemoryGameConfig(
      difficulty: DifficultyLevel.hard,
      rows: 6,
      cols: 5,
      totalPairs: 15,
    ),
  };
}

// ===== SPEED GAME MODELS =====
@freezed
class SpeedGameScore with _$SpeedGameScore {
  const factory SpeedGameScore({
    required String gameType,
    required int score,
    required int level,
    required Duration duration,
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _SpeedGameScore;

  factory SpeedGameScore.fromJson(Map<String, dynamic> json) =>
      _$SpeedGameScoreFromJson(json);
}

// ===== GAME STATISTICS =====
@freezed
class GameStats with _$GameStats {
  const factory GameStats({
    @Default([]) List<MemoryGameScore> memoryGames,
    @Default([]) List<TriviaGameScore> triviaGames,
    @Default([]) List<SpeedGameScore> speedGames,
    @Default(0) int totalGamesPlayed,
    @Default(0) int totalTimeSpent, // in seconds
  }) = _GameStats;

  factory GameStats.fromJson(Map<String, dynamic> json) =>
      _$GameStatsFromJson(json);
}

@freezed
class MemoryGameScore with _$MemoryGameScore {
  const factory MemoryGameScore({
    required DifficultyLevel level,
    required int moves,
    required Duration time,
    required DateTime timestamp,
    @Default(0) int stars,
  }) = _MemoryGameScore;

  factory MemoryGameScore.fromJson(Map<String, dynamic> json) =>
      _$MemoryGameScoreFromJson(json);
}

@freezed
class TriviaGameScore with _$TriviaGameScore {
  const factory TriviaGameScore({
    required int score,
    required int correctAnswers,
    required int totalQuestions,
    required Duration totalTime,
    required DateTime timestamp,
    @Default([]) List<TriviaAnswer> answers,
  }) = _TriviaGameScore;

  factory TriviaGameScore.fromJson(Map<String, dynamic> json) =>
      _$TriviaGameScoreFromJson(json);
}

// ===== COLOR PALETTE =====
@freezed
class ColorPalette with _$ColorPalette {
  const factory ColorPalette({
    required String name,
    required String primary,
    required String secondary,
    required String accent,
    required String background,
    required String surface,
    required String onPrimary,
    required String onSecondary,
    required String onBackground,
    required String onSurface,
    @Default(false) bool isCustom,
  }) = _ColorPalette;

  factory ColorPalette.fromJson(Map<String, dynamic> json) =>
      _$ColorPaletteFromJson(json);

  static const ColorPalette sunset = ColorPalette(
    name: 'Sunset',
    primary: '#FF6B6B',
    secondary: '#4ECDC4',
    accent: '#FFE66D',
    background: '#FFF5F5',
    surface: '#FFFFFF',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#2D3748',
    onSurface: '#2D3748',
  );

  static const ColorPalette ocean = ColorPalette(
    name: 'Ocean',
    primary: '#3182CE',
    secondary: '#38B2AC',
    accent: '#68D391',
    background: '#EBF8FF',
    surface: '#FFFFFF',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#2D3748',
    onSurface: '#2D3748',
  );

  static const ColorPalette forest = ColorPalette(
    name: 'Forest',
    primary: '#38A169',
    secondary: '#68D391',
    accent: '#9AE6B4',
    background: '#F0FFF4',
    surface: '#FFFFFF',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onBackground: '#2D3748',
    onSurface: '#2D3748',
  );

  static const List<ColorPalette> presets = [
    sunset,
    ocean,
    forest,
  ];
}

// ===== MAIN GAME CONFIG =====
@freezed
class GameConfig with _$GameConfig {
  const factory GameConfig({
    required String eventName,
    required String honoredPerson,
    required EventType eventType,
    required String eventDate,
    required ColorPalette colorPalette,
    @Default([]) List<String> customImages,
    @Default(false) bool useCustomImages,
    @Default([]) List<TriviaQuestion> triviaQuestions,
    @Default(GameStats()) GameStats gameStats,
    @Default(true) bool soundEnabled,
    @Default(true) bool animationsEnabled,
    @Default(1.0) double volume,
    DateTime? createdAt,
    DateTime? lastModified,
  }) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) =>
      _$GameConfigFromJson(json);

  factory GameConfig.initial() => GameConfig(
        eventName: 'Mi Evento Especial',
        honoredPerson: 'Persona Homenajeada',
        eventType: EventType.birthday,
        eventDate: DateTime.now().toIso8601String().split('T')[0],
        colorPalette: ColorPalette.sunset,
        createdAt: DateTime.now(),
        lastModified: DateTime.now(),
      );
}

// ===== GAME STATE =====
@freezed
class GameState with _$GameState {
  const factory GameState({
    required GameType currentGame,
    required GameStatus status,
    @Default(0) int score,
    @Default(0) int moves,
    @Default(0) int timeElapsed,
    DateTime? gameStartedAt,
    Map<String, dynamic>? gameData,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  factory GameState.initial() => const GameState(
        currentGame: GameType.memory,
        status: GameStatus.idle,
      );
}