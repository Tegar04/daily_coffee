import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

import 'coffee_draft.dart';
import 'recognized_label_text.dart';

class CoffeeLabelCandidates {
  const CoffeeLabelCandidates(this.values, this.fields, this.suggestions);
  final CoffeeFormValues values;
  final List<ScanExtractedField> fields;
  final Map<String, List<LabelSuggestion>> suggestions;
}

class LabelSuggestion {
  const LabelSuggestion(this.value, this.rawText);
  final String value;
  final String rawText;
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
    'varieties': ['varieties', 'variety', 'varietal', 'varietas', 'cultivar'],
    'roast_level': ['roast level', 'roast profile', 'tingkat sangrai'],
    'tasting_notes': [
      'tasting notes',
      'taste notes',
      'flavor notes',
      'flavour notes',
      'notes',
      'cita rasa',
      'taste profile',
      'flavor',
      'flavour',
    ],
    'altitude': ['altitude', 'elevation', 'ketinggian'],
    'roast_date': [
      'roast date',
      'roasted on',
      'tanggal roasting',
      'tanggal sangrai',
      'roasting date',
      'roasted',
    ],
    'package_weight': [
      'net weight',
      'netto',
      'weight',
      'berat bersih',
      'berat',
      'net wt',
      'net wt.',
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
      if (key == 'origin_country') {
        final parts = _clean(value)
            .split(RegExp(r'[,;/|]'))
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
        final countries = parts
            .where(
              (s) => _countries.any((c) => c.toLowerCase() == s.toLowerCase()),
            )
            .toList();
        if (countries.length > 1 && countries.length == parts.length) {
          for (final country in countries) {
            candidates.putIfAbsent(key, () => []).add((
              value: country,
              line: line,
            ));
          }
          return;
        }
        if (parts.length == 2 && countries.length == 1) {
          final region = parts.firstWhere((s) => s != countries.single);
          candidates.putIfAbsent('region', () => []).add((
            value: region,
            line: line,
          ));
          value = countries.single;
        }
      }
      candidates.putIfAbsent(key, () => []).add((
        value: value.trim(),
        line: line,
      ));
    }

