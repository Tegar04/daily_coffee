import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:daily_coffee/core/database/app_database.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/images/image_maintenance.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/features/capture/data/capture_service.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:daily_coffee/features/capture/domain/recovered_capture.dart';
import 'package:daily_coffee/features/coffee/data/drift_coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_photo_edit.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

import '../helpers/coffee_fakes.dart';
import '../helpers/database_fixtures.dart';
import '../helpers/test_doubles.dart';

class FakePicker implements PhotoPickerGateway {
  Result<String?> next = const Ok(null);
  Result<String?> lost = const Ok(null);
  Completer<Result<String?>>? gate;
  @override
  Future<Result<String?>> pick(PhotoSource source) async =>
      gate == null ? next : await gate!.future;
  @override
  Future<Result<String?>> recover() async => lost;
}

class FailingDeleteStorage extends ImageStorage {
  FailingDeleteStorage(super.root, super.processor);
  @override
  Future<void> deleteWithThumbnail(String path) async =>
      throw const FileSystemException('full or busy');
}

void main() {
  late Directory root;
  late AppDatabase db;
  late ImageStorage storage;
  late DriftCoffeeRepository repo;
  late CaptureService service;
  late FakePicker picker;
  late File fixture;
  late RandomAppIdGenerator ids;
  setUp(() async {
    root = await Directory.systemTemp.createTemp('daily_coffee_images_');
    db = AppDatabase(NativeDatabase(File('${root.path}/test.sqlite')));
    await db.initialize();
    ids = RandomAppIdGenerator(random: Random(123));
    storage = ImageStorage(root, ImageProcessor());
    repo = DriftCoffeeRepository(
      database: db,
      clock: FixedAppClock(dbTime),
      ids: ids,
      imageStorage: () async => storage,
    );
    picker = FakePicker();
    service = CaptureService(db, storage, picker, ids, FixedAppClock(dbTime));
    final image = img.Image(width: 600, height: 900);
    img.fill(image, color: img.ColorRgb8(245, 239, 222));
    img.drawString(
      image,
      'GUJI\nWASHED\nETHIOPIA',
      font: img.arial48,
      x: 30,
      y: 150,
      color: img.ColorRgb8(30, 20, 10),
    );
    fixture = await File('${root.path}/external.png')
        .writeAsBytes(img.encodePng(image));
    picker.next = Ok(fixture.path);
  });
  tearDown(() async {
    await db.close();
    await root.delete(recursive: true);
  });
  Future<ManagedImage> acquire() async => (await service.acquire(
    PhotoSource.gallery,
    targetCoffeeId: null,
    context: {
      'values': {'name': 'draft'},
      'baseline': {},
    },
  ) as Ok<ManagedImage?>).value!;

  test(
    'cover, thumbnail, metadata survive closing and reopening SQLite',
    () async {
      final image = await acquire();
      final coffee = (await repo.create(
        coffeeInput(),
        photo: CoffeePhotoEdit(replacement: image),
      ) as Ok<Coffee>).value;
      expect(coffee.photos.single.widthPixels, 600);
      expect(coffee.photos.single.heightPixels, 900);
      final cover = storage.file(coffee.photos.single.localPath);
      expect(await cover.exists(), isTrue);
      final thumb = img.decodeJpg(
        await storage
            .file('${coffee.photos.single.localPath}.thumb.jpg')
            .readAsBytes(),
      )!;
      expect(max(thumb.width, thumb.height), 480);
      expect(await storage.file(image.localPath).exists(), isFalse);
      expect(await db.select(db.coffeeDrafts).get(), isEmpty);
      await db.close();
      db = AppDatabase(NativeDatabase(File('${root.path}/test.sqlite')));
      repo = DriftCoffeeRepository(
        database: db,
        clock: FixedAppClock(dbTime),
        ids: ids,
        imageStorage: () async => storage,
      );
      final loaded =
          (await repo.watchCoffee(coffee.id).first as Ok<Coffee?>).value!;
      expect(loaded.photos.single.localPath, coffee.photos.single.localPath);
      expect(
        await storage.file(loaded.photos.single.localPath).exists(),
        isTrue,
      );
      final impact = (await repo.inspectDeleteImpact(coffee.id) as Ok).value;
      expect(await repo.delete(impact), isA<Ok<void>>());
      expect(await cover.exists(), isFalse);
      expect(
        await storage
            .file('${coffee.photos.single.localPath}.thumb.jpg')
            .exists(),
        isFalse,
      );
    },
  );

  test(
    'replace/remove only after commit; stale photo edit cannot overwrite',
    () async {
      final first = await acquire();
      final coffee = (await repo.create(
        coffeeInput(),
        photo: CoffeePhotoEdit(replacement: first),
      ) as Ok<Coffee>).value;
      final second = await acquire();
      final updated = (await repo.update(
        coffee.id,
        coffeeInput(),
        expected: coffee.toFormValues(),
        photo: CoffeePhotoEdit(replacement: second, expectedPhotoId: first.id),
      ) as Ok<Coffee>).value;
      expect(
        await storage.file(coffee.photos.single.localPath).exists(),
        isFalse,
      );
      expect(updated.photos.single.id, second.id);
      final stale = await repo.update(
        coffee.id,
        coffeeInput(),
        expected: coffee.toFormValues(),
        photo: CoffeePhotoEdit(expectedPhotoId: first.id),
      );
      expect(stale, isA<Err<Coffee>>());
      expect(
        await storage.file(updated.photos.single.localPath).exists(),
        isTrue,
      );
      final removed = (await repo.update(
        coffee.id,
        coffeeInput(),
        expected: updated.toFormValues(),
        photo: CoffeePhotoEdit(expectedPhotoId: second.id),
      ) as Ok<Coffee>).value;
      expect(removed.photos, isEmpty);
    },
  );

  test('database failure rolls back coffee and permanent candidate, retains retry image', () async {
    final image = await acquire();
    await db.customStatement(
      "CREATE TRIGGER reject_photo BEFORE INSERT ON coffee_photos BEGIN SELECT RAISE(ABORT, 'test rollback'); END",
    );
    final result = await repo.create(
      coffeeInput(),
      photo: CoffeePhotoEdit(replacement: image),
    );
    expect(result, isA<Err<Coffee>>());
    expect(await db.select(db.coffees).get(), isEmpty);
    expect(await storage.file(image.localPath).exists(), isTrue);
    final files = await Directory('${root.path}/photos')
        .list(recursive: true)
        .where((e) => e is File)
        .toList();
    expect(files, isEmpty);
    await db.customStatement('DROP TRIGGER reject_photo');
    expect(
      await repo.create(
        coffeeInput(),
        photo: CoffeePhotoEdit(replacement: image),
      ),
      isA<Ok<Coffee>>(),
    );
  });

  test('missing candidate file prevents database creation; manual remains available', () async {
    final image = await acquire();
    await storage.delete(image.localPath);
    expect(
      await repo.create(
        coffeeInput(),
        photo: CoffeePhotoEdit(replacement: image),
      ),
      isA<Err<Coffee>>(),
    );
    expect(await db.select(db.coffees).get(), isEmpty);
    expect(await repo.create(coffeeInput()), isA<Ok<Coffee>>());
  });

  test(
    'cleanup failure persists task; retry never deletes referenced cover',
    () async {
      final image = await acquire();
      final coffee = (await repo.create(
        coffeeInput(),
        photo: CoffeePhotoEdit(replacement: image),
      ) as Ok<Coffee>).value;
      final path = coffee.photos.single.localPath;
      await db
          .into(db.fileCleanupTasks)
          .insert(
            FileCleanupTasksCompanion.insert(
              id: dbId(99),
              localPath: path,
              createdAt: 1,
            ),
          );
      await ImageMaintenance(db, storage).runQueue();
      expect(await storage.file(path).exists(), isTrue);
      storage = FailingDeleteStorage(root, ImageProcessor());
      final impact = (await repo.inspectDeleteImpact(coffee.id) as Ok).value;
      expect(await repo.delete(impact), isA<Ok<void>>());
      expect(await db.select(db.coffees).get(), isEmpty);
      expect(await db.select(db.fileCleanupTasks).get(), isNotEmpty);
      storage = ImageStorage(root, ImageProcessor());
      await ImageMaintenance(db, storage).runQueue();
      expect(await storage.file(path).exists(), isFalse);
      expect(await db.select(db.fileCleanupTasks).get(), isEmpty);
    },
  );

  test('cancel and permission denial leave no coffee or draft', () async {
    for (final result in <Result<String?>>[
      const Ok(null),
      const Err(PermissionDeniedFailure()),
    ]) {
      picker.next = result;
      await service.acquire(
        PhotoSource.camera,
        targetCoffeeId: null,
        context: {},
      );
      expect(await db.select(db.coffees).get(), isEmpty);
      expect(await db.select(db.coffeeDrafts).get(), isEmpty);
    }
  });

  test(
    'invalid image cleans failed draft and allows a later acquisition',
    () async {
      final invalid = await File('${root.path}/invalid.jpg')
          .writeAsBytes([1, 2, 3]);
      picker.next = Ok(invalid.path);
      final result = await service.acquire(
        PhotoSource.gallery,
        targetCoffeeId: null,
        context: {},
      );
      expect(
        (result as Err<ManagedImage?>).failure,
        isA<ImageValidationFailure>(),
      );
      expect(await db.select(db.coffeeDrafts).get(), isEmpty);
      expect(await storage.readJson(CaptureService.pendingPath), isNull);
      picker.next = Ok(fixture.path);
      expect(await acquire(), isA<ManagedImage>());
    },
  );

  test('lost picker result resumes exact draft and context, never creates coffee', () async {
    picker.gate = Completer<Result<String?>>();
    final interrupted = service.acquire(
      PhotoSource.gallery,
      targetCoffeeId: null,
      context: {'test': 'checkpoint'},
    );
    while (await storage.readJson(CaptureService.pendingPath) == null) {
      await Future<void>.delayed(const Duration(milliseconds: 5));
    }
    final recoveryPicker = FakePicker()..lost = Ok(fixture.path);
    final recoveredService = CaptureService(
      db,
      storage,
      recoveryPicker,
      ids,
      FixedAppClock(dbTime),
    );
    final result =
        await recoveredService.recover() as Ok<List<RecoveredCapture>>;
    expect(result.value.single.context['test'], 'checkpoint');
    expect(await db.select(db.coffees).get(), isEmpty);
    // Complete the simulated old process only after assertions, without a save.
    picker.gate!.complete(const Ok(null));
    await interrupted;
  });

  test(
    'unassociated lost result is never attached to a coffee or draft',
    () async {
      picker.lost = Ok(fixture.path);
      final result = await service.recover() as Ok<List<RecoveredCapture>>;
      expect(result.value, isEmpty);
      expect(await db.select(db.coffeeDrafts).get(), isEmpty);
    },
  );

  test(
    'static WebP is accepted even though decoder reports zero animation frames',
    () {
      final bytes = base64Decode(
        'UklGRiIAAABXRUJQVlA4IBYAAAAwAQCdASoBAAEADsD+JaQAA3AAAAAA',
      );
      final result = ImageProcessor.normalize(bytes);
      expect(result.width, 1);
      expect(result.height, 1);
    },
  );

  test(
    'orphan sweep retains referenced draft bundles and recent files',
    () async {
      final image = await acquire();
      final old = DateTime.now().subtract(const Duration(days: 3));
      final original = storage.file(image.localPath);
      final context = storage.file('drafts/${image.id}/context.json');
      await original.setLastModified(old);
      await context.setLastModified(old);
      final orphan = storage.file('photos/orphan/unused.jpg');
      await orphan.parent.create(recursive: true);
      await orphan.writeAsBytes([1]);
      await orphan.setLastModified(old);
      final recent = storage.file('photos/orphan/recent.jpg');
      await recent.writeAsBytes([1]);
      await ImageMaintenance(db, storage).sweep(DateTime.now());
      expect(await original.exists(), isTrue);
      expect(await context.exists(), isTrue);
      expect(await orphan.exists(), isFalse);
      expect(await recent.exists(), isTrue);
    },
  );

  test(
    'oversized encoded input and JPEG dimensions are rejected before decode',
    () {
      expect(
        () => ImageProcessor.normalize(
          Uint8List(ImageProcessor.maxInputBytes + 1),
        ),
        throwsA(isA<ImageValidationFailure>()),
      );
      final jpeg = img.encodeJpg(img.Image(width: 10, height: 10));
      var changed = false;
      for (var i = 0; i < jpeg.length - 9; i++) {
        if (jpeg[i] == 255 && jpeg[i + 1] == 192) {
          jpeg[i + 5] = 255;
          jpeg[i + 6] = 255;
          jpeg[i + 7] = 255;
          jpeg[i + 8] = 255;
          changed = true;
          break;
        }
      }
      expect(changed, isTrue);
      expect(
        () => ImageProcessor.normalize(jpeg),
        throwsA(isA<ImageValidationFailure>()),
      );
    },
  );

  test('reject traversal, invalid content, excessive dimensions and normalize EXIF', () async {
    for (final path in [
      '/tmp/a',
      '../a',
      'photos/../x',
      'C:/photo.jpg',
      'photos//a',
    ]) {
      expect(() => storage.file(path), throwsA(isA<ImageValidationFailure>()));
    }
    expect(
      () => ImageProcessor.normalize(Uint8List.fromList([1, 2, 3])),
      throwsA(isA<ImageValidationFailure>()),
    );
    final portrait = img.Image(width: 40, height: 80);
    portrait.exif.imageIfd.orientation = 6;
    final normalized = ImageProcessor.normalize(img.encodeJpg(portrait));
    expect(normalized.width, 80);
    expect(normalized.height, 40);
    expect(
      img.decodeJpg(normalized.cover)!.exif.imageIfd.hasOrientation,
      isFalse,
    );
    final large = img.Image(width: 2600, height: 1600);
    final resized = ImageProcessor.normalize(img.encodePng(large));
    expect(resized.width, 2400);
    expect(resized.height, lessThan(1600));
  });
}
