import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';

void main() {
  test('UUID and calendar date values reject malformed input', () {
    expect(() => CoffeeId('not-a-uuid'), throwsFormatException);
    expect(
      CoffeeId('ABCDEFAB-1234-4000-8000-000000000001').value,
      'abcdefab-1234-4000-8000-000000000001',
    );
    expect(CoffeeDate.tryParse('2025-02-29'), isNull);
    expect(CoffeeDate.tryParse('2026-13-01'), isNull);
    expect(CoffeeDate.tryParse('2024-02-29').toString(), '2024-02-29');
    final date = CoffeeDate(2026, 9, 28);
    expect(CoffeeDate.tryParse(date.toString()), date);
    expect(date.toLocalDate().day, 28);
  });

  test(
    'minimum, optional nulls, numbers, range and roast custom validation',
    () {
      expect(
        CoffeeValidation.validate(coffeeInput(name: '  ', roastery: ' ')).keys,
        containsAll([CoffeeField.name, CoffeeField.roastery]),
      );
      final details = CoffeeValidation.details(
        coffeeInput(name: ' Guji ').set(CoffeeField.region, '  '),
      );
      expect(details.name, 'Guji');
      expect(details.region, isNull);
      for (final invalid in [
        '0',
        '-1',
        '1.5',
        'abc',
        '999999999999999999999',
      ]) {
        expect(
          CoffeeValidation.validate(
            coffeeInput().set(CoffeeField.packageWeightGrams, invalid),
          )[CoffeeField.packageWeightGrams],
          CoffeeValidationIssue.positiveInteger,
        );
      }
      final badAltitude = coffeeInput()
          .set(CoffeeField.altitudeMinMeters, ' 2000 ')
          .set(CoffeeField.altitudeMaxMeters, ' 1800 ');
      expect(
        CoffeeValidation.validate(badAltitude)[CoffeeField.altitudeMaxMeters],
        CoffeeValidationIssue.altitudeRange,
      );
      expect(
        CoffeeValidation.validate(
          coffeeInput().set(CoffeeField.roastLevelKey, 'other'),
        )[CoffeeField.roastLevelCustom],
        CoffeeValidationIssue.customRequired,
      );
      expect(
        CoffeeValidation.details(
          coffeeInput()
              .set(CoffeeField.roastLevelKey, 'other')
              .set(CoffeeField.roastLevelCustom, ' Omni '),
        ).roastLevelCustom,
        'Omni',
      );
      expect(
        CoffeeValidation.validate(
          coffeeInput().set(CoffeeField.roastLevelCustom, 'Omni'),
        )[CoffeeField.roastLevelCustom],
        CoffeeValidationIssue.inconsistentCustom,
      );
    },
  );

  test(
    'Unicode-equivalent tags deduplicate without stripping display accents',
    () {
      expect(
        normalizeCoffeeText('  CAFÉ  floral '),
        normalizeCoffeeText('Cafe\u0301 floral'),
      );
      expect(
        CoffeeValidation.uniqueTags(['Café', 'cafe\u0301', ' Peach ', 'peach']),
        ['Café', 'Peach'],
      );
      expect(
        CoffeeValidation.validateTags(['']),
        CoffeeValidationIssue.invalidTag,
      );
      expect(
        CoffeeValidation.validateTags(List.filled(31, 'tag')),
        CoffeeValidationIssue.tooManyTags,
      );
    },
  );

  test('photo references cannot escape managed storage', () {
    CoffeePhoto photo(String path) => CoffeePhoto(
      id: 'photo',
      coffeeId: CoffeeId('00000000-0000-4000-8000-000000000001'),
      localPath: path,
      mimeType: 'image/jpeg',
      widthPixels: 100,
      heightPixels: 100,
      byteSize: 500,
      source: CoffeePhotoSource.gallery,
      createdAt: DateTime.utc(2026),
    );
    expect(photo('coffee/cover.jpg').localPath, 'coffee/cover.jpg');
    for (final path in [
      '../cover.jpg',
      '/cover.jpg',
      'C:/cover.jpg',
      'coffee/../cover.jpg',
      'coffee\\cover.jpg',
    ]) {
      expect(() => photo(path), throwsArgumentError);
    }
  });
}
