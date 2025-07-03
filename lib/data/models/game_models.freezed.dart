// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TriviaQuestion _$TriviaQuestionFromJson(Map<String, dynamic> json) {
  return _TriviaQuestion.fromJson(json);
}

/// @nodoc
mixin _$TriviaQuestion {
  String get id => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  List<String> get options => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  /// Serializes this TriviaQuestion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaQuestionCopyWith<TriviaQuestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaQuestionCopyWith<$Res> {
  factory $TriviaQuestionCopyWith(
    TriviaQuestion value,
    $Res Function(TriviaQuestion) then,
  ) = _$TriviaQuestionCopyWithImpl<$Res, TriviaQuestion>;
  @useResult
  $Res call({
    String id,
    String question,
    List<String> options,
    int correctAnswer,
    String category,
    DifficultyLevel difficulty,
    String? imageUrl,
    String? explanation,
    int points,
  });
}

/// @nodoc
class _$TriviaQuestionCopyWithImpl<$Res, $Val extends TriviaQuestion>
    implements $TriviaQuestionCopyWith<$Res> {
  _$TriviaQuestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? category = null,
    Object? difficulty = null,
    Object? imageUrl = freezed,
    Object? explanation = freezed,
    Object? points = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            options: null == options
                ? _value.options
                : options // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as DifficultyLevel,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            explanation: freezed == explanation
                ? _value.explanation
                : explanation // ignore: cast_nullable_to_non_nullable
                      as String?,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TriviaQuestionImplCopyWith<$Res>
    implements $TriviaQuestionCopyWith<$Res> {
  factory _$$TriviaQuestionImplCopyWith(
    _$TriviaQuestionImpl value,
    $Res Function(_$TriviaQuestionImpl) then,
  ) = __$$TriviaQuestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String question,
    List<String> options,
    int correctAnswer,
    String category,
    DifficultyLevel difficulty,
    String? imageUrl,
    String? explanation,
    int points,
  });
}

/// @nodoc
class __$$TriviaQuestionImplCopyWithImpl<$Res>
    extends _$TriviaQuestionCopyWithImpl<$Res, _$TriviaQuestionImpl>
    implements _$$TriviaQuestionImplCopyWith<$Res> {
  __$$TriviaQuestionImplCopyWithImpl(
    _$TriviaQuestionImpl _value,
    $Res Function(_$TriviaQuestionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? question = null,
    Object? options = null,
    Object? correctAnswer = null,
    Object? category = null,
    Object? difficulty = null,
    Object? imageUrl = freezed,
    Object? explanation = freezed,
    Object? points = null,
  }) {
    return _then(
      _$TriviaQuestionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        options: null == options
            ? _value._options
            : options // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as DifficultyLevel,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        explanation: freezed == explanation
            ? _value.explanation
            : explanation // ignore: cast_nullable_to_non_nullable
                  as String?,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TriviaQuestionImpl
    with DiagnosticableTreeMixin
    implements _TriviaQuestion {
  const _$TriviaQuestionImpl({
    required this.id,
    required this.question,
    required final List<String> options,
    required this.correctAnswer,
    required this.category,
    required this.difficulty,
    this.imageUrl,
    this.explanation,
    this.points = 100,
  }) : _options = options;

  factory _$TriviaQuestionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriviaQuestionImplFromJson(json);

  @override
  final String id;
  @override
  final String question;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final int correctAnswer;
  @override
  final String category;
  @override
  final DifficultyLevel difficulty;
  @override
  final String? imageUrl;
  @override
  final String? explanation;
  @override
  @JsonKey()
  final int points;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TriviaQuestion(id: $id, question: $question, options: $options, correctAnswer: $correctAnswer, category: $category, difficulty: $difficulty, imageUrl: $imageUrl, explanation: $explanation, points: $points)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TriviaQuestion'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('options', options))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('difficulty', difficulty))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('explanation', explanation))
      ..add(DiagnosticsProperty('points', points));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaQuestionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    question,
    const DeepCollectionEquality().hash(_options),
    correctAnswer,
    category,
    difficulty,
    imageUrl,
    explanation,
    points,
  );

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaQuestionImplCopyWith<_$TriviaQuestionImpl> get copyWith =>
      __$$TriviaQuestionImplCopyWithImpl<_$TriviaQuestionImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TriviaQuestionImplToJson(this);
  }
}

abstract class _TriviaQuestion implements TriviaQuestion {
  const factory _TriviaQuestion({
    required final String id,
    required final String question,
    required final List<String> options,
    required final int correctAnswer,
    required final String category,
    required final DifficultyLevel difficulty,
    final String? imageUrl,
    final String? explanation,
    final int points,
  }) = _$TriviaQuestionImpl;

  factory _TriviaQuestion.fromJson(Map<String, dynamic> json) =
      _$TriviaQuestionImpl.fromJson;

  @override
  String get id;
  @override
  String get question;
  @override
  List<String> get options;
  @override
  int get correctAnswer;
  @override
  String get category;
  @override
  DifficultyLevel get difficulty;
  @override
  String? get imageUrl;
  @override
  String? get explanation;
  @override
  int get points;

  /// Create a copy of TriviaQuestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaQuestionImplCopyWith<_$TriviaQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriviaAnswer _$TriviaAnswerFromJson(Map<String, dynamic> json) {
  return _TriviaAnswer.fromJson(json);
}

/// @nodoc
mixin _$TriviaAnswer {
  String get questionId => throw _privateConstructorUsedError;
  int get selectedAnswer => throw _privateConstructorUsedError;
  int get correctAnswer => throw _privateConstructorUsedError;
  bool get isCorrect => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get timeLeft => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this TriviaAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriviaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaAnswerCopyWith<TriviaAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaAnswerCopyWith<$Res> {
  factory $TriviaAnswerCopyWith(
    TriviaAnswer value,
    $Res Function(TriviaAnswer) then,
  ) = _$TriviaAnswerCopyWithImpl<$Res, TriviaAnswer>;
  @useResult
  $Res call({
    String questionId,
    int selectedAnswer,
    int correctAnswer,
    bool isCorrect,
    int points,
    int timeLeft,
    DateTime timestamp,
  });
}

/// @nodoc
class _$TriviaAnswerCopyWithImpl<$Res, $Val extends TriviaAnswer>
    implements $TriviaAnswerCopyWith<$Res> {
  _$TriviaAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
    Object? points = null,
    Object? timeLeft = null,
    Object? timestamp = null,
  }) {
    return _then(
      _value.copyWith(
            questionId: null == questionId
                ? _value.questionId
                : questionId // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedAnswer: null == selectedAnswer
                ? _value.selectedAnswer
                : selectedAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswer: null == correctAnswer
                ? _value.correctAnswer
                : correctAnswer // ignore: cast_nullable_to_non_nullable
                      as int,
            isCorrect: null == isCorrect
                ? _value.isCorrect
                : isCorrect // ignore: cast_nullable_to_non_nullable
                      as bool,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            timeLeft: null == timeLeft
                ? _value.timeLeft
                : timeLeft // ignore: cast_nullable_to_non_nullable
                      as int,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TriviaAnswerImplCopyWith<$Res>
    implements $TriviaAnswerCopyWith<$Res> {
  factory _$$TriviaAnswerImplCopyWith(
    _$TriviaAnswerImpl value,
    $Res Function(_$TriviaAnswerImpl) then,
  ) = __$$TriviaAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String questionId,
    int selectedAnswer,
    int correctAnswer,
    bool isCorrect,
    int points,
    int timeLeft,
    DateTime timestamp,
  });
}

/// @nodoc
class __$$TriviaAnswerImplCopyWithImpl<$Res>
    extends _$TriviaAnswerCopyWithImpl<$Res, _$TriviaAnswerImpl>
    implements _$$TriviaAnswerImplCopyWith<$Res> {
  __$$TriviaAnswerImplCopyWithImpl(
    _$TriviaAnswerImpl _value,
    $Res Function(_$TriviaAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TriviaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionId = null,
    Object? selectedAnswer = null,
    Object? correctAnswer = null,
    Object? isCorrect = null,
    Object? points = null,
    Object? timeLeft = null,
    Object? timestamp = null,
  }) {
    return _then(
      _$TriviaAnswerImpl(
        questionId: null == questionId
            ? _value.questionId
            : questionId // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedAnswer: null == selectedAnswer
            ? _value.selectedAnswer
            : selectedAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswer: null == correctAnswer
            ? _value.correctAnswer
            : correctAnswer // ignore: cast_nullable_to_non_nullable
                  as int,
        isCorrect: null == isCorrect
            ? _value.isCorrect
            : isCorrect // ignore: cast_nullable_to_non_nullable
                  as bool,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        timeLeft: null == timeLeft
            ? _value.timeLeft
            : timeLeft // ignore: cast_nullable_to_non_nullable
                  as int,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TriviaAnswerImpl with DiagnosticableTreeMixin implements _TriviaAnswer {
  const _$TriviaAnswerImpl({
    required this.questionId,
    required this.selectedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.points,
    required this.timeLeft,
    required this.timestamp,
  });

  factory _$TriviaAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriviaAnswerImplFromJson(json);

  @override
  final String questionId;
  @override
  final int selectedAnswer;
  @override
  final int correctAnswer;
  @override
  final bool isCorrect;
  @override
  final int points;
  @override
  final int timeLeft;
  @override
  final DateTime timestamp;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TriviaAnswer(questionId: $questionId, selectedAnswer: $selectedAnswer, correctAnswer: $correctAnswer, isCorrect: $isCorrect, points: $points, timeLeft: $timeLeft, timestamp: $timestamp)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TriviaAnswer'))
      ..add(DiagnosticsProperty('questionId', questionId))
      ..add(DiagnosticsProperty('selectedAnswer', selectedAnswer))
      ..add(DiagnosticsProperty('correctAnswer', correctAnswer))
      ..add(DiagnosticsProperty('isCorrect', isCorrect))
      ..add(DiagnosticsProperty('points', points))
      ..add(DiagnosticsProperty('timeLeft', timeLeft))
      ..add(DiagnosticsProperty('timestamp', timestamp));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaAnswerImpl &&
            (identical(other.questionId, questionId) ||
                other.questionId == questionId) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.correctAnswer, correctAnswer) ||
                other.correctAnswer == correctAnswer) &&
            (identical(other.isCorrect, isCorrect) ||
                other.isCorrect == isCorrect) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.timeLeft, timeLeft) ||
                other.timeLeft == timeLeft) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    questionId,
    selectedAnswer,
    correctAnswer,
    isCorrect,
    points,
    timeLeft,
    timestamp,
  );

  /// Create a copy of TriviaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaAnswerImplCopyWith<_$TriviaAnswerImpl> get copyWith =>
      __$$TriviaAnswerImplCopyWithImpl<_$TriviaAnswerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TriviaAnswerImplToJson(this);
  }
}

