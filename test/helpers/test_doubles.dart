import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/time/app_clock.dart';

final class FixedAppClock implements AppClock {
  const FixedAppClock(this.value);

  final DateTime value;

  @override
  DateTime now() => value;
}

final class SequenceAppIdGenerator implements AppIdGenerator {
  SequenceAppIdGenerator(this._values);

  final List<String> _values;
  var _index = 0;

  @override
  String generate() {
    if (_index >= _values.length) {
      throw StateError('No test ID remains in the sequence.');
    }

    return _values[_index++];
  }
}
