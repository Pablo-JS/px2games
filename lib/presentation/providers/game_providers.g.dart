// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'7cd30c9640ca952d1bcf1772c709fc45dc47c8b3';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeFutureProvider<SharedPreferences>.internal(
      sharedPreferences,
      name: r'sharedPreferencesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = AutoDisposeFutureProviderRef<SharedPreferences>;
String _$gameConfigNotifierHash() =>
    r'527118992a865defd08d491341af892dcac2e006';

/// See also [GameConfigNotifier].
@ProviderFor(GameConfigNotifier)
final gameConfigNotifierProvider =
    AutoDisposeAsyncNotifierProvider<GameConfigNotifier, GameConfig>.internal(
      GameConfigNotifier.new,
      name: r'gameConfigNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$gameConfigNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GameConfigNotifier = AutoDisposeAsyncNotifier<GameConfig>;
String _$triviaQuestionsNotifierHash() =>
    r'b1ae8c9865d8074d2342abd2c11a1ee29d35f363';

/// See also [TriviaQuestionsNotifier].
@ProviderFor(TriviaQuestionsNotifier)
final triviaQuestionsNotifierProvider =
    AutoDisposeNotifierProvider<
      TriviaQuestionsNotifier,
      List<TriviaQuestion>
    >.internal(
      TriviaQuestionsNotifier.new,
      name: r'triviaQuestionsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$triviaQuestionsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TriviaQuestionsNotifier = AutoDisposeNotifier<List<TriviaQuestion>>;
String _$memoryGameNotifierHash() =>
    r'77e0f8fc7b9b992b3bd7e124a131ff8b5810aef2';

/// See also [MemoryGameNotifier].
@ProviderFor(MemoryGameNotifier)
final memoryGameNotifierProvider =
    AutoDisposeNotifierProvider<MemoryGameNotifier, GameState>.internal(
      MemoryGameNotifier.new,
      name: r'memoryGameNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$memoryGameNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MemoryGameNotifier = AutoDisposeNotifier<GameState>;
String _$triviaGameNotifierHash() =>
    r'686938e9c083d87d122b702831f3e8c25872903b';

/// See also [TriviaGameNotifier].
@ProviderFor(TriviaGameNotifier)
final triviaGameNotifierProvider =
    AutoDisposeNotifierProvider<TriviaGameNotifier, GameState>.internal(
      TriviaGameNotifier.new,
      name: r'triviaGameNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$triviaGameNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TriviaGameNotifier = AutoDisposeNotifier<GameState>;
String _$currentGameNotifierHash() =>
    r'4f92931dcef8f271207779edbd7a283d9022c5da';

/// See also [CurrentGameNotifier].
@ProviderFor(CurrentGameNotifier)
final currentGameNotifierProvider =
    AutoDisposeNotifierProvider<CurrentGameNotifier, GameType>.internal(
      CurrentGameNotifier.new,
      name: r'currentGameNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentGameNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentGameNotifier = AutoDisposeNotifier<GameType>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