abstract class _TriviaAnswer implements TriviaAnswer {
  const factory _TriviaAnswer({
    required final String questionId,
    required final int selectedAnswer,
    required final int correctAnswer,
    required final bool isCorrect,
    required final int points,
    required final int timeLeft,
    required final DateTime timestamp,
  }) = _$TriviaAnswerImpl;

  factory _TriviaAnswer.fromJson(Map<String, dynamic> json) =
      _$TriviaAnswerImpl.fromJson;

  @override
  String get questionId;
  @override
  int get selectedAnswer;
  @override
  int get correctAnswer;
  @override
  bool get isCorrect;
  @override
  int get points;
  @override
  int get timeLeft;
  @override
  DateTime get timestamp;

  /// Create a copy of TriviaAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaAnswerImplCopyWith<_$TriviaAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemoryCard _$MemoryCardFromJson(Map<String, dynamic> json) {
  return _MemoryCard.fromJson(json);
}

/// @nodoc
mixin _$MemoryCard {
  String get id => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  bool get isFlipped => throw _privateConstructorUsedError;
  bool get isMatched => throw _privateConstructorUsedError;
  bool get isAnimating => throw _privateConstructorUsedError;
  String? get customImagePath => throw _privateConstructorUsedError;

  /// Serializes this MemoryCard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoryCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryCardCopyWith<MemoryCard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryCardCopyWith<$Res> {
  factory $MemoryCardCopyWith(
    MemoryCard value,
    $Res Function(MemoryCard) then,
  ) = _$MemoryCardCopyWithImpl<$Res, MemoryCard>;
  @useResult
  $Res call({
    String id,
    String imageUrl,
    String emoji,
    bool isFlipped,
    bool isMatched,
    bool isAnimating,
    String? customImagePath,
  });
}

/// @nodoc
class _$MemoryCardCopyWithImpl<$Res, $Val extends MemoryCard>
    implements $MemoryCardCopyWith<$Res> {
  _$MemoryCardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoryCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? emoji = null,
    Object? isFlipped = null,
    Object? isMatched = null,
    Object? isAnimating = null,
    Object? customImagePath = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            emoji: null == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String,
            isFlipped: null == isFlipped
                ? _value.isFlipped
                : isFlipped // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMatched: null == isMatched
                ? _value.isMatched
                : isMatched // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAnimating: null == isAnimating
                ? _value.isAnimating
                : isAnimating // ignore: cast_nullable_to_non_nullable
                      as bool,
            customImagePath: freezed == customImagePath
                ? _value.customImagePath
                : customImagePath // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemoryCardImplCopyWith<$Res>
    implements $MemoryCardCopyWith<$Res> {
  factory _$$MemoryCardImplCopyWith(
    _$MemoryCardImpl value,
    $Res Function(_$MemoryCardImpl) then,
  ) = __$$MemoryCardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String imageUrl,
    String emoji,
    bool isFlipped,
    bool isMatched,
    bool isAnimating,
    String? customImagePath,
  });
}

/// @nodoc
class __$$MemoryCardImplCopyWithImpl<$Res>
    extends _$MemoryCardCopyWithImpl<$Res, _$MemoryCardImpl>
    implements _$$MemoryCardImplCopyWith<$Res> {
  __$$MemoryCardImplCopyWithImpl(
    _$MemoryCardImpl _value,
    $Res Function(_$MemoryCardImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MemoryCard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? emoji = null,
    Object? isFlipped = null,
    Object? isMatched = null,
    Object? isAnimating = null,
    Object? customImagePath = freezed,
  }) {
    return _then(
      _$MemoryCardImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        emoji: null == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String,
        isFlipped: null == isFlipped
            ? _value.isFlipped
            : isFlipped // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMatched: null == isMatched
            ? _value.isMatched
            : isMatched // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAnimating: null == isAnimating
            ? _value.isAnimating
            : isAnimating // ignore: cast_nullable_to_non_nullable
                  as bool,
        customImagePath: freezed == customImagePath
            ? _value.customImagePath
            : customImagePath // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoryCardImpl with DiagnosticableTreeMixin implements _MemoryCard {
  const _$MemoryCardImpl({
    required this.id,
    required this.imageUrl,
    required this.emoji,
    this.isFlipped = false,
    this.isMatched = false,
    this.isAnimating = false,
    this.customImagePath,
  });

  factory _$MemoryCardImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoryCardImplFromJson(json);

  @override
  final String id;
  @override
  final String imageUrl;
  @override
  final String emoji;
  @override
  @JsonKey()
  final bool isFlipped;
  @override
  @JsonKey()
  final bool isMatched;
  @override
  @JsonKey()
  final bool isAnimating;
  @override
  final String? customImagePath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MemoryCard(id: $id, imageUrl: $imageUrl, emoji: $emoji, isFlipped: $isFlipped, isMatched: $isMatched, isAnimating: $isAnimating, customImagePath: $customImagePath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MemoryCard'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('imageUrl', imageUrl))
      ..add(DiagnosticsProperty('emoji', emoji))
      ..add(DiagnosticsProperty('isFlipped', isFlipped))
      ..add(DiagnosticsProperty('isMatched', isMatched))
      ..add(DiagnosticsProperty('isAnimating', isAnimating))
      ..add(DiagnosticsProperty('customImagePath', customImagePath));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryCardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.isFlipped, isFlipped) ||
                other.isFlipped == isFlipped) &&
            (identical(other.isMatched, isMatched) ||
                other.isMatched == isMatched) &&
            (identical(other.isAnimating, isAnimating) ||
                other.isAnimating == isAnimating) &&
            (identical(other.customImagePath, customImagePath) ||
                other.customImagePath == customImagePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    imageUrl,
    emoji,
    isFlipped,
    isMatched,
    isAnimating,
    customImagePath,
  );

  /// Create a copy of MemoryCard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryCardImplCopyWith<_$MemoryCardImpl> get copyWith =>
      __$$MemoryCardImplCopyWithImpl<_$MemoryCardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoryCardImplToJson(this);
  }
}

abstract class _MemoryCard implements MemoryCard {
  const factory _MemoryCard({
    required final String id,
    required final String imageUrl,
    required final String emoji,
    final bool isFlipped,
    final bool isMatched,
    final bool isAnimating,
    final String? customImagePath,
  }) = _$MemoryCardImpl;

  factory _MemoryCard.fromJson(Map<String, dynamic> json) =
      _$MemoryCardImpl.fromJson;

  @override
  String get id;
  @override
  String get imageUrl;
  @override
  String get emoji;
  @override
  bool get isFlipped;
  @override
  bool get isMatched;
  @override
  bool get isAnimating;
  @override
  String? get customImagePath;

  /// Create a copy of MemoryCard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryCardImplCopyWith<_$MemoryCardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemoryGameConfig _$MemoryGameConfigFromJson(Map<String, dynamic> json) {
  return _MemoryGameConfig.fromJson(json);
}

/// @nodoc
mixin _$MemoryGameConfig {
  DifficultyLevel get difficulty => throw _privateConstructorUsedError;
  int get rows => throw _privateConstructorUsedError;
  int get cols => throw _privateConstructorUsedError;
  int get totalPairs => throw _privateConstructorUsedError;
  int get flipDuration => throw _privateConstructorUsedError;
  int get showDuration => throw _privateConstructorUsedError;
  int get mismatchDelay => throw _privateConstructorUsedError;

  /// Serializes this MemoryGameConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoryGameConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryGameConfigCopyWith<MemoryGameConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryGameConfigCopyWith<$Res> {
  factory $MemoryGameConfigCopyWith(
    MemoryGameConfig value,
    $Res Function(MemoryGameConfig) then,
  ) = _$MemoryGameConfigCopyWithImpl<$Res, MemoryGameConfig>;
  @useResult
  $Res call({
    DifficultyLevel difficulty,
    int rows,
    int cols,
    int totalPairs,
    int flipDuration,
    int showDuration,
    int mismatchDelay,
  });
}

