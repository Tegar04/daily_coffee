import 'dart:math';

import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generates an RFC 4122 version 4 identifier', () {
    final generator = RandomAppIdGenerator(random: Random(7));
    final id = generator.generate();

    expect(
      id,
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
        ),
      ),
    );
  });
}
