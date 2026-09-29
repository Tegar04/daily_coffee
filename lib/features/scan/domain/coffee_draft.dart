import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

import 'recognized_label_text.dart';

enum ScanReviewStatus { unreviewed, needsReview, accepted, edited, rejected }

enum DraftValueSource { ocr, user }

class ScanExtractedField {
  const ScanExtractedField({
    required this.key,
    required this.rawValue,
    required this.normalizedValue,
    required this.confidence,
    required this.status,
    this.regions = const [],
  });
  final String key;
  final String rawValue;
  final String normalizedValue;
  final double? confidence;
  final ScanReviewStatus status;
  final List<List<double>> regions;
  DraftValueSource get source =>
      status == ScanReviewStatus.edited || status == ScanReviewStatus.rejected
      ? DraftValueSource.user
      : DraftValueSource.ocr;
  ScanExtractedField reviewed(String value) => ScanExtractedField(
    key: key,
    rawValue: rawValue,
    normalizedValue: normalizedValue,
    confidence: confidence,
    regions: regions,
    status: value.isEmpty
        ? ScanReviewStatus.rejected
        : value != normalizedValue
        ? ScanReviewStatus.edited
        : status,
  );
}

/// Invalid/intermediate text is intentionally retained until explicit save.
class CoffeeDraft {
  const CoffeeDraft({
    required this.id,
    required this.image,
    required this.text,
    required this.values,
    required this.fields,
    required this.revision,
    this.includePhoto = true,
  });
  final String id;
  final ManagedImage? image;
  final RecognizedLabelText text;
  final CoffeeFormValues values;
  final List<ScanExtractedField> fields;
  final int revision;
  final bool includePhoto;
  DraftValueSource sourceFor(String key) =>
      fields.where((f) => f.key == key).firstOrNull?.source ??
      DraftValueSource.user;
}

String draftFieldValue(CoffeeFormValues values, String key) => switch (key) {
  'varieties' => values.varieties.join('; '),
  'tasting_notes' => values.tastingNotes.join('; '),
  'altitude' =>
    '${values[CoffeeField.altitudeMinMeters]}-${values[CoffeeField.altitudeMaxMeters]}',
  'roast_level' =>
    values[CoffeeField.roastLevelKey] == 'other'
        ? values[CoffeeField.roastLevelCustom]
        : values[CoffeeField.roastLevelKey],
  _ =>
    values[switch (key) {
      'roastery' => CoffeeField.roastery,
      'origin_country' => CoffeeField.originCountry,
      'region' => CoffeeField.region,
      'producer' => CoffeeField.producer,
      'process' => CoffeeField.process,
      'roast_date' => CoffeeField.roastDate,
      'package_weight' => CoffeeField.packageWeightGrams,
      _ => CoffeeField.name,
    }],
};
