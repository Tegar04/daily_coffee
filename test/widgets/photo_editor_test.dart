import 'dart:io';

import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/features/capture/data/capture_service.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:daily_coffee/features/capture/presentation/coffee_photo_editor.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_photo_edit.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_doubles.dart';

class _Picker implements PhotoPickerGateway {
  @override
  Future<Result<String?>> pick(PhotoSource source) async => const Ok(null);
  @override
  Future<Result<String?>> recover() async => const Ok(null);
}

class _Service extends CaptureService {
  _Service(AppDatabase db)
    : super(
        db,
        ImageStorage(Directory.systemTemp, ImageProcessor()),
        _Picker(),
        SequenceAppIdGenerator([]),
        FixedAppClock(DateTime.utc(2026)),
      );
  Result<ManagedImage?> result = const Ok(null);
  final discarded = <String>[];
  @override
  Future<Result<ManagedImage?>> acquire(
    PhotoSource source, {
    required String? targetCoffeeId,
    required Map<String, Object?> context,
  }) async => result;
  @override
  Future<void> discard(String id) async {
    discarded.add(id);
  }
}

void main() {
  const image = ManagedImage(
    id: 'test',
    localPath: 'drafts/test/cover.jpg',
    width: 300,
    height: 400,
    byteSize: 100,
    source: 'gallery',
  );
  testWidgets(
    'cancel/denial preserves optional flow; preview needs explicit confirmation',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final service = _Service(db);
      addTearDown(db.close);
      CoffeePhotoEdit? edit;
      var busy = false;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            captureServiceProvider.overrideWith((ref) async => service),
            recoveredCapturesProvider.overrideWith((ref) async => []),
            managedPhotoProvider(image.localPath)
                .overrideWith((ref) async => null),
          ],
          child: MaterialApp(
            theme: DailyTheme.light,
            home: Scaffold(
              body: SingleChildScrollView(
                child: StatefulBuilder(
                  builder: (context, setState) => CoffeePhotoEditor(
                    targetCoffeeId: null,
                    initialPath: null,
                    initialPhotoId: null,
                    edit: edit,
                    checkpoint: () => {},
                    onChanged: (value) => setState(() => edit = value),
                    onBusy: (value) => busy = value,
                    onRestore: (_) {},
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pilih dari galeri'));
      await tester.pumpAndSettle();
      expect(edit, isNull);
      expect(busy, isFalse);
      service.result = const Err(PermissionDeniedFailure());
      await tester.tap(find.text('Ambil foto'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Akses foto/kamera ditolak'), findsOneWidget);
      expect(edit, isNull);
      expect(busy, isFalse);
      service.result = const Ok(image);
      await tester.tap(find.text('Pilih dari galeri'));
      await tester.pumpAndSettle();
      expect(find.text('Periksa foto'), findsOneWidget);
      expect(edit, isNull);
      await tester.ensureVisible(find.text('Ambil / pilih ulang'));
      await tester.tap(find.text('Ambil / pilih ulang'));
      await tester.pumpAndSettle();
      expect(service.discarded, ['test']);
      expect(edit, isNull);
      await tester.tap(find.text('Pilih dari galeri'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Gunakan foto'));
      await tester.tap(find.text('Gunakan foto'));
      await tester.pumpAndSettle();
      expect(edit!.replacement, image);
      expect(busy, isFalse);
      expect(find.text('Hapus foto'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
  testWidgets(
    'reselect preserves the recovered cover revision for conflict detection',
    (tester) async {
      final db = AppDatabase(NativeDatabase.memory());
      final service = _Service(db)..result = const Ok(image);
      addTearDown(db.close);
      CoffeePhotoEdit? result;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            captureServiceProvider.overrideWith((ref) async => service),
            recoveredCapturesProvider.overrideWith((ref) async => []),
            managedPhotoProvider(image.localPath)
                .overrideWith((ref) async => null),
          ],
          child: MaterialApp(
            theme: DailyTheme.light,
            home: Scaffold(
              body: CoffeePhotoEditor(
                targetCoffeeId: 'coffee',
                initialPath: null,
                initialPhotoId: 'concurrently-replaced-cover',
                edit: const CoffeePhotoEdit(
                  expectedPhotoId: 'recovered-old-cover',
                ),
                checkpoint: () => {},
                onChanged: (value) => result = value,
                onBusy: (_) {},
                onRestore: (_) {},
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Pilih dari galeri'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Gunakan foto'));
      await tester.tap(find.text('Gunakan foto'));
      await tester.pumpAndSettle();
      expect(result!.expectedPhotoId, 'recovered-old-cover');
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