/// @nodoc
class _$MemoryGameConfigCopyWithImpl<$Res, $Val extends MemoryGameConfig>
    implements $MemoryGameConfigCopyWith<$Res> {
  _$MemoryGameConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoryGameConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? difficulty = null,
    Object? rows = null,
    Object? cols = null,
    Object? totalPairs = null,
    Object? flipDuration = null,
    Object? showDuration = null,
    Object? mismatchDelay = null,
  }) {
    return _then(
      _value.copyWith(
            difficulty: null == difficulty
                ? _value.difficulty
                : difficulty // ignore: cast_nullable_to_non_nullable
                      as DifficultyLevel,
            rows: null == rows
                ? _value.rows
                : rows // ignore: cast_nullable_to_non_nullable
                      as int,
            cols: null == cols
                ? _value.cols
                : cols // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPairs: null == totalPairs
                ? _value.totalPairs
                : totalPairs // ignore: cast_nullable_to_non_nullable
                      as int,
            flipDuration: null == flipDuration
                ? _value.flipDuration
                : flipDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            showDuration: null == showDuration
                ? _value.showDuration
                : showDuration // ignore: cast_nullable_to_non_nullable
                      as int,
            mismatchDelay: null == mismatchDelay
                ? _value.mismatchDelay
                : mismatchDelay // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemoryGameConfigImplCopyWith<$Res>
    implements $MemoryGameConfigCopyWith<$Res> {
  factory _$$MemoryGameConfigImplCopyWith(
    _$MemoryGameConfigImpl value,
    $Res Function(_$MemoryGameConfigImpl) then,
  ) = __$$MemoryGameConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DifficultyLevel difficulty,
    int rows,
    int cols,
    int totalPairs,
    int flipDuration,
    int showDuration,
    int mismatchDelay,
  });
}

/// @nodoc
class __$$MemoryGameConfigImplCopyWithImpl<$Res>
    extends _$MemoryGameConfigCopyWithImpl<$Res, _$MemoryGameConfigImpl>
    implements _$$MemoryGameConfigImplCopyWith<$Res> {
  __$$MemoryGameConfigImplCopyWithImpl(
    _$MemoryGameConfigImpl _value,
    $Res Function(_$MemoryGameConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MemoryGameConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? difficulty = null,
    Object? rows = null,
    Object? cols = null,
    Object? totalPairs = null,
    Object? flipDuration = null,
    Object? showDuration = null,
    Object? mismatchDelay = null,
  }) {
    return _then(
      _$MemoryGameConfigImpl(
        difficulty: null == difficulty
            ? _value.difficulty
            : difficulty // ignore: cast_nullable_to_non_nullable
                  as DifficultyLevel,
        rows: null == rows
            ? _value.rows
            : rows // ignore: cast_nullable_to_non_nullable
                  as int,
        cols: null == cols
            ? _value.cols
            : cols // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPairs: null == totalPairs
            ? _value.totalPairs
            : totalPairs // ignore: cast_nullable_to_non_nullable
                  as int,
        flipDuration: null == flipDuration
            ? _value.flipDuration
            : flipDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        showDuration: null == showDuration
            ? _value.showDuration
            : showDuration // ignore: cast_nullable_to_non_nullable
                  as int,
        mismatchDelay: null == mismatchDelay
            ? _value.mismatchDelay
            : mismatchDelay // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoryGameConfigImpl
    with DiagnosticableTreeMixin
    implements _MemoryGameConfig {
  const _$MemoryGameConfigImpl({
    required this.difficulty,
    required this.rows,
    required this.cols,
    required this.totalPairs,
    this.flipDuration = 600,
    this.showDuration = 1000,
    this.mismatchDelay = 1500,
  });

  factory _$MemoryGameConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoryGameConfigImplFromJson(json);

  @override
  final DifficultyLevel difficulty;
  @override
  final int rows;
  @override
  final int cols;
  @override
  final int totalPairs;
  @override
  @JsonKey()
  final int flipDuration;
  @override
  @JsonKey()
  final int showDuration;
  @override
  @JsonKey()
  final int mismatchDelay;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MemoryGameConfig(difficulty: $difficulty, rows: $rows, cols: $cols, totalPairs: $totalPairs, flipDuration: $flipDuration, showDuration: $showDuration, mismatchDelay: $mismatchDelay)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MemoryGameConfig'))
      ..add(DiagnosticsProperty('difficulty', difficulty))
      ..add(DiagnosticsProperty('rows', rows))
      ..add(DiagnosticsProperty('cols', cols))
      ..add(DiagnosticsProperty('totalPairs', totalPairs))
      ..add(DiagnosticsProperty('flipDuration', flipDuration))
      ..add(DiagnosticsProperty('showDuration', showDuration))
      ..add(DiagnosticsProperty('mismatchDelay', mismatchDelay));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryGameConfigImpl &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.rows, rows) || other.rows == rows) &&
            (identical(other.cols, cols) || other.cols == cols) &&
            (identical(other.totalPairs, totalPairs) ||
                other.totalPairs == totalPairs) &&
            (identical(other.flipDuration, flipDuration) ||
                other.flipDuration == flipDuration) &&
            (identical(other.showDuration, showDuration) ||
                other.showDuration == showDuration) &&
            (identical(other.mismatchDelay, mismatchDelay) ||
                other.mismatchDelay == mismatchDelay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    difficulty,
    rows,
    cols,
    totalPairs,
    flipDuration,
    showDuration,
    mismatchDelay,
  );

  /// Create a copy of MemoryGameConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryGameConfigImplCopyWith<_$MemoryGameConfigImpl> get copyWith =>
      __$$MemoryGameConfigImplCopyWithImpl<_$MemoryGameConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoryGameConfigImplToJson(this);
  }
}

abstract class _MemoryGameConfig implements MemoryGameConfig {
  const factory _MemoryGameConfig({
    required final DifficultyLevel difficulty,
    required final int rows,
    required final int cols,
    required final int totalPairs,
    final int flipDuration,
    final int showDuration,
    final int mismatchDelay,
  }) = _$MemoryGameConfigImpl;

  factory _MemoryGameConfig.fromJson(Map<String, dynamic> json) =
      _$MemoryGameConfigImpl.fromJson;

  @override
  DifficultyLevel get difficulty;
  @override
  int get rows;
  @override
  int get cols;
  @override
  int get totalPairs;
  @override
  int get flipDuration;
  @override
  int get showDuration;
  @override
  int get mismatchDelay;

  /// Create a copy of MemoryGameConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryGameConfigImplCopyWith<_$MemoryGameConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SpeedGameScore _$SpeedGameScoreFromJson(Map<String, dynamic> json) {
  return _SpeedGameScore.fromJson(json);
}

/// @nodoc
mixin _$SpeedGameScore {
  String get gameType => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this SpeedGameScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpeedGameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpeedGameScoreCopyWith<SpeedGameScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpeedGameScoreCopyWith<$Res> {
  factory $SpeedGameScoreCopyWith(
    SpeedGameScore value,
    $Res Function(SpeedGameScore) then,
  ) = _$SpeedGameScoreCopyWithImpl<$Res, SpeedGameScore>;
  @useResult
  $Res call({
    String gameType,
    int score,
    int level,
    Duration duration,
    DateTime timestamp,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$SpeedGameScoreCopyWithImpl<$Res, $Val extends SpeedGameScore>
    implements $SpeedGameScoreCopyWith<$Res> {
  _$SpeedGameScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpeedGameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameType = null,
    Object? score = null,
    Object? level = null,
    Object? duration = null,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            gameType: null == gameType
                ? _value.gameType
                : gameType // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SpeedGameScoreImplCopyWith<$Res>
    implements $SpeedGameScoreCopyWith<$Res> {
  factory _$$SpeedGameScoreImplCopyWith(
    _$SpeedGameScoreImpl value,
    $Res Function(_$SpeedGameScoreImpl) then,
  ) = __$$SpeedGameScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String gameType,
    int score,
    int level,
    Duration duration,
    DateTime timestamp,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$SpeedGameScoreImplCopyWithImpl<$Res>
    extends _$SpeedGameScoreCopyWithImpl<$Res, _$SpeedGameScoreImpl>
    implements _$$SpeedGameScoreImplCopyWith<$Res> {
  __$$SpeedGameScoreImplCopyWithImpl(
    _$SpeedGameScoreImpl _value,
    $Res Function(_$SpeedGameScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SpeedGameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameType = null,
    Object? score = null,
    Object? level = null,
    Object? duration = null,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$SpeedGameScoreImpl(
        gameType: null == gameType
            ? _value.gameType
            : gameType // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SpeedGameScoreImpl
    with DiagnosticableTreeMixin
    implements _SpeedGameScore {
  const _$SpeedGameScoreImpl({
    required this.gameType,
    required this.score,
    required this.level,
    required this.duration,
    required this.timestamp,
    final Map<String, dynamic>? metadata,
  }) : _metadata = metadata;

  factory _$SpeedGameScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpeedGameScoreImplFromJson(json);

  @override
  final String gameType;
  @override
  final int score;
  @override
  final int level;
  @override
  final Duration duration;
  @override
  final DateTime timestamp;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SpeedGameScore(gameType: $gameType, score: $score, level: $level, duration: $duration, timestamp: $timestamp, metadata: $metadata)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SpeedGameScore'))
      ..add(DiagnosticsProperty('gameType', gameType))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('level', level))
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('metadata', metadata));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpeedGameScoreImpl &&
            (identical(other.gameType, gameType) ||
                other.gameType == gameType) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    gameType,
    score,
    level,
    duration,
    timestamp,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of SpeedGameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpeedGameScoreImplCopyWith<_$SpeedGameScoreImpl> get copyWith =>
      __$$SpeedGameScoreImplCopyWithImpl<_$SpeedGameScoreImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SpeedGameScoreImplToJson(this);
  }
}

abstract class _SpeedGameScore implements SpeedGameScore {
  const factory _SpeedGameScore({
    required final String gameType,
    required final int score,
    required final int level,
    required final Duration duration,
    required final DateTime timestamp,
    final Map<String, dynamic>? metadata,
  }) = _$SpeedGameScoreImpl;

  factory _SpeedGameScore.fromJson(Map<String, dynamic> json) =
      _$SpeedGameScoreImpl.fromJson;

  @override
  String get gameType;
  @override
  int get score;
  @override
  int get level;
  @override
  Duration get duration;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of SpeedGameScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpeedGameScoreImplCopyWith<_$SpeedGameScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameStats _$GameStatsFromJson(Map<String, dynamic> json) {
  return _GameStats.fromJson(json);
}

/// @nodoc
mixin _$GameStats {
  List<MemoryGameScore> get memoryGames => throw _privateConstructorUsedError;
  List<TriviaGameScore> get triviaGames => throw _privateConstructorUsedError;
  List<SpeedGameScore> get speedGames => throw _privateConstructorUsedError;
  int get totalGamesPlayed => throw _privateConstructorUsedError;
  int get totalTimeSpent => throw _privateConstructorUsedError;

  /// Serializes this GameStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStatsCopyWith<GameStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStatsCopyWith<$Res> {
  factory $GameStatsCopyWith(GameStats value, $Res Function(GameStats) then) =
      _$GameStatsCopyWithImpl<$Res, GameStats>;
  @useResult
  $Res call({
    List<MemoryGameScore> memoryGames,
    List<TriviaGameScore> triviaGames,
    List<SpeedGameScore> speedGames,
    int totalGamesPlayed,
    int totalTimeSpent,
  });
}

/// @nodoc
class _$GameStatsCopyWithImpl<$Res, $Val extends GameStats>
    implements $GameStatsCopyWith<$Res> {
  _$GameStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryGames = null,
    Object? triviaGames = null,
    Object? speedGames = null,
    Object? totalGamesPlayed = null,
    Object? totalTimeSpent = null,
  }) {
    return _then(
      _value.copyWith(
            memoryGames: null == memoryGames
                ? _value.memoryGames
                : memoryGames // ignore: cast_nullable_to_non_nullable
                      as List<MemoryGameScore>,
            triviaGames: null == triviaGames
                ? _value.triviaGames
                : triviaGames // ignore: cast_nullable_to_non_nullable
                      as List<TriviaGameScore>,
            speedGames: null == speedGames
                ? _value.speedGames
                : speedGames // ignore: cast_nullable_to_non_nullable
                      as List<SpeedGameScore>,
            totalGamesPlayed: null == totalGamesPlayed
                ? _value.totalGamesPlayed
                : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTimeSpent: null == totalTimeSpent
                ? _value.totalTimeSpent
                : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameStatsImplCopyWith<$Res>
    implements $GameStatsCopyWith<$Res> {
  factory _$$GameStatsImplCopyWith(
    _$GameStatsImpl value,
    $Res Function(_$GameStatsImpl) then,
  ) = __$$GameStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<MemoryGameScore> memoryGames,
    List<TriviaGameScore> triviaGames,
    List<SpeedGameScore> speedGames,
    int totalGamesPlayed,
    int totalTimeSpent,
  });
}

/// @nodoc
class __$$GameStatsImplCopyWithImpl<$Res>
    extends _$GameStatsCopyWithImpl<$Res, _$GameStatsImpl>
    implements _$$GameStatsImplCopyWith<$Res> {
  __$$GameStatsImplCopyWithImpl(
    _$GameStatsImpl _value,
    $Res Function(_$GameStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memoryGames = null,
    Object? triviaGames = null,
    Object? speedGames = null,
    Object? totalGamesPlayed = null,
    Object? totalTimeSpent = null,
  }) {
    return _then(
      _$GameStatsImpl(
        memoryGames: null == memoryGames
            ? _value._memoryGames
            : memoryGames // ignore: cast_nullable_to_non_nullable
                  as List<MemoryGameScore>,
        triviaGames: null == triviaGames
            ? _value._triviaGames
            : triviaGames // ignore: cast_nullable_to_non_nullable
                  as List<TriviaGameScore>,
        speedGames: null == speedGames
            ? _value._speedGames
            : speedGames // ignore: cast_nullable_to_non_nullable
                  as List<SpeedGameScore>,
        totalGamesPlayed: null == totalGamesPlayed
            ? _value.totalGamesPlayed
            : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTimeSpent: null == totalTimeSpent
            ? _value.totalTimeSpent
            : totalTimeSpent // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStatsImpl with DiagnosticableTreeMixin implements _GameStats {
  const _$GameStatsImpl({
    final List<MemoryGameScore> memoryGames = const [],
    final List<TriviaGameScore> triviaGames = const [],
    final List<SpeedGameScore> speedGames = const [],
    this.totalGamesPlayed = 0,
    this.totalTimeSpent = 0,
  }) : _memoryGames = memoryGames,
       _triviaGames = triviaGames,
       _speedGames = speedGames;

  factory _$GameStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStatsImplFromJson(json);

  final List<MemoryGameScore> _memoryGames;
  @override
  @JsonKey()
  List<MemoryGameScore> get memoryGames {
    if (_memoryGames is EqualUnmodifiableListView) return _memoryGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memoryGames);
  }

  final List<TriviaGameScore> _triviaGames;
  @override
  @JsonKey()
  List<TriviaGameScore> get triviaGames {
    if (_triviaGames is EqualUnmodifiableListView) return _triviaGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triviaGames);
  }

  final List<SpeedGameScore> _speedGames;
  @override
  @JsonKey()
  List<SpeedGameScore> get speedGames {
    if (_speedGames is EqualUnmodifiableListView) return _speedGames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_speedGames);
  }

  @override
  @JsonKey()
  final int totalGamesPlayed;
  @override
  @JsonKey()
  final int totalTimeSpent;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameStats(memoryGames: $memoryGames, triviaGames: $triviaGames, speedGames: $speedGames, totalGamesPlayed: $totalGamesPlayed, totalTimeSpent: $totalTimeSpent)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameStats'))
      ..add(DiagnosticsProperty('memoryGames', memoryGames))
      ..add(DiagnosticsProperty('triviaGames', triviaGames))
      ..add(DiagnosticsProperty('speedGames', speedGames))
      ..add(DiagnosticsProperty('totalGamesPlayed', totalGamesPlayed))
      ..add(DiagnosticsProperty('totalTimeSpent', totalTimeSpent));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStatsImpl &&
            const DeepCollectionEquality().equals(
              other._memoryGames,
              _memoryGames,
            ) &&
            const DeepCollectionEquality().equals(
              other._triviaGames,
              _triviaGames,
            ) &&
            const DeepCollectionEquality().equals(
              other._speedGames,
              _speedGames,
            ) &&
            (identical(other.totalGamesPlayed, totalGamesPlayed) ||
                other.totalGamesPlayed == totalGamesPlayed) &&
            (identical(other.totalTimeSpent, totalTimeSpent) ||
                other.totalTimeSpent == totalTimeSpent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_memoryGames),
    const DeepCollectionEquality().hash(_triviaGames),
    const DeepCollectionEquality().hash(_speedGames),
    totalGamesPlayed,
    totalTimeSpent,
  );

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStatsImplCopyWith<_$GameStatsImpl> get copyWith =>
      __$$GameStatsImplCopyWithImpl<_$GameStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStatsImplToJson(this);
  }
}

abstract class _GameStats implements GameStats {
  const factory _GameStats({
    final List<MemoryGameScore> memoryGames,
    final List<TriviaGameScore> triviaGames,
    final List<SpeedGameScore> speedGames,
    final int totalGamesPlayed,
    final int totalTimeSpent,
  }) = _$GameStatsImpl;

  factory _GameStats.fromJson(Map<String, dynamic> json) =
      _$GameStatsImpl.fromJson;

  @override
  List<MemoryGameScore> get memoryGames;
  @override
  List<TriviaGameScore> get triviaGames;
  @override
  List<SpeedGameScore> get speedGames;
  @override
  int get totalGamesPlayed;
  @override
  int get totalTimeSpent;

  /// Create a copy of GameStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStatsImplCopyWith<_$GameStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MemoryGameScore _$MemoryGameScoreFromJson(Map<String, dynamic> json) {
  return _MemoryGameScore.fromJson(json);
}

/// @nodoc
mixin _$MemoryGameScore {
  DifficultyLevel get level => throw _privateConstructorUsedError;
  int get moves => throw _privateConstructorUsedError;
  Duration get time => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  int get stars => throw _privateConstructorUsedError;

  /// Serializes this MemoryGameScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MemoryGameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MemoryGameScoreCopyWith<MemoryGameScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MemoryGameScoreCopyWith<$Res> {
  factory $MemoryGameScoreCopyWith(
    MemoryGameScore value,
    $Res Function(MemoryGameScore) then,
  ) = _$MemoryGameScoreCopyWithImpl<$Res, MemoryGameScore>;
  @useResult
  $Res call({
    DifficultyLevel level,
    int moves,
    Duration time,
    DateTime timestamp,
    int stars,
  });
}

/// @nodoc
class _$MemoryGameScoreCopyWithImpl<$Res, $Val extends MemoryGameScore>
    implements $MemoryGameScoreCopyWith<$Res> {
  _$MemoryGameScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MemoryGameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? moves = null,
    Object? time = null,
    Object? timestamp = null,
    Object? stars = null,
  }) {
    return _then(
      _value.copyWith(
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as DifficultyLevel,
            moves: null == moves
                ? _value.moves
                : moves // ignore: cast_nullable_to_non_nullable
                      as int,
            time: null == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as Duration,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            stars: null == stars
                ? _value.stars
                : stars // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MemoryGameScoreImplCopyWith<$Res>
    implements $MemoryGameScoreCopyWith<$Res> {
  factory _$$MemoryGameScoreImplCopyWith(
    _$MemoryGameScoreImpl value,
    $Res Function(_$MemoryGameScoreImpl) then,
  ) = __$$MemoryGameScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DifficultyLevel level,
    int moves,
    Duration time,
    DateTime timestamp,
    int stars,
  });
}

/// @nodoc
class __$$MemoryGameScoreImplCopyWithImpl<$Res>
    extends _$MemoryGameScoreCopyWithImpl<$Res, _$MemoryGameScoreImpl>
    implements _$$MemoryGameScoreImplCopyWith<$Res> {
  __$$MemoryGameScoreImplCopyWithImpl(
    _$MemoryGameScoreImpl _value,
    $Res Function(_$MemoryGameScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MemoryGameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? moves = null,
    Object? time = null,
    Object? timestamp = null,
    Object? stars = null,
  }) {
    return _then(
      _$MemoryGameScoreImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as DifficultyLevel,
        moves: null == moves
            ? _value.moves
            : moves // ignore: cast_nullable_to_non_nullable
                  as int,
        time: null == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as Duration,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        stars: null == stars
            ? _value.stars
            : stars // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MemoryGameScoreImpl
    with DiagnosticableTreeMixin
    implements _MemoryGameScore {
  const _$MemoryGameScoreImpl({
    required this.level,
    required this.moves,
    required this.time,
    required this.timestamp,
    this.stars = 0,
  });

  factory _$MemoryGameScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$MemoryGameScoreImplFromJson(json);

  @override
  final DifficultyLevel level;
  @override
  final int moves;
  @override
  final Duration time;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final int stars;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MemoryGameScore(level: $level, moves: $moves, time: $time, timestamp: $timestamp, stars: $stars)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MemoryGameScore'))
      ..add(DiagnosticsProperty('level', level))
      ..add(DiagnosticsProperty('moves', moves))
      ..add(DiagnosticsProperty('time', time))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('stars', stars));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MemoryGameScoreImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.moves, moves) || other.moves == moves) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.stars, stars) || other.stars == stars));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, level, moves, time, timestamp, stars);

  /// Create a copy of MemoryGameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MemoryGameScoreImplCopyWith<_$MemoryGameScoreImpl> get copyWith =>
      __$$MemoryGameScoreImplCopyWithImpl<_$MemoryGameScoreImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MemoryGameScoreImplToJson(this);
  }
}

abstract class _MemoryGameScore implements MemoryGameScore {
  const factory _MemoryGameScore({
    required final DifficultyLevel level,
    required final int moves,
    required final Duration time,
    required final DateTime timestamp,
    final int stars,
  }) = _$MemoryGameScoreImpl;

  factory _MemoryGameScore.fromJson(Map<String, dynamic> json) =
      _$MemoryGameScoreImpl.fromJson;

  @override
  DifficultyLevel get level;
  @override
  int get moves;
  @override
  Duration get time;
  @override
  DateTime get timestamp;
  @override
  int get stars;

  /// Create a copy of MemoryGameScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MemoryGameScoreImplCopyWith<_$MemoryGameScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TriviaGameScore _$TriviaGameScoreFromJson(Map<String, dynamic> json) {
  return _TriviaGameScore.fromJson(json);
}

/// @nodoc
mixin _$TriviaGameScore {
  int get score => throw _privateConstructorUsedError;
  int get correctAnswers => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  Duration get totalTime => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  List<TriviaAnswer> get answers => throw _privateConstructorUsedError;

  /// Serializes this TriviaGameScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TriviaGameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TriviaGameScoreCopyWith<TriviaGameScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TriviaGameScoreCopyWith<$Res> {
  factory $TriviaGameScoreCopyWith(
    TriviaGameScore value,
    $Res Function(TriviaGameScore) then,
  ) = _$TriviaGameScoreCopyWithImpl<$Res, TriviaGameScore>;
  @useResult
  $Res call({
    int score,
    int correctAnswers,
    int totalQuestions,
    Duration totalTime,
    DateTime timestamp,
    List<TriviaAnswer> answers,
  });
}

/// @nodoc
class _$TriviaGameScoreCopyWithImpl<$Res, $Val extends TriviaGameScore>
    implements $TriviaGameScoreCopyWith<$Res> {
  _$TriviaGameScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TriviaGameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? correctAnswers = null,
    Object? totalQuestions = null,
    Object? totalTime = null,
    Object? timestamp = null,
    Object? answers = null,
  }) {
    return _then(
      _value.copyWith(
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            correctAnswers: null == correctAnswers
                ? _value.correctAnswers
                : correctAnswers // ignore: cast_nullable_to_non_nullable
                      as int,
            totalQuestions: null == totalQuestions
                ? _value.totalQuestions
                : totalQuestions // ignore: cast_nullable_to_non_nullable
                      as int,
            totalTime: null == totalTime
                ? _value.totalTime
                : totalTime // ignore: cast_nullable_to_non_nullable
                      as Duration,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            answers: null == answers
                ? _value.answers
                : answers // ignore: cast_nullable_to_non_nullable
                      as List<TriviaAnswer>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TriviaGameScoreImplCopyWith<$Res>
    implements $TriviaGameScoreCopyWith<$Res> {
  factory _$$TriviaGameScoreImplCopyWith(
    _$TriviaGameScoreImpl value,
    $Res Function(_$TriviaGameScoreImpl) then,
  ) = __$$TriviaGameScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int score,
    int correctAnswers,
    int totalQuestions,
    Duration totalTime,
    DateTime timestamp,
    List<TriviaAnswer> answers,
  });
}

/// @nodoc
class __$$TriviaGameScoreImplCopyWithImpl<$Res>
    extends _$TriviaGameScoreCopyWithImpl<$Res, _$TriviaGameScoreImpl>
    implements _$$TriviaGameScoreImplCopyWith<$Res> {
  __$$TriviaGameScoreImplCopyWithImpl(
    _$TriviaGameScoreImpl _value,
    $Res Function(_$TriviaGameScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TriviaGameScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? score = null,
    Object? correctAnswers = null,
    Object? totalQuestions = null,
    Object? totalTime = null,
    Object? timestamp = null,
    Object? answers = null,
  }) {
    return _then(
      _$TriviaGameScoreImpl(
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        correctAnswers: null == correctAnswers
            ? _value.correctAnswers
            : correctAnswers // ignore: cast_nullable_to_non_nullable
                  as int,
        totalQuestions: null == totalQuestions
            ? _value.totalQuestions
            : totalQuestions // ignore: cast_nullable_to_non_nullable
                  as int,
        totalTime: null == totalTime
            ? _value.totalTime
            : totalTime // ignore: cast_nullable_to_non_nullable
                  as Duration,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        answers: null == answers
            ? _value._answers
            : answers // ignore: cast_nullable_to_non_nullable
                  as List<TriviaAnswer>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TriviaGameScoreImpl
    with DiagnosticableTreeMixin
    implements _TriviaGameScore {
  const _$TriviaGameScoreImpl({
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.totalTime,
    required this.timestamp,
    final List<TriviaAnswer> answers = const [],
  }) : _answers = answers;

  factory _$TriviaGameScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$TriviaGameScoreImplFromJson(json);

  @override
  final int score;
  @override
  final int correctAnswers;
  @override
  final int totalQuestions;
  @override
  final Duration totalTime;
  @override
  final DateTime timestamp;
  final List<TriviaAnswer> _answers;
  @override
  @JsonKey()
  List<TriviaAnswer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TriviaGameScore(score: $score, correctAnswers: $correctAnswers, totalQuestions: $totalQuestions, totalTime: $totalTime, timestamp: $timestamp, answers: $answers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TriviaGameScore'))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('correctAnswers', correctAnswers))
      ..add(DiagnosticsProperty('totalQuestions', totalQuestions))
      ..add(DiagnosticsProperty('totalTime', totalTime))
      ..add(DiagnosticsProperty('timestamp', timestamp))
      ..add(DiagnosticsProperty('answers', answers));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TriviaGameScoreImpl &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.correctAnswers, correctAnswers) ||
                other.correctAnswers == correctAnswers) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            (identical(other.totalTime, totalTime) ||
                other.totalTime == totalTime) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._answers, _answers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    score,
    correctAnswers,
    totalQuestions,
    totalTime,
    timestamp,
    const DeepCollectionEquality().hash(_answers),
  );

  /// Create a copy of TriviaGameScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TriviaGameScoreImplCopyWith<_$TriviaGameScoreImpl> get copyWith =>
      __$$TriviaGameScoreImplCopyWithImpl<_$TriviaGameScoreImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TriviaGameScoreImplToJson(this);
  }
}

abstract class _TriviaGameScore implements TriviaGameScore {
  const factory _TriviaGameScore({
    required final int score,
    required final int correctAnswers,
    required final int totalQuestions,
    required final Duration totalTime,
    required final DateTime timestamp,
    final List<TriviaAnswer> answers,
  }) = _$TriviaGameScoreImpl;

  factory _TriviaGameScore.fromJson(Map<String, dynamic> json) =
      _$TriviaGameScoreImpl.fromJson;

  @override
  int get score;
  @override
  int get correctAnswers;
  @override
  int get totalQuestions;
  @override
  Duration get totalTime;
  @override
  DateTime get timestamp;
  @override
  List<TriviaAnswer> get answers;

  /// Create a copy of TriviaGameScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TriviaGameScoreImplCopyWith<_$TriviaGameScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColorPalette _$ColorPaletteFromJson(Map<String, dynamic> json) {
  return _ColorPalette.fromJson(json);
}

/// @nodoc
mixin _$ColorPalette {
  String get name => throw _privateConstructorUsedError;
  String get primary => throw _privateConstructorUsedError;
  String get secondary => throw _privateConstructorUsedError;
  String get accent => throw _privateConstructorUsedError;
  String get background => throw _privateConstructorUsedError;
  String get surface => throw _privateConstructorUsedError;
  String get onPrimary => throw _privateConstructorUsedError;
  String get onSecondary => throw _privateConstructorUsedError;
  String get onBackground => throw _privateConstructorUsedError;
  String get onSurface => throw _privateConstructorUsedError;
  bool get isCustom => throw _privateConstructorUsedError;

  /// Serializes this ColorPalette to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColorPaletteCopyWith<ColorPalette> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorPaletteCopyWith<$Res> {
  factory $ColorPaletteCopyWith(
    ColorPalette value,
    $Res Function(ColorPalette) then,
  ) = _$ColorPaletteCopyWithImpl<$Res, ColorPalette>;
  @useResult
  $Res call({
    String name,
    String primary,
    String secondary,
    String accent,
    String background,
    String surface,
    String onPrimary,
    String onSecondary,
    String onBackground,
    String onSurface,
    bool isCustom,
  });
}

/// @nodoc
class _$ColorPaletteCopyWithImpl<$Res, $Val extends ColorPalette>
    implements $ColorPaletteCopyWith<$Res> {
  _$ColorPaletteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? primary = null,
    Object? secondary = null,
    Object? accent = null,
    Object? background = null,
    Object? surface = null,
    Object? onPrimary = null,
    Object? onSecondary = null,
    Object? onBackground = null,
    Object? onSurface = null,
    Object? isCustom = null,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            primary: null == primary
                ? _value.primary
                : primary // ignore: cast_nullable_to_non_nullable
                      as String,
            secondary: null == secondary
                ? _value.secondary
                : secondary // ignore: cast_nullable_to_non_nullable
                      as String,
            accent: null == accent
                ? _value.accent
                : accent // ignore: cast_nullable_to_non_nullable
                      as String,
            background: null == background
                ? _value.background
                : background // ignore: cast_nullable_to_non_nullable
                      as String,
            surface: null == surface
                ? _value.surface
                : surface // ignore: cast_nullable_to_non_nullable
                      as String,
            onPrimary: null == onPrimary
                ? _value.onPrimary
                : onPrimary // ignore: cast_nullable_to_non_nullable
                      as String,
            onSecondary: null == onSecondary
                ? _value.onSecondary
                : onSecondary // ignore: cast_nullable_to_non_nullable
                      as String,
            onBackground: null == onBackground
                ? _value.onBackground
                : onBackground // ignore: cast_nullable_to_non_nullable
                      as String,
            onSurface: null == onSurface
                ? _value.onSurface
                : onSurface // ignore: cast_nullable_to_non_nullable
                      as String,
            isCustom: null == isCustom
                ? _value.isCustom
                : isCustom // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ColorPaletteImplCopyWith<$Res>
    implements $ColorPaletteCopyWith<$Res> {
  factory _$$ColorPaletteImplCopyWith(
    _$ColorPaletteImpl value,
    $Res Function(_$ColorPaletteImpl) then,
  ) = __$$ColorPaletteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String primary,
    String secondary,
    String accent,
    String background,
    String surface,
    String onPrimary,
    String onSecondary,
    String onBackground,
    String onSurface,
    bool isCustom,
  });
}

/// @nodoc
class __$$ColorPaletteImplCopyWithImpl<$Res>
    extends _$ColorPaletteCopyWithImpl<$Res, _$ColorPaletteImpl>
    implements _$$ColorPaletteImplCopyWith<$Res> {
  __$$ColorPaletteImplCopyWithImpl(
    _$ColorPaletteImpl _value,
    $Res Function(_$ColorPaletteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? primary = null,
    Object? secondary = null,
    Object? accent = null,
    Object? background = null,
    Object? surface = null,
    Object? onPrimary = null,
    Object? onSecondary = null,
    Object? onBackground = null,
    Object? onSurface = null,
    Object? isCustom = null,
  }) {
    return _then(
      _$ColorPaletteImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        primary: null == primary
            ? _value.primary
            : primary // ignore: cast_nullable_to_non_nullable
                  as String,
        secondary: null == secondary
            ? _value.secondary
            : secondary // ignore: cast_nullable_to_non_nullable
                  as String,
        accent: null == accent
            ? _value.accent
            : accent // ignore: cast_nullable_to_non_nullable
                  as String,
        background: null == background
            ? _value.background
            : background // ignore: cast_nullable_to_non_nullable
                  as String,
        surface: null == surface
            ? _value.surface
            : surface // ignore: cast_nullable_to_non_nullable
                  as String,
        onPrimary: null == onPrimary
            ? _value.onPrimary
            : onPrimary // ignore: cast_nullable_to_non_nullable
                  as String,
        onSecondary: null == onSecondary
            ? _value.onSecondary
            : onSecondary // ignore: cast_nullable_to_non_nullable
                  as String,
        onBackground: null == onBackground
            ? _value.onBackground
            : onBackground // ignore: cast_nullable_to_non_nullable
                  as String,
        onSurface: null == onSurface
            ? _value.onSurface
            : onSurface // ignore: cast_nullable_to_non_nullable
                  as String,
        isCustom: null == isCustom
            ? _value.isCustom
            : isCustom // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorPaletteImpl with DiagnosticableTreeMixin implements _ColorPalette {
  const _$ColorPaletteImpl({
    required this.name,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
    required this.onPrimary,
    required this.onSecondary,
    required this.onBackground,
    required this.onSurface,
    this.isCustom = false,
  });

  factory _$ColorPaletteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorPaletteImplFromJson(json);

  @override
  final String name;
  @override
  final String primary;
  @override
  final String secondary;
  @override
  final String accent;
  @override
  final String background;
  @override
  final String surface;
  @override
  final String onPrimary;
  @override
  final String onSecondary;
  @override
  final String onBackground;
  @override
  final String onSurface;
  @override
  @JsonKey()
  final bool isCustom;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ColorPalette(name: $name, primary: $primary, secondary: $secondary, accent: $accent, background: $background, surface: $surface, onPrimary: $onPrimary, onSecondary: $onSecondary, onBackground: $onBackground, onSurface: $onSurface, isCustom: $isCustom)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ColorPalette'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('primary', primary))
      ..add(DiagnosticsProperty('secondary', secondary))
      ..add(DiagnosticsProperty('accent', accent))
      ..add(DiagnosticsProperty('background', background))
      ..add(DiagnosticsProperty('surface', surface))
      ..add(DiagnosticsProperty('onPrimary', onPrimary))
      ..add(DiagnosticsProperty('onSecondary', onSecondary))
      ..add(DiagnosticsProperty('onBackground', onBackground))
      ..add(DiagnosticsProperty('onSurface', onSurface))
      ..add(DiagnosticsProperty('isCustom', isCustom));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorPaletteImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.accent, accent) || other.accent == accent) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.onPrimary, onPrimary) ||
                other.onPrimary == onPrimary) &&
            (identical(other.onSecondary, onSecondary) ||
                other.onSecondary == onSecondary) &&
            (identical(other.onBackground, onBackground) ||
                other.onBackground == onBackground) &&
            (identical(other.onSurface, onSurface) ||
                other.onSurface == onSurface) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    primary,
    secondary,
    accent,
    background,
    surface,
    onPrimary,
    onSecondary,
    onBackground,
    onSurface,
    isCustom,
  );

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorPaletteImplCopyWith<_$ColorPaletteImpl> get copyWith =>
      __$$ColorPaletteImplCopyWithImpl<_$ColorPaletteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorPaletteImplToJson(this);
  }
}

