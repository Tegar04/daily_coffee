import 'dart:async';

import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/recognized_label_text.dart';

part 'scan_controller.g.dart';

enum ScanPhase { idle, acquiring, processing, success, failure, cancelled }

class ScanState {
  const ScanState({
    this.phase = ScanPhase.idle,
    this.image,
    this.result,
    this.failure,
  });
  final ScanPhase phase;
  final ManagedImage? image;
  final RecognizedLabelText? result;
  final AppFailure? failure;
  bool get busy =>
      phase == ScanPhase.acquiring || phase == ScanPhase.processing;
}

@riverpod
Duration scanTimeout(Ref ref) => const Duration(seconds: 30);

@riverpod
class ScanController extends _$ScanController {
  int _operation = 0;
  bool _alive = true;
  bool _cancelling = false;
  @override
  ScanState build() {
    ref.onDispose(() {
      _alive = false;
      _operation++;
    });
    return const ScanState();
  }

  bool _active(int operation) => _alive && operation == _operation;

  void restore(ScanDraft draft) {
    if (state.busy || _cancelling) return;
    _operation++;
    state = ScanState(
      image: draft.image,
      result: draft.result,
      phase: draft.result == null ? ScanPhase.cancelled : ScanPhase.success,
    );
  }

  Future<void> acquire(PhotoSource source) async {
    if (state.busy || _cancelling) return;
    final operation = ++_operation;
    state = const ScanState(phase: ScanPhase.acquiring);
    try {
      final service = await ref.read(captureServiceProvider.future);
      if (!_active(operation)) return;
      final result = await service.acquire(
        source,
        targetCoffeeId: null,
        context: const {'purpose': 'scan'},
        forScan: true,
      );
      // A completed native acquisition remains a recoverable draft on exit.
      if (!_active(operation)) {
        if (_alive) ref.invalidate(savedScanDraftsProvider);
        return;
      }
      ref.invalidate(savedScanDraftsProvider);
      switch (result) {
        case Ok<ManagedImage?>(value: final image?):
          state = ScanState(image: image);
          await retry();
        case Ok<ManagedImage?>():
          state = const ScanState(phase: ScanPhase.cancelled);
        case Err<ManagedImage?>(:final failure):
          state = ScanState(phase: ScanPhase.failure, failure: failure);
      }
    } catch (error) {
      if (_active(operation)) {
        state = ScanState(phase: ScanPhase.failure, failure: _failure(error));
      }
    }
  }

  Future<void> retry() async {
    final image = state.image;
    if (state.busy || _cancelling || image == null) return;
    final operation = ++_operation;
    final timeout = ref.read(scanTimeoutProvider);
    state = ScanState(phase: ScanPhase.processing, image: image);
    try {
      final store = await ref.read(scanDraftStoreProvider.future);
      if (!_active(operation)) return;
      final revision = await store.begin(image.id);
      if (!_active(operation)) return;
      final recognizer = await ref.read(labelTextRecognizerProvider.future);
      if (!_active(operation)) return;
      final result = await recognizer
          .recognize(image)
          .timeout(
            timeout,
            onTimeout: () => const Err(
              OcrUnavailableFailure(diagnosticContext: {'reason': 'timeout'}),
            ),
          );
      if (!_active(operation)) return;
      final text = switch (result) {
        Ok<RecognizedLabelText>(:final value) => value,
        _ => null,
      };
      final failure = switch (result) {
        Err<RecognizedLabelText>(:final failure) => failure,
        _ => null,
      };
      final saved = await store.finish(
        image.id,
        revision,
        result: text,
        failure: failure,
      );
      if (!_active(operation)) return;
      if (!saved) throw const ConflictFailure();
      state = ScanState(
        phase: text == null ? ScanPhase.failure : ScanPhase.success,
        image: image,
        result: text,
        failure: failure,
      );
      ref.invalidate(savedScanDraftsProvider);
    } catch (error) {
      if (_active(operation)) {
        state = ScanState(
          phase: ScanPhase.failure,
          image: image,
          failure: _failure(error),
        );
      }
    }
  }

  Future<void> cancel() async {
    final image = state.image;
    final operation = ++_operation;
    state = ScanState(phase: ScanPhase.cancelled, image: image);
    if (image == null) return;
    _cancelling = true;
    try {
      await (await ref.read(scanDraftStoreProvider.future)).cancel(image.id);
      if (_active(operation)) ref.invalidate(savedScanDraftsProvider);
    } catch (error) {
      if (_active(operation)) {
        state = ScanState(
          phase: ScanPhase.failure,
          image: image,
          failure: _failure(error),
        );
      }
    } finally {
      _cancelling = false;
    }
  }

  Future<void> discard(ScanDraft draft) async {
    if (state.busy || _cancelling) return;
    try {
      await (await ref.read(captureServiceProvider.future))
          .discard(draft.image.id);
      if (!_alive) return;
      if (state.image?.id == draft.image.id) state = const ScanState();
      ref.invalidate(savedScanDraftsProvider);
    } catch (error) {
      if (_alive) {
        state = ScanState(
          phase: ScanPhase.failure,
          image: state.image,
          failure: _failure(error),
        );
      }
    }
  }

  AppFailure _failure(Object error) =>
      error is AppFailure ? error : StorageFailure(cause: error);
}
