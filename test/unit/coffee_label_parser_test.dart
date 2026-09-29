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
Origin: Guji, Ethiopia
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
