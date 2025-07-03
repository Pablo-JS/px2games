// lib/core/services/audio_service.dart
import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/default_data.dart';

// ===== AUDIO SERVICE PROVIDER =====
final audioServiceProvider = Provider<AudioService>((ref) {
  return AudioService();
});

// ===== AUDIO SERVICE =====
class AudioService {
  bool _isEnabled = true;
  double _volume = 1.0;
  final Map<String, Timer> _playingTimers = {};

  // Getters
  bool get isEnabled => _isEnabled;
  double get volume => _volume;

  // Configuration
  void setEnabled(bool enabled) {
    _isEnabled = enabled;
    if (!enabled) {
      stopAllSounds();
    }
  }

  void setVolume(double volume) {
    _volume = volume.clamp(0.0, 1.0);
  }

  // Sound playback
  Future<void> playSound(String soundType, {Map<String, dynamic>? options}) async {
    if (!_isEnabled || _volume == 0.0) return;

    try {
      switch (soundType) {
        case 'flip':
          await _playSyntheticSound(soundType, options);
          break;
        case 'match':
          await _playSyntheticSound(soundType, options);
          break;
        case 'mismatch':
          await _playSyntheticSound(soundType, options);
          break;
        case 'correct':
          await _playCorrectSound(options);
          break;
        case 'incorrect':
          await _playSyntheticSound(soundType, options);
          break;
        case 'completion':
          await _playCompletionSound(options);
          break;
        case 'pop':
          await _playSyntheticSound(soundType, options);
          break;
        case 'sequence':
          await _playSyntheticSound(soundType, options);
          break;
        case 'countdown':
          await _playSyntheticSound(soundType, options);
          break;
        default:
          debugPrint('Unknown sound type: $soundType');
      }
    } catch (e) {
      debugPrint('Error playing sound $soundType: $e');
      // Fallback to haptic feedback
      _playHapticFeedback(soundType);
    }
  }

  // Synthetic sound generation using Web Audio API concepts
  Future<void> _playSyntheticSound(String soundType, Map<String, dynamic>? options) async {
    final config = DefaultData.soundConfig[soundType];
    if (config == null) return;

    final effectiveVolume = _volume * (config['volume'] as double);
    
    // For now, we'll use haptic feedback as a substitute
    // In a real implementation, you would use a proper audio library
    await _playHapticFeedback(soundType);
    
    // Simulate sound duration
    final duration = ((config['duration'] as double) * 1000).round();
    await Future.delayed(Duration(milliseconds: duration));
  }

  Future<void> _playCorrectSound(Map<String, dynamic>? options) async {
    final config = DefaultData.soundConfig['correct']!;
    final frequencies = config['frequencies'] as List<int>;
    final duration = ((config['duration'] as double) * 1000).round();
    
    // Play success haptic
    await HapticFeedback.mediumImpact();
    
    // Simulate musical sequence
    for (int i = 0; i < frequencies.length; i++) {
      await Future.delayed(Duration(milliseconds: duration ~/ frequencies.length));
      if (i < frequencies.length - 1) {
        await HapticFeedback.lightImpact();
      }
    }
  }

  Future<void> _playCompletionSound(Map<String, dynamic>? options) async {
    final config = DefaultData.soundConfig['completion']!;
    final frequencies = config['frequencies'] as List<int>;
    
    // Play success haptic
    await HapticFeedback.mediumImpact();
    
    // Play a celebratory sequence
    for (int i = 0; i < frequencies.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      await HapticFeedback.lightImpact();
    }
  }

  Future<void> _playHapticFeedback(String soundType) async {
    try {
      switch (soundType) {
        case 'flip':
        case 'pop':
        case 'sequence':
        case 'countdown':
          await HapticFeedback.lightImpact();
          break;
        case 'match':
        case 'correct':
          await HapticFeedback.mediumImpact();
          break;
        case 'mismatch':
        case 'incorrect':
          await HapticFeedback.heavyImpact();
          break;
        case 'completion':
          await HapticFeedback.heavyImpact();
          break;
        default:
          await HapticFeedback.selectionClick();
      }
    } catch (e) {
      debugPrint('Error playing haptic feedback: $e');
    }
  }

  // Background music (for future implementation)
  Future<void> playBackgroundMusic(String musicType) async {
    if (!_isEnabled) return;
    
    // TODO: Implement background music playback
    debugPrint('Background music: $musicType');
  }

  Future<void> stopBackgroundMusic() async {
    // TODO: Implement background music stop
    debugPrint('Stopping background music');
  }

  void stopAllSounds() {
    // Cancel all playing timers
    for (final timer in _playingTimers.values) {
      timer.cancel();
    }
    _playingTimers.clear();
  }

  // Sound preloading (for future optimization)
  Future<void> preloadSounds(List<String> soundTypes) async {
    // TODO: Implement sound preloading for better performance
    debugPrint('Preloading sounds: $soundTypes');
  }

  void dispose() {
    stopAllSounds();
  }
}

// ===== AUDIO MANAGER =====
class AudioManager {
  static AudioManager? _instance;
  static AudioManager get instance => _instance ??= AudioManager._internal();
  
