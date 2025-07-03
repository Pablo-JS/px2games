// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TriviaQuestionImpl _$$TriviaQuestionImplFromJson(Map<String, dynamic> json) =>
    _$TriviaQuestionImpl(
      id: json['id'] as String,
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      category: json['category'] as String,
      difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
      imageUrl: json['imageUrl'] as String?,
      explanation: json['explanation'] as String?,
      points: (json['points'] as num?)?.toInt() ?? 100,
    );

Map<String, dynamic> _$$TriviaQuestionImplToJson(
  _$TriviaQuestionImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'options': instance.options,
  'correctAnswer': instance.correctAnswer,
  'category': instance.category,
  'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
  'imageUrl': instance.imageUrl,
  'explanation': instance.explanation,
  'points': instance.points,
};

const _$DifficultyLevelEnumMap = {
  DifficultyLevel.easy: 'easy',
  DifficultyLevel.medium: 'medium',
  DifficultyLevel.hard: 'hard',
};

_$TriviaAnswerImpl _$$TriviaAnswerImplFromJson(Map<String, dynamic> json) =>
    _$TriviaAnswerImpl(
      questionId: json['questionId'] as String,
      selectedAnswer: (json['selectedAnswer'] as num).toInt(),
      correctAnswer: (json['correctAnswer'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
      points: (json['points'] as num).toInt(),
      timeLeft: (json['timeLeft'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$TriviaAnswerImplToJson(_$TriviaAnswerImpl instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'selectedAnswer': instance.selectedAnswer,
      'correctAnswer': instance.correctAnswer,
      'isCorrect': instance.isCorrect,
      'points': instance.points,
      'timeLeft': instance.timeLeft,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$MemoryCardImpl _$$MemoryCardImplFromJson(Map<String, dynamic> json) =>
    _$MemoryCardImpl(
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      emoji: json['emoji'] as String,
      isFlipped: json['isFlipped'] as bool? ?? false,
      isMatched: json['isMatched'] as bool? ?? false,
      isAnimating: json['isAnimating'] as bool? ?? false,
      customImagePath: json['customImagePath'] as String?,
    );

Map<String, dynamic> _$$MemoryCardImplToJson(_$MemoryCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'emoji': instance.emoji,
      'isFlipped': instance.isFlipped,
      'isMatched': instance.isMatched,
      'isAnimating': instance.isAnimating,
      'customImagePath': instance.customImagePath,
    };

_$MemoryGameConfigImpl _$$MemoryGameConfigImplFromJson(
  Map<String, dynamic> json,
) => _$MemoryGameConfigImpl(
  difficulty: $enumDecode(_$DifficultyLevelEnumMap, json['difficulty']),
  rows: (json['rows'] as num).toInt(),
  cols: (json['cols'] as num).toInt(),
  totalPairs: (json['totalPairs'] as num).toInt(),
  flipDuration: (json['flipDuration'] as num?)?.toInt() ?? 600,
  showDuration: (json['showDuration'] as num?)?.toInt() ?? 1000,
  mismatchDelay: (json['mismatchDelay'] as num?)?.toInt() ?? 1500,
);

Map<String, dynamic> _$$MemoryGameConfigImplToJson(
  _$MemoryGameConfigImpl instance,
) => <String, dynamic>{
  'difficulty': _$DifficultyLevelEnumMap[instance.difficulty]!,
  'rows': instance.rows,
  'cols': instance.cols,
  'totalPairs': instance.totalPairs,
  'flipDuration': instance.flipDuration,
  'showDuration': instance.showDuration,
  'mismatchDelay': instance.mismatchDelay,
};

_$SpeedGameScoreImpl _$$SpeedGameScoreImplFromJson(Map<String, dynamic> json) =>
    _$SpeedGameScoreImpl(
      gameType: json['gameType'] as String,
      score: (json['score'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$SpeedGameScoreImplToJson(
  _$SpeedGameScoreImpl instance,
) => <String, dynamic>{
  'gameType': instance.gameType,
  'score': instance.score,
  'level': instance.level,
  'duration': instance.duration.inMicroseconds,
  'timestamp': instance.timestamp.toIso8601String(),
  'metadata': instance.metadata,
};

_$GameStatsImpl _$$GameStatsImplFromJson(Map<String, dynamic> json) =>
    _$GameStatsImpl(
      memoryGames:
          (json['memoryGames'] as List<dynamic>?)
              ?.map((e) => MemoryGameScore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      triviaGames:
          (json['triviaGames'] as List<dynamic>?)
              ?.map((e) => TriviaGameScore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      speedGames:
          (json['speedGames'] as List<dynamic>?)
              ?.map((e) => SpeedGameScore.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalGamesPlayed: (json['totalGamesPlayed'] as num?)?.toInt() ?? 0,
      totalTimeSpent: (json['totalTimeSpent'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$GameStatsImplToJson(_$GameStatsImpl instance) =>
    <String, dynamic>{
      'memoryGames': instance.memoryGames,
      'triviaGames': instance.triviaGames,
      'speedGames': instance.speedGames,
      'totalGamesPlayed': instance.totalGamesPlayed,
      'totalTimeSpent': instance.totalTimeSpent,
    };

_$MemoryGameScoreImpl _$$MemoryGameScoreImplFromJson(
  Map<String, dynamic> json,
) => _$MemoryGameScoreImpl(
  level: $enumDecode(_$DifficultyLevelEnumMap, json['level']),
  moves: (json['moves'] as num).toInt(),
  time: Duration(microseconds: (json['time'] as num).toInt()),
  timestamp: DateTime.parse(json['timestamp'] as String),
  stars: (json['stars'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$MemoryGameScoreImplToJson(
  _$MemoryGameScoreImpl instance,
) => <String, dynamic>{
  'level': _$DifficultyLevelEnumMap[instance.level]!,
  'moves': instance.moves,
  'time': instance.time.inMicroseconds,
  'timestamp': instance.timestamp.toIso8601String(),
  'stars': instance.stars,
};

_$TriviaGameScoreImpl _$$TriviaGameScoreImplFromJson(
  Map<String, dynamic> json,
) => _$TriviaGameScoreImpl(
  score: (json['score'] as num).toInt(),
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  totalTime: Duration(microseconds: (json['totalTime'] as num).toInt()),
  timestamp: DateTime.parse(json['timestamp'] as String),
  answers:
      (json['answers'] as List<dynamic>?)
          ?.map((e) => TriviaAnswer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TriviaGameScoreImplToJson(
  _$TriviaGameScoreImpl instance,
) => <String, dynamic>{
  'score': instance.score,
  'correctAnswers': instance.correctAnswers,
  'totalQuestions': instance.totalQuestions,
  'totalTime': instance.totalTime.inMicroseconds,
  'timestamp': instance.timestamp.toIso8601String(),
  'answers': instance.answers,
};

_$ColorPaletteImpl _$$ColorPaletteImplFromJson(Map<String, dynamic> json) =>
    _$ColorPaletteImpl(
      name: json['name'] as String,
      primary: json['primary'] as String,
      secondary: json['secondary'] as String,
      accent: json['accent'] as String,
      background: json['background'] as String,
      surface: json['surface'] as String,
      onPrimary: json['onPrimary'] as String,
      onSecondary: json['onSecondary'] as String,
      onBackground: json['onBackground'] as String,
      onSurface: json['onSurface'] as String,
      isCustom: json['isCustom'] as bool? ?? false,
    );

Map<String, dynamic> _$$ColorPaletteImplToJson(_$ColorPaletteImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'primary': instance.primary,
      'secondary': instance.secondary,
      'accent': instance.accent,
      'background': instance.background,
      'surface': instance.surface,
      'onPrimary': instance.onPrimary,
      'onSecondary': instance.onSecondary,
      'onBackground': instance.onBackground,
      'onSurface': instance.onSurface,
      'isCustom': instance.isCustom,
    };

_$GameConfigImpl _$$GameConfigImplFromJson(Map<String, dynamic> json) =>
    _$GameConfigImpl(
      eventName: json['eventName'] as String,
      honoredPerson: json['honoredPerson'] as String,
      eventType: $enumDecode(_$EventTypeEnumMap, json['eventType']),
      eventDate: json['eventDate'] as String,
      colorPalette: ColorPalette.fromJson(
        json['colorPalette'] as Map<String, dynamic>,
      ),
      customImages:
          (json['customImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      useCustomImages: json['useCustomImages'] as bool? ?? false,
      triviaQuestions:
          (json['triviaQuestions'] as List<dynamic>?)
              ?.map((e) => TriviaQuestion.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      gameStats: json['gameStats'] == null
          ? const GameStats()
          : GameStats.fromJson(json['gameStats'] as Map<String, dynamic>),
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      animationsEnabled: json['animationsEnabled'] as bool? ?? true,
      volume: (json['volume'] as num?)?.toDouble() ?? 1.0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastModified: json['lastModified'] == null
          ? null
          : DateTime.parse(json['lastModified'] as String),
    );

Map<String, dynamic> _$$GameConfigImplToJson(_$GameConfigImpl instance) =>
    <String, dynamic>{
      'eventName': instance.eventName,
      'honoredPerson': instance.honoredPerson,
      'eventType': _$EventTypeEnumMap[instance.eventType]!,
      'eventDate': instance.eventDate,
      'colorPalette': instance.colorPalette,
      'customImages': instance.customImages,
      'useCustomImages': instance.useCustomImages,
      'triviaQuestions': instance.triviaQuestions,
      'gameStats': instance.gameStats,
      'soundEnabled': instance.soundEnabled,
      'animationsEnabled': instance.animationsEnabled,
      'volume': instance.volume,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastModified': instance.lastModified?.toIso8601String(),
    };

const _$EventTypeEnumMap = {
  EventType.birthday: 'birthday',
  EventType.wedding: 'wedding',
  EventType.graduation: 'graduation',
  EventType.anniversary: 'anniversary',
  EventType.babyShower: 'baby_shower',
  EventType.corporate: 'corporate',
  EventType.celebration: 'celebration',
};

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      currentGame: $enumDecode(_$GameTypeEnumMap, json['currentGame']),
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      score: (json['score'] as num?)?.toInt() ?? 0,
      moves: (json['moves'] as num?)?.toInt() ?? 0,
      timeElapsed: (json['timeElapsed'] as num?)?.toInt() ?? 0,
      gameStartedAt: json['gameStartedAt'] == null
          ? null
          : DateTime.parse(json['gameStartedAt'] as String),
      gameData: json['gameData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'currentGame': _$GameTypeEnumMap[instance.currentGame]!,
      'status': _$GameStatusEnumMap[instance.status]!,
      'score': instance.score,
      'moves': instance.moves,
      'timeElapsed': instance.timeElapsed,
      'gameStartedAt': instance.gameStartedAt?.toIso8601String(),
      'gameData': instance.gameData,
    };

const _$GameTypeEnumMap = {
  GameType.memory: 'memory',
  GameType.trivia: 'trivia',
  GameType.speed: 'speed',
  GameType.messageCreator: 'message_creator',
};

const _$GameStatusEnumMap = {
  GameStatus.idle: 'idle',
  GameStatus.playing: 'playing',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
  GameStatus.failed: 'failed',
};
