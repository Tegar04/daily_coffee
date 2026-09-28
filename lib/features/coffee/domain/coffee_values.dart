import 'package:unorm_dart/unorm_dart.dart' as unicode;

String normalizeCoffeeText(String value) =>
    unicode.nfc(value.trim()).replaceAll(RegExp(r'\s+'), ' ').toLowerCase();

final class CoffeeId {
  CoffeeId(String value) : value = value.toLowerCase() {
    if (!RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    ).hasMatch(this.value)) {
      throw FormatException('Invalid coffee UUID');
    }
  }
  final String value;
  @override
  bool operator ==(Object other) => other is CoffeeId && other.value == value;
  @override
  int get hashCode => value.hashCode;
  @override
  String toString() => value;
}

/// Calendar date; never converted to/from UTC for storage.
final class CoffeeDate {
  CoffeeDate(this.year, this.month, this.day) {
    final check = DateTime.utc(year, month, day);
    if (year < 1 ||
        year > 9999 ||
        check.year != year ||
        check.month != month ||
        check.day != day) {
      throw FormatException('Invalid calendar date');
    }
  }
  final int year;
  final int month;
  final int day;
  static CoffeeDate? tryParse(String value) {
    if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) return null;
    final parts = value.split('-').map(int.parse).toList();
    try {
      return CoffeeDate(parts[0], parts[1], parts[2]);
    } on FormatException {
      return null;
    }
  }

  DateTime toLocalDate() => DateTime(year, month, day);
  @override
  String toString() =>
      '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  @override
  bool operator ==(Object other) =>
      other is CoffeeDate &&
      year == other.year &&
      month == other.month &&
      day == other.day;
  @override
  int get hashCode => Object.hash(year, month, day);
}

enum RoastLevel { light, mediumLight, medium, mediumDark, dark, other }

extension RoastLevelKey on RoastLevel {
  String get key => switch (this) {
    RoastLevel.mediumLight => 'medium_light',
    RoastLevel.mediumDark => 'medium_dark',
    _ => name,
  };
  static RoastLevel? fromKey(String? key) {
    for (final level in RoastLevel.values) {
      if (level.key == key) return level;
    }
    return null;
  }
}

enum CoffeeField {
  name,
  roastery,
  originCountry,
  region,
  producer,
  process,
  roastLevelKey,
  roastLevelCustom,
  altitudeMinMeters,
  altitudeMaxMeters,
  roastDate,
  purchaseDate,
  packageWeightGrams,
  personalNote,
}

/// Immutable editable snapshot, allowed to contain incomplete/invalid values.
final class CoffeeFormValues {
  CoffeeFormValues({
    Map<CoffeeField, String> fields = const {},
    List<String> varieties = const [],
    List<String> tastingNotes = const [],
  }) : fields = Map.unmodifiable(fields),
       varieties = List.unmodifiable(varieties),
       tastingNotes = List.unmodifiable(tastingNotes);
  final Map<CoffeeField, String> fields;
  final List<String> varieties;
  final List<String> tastingNotes;
  String operator [](CoffeeField field) => fields[field] ?? '';
  CoffeeFormValues set(CoffeeField field, String value) => CoffeeFormValues(
    fields: {...fields, field: value},
    varieties: varieties,
    tastingNotes: tastingNotes,
  );
  CoffeeFormValues withTags({
    List<String>? varieties,
    List<String>? tastingNotes,
  }) => CoffeeFormValues(
    fields: fields,
    varieties: varieties ?? this.varieties,
    tastingNotes: tastingNotes ?? this.tastingNotes,
  );
  @override
  bool operator ==(Object other) =>
      other is CoffeeFormValues &&
      CoffeeField.values.every((field) => this[field] == other[field]) &&
      _same(varieties, other.varieties) &&
      _same(tastingNotes, other.tastingNotes);
  static bool _same(List<String> a, List<String> b) =>
      a.length == b.length &&
      Iterable<int>.generate(a.length).every((i) => a[i] == b[i]);
  @override
  int get hashCode => Object.hash(
    Object.hashAll(CoffeeField.values.map((field) => this[field])),
    Object.hashAll(varieties),
    Object.hashAll(tastingNotes),
  );
}
