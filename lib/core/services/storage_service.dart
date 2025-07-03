// lib/core/services/storage_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

import '../../data/models/game_models.dart';

// ===== STORAGE SERVICE PROVIDER =====
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// ===== STORAGE SERVICE =====
class StorageService {
  static const String _configKey = 'game_config';
  static const String _statsKey = 'game_stats';
  static const String _settingsKey = 'app_settings';
  static const String _backupPrefix = 'EventGameSuite_Backup_';

  // ===== BASIC STORAGE OPERATIONS =====

  Future<bool> save(String key, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(data);
      return await prefs.setString(key, jsonString);
    } catch (e) {
      debugPrint('Error saving data for key $key: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> load(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(key);

      if (jsonString != null) {
        return json.decode(jsonString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('Error loading data for key $key: $e');
      return null;
    }
  }

  Future<bool> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(key);
    } catch (e) {
      debugPrint('Error removing data for key $key: $e');
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.clear();
    } catch (e) {
      debugPrint('Error clearing storage: $e');
      return false;
    }
  }

  // ===== GAME CONFIG OPERATIONS =====

  Future<bool> saveGameConfig(GameConfig config) async {
    return await save(_configKey, config.toJson());
  }

  Future<GameConfig?> loadGameConfig() async {
    final data = await load(_configKey);
    if (data != null) {
      try {
        return GameConfig.fromJson(data);
      } catch (e) {
        debugPrint('Error parsing game config: $e');
        return null;
      }
    }
    return null;
  }

  // ===== STATS OPERATIONS =====

  Future<bool> saveGameStats(GameStats stats) async {
    return await save(_statsKey, stats.toJson());
  }

  Future<GameStats?> loadGameStats() async {
    final data = await load(_statsKey);
    if (data != null) {
      try {
        return GameStats.fromJson(data);
      } catch (e) {
        debugPrint('Error parsing game stats: $e');
        return null;
      }
    }
    return null;
  }

  // ===== BACKUP & EXPORT OPERATIONS =====

  Future<String?> exportConfigToFile(GameConfig config) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final fileName =
          '$_backupPrefix${config.eventName.replaceAll(' ', '_')}_$timestamp.json';
      final file = File('${directory.path}/$fileName');

      final exportData = {
        'version': '2.0.0',
        'exportDate': DateTime.now().toIso8601String(),
        'config': config.toJson(),
        'metadata': {
          'appName': 'Event Game Suite',
          'platform': Platform.operatingSystem,
        },
      };

