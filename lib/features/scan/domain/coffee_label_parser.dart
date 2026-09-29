import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

import 'coffee_draft.dart';
import 'recognized_label_text.dart';

class CoffeeLabelCandidates {
  const CoffeeLabelCandidates(this.values, this.fields);
  final CoffeeFormValues values;
  final List<ScanExtractedField> fields;
}

/// Conservative, deterministic extraction. No inferred country from region,
/// invented dates, or guessed product/roaster from arbitrary heading order.
class CoffeeLabelParser {
  const CoffeeLabelParser();
  static const _aliases = {
    'name': [
      'coffee name',
      'nama kopi',
      'nama coffee',
      'coffee',
      'kopi',
      'name',
    ],
    'roastery': ['roastery', 'roaster', 'roasted by', 'disangrai oleh'],
    'origin_country': [
      'origin country',
      'country',
      'negara asal',
      'negara',
      'origin',
      'asal',
    ],
    'region': ['region', 'wilayah', 'farm', 'estate'],
    'producer': ['producer', 'produsen', 'farmer', 'petani'],
    'process': ['processing', 'process', 'proses'],
    'varieties': ['varieties', 'variety', 'varietal', 'varietas'],
    'roast_level': ['roast level', 'roast profile', 'tingkat sangrai'],
    'tasting_notes': [
      'tasting notes',
      'taste notes',
      'flavor notes',
      'flavour notes',
      'notes',
      'cita rasa',
    ],
    'altitude': ['altitude', 'elevation', 'ketinggian'],
    'roast_date': [
      'roast date',
      'roasted on',
      'tanggal roasting',
      'tanggal sangrai',
    ],
    'package_weight': [
      'net weight',
      'netto',
      'weight',
      'berat bersih',
      'berat',
    ],
  };
  static const _countries = [
    'Indonesia',
    'Ethiopia',
    'Colombia',
    'Brazil',
    'Kenya',
    'Guatemala',
    'Costa Rica',
    'Panama',
    'Peru',
    'Rwanda',
    'Burundi',
    'India',
    'Vietnam',
    'El Salvador',
    'Honduras',
    'Mexico',
    'Ecuador',
    'Bolivia',
    'Yemen',
    'Uganda',
    'Tanzania',
  ];
  static const _processes = [
    'washed',
    'natural',
    'honey',
    'wet hulled',
    'giling basah',
    'anaerobic',
    'anaerobic natural',
    'anaerobic washed',
    'carbonic maceration',
  ];