  AudioManager._internal();

  late AudioService _audioService;
  bool _isInitialized = false;

  Future<void> initialize(AudioService audioService) async {
    if (_isInitialized) return;
    
    _audioService = audioService;
    _isInitialized = true;
    
    // Preload common sounds
    await _audioService.preloadSounds([
      'flip',
      'match',
      'mismatch',
      'correct',
      'incorrect',
      'completion',
    ]);
  }

  Future<void> playGameSound(String soundType, {Map<String, dynamic>? options}) async {
    if (!_isInitialized) return;
    await _audioService.playSound(soundType, options: options);
  }

  void setVolume(double volume) {
    if (!_isInitialized) return;
    _audioService.setVolume(volume);
  }

  void setEnabled(bool enabled) {
    if (!_isInitialized) return;
    _audioService.setEnabled(enabled);
  }

  bool get isEnabled => _isInitialized ? _audioService.isEnabled : false;
  double get volume => _isInitialized ? _audioService.volume : 1.0;
}

// ===== SOUND EFFECTS UTILITY =====
class SoundEffects {
  static const String flip = 'flip';
  static const String match = 'match';
  static const String mismatch = 'mismatch';
  static const String correct = 'correct';
  static const String incorrect = 'incorrect';
  static const String completion = 'completion';
  static const String pop = 'pop';
  static const String sequence = 'sequence';
  static const String countdown = 'countdown';

  // Game-specific sound sets
  static const List<String> memorySounds = [
    flip,
    match,
    mismatch,
    completion,
  ];

  static const List<String> triviaSounds = [
    correct,
    incorrect,
    completion,
    countdown,
  ];

  static const List<String> speedSounds = [
    pop,
    sequence,
    correct,
    incorrect,
    completion,
  ];

  // Quick play methods
  static Future<void> playFlip() async {
    await AudioManager.instance.playGameSound(flip);
  }

  static Future<void> playMatch() async {
    await AudioManager.instance.playGameSound(match);
  }

  static Future<void> playMismatch() async {
    await AudioManager.instance.playGameSound(mismatch);
  }

  static Future<void> playCorrect() async {
    await AudioManager.instance.playGameSound(correct);
  }

  static Future<void> playIncorrect() async {
    await AudioManager.instance.playGameSound(incorrect);
  }

  static Future<void> playCompletion() async {
    await AudioManager.instance.playGameSound(completion);
  }

  static Future<void> playPop() async {
    await AudioManager.instance.playGameSound(pop);
  }

  static Future<void> playSequence() async {
    await AudioManager.instance.playGameSound(sequence);
  }

  static Future<void> playCountdown() async {
    await AudioManager.instance.playGameSound(countdown);
  }
}

// ===== AUDIO EXTENSIONS =====
extension AudioContextExtension on WidgetRef {
  AudioService get audio => read(audioServiceProvider);
  
  Future<void> playSound(String soundType, {Map<String, dynamic>? options}) async {
    await audio.playSound(soundType, options: options);
  }
}

// ===== AUDIO REACTIVE PROVIDER =====
final audioSettingsProvider = StateNotifierProvider<AudioSettingsNotifier, AudioSettings>((ref) {
  return AudioSettingsNotifier(ref);
});

class AudioSettings {
  final bool isEnabled;
  final double volume;
  final bool backgroundMusicEnabled;
  final double backgroundMusicVolume;

  const AudioSettings({
    this.isEnabled = true,
    this.volume = 1.0,
    this.backgroundMusicEnabled = false,
    this.backgroundMusicVolume = 0.5,
  });

  AudioSettings copyWith({
    bool? isEnabled,
    double? volume,
    bool? backgroundMusicEnabled,
    double? backgroundMusicVolume,
  }) {
    return AudioSettings(
      isEnabled: isEnabled ?? this.isEnabled,
      volume: volume ?? this.volume,
      backgroundMusicEnabled: backgroundMusicEnabled ?? this.backgroundMusicEnabled,
      backgroundMusicVolume: backgroundMusicVolume ?? this.backgroundMusicVolume,
    );
  }
}

class AudioSettingsNotifier extends StateNotifier<AudioSettings> {
  final Ref _ref;

  AudioSettingsNotifier(this._ref) : super(const AudioSettings()) {
    _initializeAudio();
  }

  void _initializeAudio() {
    final audioService = _ref.read(audioServiceProvider);
    AudioManager.instance.initialize(audioService);
  }

  void setEnabled(bool enabled) {
    state = state.copyWith(isEnabled: enabled);
    AudioManager.instance.setEnabled(enabled);
  }

  void setVolume(double volume) {
    state = state.copyWith(volume: volume);
    AudioManager.instance.setVolume(volume);
  }

  void setBackgroundMusicEnabled(bool enabled) {
    state = state.copyWith(backgroundMusicEnabled: enabled);
    // TODO: Implement background music control
  }

  void setBackgroundMusicVolume(double volume) {
    state = state.copyWith(backgroundMusicVolume: volume);
    // TODO: Implement background music volume control
  }

  Future<void> testSound(String soundType) async {
    await AudioManager.instance.playGameSound(soundType);
  }
}