      await file.writeAsString(json.encode(exportData));
      return file.path;
    } catch (e) {
      debugPrint('Error exporting config: $e');
      return null;
    }
  }

  Future<GameConfig?> importConfigFromFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: 'Seleccionar archivo de configuración',
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();
        final data = json.decode(content) as Map<String, dynamic>;

        // Validate backup format
        if (data.containsKey('config') && data.containsKey('version')) {
          final configData = data['config'] as Map<String, dynamic>;
          return GameConfig.fromJson(configData);
        } else {
          // Try to parse as direct config
          return GameConfig.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      debugPrint('Error importing config: $e');
      return null;
    }
  }

  Future<String?> exportFullBackup() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      final fileName = '${_backupPrefix}Full_$timestamp.json';
      final file = File('${directory.path}/$fileName');

      final config = await loadGameConfig();
      final stats = await loadGameStats();
      final prefs = await SharedPreferences.getInstance();

      final backupData = {
        'version': '2.0.0',
        'exportDate': DateTime.now().toIso8601String(),
        'type': 'full_backup',
        'data': {
          'config': config?.toJson(),
          'stats': stats?.toJson(),
          'preferences': _getAllPreferences(prefs),
        },
        'metadata': {
          'appName': 'Event Game Suite',
          'platform': Platform.operatingSystem,
          'configExists': config != null,
          'statsExists': stats != null,
        },
      };

      await file.writeAsString(json.encode(backupData));
      return file.path;
    } catch (e) {
      debugPrint('Error creating full backup: $e');
      return null;
    }
  }

  Future<bool> restoreFullBackup() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        dialogTitle: 'Seleccionar respaldo completo',
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        final content = await file.readAsString();
        final backupData = json.decode(content) as Map<String, dynamic>;

        if (backupData['type'] != 'full_backup') {
          throw Exception('El archivo no es un respaldo completo válido');
        }

        final data = backupData['data'] as Map<String, dynamic>;

        // Restore config
        if (data['config'] != null) {
          final config = GameConfig.fromJson(data['config']);
          await saveGameConfig(config);
        }

        // Restore stats
        if (data['stats'] != null) {
          final stats = GameStats.fromJson(data['stats']);
          await saveGameStats(stats);
        }

        // Restore preferences
        if (data['preferences'] != null) {
          await _restorePreferences(data['preferences']);
        }

        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error restoring full backup: $e');
      return false;
    }
  }

  // ===== IMAGE OPERATIONS =====

  Future<String?> saveImage(String imageData, String imageName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${directory.path}/images');

      if (!await imagesDir.exists()) {
        await imagesDir.create(recursive: true);
      }

      final file = File('${imagesDir.path}/$imageName');
      await file.writeAsString(imageData);

      return file.path;
    } catch (e) {
      debugPrint('Error saving image: $e');
      return null;
    }
  }

  Future<String?> loadImage(String imageName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/images/$imageName');

      if (await file.exists()) {
        return await file.readAsString();
      }
      return null;
    } catch (e) {
      debugPrint('Error loading image: $e');
      return null;
    }
  }

  Future<List<String>> listSavedImages() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesDir = Directory('${directory.path}/images');

      if (await imagesDir.exists()) {
        final files = await imagesDir.list().toList();
        return files
            .where((file) => file is File)
            .map((file) => file.path.split('/').last)
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error listing images: $e');
      return [];
    }
  }

  // ===== CACHE OPERATIONS =====

  Future<bool> clearCache() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
        await cacheDir.create();
      }
      return true;
    } catch (e) {
      debugPrint('Error clearing cache: $e');
      return false;
    }
  }

  Future<int> getCacheSize() async {
    try {
      final cacheDir = await getTemporaryDirectory();
      int totalSize = 0;

      if (await cacheDir.exists()) {
        await for (final entity in cacheDir.list(recursive: true)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }

      return totalSize;
    } catch (e) {
      debugPrint('Error calculating cache size: $e');
      return 0;
    }
  }

  // ===== UTILITY METHODS =====

  Map<String, dynamic> _getAllPreferences(SharedPreferences prefs) {
    final keys = prefs.getKeys();
    final preferences = <String, dynamic>{};

    for (final key in keys) {
      final value = prefs.get(key);
      if (value != null) {
        preferences[key] = value;
      }
    }

    return preferences;
  }

  Future<void> _restorePreferences(Map<String, dynamic> preferences) async {
    final prefs = await SharedPreferences.getInstance();

    for (final entry in preferences.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      }
    }
  }

  Future<Map<String, dynamic>> getStorageInfo() async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      final cacheDir = await getTemporaryDirectory();

      final documentsSize = await _getDirectorySize(documentsDir);
      final cacheSize = await _getDirectorySize(cacheDir);

      final config = await loadGameConfig();
      final stats = await loadGameStats();

      return {
        'documentsPath': documentsDir.path,
        'cachePath': cacheDir.path,
        'documentsSize': documentsSize,
        'cacheSize': cacheSize,
        'totalSize': documentsSize + cacheSize,
        'hasConfig': config != null,
        'hasStats': stats != null,
        'configSize': config != null ? json.encode(config.toJson()).length : 0,
        'statsSize': stats != null ? json.encode(stats.toJson()).length : 0,
      };
    } catch (e) {
      debugPrint('Error getting storage info: $e');
      return {};
    }
  }

  Future<int> _getDirectorySize(Directory directory) async {
    int totalSize = 0;

    try {
      if (await directory.exists()) {
        await for (final entity in directory.list(recursive: true)) {
          if (entity is File) {
            totalSize += await entity.length();
          }
        }
      }
    } catch (e) {
      debugPrint('Error calculating directory size: $e');
    }

    return totalSize;
  }

  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}

// ===== STORAGE MANAGER =====
class StorageManager {
  static StorageManager? _instance;
  static StorageManager get instance =>
      _instance ??= StorageManager._internal();

  StorageManager._internal();

  late StorageService _storageService;
  bool _isInitialized = false;

  Future<void> initialize(StorageService storageService) async {
    if (_isInitialized) return;

    _storageService = storageService;
    _isInitialized = true;
  }

  StorageService get storage {
    if (!_isInitialized) {
      throw Exception('StorageManager not initialized');
    }
    return _storageService;
  }

  // Quick access methods
  Future<bool> saveConfig(GameConfig config) async {
    return await storage.saveGameConfig(config);
  }

  Future<GameConfig?> loadConfig() async {
    return await storage.loadGameConfig();
  }

  Future<String?> exportConfig(GameConfig config) async {
    return await storage.exportConfigToFile(config);
  }

  Future<GameConfig?> importConfig() async {
    return await storage.importConfigFromFile();
  }

  Future<bool> createBackup() async {
    final path = await storage.exportFullBackup();
    return path != null;
  }

  Future<bool> restoreBackup() async {
    return await storage.restoreFullBackup();
  }
}

// ===== STORAGE EXTENSIONS =====
extension StorageContextExtension on WidgetRef {
  StorageService get storage => read(storageServiceProvider);

  Future<bool> saveData(String key, Map<String, dynamic> data) async {
    return await storage.save(key, data);
  }

  Future<Map<String, dynamic>?> loadData(String key) async {
    return await storage.load(key);
  }
}
