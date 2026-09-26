import 'dart:io';

import 'package:daily_coffee/core/errors/app_failure.dart';

abstract final class ExceptionMapper {
  static AppFailure map(Object error) {
    return switch (error) {
      FormatException() => ValidationFailure(
        diagnosticContext: {'exceptionType': error.runtimeType.toString()},
        cause: error,
      ),
      FileSystemException() => StorageFailure(
        diagnosticContext: {'exceptionType': error.runtimeType.toString()},
        cause: error,
      ),
      _ => UnexpectedFailure(
        diagnosticContext: {'exceptionType': error.runtimeType.toString()},
        cause: error,
      ),
    };
  }
}
