import 'dart:convert';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:daily_coffee/features/capture/application/capture_form_snapshot.dart';
import 'package:daily_coffee/features/coffee/data/drift_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:drift/drift.dart';

import '../domain/coffee_draft.dart';
import '../domain/coffee_label_parser.dart';
import '../domain/recognized_label_text.dart';
import '../domain/scan_review_repository.dart';

class DriftScanReviewRepository implements ScanReviewRepository {
  DriftScanReviewRepository(
    this.db,
    this.storage,
    this.clock,
    this.ids,
    this.coffees,
  );
  final AppDatabase db;
  final ImageStorage storage;
  final AppClock clock;
  final AppIdGenerator ids;
  final DriftCoffeeRepository coffees;
  int get _now => clock.now().toUtc().microsecondsSinceEpoch;
  Future<Result<T>> _guard<T>(Future<T> Function() action) async {
    try {
      return Ok(await action());
    } catch (error) {
      return Err(error is AppFailure ? error : StorageFailure(cause: error));
    }
  }

  Future<DraftRecord> _row(String id) async {
    final row =
        await (db.select(db.coffeeDrafts)..where(
              (t) => t.id.equals(id) & t.draftType.equals('scan_create'),
            ))
            .getSingleOrNull();
    if (row == null) throw const NotFoundFailure();
    if (row.status != 'review_required' || row.ocrRawText == null) {
      throw const ConflictFailure();
    }
    return row;
  }

  RecognizedLabelText _text(DraftRecord row) => RecognizedLabelText(
    row.ocrRawText!,
    (jsonDecode(row.ocrLinesJson ?? '[]') as List)
        .map((e) => RecognizedLine.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
  String _encode(CoffeeFormValues values, bool includePhoto) => jsonEncode({
    'version': 1,
    'values': encodeForm(values),
    'includePhoto': includePhoto,
  });
  String _status(ScanReviewStatus status) =>
      status == ScanReviewStatus.needsReview ? 'needs_review' : status.name;
  ScanExtractedField _field(ScanExtractedFieldRecord row) => ScanExtractedField(
    key: row.fieldKey,
    rawValue: row.rawValue ?? '',
    normalizedValue: row.normalizedValue ?? '',
    confidence: row.confidenceBasisPoints == null
        ? null
        : row.confidenceBasisPoints! / 10000,
    status: row.reviewStatus == 'needs_review'
        ? ScanReviewStatus.needsReview
        : ScanReviewStatus.values.byName(row.reviewStatus),
    regions: (jsonDecode(row.sourceRegion ?? '[]') as List)
        .map((b) => (b as List).map((v) => (v as num).toDouble()).toList())
        .toList(),
  );
  Future<CoffeeDraft> _decode(DraftRecord row) async {
    final json = jsonDecode(row.reviewJson!) as Map<String, dynamic>;
    final imageJson = await storage.readJson('drafts/${row.id}/image.json');
    final fields = await (db.select(
      db.scanExtractedFields,
    )..where((t) => t.coffeeDraftId.equals(row.id))).get();
    return CoffeeDraft(
      id: row.id,
      image: imageJson == null ? null : ManagedImage.fromJson(imageJson),
      text: _text(row),
      values: decodeForm(json['values'] as Map<String, dynamic>),
      fields: fields.map(_field).toList(),
      revision: row.reviewRevision,
      includePhoto: json['includePhoto'] as bool,
    );
  }

  @override
  Future<Result<CoffeeDraft>> open(String id) => _guard(
    () => db.transaction(() async {
      var row = await _row(id);
      if (row.reviewJson == null) {
        final parsed = const CoffeeLabelParser().extract(_text(row));
        await (db.delete(
          db.scanExtractedFields,
        )..where((t) => t.coffeeDraftId.equals(id))).go();
        for (final field in parsed.fields) {
          await db
              .into(db.scanExtractedFields)
              .insert(
                ScanExtractedFieldsCompanion.insert(
                  id: ids.generate(),
                  coffeeDraftId: id,
                  fieldKey: field.key,
                  rawValue: Value(field.rawValue),
                  normalizedValue: Value(field.normalizedValue),
                  confidenceBasisPoints: Value(
                    field.confidence == null
                        ? null
                        : (field.confidence!.clamp(0, 1) * 10000).round(),
                  ),
                  reviewStatus: _status(field.status),
                  sourceRegion: Value(jsonEncode(field.regions)),
                  createdAt: _now,
                  updatedAt: _now,
                ),
              );
        }
        await (db.update(db.coffeeDrafts)..where((t) => t.id.equals(id))).write(
          CoffeeDraftsCompanion(
            reviewJson: Value(
              _encode(parsed.values, row.temporaryImagePath != null),
            ),
            reviewRevision: Value(row.reviewRevision + 1),
            updatedAt: Value(_now),
          ),
        );
        row = await _row(id);
      }
      return _decode(row);
    }),
  );
  @override
  Future<Result<CoffeeDraft>> save(
    String id,
    int expectedRevision,
    CoffeeFormValues values,
    bool includePhoto,
  ) => _guard(
    () => db.transaction(() async {
      final row = await _row(id);
      if (row.reviewRevision != expectedRevision || row.reviewJson == null) {
        throw const ConflictFailure();
      }
      final fields = await (db.select(
        db.scanExtractedFields,
      )..where((t) => t.coffeeDraftId.equals(id))).get();
      for (final field in fields) {
        final current = draftFieldValue(values, field.fieldKey);
        final status = current == (field.normalizedValue ?? '')
            ? (field.reviewStatus == 'edited' ||
                      field.reviewStatus == 'rejected'
                  ? 'unreviewed'
                  : field.reviewStatus)
            : (current.isEmpty || current == '-' ? 'rejected' : 'edited');
        await (db.update(
          db.scanExtractedFields,
        )..where((t) => t.id.equals(field.id))).write(
          ScanExtractedFieldsCompanion(
            reviewStatus: Value(status),
            updatedAt: Value(_now),
          ),
        );
      }
      await (db.update(db.coffeeDrafts)..where((t) => t.id.equals(id))).write(
        CoffeeDraftsCompanion(
          reviewJson: Value(_encode(values, includePhoto)),
          reviewRevision: Value(expectedRevision + 1),
          updatedAt: Value(_now),
        ),
      );
      return _decode(await _row(id));
    }),
  );
  @override
  Future<Result<Coffee>> promote(String id, int expectedRevision) async {
    final loaded = await _guard(() async => _decode(await _row(id)));
    if (loaded case Err<CoffeeDraft>(:final failure)) return Err(failure);
    final draft = (loaded as Ok<CoffeeDraft>).value;
    if (draft.revision != expectedRevision) return const Err(ConflictFailure());
    if (draft.includePhoto && draft.image == null) {
      return const Err(ImageValidationFailure());
    }
    return coffees.createFromDraft(
      draft.values,
      draftId: id,
      expectedRevision: expectedRevision,
      image: draft.includePhoto ? draft.image : null,
    );
  }
}
