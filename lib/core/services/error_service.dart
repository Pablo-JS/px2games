// lib/core/services/error_service.dart
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

// ===== ERROR SERVICE PROVIDER =====
final errorServiceProvider = Provider<ErrorService>((ref) {
  return ErrorService();
});

// ===== ERROR TYPES =====
enum ErrorLevel {
  info,
  warning,
  error,
  critical,
}

enum ErrorCategory {
  ui,
  game,
  storage,
  audio,
  network,
  system,
  unknown,
}

// ===== ERROR DATA CLASS =====
class AppError {
  final String id;
  final ErrorLevel level;
  final ErrorCategory category;
  final String message;
  final String? details;
  final StackTrace? stackTrace;
  final DateTime timestamp;
  final Map<String, dynamic>? context;

  AppError({
    required this.id,
    required this.level,
    required this.category,
    required this.message,
    this.details,
    this.stackTrace,
    DateTime? timestamp,
    this.context,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'level': level.name,
        'category': category.name,
        'message': message,
        'details': details,
        'stackTrace': stackTrace?.toString(),
        'timestamp': timestamp.toIso8601String(),
        'context': context,
      };

  @override
  String toString() {
    return '[${level.name.toUpperCase()}] ${category.name}: $message';
  }
}

// ===== ERROR SERVICE =====
class ErrorService {
  final List<AppError> _errorHistory = [];
  final int _maxHistorySize = 100;

  // Error reporting configuration
  bool _reportingEnabled = true;
  bool _consoleLoggingEnabled = kDebugMode;
  bool _fileLoggingEnabled = true;         

  // Getters
  List<AppError> get errorHistory => List.unmodifiable(_errorHistory);
  bool get reportingEnabled => _reportingEnabled;

  // Configuration
  void setReportingEnabled(bool enabled) {
    _reportingEnabled = enabled;
  }

  void setConsoleLoggingEnabled(bool enabled) {
    _consoleLoggingEnabled = enabled;
  }

  void setFileLoggingEnabled(bool enabled) {
    _fileLoggingEnabled = enabled;
  }

  // ===== ERROR REPORTING =====
  
  Future<void> reportError(
    String message, {
    ErrorLevel level = ErrorLevel.error,
    ErrorCategory category = ErrorCategory.unknown,
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) async {
    if (!_reportingEnabled) return;

    final error = AppError(
      id: _generateErrorId(),
      level: level,
      category: category,
      message: message,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );

    _addToHistory(error);
    await _logError(error);
    
    // Handle critical errors
    if (level == ErrorLevel.critical) {
      await _handleCriticalError(error);
    }
  }

  Future<void> reportException(
    Object exception,
    StackTrace stackTrace, {
    ErrorLevel level = ErrorLevel.error,
    ErrorCategory category = ErrorCategory.unknown,
    String? additionalInfo,
    Map<String, dynamic>? context,
  }) async {
    await reportError(
      exception.toString(),
      level: level,
      category: category,
      details: additionalInfo,
      stackTrace: stackTrace,
      context: context,
    );
  }

  // ===== SPECIFIC ERROR TYPES =====
  
  Future<void> reportGameError(String message, {String? gameType, Map<String, dynamic>? gameState}) async {
    await reportError(
      message,
      level: ErrorLevel.error,
      category: ErrorCategory.game,
      context: {
        'gameType': gameType,
        'gameState': gameState,
        ...?_getSystemContext(),
      },
    );
  }

  Future<void> reportStorageError(String message, {String? operation, String? key}) async {
    await reportError(
      message,
      level: ErrorLevel.error,
      category: ErrorCategory.storage,
      context: {
        'operation': operation,
        'key': key,
        ...?_getSystemContext(),
      },
    );
  }

  Future<void> reportAudioError(String message, {String? soundType, Map<String, dynamic>? audioState}) async {
    await reportError(
      message,
      level: ErrorLevel.warning,
      category: ErrorCategory.audio,
      context: {
        'soundType': soundType,
        'audioState': audioState,
        ...?_getSystemContext(),
      },
    );
  }

  Future<void> reportUIError(String message, {String? widget, Map<String, dynamic>? uiState}) async {
    await reportError(
      message,
      level: ErrorLevel.error,
      category: ErrorCategory.ui,
      context: {
        'widget': widget,
        'uiState': uiState,
        ...?_getSystemContext(),
      },
    );
  }

  Future<void> reportSystemError(String message, {Map<String, dynamic>? systemInfo}) async {
    await reportError(
      message,
      level: ErrorLevel.critical,
      category: ErrorCategory.system,
      context: {
        'systemInfo': systemInfo,
        ...?_getSystemContext(),
      },
    );
  }

  // ===== LOGGING =====
  
  Future<void> _logError(AppError error) async {
    if (_consoleLoggingEnabled) {
      _logToConsole(error);
    }
    
    if (_fileLoggingEnabled) {
      await _logToFile(error);
    }
  }

  void _logToConsole(AppError error) {
    final message = error.toString();
    
    switch (error.level) {
      case ErrorLevel.info:
        developer.log(message, name: 'EventGameSuite');
        break;
      case ErrorLevel.warning:
        developer.log(message, name: 'EventGameSuite', level: 900);
        break;
      case ErrorLevel.error:
        developer.log(message, name: 'EventGameSuite', level: 1000);
        break;
      case ErrorLevel.critical:
        developer.log(message, name: 'EventGameSuite', level: 1200);
        break;
    }

    if (error.stackTrace != null) {
      developer.log(error.stackTrace.toString(), name: 'EventGameSuite');
    }
  }

  Future<void> _logToFile(AppError error) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${directory.path}/logs');
      
      if (!await logsDir.exists()) {
        await logsDir.create(recursive: true);
      }
      
      final today = DateTime.now().toIso8601String().split('T')[0];
      final logFile = File('${logsDir.path}/errors_$today.log');
      
      final logEntry = _formatLogEntry(error);
      await logFile.writeAsString('$logEntry\n', mode: FileMode.append);
      
      // Clean old log files
      await _cleanOldLogs(logsDir);
    } catch (e) {
      debugPrint('Failed to write error to log file: $e');
    }
  }