abstract class _ColorPalette implements ColorPalette {
  const factory _ColorPalette({
    required final String name,
    required final String primary,
    required final String secondary,
    required final String accent,
    required final String background,
    required final String surface,
    required final String onPrimary,
    required final String onSecondary,
    required final String onBackground,
    required final String onSurface,
    final bool isCustom,
  }) = _$ColorPaletteImpl;

  factory _ColorPalette.fromJson(Map<String, dynamic> json) =
      _$ColorPaletteImpl.fromJson;

  @override
  String get name;
  @override
  String get primary;
  @override
  String get secondary;
  @override
  String get accent;
  @override
  String get background;
  @override
  String get surface;
  @override
  String get onPrimary;
  @override
  String get onSecondary;
  @override
  String get onBackground;
  @override
  String get onSurface;
  @override
  bool get isCustom;

  /// Create a copy of ColorPalette
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColorPaletteImplCopyWith<_$ColorPaletteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameConfig _$GameConfigFromJson(Map<String, dynamic> json) {
  return _GameConfig.fromJson(json);
}

/// @nodoc
mixin _$GameConfig {
  String get eventName => throw _privateConstructorUsedError;
  String get honoredPerson => throw _privateConstructorUsedError;
  EventType get eventType => throw _privateConstructorUsedError;
  String get eventDate => throw _privateConstructorUsedError;
  ColorPalette get colorPalette => throw _privateConstructorUsedError;
  List<String> get customImages => throw _privateConstructorUsedError;
  bool get useCustomImages => throw _privateConstructorUsedError;
  List<TriviaQuestion> get triviaQuestions =>
      throw _privateConstructorUsedError;
  GameStats get gameStats => throw _privateConstructorUsedError;
  bool get soundEnabled => throw _privateConstructorUsedError;
  bool get animationsEnabled => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get lastModified => throw _privateConstructorUsedError;

  /// Serializes this GameConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameConfigCopyWith<GameConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameConfigCopyWith<$Res> {
  factory $GameConfigCopyWith(
    GameConfig value,
    $Res Function(GameConfig) then,
  ) = _$GameConfigCopyWithImpl<$Res, GameConfig>;
  @useResult
  $Res call({
    String eventName,
    String honoredPerson,
    EventType eventType,
    String eventDate,
    ColorPalette colorPalette,
    List<String> customImages,
    bool useCustomImages,
    List<TriviaQuestion> triviaQuestions,
    GameStats gameStats,
    bool soundEnabled,
    bool animationsEnabled,
    double volume,
    DateTime? createdAt,
    DateTime? lastModified,
  });

  $ColorPaletteCopyWith<$Res> get colorPalette;
  $GameStatsCopyWith<$Res> get gameStats;
}

/// @nodoc
class _$GameConfigCopyWithImpl<$Res, $Val extends GameConfig>
    implements $GameConfigCopyWith<$Res> {
  _$GameConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventName = null,
    Object? honoredPerson = null,
    Object? eventType = null,
    Object? eventDate = null,
    Object? colorPalette = null,
    Object? customImages = null,
    Object? useCustomImages = null,
    Object? triviaQuestions = null,
    Object? gameStats = null,
    Object? soundEnabled = null,
    Object? animationsEnabled = null,
    Object? volume = null,
    Object? createdAt = freezed,
    Object? lastModified = freezed,
  }) {
    return _then(
      _value.copyWith(
            eventName: null == eventName
                ? _value.eventName
                : eventName // ignore: cast_nullable_to_non_nullable
                      as String,
            honoredPerson: null == honoredPerson
                ? _value.honoredPerson
                : honoredPerson // ignore: cast_nullable_to_non_nullable
                      as String,
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as EventType,
            eventDate: null == eventDate
                ? _value.eventDate
                : eventDate // ignore: cast_nullable_to_non_nullable
                      as String,
            colorPalette: null == colorPalette
                ? _value.colorPalette
                : colorPalette // ignore: cast_nullable_to_non_nullable
                      as ColorPalette,
            customImages: null == customImages
                ? _value.customImages
                : customImages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            useCustomImages: null == useCustomImages
                ? _value.useCustomImages
                : useCustomImages // ignore: cast_nullable_to_non_nullable
                      as bool,
            triviaQuestions: null == triviaQuestions
                ? _value.triviaQuestions
                : triviaQuestions // ignore: cast_nullable_to_non_nullable
                      as List<TriviaQuestion>,
            gameStats: null == gameStats
                ? _value.gameStats
                : gameStats // ignore: cast_nullable_to_non_nullable
                      as GameStats,
            soundEnabled: null == soundEnabled
                ? _value.soundEnabled
                : soundEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            animationsEnabled: null == animationsEnabled
                ? _value.animationsEnabled
                : animationsEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            volume: null == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            lastModified: freezed == lastModified
                ? _value.lastModified
                : lastModified // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ColorPaletteCopyWith<$Res> get colorPalette {
    return $ColorPaletteCopyWith<$Res>(_value.colorPalette, (value) {
      return _then(_value.copyWith(colorPalette: value) as $Val);
    });
  }

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $GameStatsCopyWith<$Res> get gameStats {
    return $GameStatsCopyWith<$Res>(_value.gameStats, (value) {
      return _then(_value.copyWith(gameStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameConfigImplCopyWith<$Res>
    implements $GameConfigCopyWith<$Res> {
  factory _$$GameConfigImplCopyWith(
    _$GameConfigImpl value,
    $Res Function(_$GameConfigImpl) then,
  ) = __$$GameConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String eventName,
    String honoredPerson,
    EventType eventType,
    String eventDate,
    ColorPalette colorPalette,
    List<String> customImages,
    bool useCustomImages,
    List<TriviaQuestion> triviaQuestions,
    GameStats gameStats,
    bool soundEnabled,
    bool animationsEnabled,
    double volume,
    DateTime? createdAt,
    DateTime? lastModified,
  });

  @override
  $ColorPaletteCopyWith<$Res> get colorPalette;
  @override
  $GameStatsCopyWith<$Res> get gameStats;
}

/// @nodoc
class __$$GameConfigImplCopyWithImpl<$Res>
    extends _$GameConfigCopyWithImpl<$Res, _$GameConfigImpl>
    implements _$$GameConfigImplCopyWith<$Res> {
  __$$GameConfigImplCopyWithImpl(
    _$GameConfigImpl _value,
    $Res Function(_$GameConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventName = null,
    Object? honoredPerson = null,
    Object? eventType = null,
    Object? eventDate = null,
    Object? colorPalette = null,
    Object? customImages = null,
    Object? useCustomImages = null,
    Object? triviaQuestions = null,
    Object? gameStats = null,
    Object? soundEnabled = null,
    Object? animationsEnabled = null,
    Object? volume = null,
    Object? createdAt = freezed,
    Object? lastModified = freezed,
  }) {
    return _then(
      _$GameConfigImpl(
        eventName: null == eventName
            ? _value.eventName
            : eventName // ignore: cast_nullable_to_non_nullable
                  as String,
        honoredPerson: null == honoredPerson
            ? _value.honoredPerson
            : honoredPerson // ignore: cast_nullable_to_non_nullable
                  as String,
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as EventType,
        eventDate: null == eventDate
            ? _value.eventDate
            : eventDate // ignore: cast_nullable_to_non_nullable
                  as String,
        colorPalette: null == colorPalette
            ? _value.colorPalette
            : colorPalette // ignore: cast_nullable_to_non_nullable
                  as ColorPalette,
        customImages: null == customImages
            ? _value._customImages
            : customImages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        useCustomImages: null == useCustomImages
            ? _value.useCustomImages
            : useCustomImages // ignore: cast_nullable_to_non_nullable
                  as bool,
        triviaQuestions: null == triviaQuestions
            ? _value._triviaQuestions
            : triviaQuestions // ignore: cast_nullable_to_non_nullable
                  as List<TriviaQuestion>,
        gameStats: null == gameStats
            ? _value.gameStats
            : gameStats // ignore: cast_nullable_to_non_nullable
                  as GameStats,
        soundEnabled: null == soundEnabled
            ? _value.soundEnabled
            : soundEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        animationsEnabled: null == animationsEnabled
            ? _value.animationsEnabled
            : animationsEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        volume: null == volume
            ? _value.volume
            : volume // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        lastModified: freezed == lastModified
            ? _value.lastModified
            : lastModified // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameConfigImpl with DiagnosticableTreeMixin implements _GameConfig {
  const _$GameConfigImpl({
    required this.eventName,
    required this.honoredPerson,
    required this.eventType,
    required this.eventDate,
    required this.colorPalette,
    final List<String> customImages = const [],
    this.useCustomImages = false,
    final List<TriviaQuestion> triviaQuestions = const [],
    this.gameStats = const GameStats(),
    this.soundEnabled = true,
    this.animationsEnabled = true,
    this.volume = 1.0,
    this.createdAt,
    this.lastModified,
  }) : _customImages = customImages,
       _triviaQuestions = triviaQuestions;

  factory _$GameConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameConfigImplFromJson(json);

  @override
  final String eventName;
  @override
  final String honoredPerson;
  @override
  final EventType eventType;
  @override
  final String eventDate;
  @override
  final ColorPalette colorPalette;
  final List<String> _customImages;
  @override
  @JsonKey()
  List<String> get customImages {
    if (_customImages is EqualUnmodifiableListView) return _customImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customImages);
  }

  @override
  @JsonKey()
  final bool useCustomImages;
  final List<TriviaQuestion> _triviaQuestions;
  @override
  @JsonKey()
  List<TriviaQuestion> get triviaQuestions {
    if (_triviaQuestions is EqualUnmodifiableListView) return _triviaQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_triviaQuestions);
  }

  @override
  @JsonKey()
  final GameStats gameStats;
  @override
  @JsonKey()
  final bool soundEnabled;
  @override
  @JsonKey()
  final bool animationsEnabled;
  @override
  @JsonKey()
  final double volume;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? lastModified;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameConfig(eventName: $eventName, honoredPerson: $honoredPerson, eventType: $eventType, eventDate: $eventDate, colorPalette: $colorPalette, customImages: $customImages, useCustomImages: $useCustomImages, triviaQuestions: $triviaQuestions, gameStats: $gameStats, soundEnabled: $soundEnabled, animationsEnabled: $animationsEnabled, volume: $volume, createdAt: $createdAt, lastModified: $lastModified)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameConfig'))
      ..add(DiagnosticsProperty('eventName', eventName))
      ..add(DiagnosticsProperty('honoredPerson', honoredPerson))
      ..add(DiagnosticsProperty('eventType', eventType))
      ..add(DiagnosticsProperty('eventDate', eventDate))
      ..add(DiagnosticsProperty('colorPalette', colorPalette))
      ..add(DiagnosticsProperty('customImages', customImages))
      ..add(DiagnosticsProperty('useCustomImages', useCustomImages))
      ..add(DiagnosticsProperty('triviaQuestions', triviaQuestions))
      ..add(DiagnosticsProperty('gameStats', gameStats))
      ..add(DiagnosticsProperty('soundEnabled', soundEnabled))
      ..add(DiagnosticsProperty('animationsEnabled', animationsEnabled))
      ..add(DiagnosticsProperty('volume', volume))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('lastModified', lastModified));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameConfigImpl &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.honoredPerson, honoredPerson) ||
                other.honoredPerson == honoredPerson) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.colorPalette, colorPalette) ||
                other.colorPalette == colorPalette) &&
            const DeepCollectionEquality().equals(
              other._customImages,
              _customImages,
            ) &&
            (identical(other.useCustomImages, useCustomImages) ||
                other.useCustomImages == useCustomImages) &&
            const DeepCollectionEquality().equals(
              other._triviaQuestions,
              _triviaQuestions,
            ) &&
            (identical(other.gameStats, gameStats) ||
                other.gameStats == gameStats) &&
            (identical(other.soundEnabled, soundEnabled) ||
                other.soundEnabled == soundEnabled) &&
            (identical(other.animationsEnabled, animationsEnabled) ||
                other.animationsEnabled == animationsEnabled) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastModified, lastModified) ||
                other.lastModified == lastModified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    eventName,
    honoredPerson,
    eventType,
    eventDate,
    colorPalette,
    const DeepCollectionEquality().hash(_customImages),
    useCustomImages,
    const DeepCollectionEquality().hash(_triviaQuestions),
    gameStats,
    soundEnabled,
    animationsEnabled,
    volume,
    createdAt,
    lastModified,
  );

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameConfigImplCopyWith<_$GameConfigImpl> get copyWith =>
      __$$GameConfigImplCopyWithImpl<_$GameConfigImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameConfigImplToJson(this);
  }
}

