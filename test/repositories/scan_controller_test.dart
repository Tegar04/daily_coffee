import 'dart:async';
import 'dart:io';

import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/features/scan/application/scan_controller.dart';
import 'package:daily_coffee/features/scan/data/scan_draft_store.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/database_fixtures.dart';
import '../helpers/test_doubles.dart';

class DeferredRecognizer implements LabelTextRecognizer {
  final calls = <Completer<Result<RecognizedLabelText>>>[];
  @override
  Future<Result<RecognizedLabelText>> recognize(ManagedImage image) {
    final completer = Completer<Result<RecognizedLabelText>>();
    calls.add(completer);
    return completer.future;
  }
}

void main() {
  late Directory dir;
  late AppDatabase db;
  late ProviderContainer container;
  late DeferredRecognizer recognizer;
  late ScanController controller;
  setUp(() async {
    dir = await Directory.systemTemp.createTemp('scan_controller_');
    db = AppDatabase(NativeDatabase.memory());
    await db
        .into(db.coffeeDrafts)
        .insert(
          CoffeeDraftsCompanion.insert(
            id: dbId(1),
            draftType: 'scan_create',
            status: 'image_ready',
            temporaryImagePath: Value('drafts/${dbId(1)}/cover.jpg'),
            imageMimeType: const Value('image/jpeg'),
            createdAt: dbTime.microsecondsSinceEpoch,
            updatedAt: dbTime.microsecondsSinceEpoch,
          ),
        );
    recognizer = DeferredRecognizer();
    container = ProviderContainer(
      overrides: [
        labelTextRecognizerProvider.overrideWith((ref) async => recognizer),
        scanDraftStoreProvider.overrideWith(
          (ref) async => ScanDraftStore(
            db,
            ImageStorage(dir, ImageProcessor()),
            FixedAppClock(dbTime),
          ),
        ),
        scanTimeoutProvider.overrideWith(
          (ref) => const Duration(milliseconds: 80),
        ),
      ],
    );
    container.listen(scanControllerProvider, (_, _) {});
    controller = container.read(scanControllerProvider.notifier);
    controller.restore(
      ScanDraft(
        ManagedImage(
          id: dbId(1),
          localPath: 'drafts/${dbId(1)}/cover.jpg',
          width: 100,
          height: 100,
          byteSize: 100,
          source: 'gallery',
        ),
        null,
      ),
    );
  });
  tearDown(() async {
    container.dispose();
    await db.close();
    await dir.delete(recursive: true);
  });
  Future<void> waitForCall() async {
    for (var i = 0; recognizer.calls.isEmpty && i < 100; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 1));
    }
    expect(recognizer.calls, hasLength(1));
  }

  test('cancel ignores native completion and creates no coffee', () async {
    final pending = controller.retry();
    await waitForCall();
    await controller.cancel();
    recognizer.calls.single.complete(
      const Ok(RecognizedLabelText('STALE', [])),
    );
    await pending;
    expect(container.read(scanControllerProvider).phase, ScanPhase.cancelled);
    expect((await db.select(db.coffeeDrafts).getSingle()).ocrRawText, isNull);
    expect(await db.select(db.coffees).get(), isEmpty);
  });
  test('timeout remains failure even after native late success', () async {
    final pending = controller.retry();
    await waitForCall();
    await pending;
    expect(container.read(scanControllerProvider).phase, ScanPhase.failure);
    recognizer.calls.single.complete(const Ok(RecognizedLabelText('LATE', [])));
    await Future<void>.delayed(Duration.zero);
    expect((await db.select(db.coffeeDrafts).getSingle()).ocrRawText, isNull);
    expect(
      (await db.select(db.coffeeDrafts).getSingle()).status,
      'failed_recoverable',
    );
  });
  test('double retry starts one native operation', () async {
    final pending = controller.retry();
    await waitForCall();
    await controller.retry();
    expect(recognizer.calls, hasLength(1));
    recognizer.calls.single.complete(const Ok(RecognizedLabelText('GAYO', [])));
    await pending;
    expect(container.read(scanControllerProvider).phase, ScanPhase.success);
  });
}
