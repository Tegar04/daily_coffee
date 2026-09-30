import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/scan/domain/coffee_draft.dart';
import 'package:daily_coffee/features/scan/domain/coffee_label_parser.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CoffeeLabelCandidates parse(String text) =>
      const CoffeeLabelParser().extract(RecognizedLabelText(text, const []));
  test(
    'labelled bilingual fields, decimal kg, altitude, tags and ISO date',
    () {
      final parsed = parse('''Roastery: Nusantara
Nama kopi: Gayo Highlands
Origin: Indonesia
Region: Aceh
Producer: Koperasi Gayo
Process: Washed
Varietas: Bourbon / Typica
Roast level: medium-light
Tasting notes: Peach, Citrus; Floral
Altitude: 1200-1500 mdpl
Roast date: 2026-09-29
Net weight: 0.25 kg''');
      final v = parsed.values;
      expect(v[CoffeeField.name], 'Gayo Highlands');
      expect(v[CoffeeField.roastery], 'Nusantara');
      expect(v[CoffeeField.originCountry], 'Indonesia');
      expect(v[CoffeeField.region], 'Aceh');
      expect(v[CoffeeField.producer], 'Koperasi Gayo');
      expect(v[CoffeeField.process], 'Washed');
      expect(v.varieties, ['Bourbon', 'Typica']);
      expect(v.tastingNotes, ['Peach', 'Citrus', 'Floral']);
      expect(v[CoffeeField.roastLevelKey], 'medium_light');
      expect(v[CoffeeField.altitudeMinMeters], '1200');
      expect(v[CoffeeField.altitudeMaxMeters], '1500');
      expect(v[CoffeeField.roastDate], '2026-09-29');
      expect(v[CoffeeField.packageWeightGrams], '250');
      expect(parsed.fields, hasLength(12));
      expect(
        parsed.fields.every(
          (f) =>
              f.confidence == null && f.status == ScanReviewStatus.needsReview,
        ),
        isTrue,
      );
    },
  );
  test(
    'missing and ambiguous values stay empty, original candidates retained',
    () {
      final parsed = parse('''Name: Gayo
Name: Guji
Origin: Kenya / Ethiopia
Roast date: 03/04/2026
Weight: 250.5g
Altitude: 1800-1200m
Roast level: Filter''');
      for (final field in [
        CoffeeField.name,
        CoffeeField.originCountry,
        CoffeeField.roastDate,
        CoffeeField.packageWeightGrams,
        CoffeeField.altitudeMinMeters,
        CoffeeField.roastLevelKey,
      ]) {
        expect(parsed.values[field], isEmpty);
      }
      expect(parsed.values[CoffeeField.roastery], isEmpty);
      expect(
        parsed.fields.every((f) => f.status == ScanReviewStatus.needsReview),
        isTrue,
      );
      expect(parsed.fields.first.rawValue, contains('Guji'));
    },
  );
  test('standalone vocabulary and stacked key/value labels', () {
    final parsed = parse('''NUSANTARA ROASTERY
Coffee name:
Gayo
INDONESIA
NATURAL
250g
1500 masl
Roast date: 29/09/2026''');
    expect(parsed.values[CoffeeField.name], 'Gayo');
    expect(parsed.values[CoffeeField.roastery], 'NUSANTARA ROASTERY');
    expect(parsed.values[CoffeeField.originCountry], 'Indonesia');
    expect(parsed.values[CoffeeField.process], 'NATURAL');
    expect(parsed.values[CoffeeField.roastDate], '2026-09-29');
  });
  test('marketing headings do not invent coffee names or provenance', () {
    final parsed = parse(
      'COFFEE ROASTERS\nGAYO HIGHLANDS\n100% ARABICA\nBEST BEFORE 2027-09-29',
    );
    expect(parsed.values[CoffeeField.name], isEmpty);
    expect(parsed.values[CoffeeField.roastDate], isEmpty);
    expect(parsed.values[CoffeeField.originCountry], isEmpty);
  });
  test(
    'combined origin, local month dates, typography and equivalent weights',
    () {
      final parsed = parse(
        'Origin: Guji, Ethiopia\nRoasted: 29 September 2026\nNet wt.\uFF1A0,25 kg\nWeight: 250g',
      );
      expect(parsed.values[CoffeeField.originCountry], 'Ethiopia');
      expect(parsed.values[CoffeeField.region], 'Guji');
      expect(parsed.values[CoffeeField.roastDate], '2026-09-29');
      expect(parsed.values[CoffeeField.packageWeightGrams], '250');
      expect(
        parse('Altitude: 1200\u20131500 mdpl')
            .values[CoffeeField.altitudeMaxMeters],
        '1500',
      );
      expect(parse('Name: Why not?').values[CoffeeField.name], 'Why not?');
      expect(
        parse('Roasted: 31 Februari 2026').values[CoffeeField.roastDate],
        isEmpty,
      );
      expect(
        parse('Roasted: 03/04/2026').values[CoffeeField.roastDate],
        isEmpty,
      );
    },
  );

  test('two columns use geometry when OCR emits labels before values', () {
    final result = const CoffeeLabelParser().extract(
      const RecognizedLabelText('', [
        RecognizedLine('Process:', [0, 0, 80, 20], null),
        RecognizedLine('Variety:', [0, 40, 80, 60], null),
        RecognizedLine('Bourbon', [100, 40, 180, 60], null),
        RecognizedLine('Natural', [100, 0, 180, 20], null),
      ]),
    );
    expect(result.values[CoffeeField.process], 'Natural');
    expect(result.values.varieties, ['Bourbon']);
    expect(result.fields.first.rawValue, contains('Process:'));
  });

  test('stacked spatial values respect label boundaries and distance', () {
    final result = const CoffeeLabelParser().extract(
      const RecognizedLabelText('', [
        RecognizedLine('Process:', [0, 0, 80, 20], null),
        RecognizedLine('Natural', [0, 25, 80, 45], null),
        RecognizedLine('Variety:', [200, 0, 280, 20], null),
        RecognizedLine('Bourbon', [200, 25, 280, 45], null),
        RecognizedLine('Roastery:', [400, 0, 480, 20], null),
        RecognizedLine('Distant brand', [400, 200, 480, 220], null),
      ]),
    );
    expect(result.values[CoffeeField.process], 'Natural');
    expect(result.values.varieties, ['Bourbon']);
    expect(result.values[CoffeeField.roastery], isEmpty);
  });

  test(
    'multiple candidates remain selectable without silently picking one',
    () {
      const text = RecognizedLabelText(
        'Name: Gayo\nName: Guji\nOrigin: Kenya / Ethiopia',
        [],
      );
      const parser = CoffeeLabelParser();
      expect(parser.extract(text).values[CoffeeField.name], isEmpty);
      expect(parser.choices(text, 'name').map((c) => c.value), [
        'Gayo',
        'Guji',
      ]);
      expect(parser.extract(text).values[CoffeeField.originCountry], isEmpty);
      expect(parser.choices(text, 'origin_country').map((c) => c.value), [
        'Kenya',
        'Ethiopia',
      ]);
    },
  );

  test(
    'unlabelled headings offered for manual assignment but never autofilled',
    () {
      const text = RecognizedLabelText(
        'GAYO HIGHLANDS\nBrand Nusantara\n250g',
        [],
      );
      const parser = CoffeeLabelParser();
      expect(parser.extract(text).values[CoffeeField.name], isEmpty);
      expect(
        parser.choices(text, 'name').map((c) => c.value),
        contains('GAYO HIGHLANDS'),
      );
      expect(parser.choices(text, 'package_weight').single.value, '250');
      expect(
        parse('Roasted in Indonesia').values[CoffeeField.originCountry],
        isEmpty,
      );
    },
  );

  test('list continuation stops at the next labelled field', () {
    final result = parse(
      'Tasting notes: Peach,\nCitrus,\nFloral\nVariety: Bourbon /\nTypica\nWeight: 250g',
    );
    expect(result.values.tastingNotes, ['Peach', 'Citrus', 'Floral']);
    expect(result.values.varieties, ['Bourbon', 'Typica']);
    expect(result.values[CoffeeField.packageWeightGrams], '250');
    expect(result.fields.first.rawValue, contains('Floral'));
  });

  test(
    'native confidence and regions retained, low-confidence needs review',
    () {
      final parsed = const CoffeeLabelParser().extract(
        const RecognizedLabelText('', [
          RecognizedLine('Name: Gayo', [1, 2, 3, 4], 0.6),
          RecognizedLine('Roastery: Nusantara', [5, 6, 7, 8], 0.97),
        ]),
      );
      expect(parsed.fields.first.confidence, 0.6);
      expect(parsed.fields.first.status, ScanReviewStatus.needsReview);
      expect(parsed.fields.last.status, ScanReviewStatus.unreviewed);
      expect(parsed.fields.first.regions.single, [1, 2, 3, 4]);
    },
  );
}
