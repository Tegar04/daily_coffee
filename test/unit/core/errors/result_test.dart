import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('Ok exposes and folds its value', () {
      const result = Ok<int>(42);

      expect(result.isOk, isTrue);
      expect(result.isErr, isFalse);
      expect(result.fold(onOk: (value) => value * 2, onErr: (_) => 0), 84);
    });

    test('Err exposes and folds its typed failure', () {
      const failure = ValidationFailure(diagnosticContext: {'field': 'name'});
      const result = Err<int>(failure);

      expect(result.isOk, isFalse);
      expect(result.isErr, isTrue);
      expect(
        result.fold(onOk: (_) => 'ok', onErr: (value) => value.code),
        'validation',
      );
      expect(failure.toString(), isNot(contains('cause')));
    });
  });
}