    final consumed = <int>{};
    final paired = <int, int>{};
    for (var i = 0; i < lines.length; i++) {
      final label = _labelled(lines[i].text);
      if (label == null || label.value.isNotEmpty) continue;
      final next = _valueLine(lines, i, consumed);
      if (next != null) {
        paired[i] = next;
        consumed.add(next);
      }
    }
    for (var i = 0; i < lines.length; i++) {
      if (consumed.contains(i)) continue;
      final line = lines[i];
      final value = _clean(line.text);
      final label = _labelled(value);
      if (label != null) {
        final start = label.value.isNotEmpty ? i : paired[i];
        if (start != null) {
          final source = lines[start];
          var content = start == i ? label.value : source.text;
          var raw = start == i ? line.text : '${line.text}\n${source.text}';
          var end = start;
          // A trailing list separator explicitly signals continuation. Avoid
          // swallowing unrelated headings just because they follow a list.
          if (label.key == 'tasting_notes' || label.key == 'varieties') {
            while (end + 1 < lines.length &&
                RegExp(r'[,;/|]$').hasMatch(content.trim()) &&
                !consumed.contains(end + 1) &&
                _labelled(lines[end + 1].text) == null) {
              final next = lines[end + 1];
              final previous = lines[end];
              if (previous.bounds.length == 4 &&
                  next.bounds.length == 4 &&
                  ((next.bounds[0] - previous.bounds[0]).abs() > 40 ||
                      next.bounds[1] < previous.bounds[3] ||
                      next.bounds[1] - previous.bounds[3] > 40)) {
                break;
              }
              content = '$content ${next.text}';
              raw = '$raw\n${next.text}';
              consumed.add(++end);
            }
          }
          add(
            label.key,
            content,
            RecognizedLine(raw, source.bounds, source.confidence),
          );
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
        if (value.toLowerCase() == country.toLowerCase()) {
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
    final suggestions = <String, List<LabelSuggestion>>{};
    for (final entry in candidates.entries) {
      final distinct = entry.value
          .map(
            (e) =>
                (normalizeValue(entry.key, e.value) ?? e.value).toLowerCase(),
          )
          .toSet();
      suggestions[entry.key] = [
        for (final c in entry.value)
          if (normalizeValue(entry.key, c.value) case final value?)
            LabelSuggestion(value, c.line.text),
      ];
      final candidate = entry.value.first;
      final value = candidate.value;
      var ambiguous = distinct.length > 1;
      final normalized = normalizeValue(entry.key, value);
      ambiguous |= normalized == null;
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
    return CoffeeLabelCandidates(values, fields, suggestions);
  }

  ({String key, String value})? _labelled(String input) {
    input = _clean(input);
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

  String? normalizeValue(String key, String value) {
    value = _clean(value);
    String? normalized;
    switch (key) {
      case 'origin_country':
        final countries = _countries
            .where((c) => c.toLowerCase() == value.toLowerCase())
            .toList();
        normalized = countries.firstOrNull;
      // Only explicit country tokens are normalized.
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
      case 'roast_date':
        normalized =
            CoffeeDate.tryParse(value)?.toString() ?? _namedDate(value);
        final m = RegExp(r'^(\d{1,2})[ /-](\d{1,2})[ /-](\d{4})$')
            .firstMatch(value);
        // Day-first numeric dates are safe only when day > 12.
        if (normalized == null && m != null && int.parse(m[1]!) > 12) {
          normalized = CoffeeDate.tryParse(
            '${m[3]}-${m[2]!.padLeft(2, '0')}-${m[1]!.padLeft(2, '0')}',
          )?.toString();
        }
      case 'altitude':
        final m = RegExp(
          r'^(\d{3,4})(?:\s*[-–]\s*(\d{3,4}))?\s*(?:m|masl|mdpl|m asl)?$',
          caseSensitive: false,
        ).firstMatch(value);
        if (m != null && int.parse(m[2] ?? m[1]!) >= int.parse(m[1]!)) {
          normalized = '${m[1]}-${m[2] ?? m[1]}';
        }
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
    return normalized;
  }

  static String _clean(String value) => value
      .trim()
      .replaceAll('\uFF1A', ':')
      .replaceAll(RegExp('[\u2013\u2014]'), '-')
      .replaceAll(RegExp(r'\s+'), ' ');

  /// Choices are rebuilt from original OCR, including for pre-existing drafts.
  /// They never modify the user's editable snapshot automatically.
  List<LabelSuggestion> choices(RecognizedLabelText text, String key) {
    final parsed = extract(text);
    final options = <LabelSuggestion>[...?parsed.suggestions[key]];
    final rawLines = text.lines.isEmpty
        ? text.text.split(RegExp(r'[\r\n]+'))
        : text.lines.map((l) => l.text);
    for (final raw in rawLines) {
      final label = _labelled(raw);
      if (label != null && label.key != key) continue;
      final value = label?.value ?? raw;
      if (value.trim().isEmpty) continue;
      final normalized = normalizeValue(key, value);
      if (normalized != null && normalized.isNotEmpty) {
        options.add(LabelSuggestion(normalized, raw));
      }
    }
    final seen = <String>{};
    return options.where((c) => seen.add(c.value.toLowerCase())).toList();
  }

  int? _valueLine(List<RecognizedLine> lines, int index, Set<int> used) {
    final label = lines[index];
    bool available(int i) =>
        i != index &&
        !used.contains(i) &&
        lines[i].text.trim().isNotEmpty &&
        _labelled(lines[i].text) == null;
    bool bounded(RecognizedLine line) =>
        line.bounds.length == 4 &&
        line.bounds.every((v) => v.isFinite) &&
        line.bounds[2] > line.bounds[0] &&
        line.bounds[3] > line.bounds[1];
    if (!bounded(label)) {
      return index + 1 < lines.length && available(index + 1)
          ? index + 1
          : null;
    }
    final b = label.bounds;
    final height = b[3] - b[1];
    final right = <({int index, double distance})>[];
    final below = <({int index, double distance})>[];
    for (var i = 0; i < lines.length; i++) {
      if (!available(i) || !bounded(lines[i])) continue;
      final v = lines[i].bounds;
      final centerDelta = ((v[1] + v[3] - b[1] - b[3]) / 2).abs();
      if (v[0] >= b[2] &&
          v[0] - b[2] <= height * 16 &&
          centerDelta <= height * 0.6) {
        // Never jump across another label on the same row.
        final blocked = lines.any(
          (other) =>
              bounded(other) &&
              _labelled(other.text) != null &&
              other.bounds[0] >= b[2] &&
              other.bounds[0] < v[0] &&
              ((other.bounds[1] + other.bounds[3] - b[1] - b[3]) / 2).abs() <=
                  height * 0.6,
        );
        if (!blocked) right.add((index: i, distance: v[0] - b[2]));
      }
      if (v[1] >= b[3] &&
          v[1] - b[3] <= height * 2 &&
          (v[0] - b[0]).abs() <= height * 2) {
        final blocked = lines.any(
          (other) =>
              bounded(other) &&
              _labelled(other.text) != null &&
              other.bounds[1] >= b[3] &&
              other.bounds[1] < v[1] &&
              (other.bounds[0] - b[0]).abs() <= height * 2,
        );
        if (!blocked) below.add((index: i, distance: v[1] - b[3]));
      }
    }
    final candidates = right.isNotEmpty ? right : below;
    candidates.sort((a, b) => a.distance.compareTo(b.distance));
    if (candidates.length > 1 &&
        (candidates[0].distance - candidates[1].distance).abs() <
            height * 0.25) {
      return null;
    }
    return candidates.firstOrNull?.index;
  }

  String? _namedDate(String value) {
    const months = [
      ['jan', 'january', 'januari'],
      ['feb', 'february', 'februari'],
      ['mar', 'march', 'maret'],
      ['apr', 'april'],
      ['may', 'mei'],
      ['jun', 'june', 'juni'],
      ['jul', 'july', 'juli'],
      ['aug', 'august', 'agu', 'agustus'],
      ['sep', 'sept', 'september'],
      ['oct', 'october', 'okt', 'oktober'],
      ['nov', 'november'],
      ['dec', 'december', 'des', 'desember'],
    ];
    final match = RegExp(
      r'^(\d{1,2})[ /-]([a-z]+)[ /-](\d{4})$',
      caseSensitive: false,
    ).firstMatch(value);
    if (match == null) return null;
    final month =
        months.indexWhere((names) => names.contains(match[2]!.toLowerCase())) +
        1;
    if (month == 0) return null;
    return CoffeeDate.tryParse(
      '${match[3]}-${month.toString().padLeft(2, '0')}-${match[1]!.padLeft(2, '0')}',
    )?.toString();
  }
}
