import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/image_maintenance.dart';
import 'package:daily_coffee/core/images/image_processor.dart';
import 'package:daily_coffee/core/images/image_storage.dart';
import 'package:daily_coffee/features/capture/data/capture_service.dart';
import 'package:daily_coffee/features/capture/data/system_photo_picker.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:daily_coffee/features/capture/domain/recovered_capture.dart';
import 'package:flutter/painting.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_providers.dart';
import 'database_providers.dart';

part 'image_providers.g.dart';

Duration? noImageRetry(int count, Object error) => null;

@Riverpod(keepAlive: true, retry: noImageRetry)
Future<ImageStorage> imageStorage(Ref ref) async =>
    ImageStorage(await getApplicationSupportDirectory(), ImageProcessor());

@Riverpod(keepAlive: true, retry: noImageRetry)
PhotoPickerGateway photoPickerGateway(Ref ref) => SystemPhotoPicker();

@Riverpod(keepAlive: true, retry: noImageRetry)
Future<CaptureService> captureService(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final picker = ref.watch(photoPickerGatewayProvider);
  final ids = ref.watch(appIdGeneratorProvider);
  final clock = ref.watch(appClockProvider);
  final storage = await ref.watch(imageStorageProvider.future);
  // Finish startup maintenance before exposing acquisition. Later recovery
  // refreshes never race an orphan sweep against active file preparation.
  final maintenance = ImageMaintenance(db, storage);
  try {
    await maintenance.runQueue();
    await maintenance.sweep(clock.now());
  } catch (_) {
    /* Maintenance must not disable acquisition or manual entry. */
  }
  return CaptureService(db, storage, picker, ids, clock);
}

@Riverpod(keepAlive: true, retry: noImageRetry)
Future<List<RecoveredCapture>> recoveredCaptures(Ref ref) async {
  try {
    final service = await ref.watch(captureServiceProvider.future);
    final recovered = await service.recover();
    return switch (recovered) {
      Ok<List<RecoveredCapture>>(:final value) => value,
      Err<List<RecoveredCapture>>(:final failure) => throw failure,
    };
  } catch (_) {
    rethrow;
  }
}

@riverpod
Future<ImageProvider<Object>?> managedPhoto(
  Ref ref,
  String path, {
  bool thumbnail = false,
}) async {
  try {
    final storage = await ref.watch(imageStorageProvider.future);
    final file = storage.file(thumbnail ? '$path.thumb.jpg' : path);
    if (!await file.exists()) {
      if (!thumbnail) return null;
      final original = storage.file(path);
      if (!await original.exists() ||
          await original.length() > ImageProcessor.maxInputBytes) {
        return null;
      }
      final processed = await storage.processor.process(
        await original.readAsBytes(),
      );
      await file.writeAsBytes(processed.thumbnail, flush: true);
    }
    return ResizeImage(
      FileImage(file),
      width: thumbnail ? 480 : 1200,
      allowUpscaling: false,
    );
  } catch (_) {
    return null;
  }
}