  CoffeeLabelCandidates extract(RecognizedLabelText text) {
    final lines = text.lines.isEmpty
        ? text.text
              .split(RegExp(r'[\r\n]+'))
              .where((s) => s.trim().isNotEmpty)
              .map((s) => RecognizedLine(s.trim(), const [], null))
              .toList()
        : text.lines;
    final candidates = <String, List<({String value, RecognizedLine line})>>{};
    void add(String key, String value, RecognizedLine line) {
      if (value.trim().isEmpty) return;
      candidates.putIfAbsent(key, () => []).add((
        value: value.trim(),
        line: line,
      ));
    }

    ({String key, String value})? labelled(String input) {
      for (final entry in _aliases.entries) {
        for (final alias in entry.value) {
          final separator = ['coffee', 'kopi', 'name', 'notes'].contains(alias)
              ? r'(?:\s*[:=]\s*|\s+-\s+)'
              : r'(?:\s*[:=]\s*|\s+-\s+|\s+)';
          final m = RegExp(
            '^${RegExp.escape(alias)}$separator(.*)\$',
            caseSensitive: false,
          ).firstMatch(input.trim());
          if (m != null) return (key: entry.key, value: m.group(1)!.trim());
          if (input.trim().toLowerCase() == alias ||
              input.trim().toLowerCase() == '$alias:') {
            return (key: entry.key, value: '');
          }
        }
      }
      return null;
    }

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final value = line.text.trim();
      final label = labelled(value);
      if (label != null) {
        if (label.value.isNotEmpty) {
          add(label.key, label.value, line);
        } else if (i + 1 < lines.length &&
            labelled(lines[i + 1].text) == null) {
          add(label.key, lines[++i].text, lines[i]);
        }
        continue;
      }
      if (RegExp(
        r'\b(roastery|roasters)\b',
        caseSensitive: false,
      ).hasMatch(value)) {
        add('roastery', value, line);
      }
      for (final country in _countries) {
        if (RegExp(
          '\\b${RegExp.escape(country)}\\b',
          caseSensitive: false,
        ).hasMatch(value)) {
          add('origin_country', country, line);
        }
      }
      final process = _processes
          .where((p) => value.toLowerCase() == p)
          .firstOrNull;
      if (process != null) add('process', value, line);
      if (RegExp(
        r'^\d+(?:[.,]\d+)?\s*(g|gr|grams?|kg)$',
        caseSensitive: false,
      ).hasMatch(value)) {
        add('package_weight', value, line);
      }
      if (RegExp(
        r'^\d{3,4}(?:\s*[-–]\s*\d{3,4})?\s*(masl|mdpl|m asl)$',
        caseSensitive: false,
      ).hasMatch(value)) {
        add('altitude', value, line);
      }
    }
    var values = CoffeeFormValues();
    final fields = <ScanExtractedField>[];
    for (final entry in candidates.entries) {
      final distinct = entry.value.map((e) => e.value.toLowerCase()).toSet();
      final candidate = entry.value.first;
      final value = candidate.value;
      var ambiguous = distinct.length > 1;
      String? normalized;
      switch (entry.key) {
        case 'origin_country':
          final countries = _countries
              .where((c) => c.toLowerCase() == value.toLowerCase())
              .toList();
          normalized = countries.firstOrNull;
          // "Origin: Guji, Ethiopia" needs user disambiguation; keep raw text.
          ambiguous |= normalized == null;
        case 'package_weight':
          final match = RegExp(
            r'^(\d+(?:[.,]\d+)?)\s*(g|gr|grams?|kg)$',
            caseSensitive: false,
          ).firstMatch(value);
          if (match != null) {
            final number =
                double.parse(match[1]!.replaceAll(',', '.')) *
                (match[2]!.toLowerCase() == 'kg' ? 1000 : 1);
            if (number > 0 &&
                number == number.roundToDouble() &&
                number <= 2147483647) {
              normalized = number.toInt().toString();
            }
          }
          ambiguous |= normalized == null;
        case 'roast_date':
          normalized = CoffeeDate.tryParse(value)?.toString();
          final m = RegExp(r'^(\d{1,2})[ /-](\d{1,2})[ /-](\d{4})$')
              .firstMatch(value);
          // Day-first numeric dates are safe only when day > 12.
          if (normalized == null && m != null && int.parse(m[1]!) > 12) {
            normalized = CoffeeDate.tryParse(
              '${m[3]}-${m[2]!.padLeft(2, '0')}-${m[1]!.padLeft(2, '0')}',
            )?.toString();
          }
          ambiguous |= normalized == null;
        case 'altitude':
          final m = RegExp(
            r'^(\d{3,4})(?:\s*[-–]\s*(\d{3,4}))?\s*(?:m|masl|mdpl|m asl)?$',
            caseSensitive: false,
          ).firstMatch(value);
          if (m != null && int.parse(m[2] ?? m[1]!) >= int.parse(m[1]!)) {
            normalized = '${m[1]}-${m[2] ?? m[1]}';
          }
          ambiguous |= normalized == null;
        case 'roast_level':
          normalized = switch (value.toLowerCase().replaceAll(
            RegExp(r'[-_ ]+'),
            ' ',
          )) {
            'light' => 'light',
            'medium light' => 'medium_light',
            'medium' => 'medium',
            'medium dark' => 'medium_dark',
            'dark' => 'dark',
            _ => null,
          };
          ambiguous |= normalized == null;
        case 'varieties':
        case 'tasting_notes':
          normalized = value
              .split(RegExp(r'[,;/|]'))
              .map((e) => e.trim())
              .where((e) => e.isNotEmpty)
              .join('; ');
        default:
          normalized = value;
      }
      final output = distinct.length > 1 ? '' : normalized ?? '';
      final confidence = candidate.line.confidence;
      fields.add(
        ScanExtractedField(
          key: entry.key,
          rawValue: entry.value.map((c) => c.line.text).toSet().join('\n'),
          normalizedValue: output,
          confidence: confidence,
          regions: entry.value
              .map((c) => c.line.bounds)
              .where((b) => b.isNotEmpty)
              .toList(),
          status: ambiguous || confidence == null || confidence < 0.85
              ? ScanReviewStatus.needsReview
              : ScanReviewStatus.unreviewed,
        ),
      );
      if (output.isEmpty) continue;
      switch (entry.key) {
        case 'varieties':
          values = values.withTags(varieties: output.split('; '));
        case 'tasting_notes':
          values = values.withTags(tastingNotes: output.split('; '));
        case 'altitude':
          values = values
              .set(CoffeeField.altitudeMinMeters, output.split('-')[0])
              .set(CoffeeField.altitudeMaxMeters, output.split('-')[1]);
        default:
          final field = switch (entry.key) {
            'name' => CoffeeField.name,
            'roastery' => CoffeeField.roastery,
            'origin_country' => CoffeeField.originCountry,
            'region' => CoffeeField.region,
            'producer' => CoffeeField.producer,
            'process' => CoffeeField.process,
            'roast_level' => CoffeeField.roastLevelKey,
            'roast_date' => CoffeeField.roastDate,
            _ => CoffeeField.packageWeightGrams,
          };
          values = values.set(field, output);
      }
    }
    return CoffeeLabelCandidates(values, fields);
  }
}
