import 'dart:developer' as developer;

import 'package:daily_coffee/core/config/app_environment.dart';

abstract interface class AppLogger {
  void log(
    String event, {
    AppLogLevel level = AppLogLevel.info,
    Map<String, Object?> context = const {},
    Object? error,
    StackTrace? stackTrace,
  });
}

final class DeveloperAppLogger implements AppLogger {
  const DeveloperAppLogger({required this.minimumLevel});

  final AppLogLevel minimumLevel;

  @override
  void log(
    String event, {
    AppLogLevel level = AppLogLevel.info,
    Map<String, Object?> context = const {},
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(level)) {
      return;
    }

    developer.log(
      context.isEmpty ? event : '$event $context',
      name: 'daily_coffee',
      level: _developerLevel(level),
      error: error,
      stackTrace: stackTrace,
    );
  }

  bool _shouldLog(AppLogLevel level) {
    return minimumLevel != AppLogLevel.off && level.index >= minimumLevel.index;
  }

  int _developerLevel(AppLogLevel level) {
    return switch (level) {
      AppLogLevel.debug => 500,
      AppLogLevel.info => 800,
      AppLogLevel.warning => 900,
      AppLogLevel.error => 1000,
      AppLogLevel.off => 2000,
    };
  }
}

final class NoopAppLogger implements AppLogger {
  const NoopAppLogger();

  @override
  void log(
    String event, {
    AppLogLevel level = AppLogLevel.info,
    Map<String, Object?> context = const {},
    Object? error,
    StackTrace? stackTrace,
  }) {}
}