  String _formatLogEntry(AppError error) {
    final buffer = StringBuffer();
    buffer.writeln('${error.timestamp.toIso8601String()} [${error.level.name.toUpperCase()}] ${error.category.name}');
    buffer.writeln('ID: ${error.id}');
    buffer.writeln('Message: ${error.message}');
    
    if (error.details != null) {
      buffer.writeln('Details: ${error.details}');
    }
    
    if (error.context != null) {
      buffer.writeln('Context: ${error.context}');
    }
    
    if (error.stackTrace != null) {
      buffer.writeln('Stack Trace:');
      buffer.writeln(error.stackTrace.toString());
    }
    
    buffer.writeln('---');
    return buffer.toString();
  }

  Future<void> _cleanOldLogs(Directory logsDir) async {
    try {
      final files = await logsDir.list().toList();
      final now = DateTime.now();
      const maxAge = Duration(days: 7); // Keep logs for 7 days
      
      for (final file in files) {
        if (file is File) {
          final stat = await file.stat();
          if (now.difference(stat.modified) > maxAge) {
            await file.delete();
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to clean old logs: $e');
    }
  }

  // ===== ERROR HANDLING =====
  
  Future<void> _handleCriticalError(AppError error) async {
    // For critical errors, we might want to:
    // 1. Save current state
    // 2. Notify user
    // 3. Restart app if necessary
    
    debugPrint('CRITICAL ERROR: ${error.message}');
    
    // In a production app, you might want to:
    // - Send error to crash reporting service
    // - Show error dialog to user
    // - Attempt recovery or restart
  }

  // ===== UTILITY METHODS =====
  
  String _generateErrorId() {
    return 'ERR_${DateTime.now().millisecondsSinceEpoch}_${_errorHistory.length}';
  }

  void _addToHistory(AppError error) {
    _errorHistory.add(error);
    
    // Keep history size manageable
    if (_errorHistory.length > _maxHistorySize) {
      _errorHistory.removeRange(0, _errorHistory.length - _maxHistorySize);
    }
  }

  Map<String, dynamic>? _getSystemContext() {
    try {
      return {
        'platform': Platform.operatingSystem,
        'version': Platform.operatingSystemVersion,
        'dartVersion': Platform.version,
        'timestamp': DateTime.now().toIso8601String(),
        'isDebug': kDebugMode,
      };
    } catch (e) {
      return null;
    }
  }

  // ===== PUBLIC UTILITIES =====
  
  List<AppError> getErrorsByLevel(ErrorLevel level) {
    return _errorHistory.where((error) => error.level == level).toList();
  }

  List<AppError> getErrorsByCategory(ErrorCategory category) {
    return _errorHistory.where((error) => error.category == category).toList();
  }

  List<AppError> getRecentErrors({Duration? since}) {
    final cutoff = since != null 
        ? DateTime.now().subtract(since)
        : DateTime.now().subtract(const Duration(hours: 1));
    
    return _errorHistory.where((error) => error.timestamp.isAfter(cutoff)).toList();
  }

  Future<String?> exportErrorLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final exportFile = File('${directory.path}/error_report_${DateTime.now().millisecondsSinceEpoch}.json');
      
      final exportData = {
        'exportDate': DateTime.now().toIso8601String(),
        'totalErrors': _errorHistory.length,
        'errors': _errorHistory.map((error) => error.toJson()).toList(),
        'systemInfo': _getSystemContext(),
      };
      
      await exportFile.writeAsString(json.encode(exportData));
      return exportFile.path;
    } catch (e) {
      debugPrint('Failed to export error logs: $e');
      return null;
    }
  }

  void clearHistory() {
    _errorHistory.clear();
  }

  Map<String, dynamic> getErrorStatistics() {
    final levelCounts = <String, int>{};
    final categoryCounts = <String, int>{};
    
    for (final error in _errorHistory) {
      levelCounts[error.level.name] = (levelCounts[error.level.name] ?? 0) + 1;
      categoryCounts[error.category.name] = (categoryCounts[error.category.name] ?? 0) + 1;
    }
    
    return {
      'totalErrors': _errorHistory.length,
      'levelCounts': levelCounts,
      'categoryCounts': categoryCounts,
      'lastError': _errorHistory.isNotEmpty ? _errorHistory.last.toJson() : null,
    };
  }
}

// ===== ERROR BOUNDARY WIDGET =====
class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(Object error, StackTrace stackTrace)? errorBuilder;
  final void Function(Object error, StackTrace stackTrace)? onError;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
    this.onError,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;
  StackTrace? _stackTrace;