abstract class _GameConfig implements GameConfig {
  const factory _GameConfig({
    required final String eventName,
    required final String honoredPerson,
    required final EventType eventType,
    required final String eventDate,
    required final ColorPalette colorPalette,
    final List<String> customImages,
    final bool useCustomImages,
    final List<TriviaQuestion> triviaQuestions,
    final GameStats gameStats,
    final bool soundEnabled,
    final bool animationsEnabled,
    final double volume,
    final DateTime? createdAt,
    final DateTime? lastModified,
  }) = _$GameConfigImpl;

  factory _GameConfig.fromJson(Map<String, dynamic> json) =
      _$GameConfigImpl.fromJson;

  @override
  String get eventName;
  @override
  String get honoredPerson;
  @override
  EventType get eventType;
  @override
  String get eventDate;
  @override
  ColorPalette get colorPalette;
  @override
  List<String> get customImages;
  @override
  bool get useCustomImages;
  @override
  List<TriviaQuestion> get triviaQuestions;
  @override
  GameStats get gameStats;
  @override
  bool get soundEnabled;
  @override
  bool get animationsEnabled;
  @override
  double get volume;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get lastModified;

  /// Create a copy of GameConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameConfigImplCopyWith<_$GameConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  GameType get currentGame => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get moves => throw _privateConstructorUsedError;
  int get timeElapsed => throw _privateConstructorUsedError;
  DateTime? get gameStartedAt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get gameData => throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({
    GameType currentGame,
    GameStatus status,
    int score,
    int moves,
    int timeElapsed,
    DateTime? gameStartedAt,
    Map<String, dynamic>? gameData,
  });
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentGame = null,
    Object? status = null,
    Object? score = null,
    Object? moves = null,
    Object? timeElapsed = null,
    Object? gameStartedAt = freezed,
    Object? gameData = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentGame: null == currentGame
                ? _value.currentGame
                : currentGame // ignore: cast_nullable_to_non_nullable
                      as GameType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as GameStatus,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            moves: null == moves
                ? _value.moves
                : moves // ignore: cast_nullable_to_non_nullable
                      as int,
            timeElapsed: null == timeElapsed
                ? _value.timeElapsed
                : timeElapsed // ignore: cast_nullable_to_non_nullable
                      as int,
            gameStartedAt: freezed == gameStartedAt
                ? _value.gameStartedAt
                : gameStartedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gameData: freezed == gameData
                ? _value.gameData
                : gameData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
    _$GameStateImpl value,
    $Res Function(_$GameStateImpl) then,
  ) = __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    GameType currentGame,
    GameStatus status,
    int score,
    int moves,
    int timeElapsed,
    DateTime? gameStartedAt,
    Map<String, dynamic>? gameData,
  });
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
    _$GameStateImpl _value,
    $Res Function(_$GameStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentGame = null,
    Object? status = null,
    Object? score = null,
    Object? moves = null,
    Object? timeElapsed = null,
    Object? gameStartedAt = freezed,
    Object? gameData = freezed,
  }) {
    return _then(
      _$GameStateImpl(
        currentGame: null == currentGame
            ? _value.currentGame
            : currentGame // ignore: cast_nullable_to_non_nullable
                  as GameType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as GameStatus,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        moves: null == moves
            ? _value.moves
            : moves // ignore: cast_nullable_to_non_nullable
                  as int,
        timeElapsed: null == timeElapsed
            ? _value.timeElapsed
            : timeElapsed // ignore: cast_nullable_to_non_nullable
                  as int,
        gameStartedAt: freezed == gameStartedAt
            ? _value.gameStartedAt
            : gameStartedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gameData: freezed == gameData
            ? _value._gameData
            : gameData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl with DiagnosticableTreeMixin implements _GameState {
  const _$GameStateImpl({
    required this.currentGame,
    required this.status,
    this.score = 0,
    this.moves = 0,
    this.timeElapsed = 0,
    this.gameStartedAt,
    final Map<String, dynamic>? gameData,
  }) : _gameData = gameData;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  @override
  final GameType currentGame;
  @override
  final GameStatus status;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int moves;
  @override
  @JsonKey()
  final int timeElapsed;
  @override
  final DateTime? gameStartedAt;
  final Map<String, dynamic>? _gameData;
  @override
  Map<String, dynamic>? get gameData {
    final value = _gameData;
    if (value == null) return null;
    if (_gameData is EqualUnmodifiableMapView) return _gameData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameState(currentGame: $currentGame, status: $status, score: $score, moves: $moves, timeElapsed: $timeElapsed, gameStartedAt: $gameStartedAt, gameData: $gameData)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameState'))
      ..add(DiagnosticsProperty('currentGame', currentGame))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('moves', moves))
      ..add(DiagnosticsProperty('timeElapsed', timeElapsed))
      ..add(DiagnosticsProperty('gameStartedAt', gameStartedAt))
      ..add(DiagnosticsProperty('gameData', gameData));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.currentGame, currentGame) ||
                other.currentGame == currentGame) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.moves, moves) || other.moves == moves) &&
            (identical(other.timeElapsed, timeElapsed) ||
                other.timeElapsed == timeElapsed) &&
            (identical(other.gameStartedAt, gameStartedAt) ||
                other.gameStartedAt == gameStartedAt) &&
            const DeepCollectionEquality().equals(other._gameData, _gameData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentGame,
    status,
    score,
    moves,
    timeElapsed,
    gameStartedAt,
    const DeepCollectionEquality().hash(_gameData),
  );

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(this);
  }
}

abstract class _GameState implements GameState {
  const factory _GameState({
    required final GameType currentGame,
    required final GameStatus status,
    final int score,
    final int moves,
    final int timeElapsed,
    final DateTime? gameStartedAt,
    final Map<String, dynamic>? gameData,
  }) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  GameType get currentGame;
  @override
  GameStatus get status;
  @override
  int get score;
  @override
  int get moves;
  @override
  int get timeElapsed;
  @override
  DateTime? get gameStartedAt;
  @override
  Map<String, dynamic>? get gameData;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
