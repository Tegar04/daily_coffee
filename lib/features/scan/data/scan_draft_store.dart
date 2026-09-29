import 'dart:convert';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:drift/drift.dart';

import '../domain/recognized_label_text.dart';

class ScanDraftStore {
  ScanDraftStore(this.db, this.storage, this.clock);
  final AppDatabase db;
  final ImageStorage storage;
  final AppClock clock;
  int get _now => clock.now().toUtc().microsecondsSinceEpoch;

  Future<List<ScanDraft>> load() async {
    final rows =
        await (db.select(db.coffeeDrafts)
              ..where((t) => t.draftType.equals('scan_create'))
              ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
            .get();
    return [for (final row in rows) await _decode(row)];
  }

  Future<ScanDraft> _decode(DraftRecord row) async {
    final json = await storage.readJson('drafts/${row.id}/image.json');
    // Keep a missing image recoverable through retry/new photo/manual input.
    final image = json == null
        ? ManagedImage(
            id: row.id,
            localPath: row.temporaryImagePath ?? 'drafts/${row.id}/cover.jpg',
            width: 0,
            height: 0,
            byteSize: 0,
            source: 'gallery',
          )
        : ManagedImage.fromJson(json);
    return ScanDraft(
      image,
      row.ocrRawText == null
          ? null
          : RecognizedLabelText(
              row.ocrRawText!,
              (jsonDecode(row.ocrLinesJson ?? '[]') as List)
                  .map(
                    (e) => RecognizedLine.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            ),
    );
  }

  Future<int> begin(String id) => db.transaction(() async {
    final row =
        await (db.select(db.coffeeDrafts)..where(
              (t) => t.id.equals(id) & t.draftType.equals('scan_create'),
            ))
            .getSingleOrNull();
    if (row == null) throw const NotFoundFailure();
    // Once review starts, preserve edits and provenance. A fresh photo creates
    // a separate draft instead of overwriting reviewed values.
    if (row.reviewJson != null) throw const ConflictFailure();
    final revision = row.scanRevision + 1;
    await (db.update(db.coffeeDrafts)..where((t) => t.id.equals(id))).write(
      CoffeeDraftsCompanion(
        scanRevision: Value(revision),
        status: const Value('processing'),
        ocrRawText: const Value(null),
        ocrLinesJson: const Value(null),
        failureCategory: const Value(null),
        updatedAt: Value(_now),
      ),
    );
    return revision;
  });

  Future<bool> finish(
    String id,
    int revision, {
    RecognizedLabelText? result,
    AppFailure? failure,
  }) async {
    final count =
        await (db.update(db.coffeeDrafts)..where(
              (t) =>
                  t.id.equals(id) &
                  t.scanRevision.equals(revision) &
                  t.status.equals('processing'),
            ))
            .write(
              CoffeeDraftsCompanion(
                status: Value(
                  result == null ? 'failed_recoverable' : 'review_required',
                ),
                ocrRawText: Value(result?.text),
                ocrLinesJson: Value(
                  result == null
                      ? null
                      : jsonEncode(
                          result.lines.map((e) => e.toJson()).toList(),
                        ),
                ),
                failureCategory: Value(failure?.code),
                updatedAt: Value(_now),
              ),
            );
    return count == 1;
  }

  Future<void> cancel(String id) async {
    await db.customUpdate(
      "UPDATE coffee_drafts SET scan_revision = scan_revision + 1, status = 'image_ready', ocr_raw_text = NULL, ocr_lines_json = NULL, failure_category = NULL, updated_at = ? WHERE id = ? AND draft_type = 'scan_create' AND review_json IS NULL",
      variables: [Variable(_now), Variable(id)],
      updates: {db.coffeeDrafts},
    );
  }
}