  @override
  Widget build(BuildContext context) {
    if (_error != null && _stackTrace != null) {
      return widget.errorBuilder?.call(_error!, _stackTrace!) ??
          _DefaultErrorWidget(error: _error!, stackTrace: _stackTrace!);
    }
    
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    // Set up error handling
    FlutterError.onError = (details) {
      setState(() {
        _error = details.exception;
        _stackTrace = details.stack;
      });
      
      widget.onError?.call(details.exception, details.stack ?? StackTrace.current);
    };
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  final Object error;
  final StackTrace stackTrace;

  const _DefaultErrorWidget({
    required this.error,
    required this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Oops! Algo salió mal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Restart app or navigate to home
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              child: const Text('Volver al Inicio'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== ERROR EXTENSIONS =====
extension ErrorContextExtension on WidgetRef {
  ErrorService get errorService => read(errorServiceProvider);
  
  Future<void> reportError(
    String message, {
    ErrorLevel level = ErrorLevel.error,
    ErrorCategory category = ErrorCategory.unknown,
    String? details,
    StackTrace? stackTrace,
    Map<String, dynamic>? context,
  }) async {
    await errorService.reportError(
      message,
      level: level,
      category: category,
      details: details,
      stackTrace: stackTrace,
      context: context,
    );
  }
  
  Future<void> reportException(
    Object exception,
    StackTrace stackTrace, {
    ErrorLevel level = ErrorLevel.error,
    ErrorCategory category = ErrorCategory.unknown,
    String? additionalInfo,
    Map<String, dynamic>? context,
  }) async {
    await errorService.reportException(
      exception,
      stackTrace,
      level: level,
      category: category,
      additionalInfo: additionalInfo,
      context: context,
    );
  }
}

// ===== GLOBAL ERROR HANDLER =====
class GlobalErrorHandler {
  static void initialize(ErrorService errorService) {
    // Handle Flutter framework errors
    FlutterError.onError = (details) {
      errorService.reportException(
        details.exception,
        details.stack ?? StackTrace.current,
        level: ErrorLevel.error,
        category: ErrorCategory.ui,
        additionalInfo: details.context?.toString(),
      );
    };

    // Handle async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      errorService.reportException(
        error,
        stack,
        level: ErrorLevel.critical,
        category: ErrorCategory.system,
      );
      return true;
    };
  }
}