import 'dart:io';

import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/exception_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps known boundary exceptions to typed failures', () {
    expect(
      ExceptionMapper.map(const FormatException()),
      isA<ValidationFailure>(),
    );
    expect(
      ExceptionMapper.map(const FileSystemException()),
      isA<StorageFailure>(),
    );
  });

  test(
    'maps unknown exceptions without exposing their message in toString',
    () {
      final failure = ExceptionMapper.map(StateError('sensitive value'));

      expect(failure, isA<UnexpectedFailure>());
      expect(failure.toString(), isNot(contains('sensitive value')));
    },
  );
}
