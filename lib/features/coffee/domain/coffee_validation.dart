import 'coffee.dart';
import 'coffee_values.dart';

enum CoffeeValidationIssue {
  required,
  tooLong,
  positiveInteger,
  invalidDate,
  invalidChoice,
  customRequired,
  inconsistentCustom,
  altitudeRange,
  tooManyTags,
  invalidTag,
}

abstract final class CoffeeValidation {
  static const textLimit = 200;
  static const noteLimit = 5000;
  static const tagLimit = 80;
  static const tagCountLimit = 30;
  // Avoid unsafe integer conversion and accidental pasted quantities.
  static const integerLimit = 2147483647;

  static Map<CoffeeField, CoffeeValidationIssue> validate(
    CoffeeFormValues input,
  ) {
    final errors = <CoffeeField, CoffeeValidationIssue>{};
    for (final field in CoffeeField.values) {
      final value = input[field].trim();
      if ((field == CoffeeField.name || field == CoffeeField.roastery) &&
          value.isEmpty) {
        errors[field] = CoffeeValidationIssue.required;
      } else if (value.length >
          (field == CoffeeField.personalNote ? noteLimit : textLimit)) {
        errors[field] = CoffeeValidationIssue.tooLong;
      }
    }
    for (final field in [
      CoffeeField.packageWeightGrams,
      CoffeeField.altitudeMinMeters,
      CoffeeField.altitudeMaxMeters,
    ]) {
      final value = input[field].trim();
      final number = int.tryParse(value);
      if (value.isNotEmpty &&
          (!RegExp(r'^\d+$').hasMatch(value) ||
              number == null ||
              number <= 0 ||
              number > integerLimit)) {
        errors[field] = CoffeeValidationIssue.positiveInteger;
      }
    }
    final min = int.tryParse(input[CoffeeField.altitudeMinMeters]);
    final max = int.tryParse(input[CoffeeField.altitudeMaxMeters]);
    if (min != null && max != null && max < min) {
      errors[CoffeeField.altitudeMaxMeters] =
          CoffeeValidationIssue.altitudeRange;
    }
    for (final field in [CoffeeField.roastDate, CoffeeField.purchaseDate]) {
      if (input[field].trim().isNotEmpty &&
          CoffeeDate.tryParse(input[field].trim()) == null) {
        errors[field] = CoffeeValidationIssue.invalidDate;
      }
    }
    final key = input[CoffeeField.roastLevelKey];
    final custom = input[CoffeeField.roastLevelCustom].trim();
    if (key.isNotEmpty && RoastLevelKey.fromKey(key) == null) {
      errors[CoffeeField.roastLevelKey] = CoffeeValidationIssue.invalidChoice;
    }
    if (key == 'other' && custom.isEmpty) {
      errors[CoffeeField.roastLevelCustom] =
          CoffeeValidationIssue.customRequired;
    }
    if (key != 'other' && custom.isNotEmpty) {
      errors[CoffeeField.roastLevelCustom] =
          CoffeeValidationIssue.inconsistentCustom;
    }
    return Map.unmodifiable(errors);
  }

  static CoffeeValidationIssue? validateTags(List<String> tags) {
    if (tags.length > tagCountLimit) return CoffeeValidationIssue.tooManyTags;
    if (tags.any((tag) => tag.trim().isEmpty || tag.trim().length > tagLimit)) {
      return CoffeeValidationIssue.invalidTag;
    }
    return null;
  }

  static List<String> uniqueTags(List<String> tags) {
    final seen = <String>{};
    return [
      for (final tag in tags)
        if (seen.add(normalizeCoffeeText(tag))) tag.trim(),
    ];
  }

  static CoffeeDetails details(CoffeeFormValues input) {
    if (validate(input).isNotEmpty ||
        validateTags(input.varieties) != null ||
        validateTags(input.tastingNotes) != null) {
      throw ArgumentError('Invalid coffee input');
    }
    String? optional(CoffeeField field) =>
        input[field].trim().isEmpty ? null : input[field].trim();
    return CoffeeDetails(
      name: input[CoffeeField.name].trim(),
      roastery: input[CoffeeField.roastery].trim(),
      originCountry: optional(CoffeeField.originCountry),
      region: optional(CoffeeField.region),
      producer: optional(CoffeeField.producer),
      process: optional(CoffeeField.process),
      roastLevel: RoastLevelKey.fromKey(optional(CoffeeField.roastLevelKey)),
      roastLevelCustom: optional(CoffeeField.roastLevelCustom),
      altitudeMinMeters: int.tryParse(
        input[CoffeeField.altitudeMinMeters].trim(),
      ),
      altitudeMaxMeters: int.tryParse(
        input[CoffeeField.altitudeMaxMeters].trim(),
      ),
      roastDate: CoffeeDate.tryParse(input[CoffeeField.roastDate].trim()),
      purchaseDate: CoffeeDate.tryParse(input[CoffeeField.purchaseDate].trim()),
      packageWeightGrams: int.tryParse(
        input[CoffeeField.packageWeightGrams].trim(),
      ),
      personalNote: optional(CoffeeField.personalNote),
    );
  }
}
