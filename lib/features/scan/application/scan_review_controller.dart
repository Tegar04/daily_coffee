import 'dart:async';

import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/coffee_draft.dart';
import '../domain/scan_review_repository.dart';

part 'scan_review_controller.g.dart';

class ScanReviewState {
  const ScanReviewState(
    this.draft, {
    this.saving = false,
    this.submitting = false,
    this.failure,
  });
  final CoffeeDraft draft;
  final bool saving;
  final bool submitting;
  final AppFailure? failure;
}

@riverpod
class ScanReviewController extends _$ScanReviewController {
  late ScanReviewRepository _repository;
  late int _revision;
  Future<void> _pending = Future.value();
  int _edit = 0;
  bool _alive = true;
  bool _failed = false;
  bool _confirming = false;

  @override
  Future<ScanReviewState> build(String id) async {
    ref.onDispose(() => _alive = false);
    _repository = await ref.watch(scanReviewRepositoryProvider.future);
    final result = await _repository.open(id);
    if (result case Err<CoffeeDraft>(:final failure)) throw failure;
    final draft = (result as Ok<CoffeeDraft>).value;
    _revision = draft.revision;
    return ScanReviewState(draft);
  }

  void change(CoffeeFormValues values, bool includePhoto) {
    final current = state.asData?.value;
    if (current == null || current.submitting || _confirming) return;
    final old = current.draft;
    final draft = CoffeeDraft(
      id: old.id,
      image: old.image,
      text: old.text,
      values: values,
      fields: old.fields,
      revision: _revision,
      includePhoto: includePhoto,
    );
    state = AsyncData(ScanReviewState(draft, saving: true));
    final edit = ++_edit;
    // Each input change is queued immediately; invalid and partial values are
    // durable too. Disposal never cancels writes already requested by the user.
    _pending = _pending.then((_) => _persist(draft, edit));
  }

  Future<void> _persist(CoffeeDraft draft, int edit) async {
    if (_failed) {
      if (_alive && edit == _edit) {
        state = AsyncData(
          ScanReviewState(draft, failure: const StorageFailure()),
        );
      }
      return;
    }
    Result<CoffeeDraft> result;
    try {
      result = await _repository.save(
        id,
        _revision,
        draft.values,
        draft.includePhoto,
      );
    } catch (error) {
      result = Err(StorageFailure(cause: error));
    }
    switch (result) {
      case Ok<CoffeeDraft>(:final value):
        _revision = value.revision;
        if (_alive && edit == _edit) {
          state = AsyncData(ScanReviewState(value, submitting: _confirming));
        }
      case Err<CoffeeDraft>(:final failure):
        _failed = true;
        if (_alive && edit == _edit) {
          state = AsyncData(ScanReviewState(draft, failure: failure));
        }
    }
  }

  Future<bool> flush() async {
    Future<void> pending;
    do {
      pending = _pending;
      await pending;
    } while (!identical(pending, _pending));
    if (!_alive) return false;
    if (_failed) {
      _failed = false;
      final draft = state.asData!.value.draft;
      _pending = _persist(draft, _edit);
      await _pending;
    }
    return !_failed;
  }

  Future<Result<Coffee>> confirm() async {
    final current = state.asData?.value;
    if (current == null || current.submitting || _confirming) {
      return const Err(ConflictFailure());
    }
    _confirming = true;
    state = AsyncData(ScanReviewState(current.draft, submitting: true));
    if (!await flush() || !_alive) {
      _confirming = false;
      return const Err(StorageFailure());
    }
    final draft = state.asData!.value.draft;
    state = AsyncData(ScanReviewState(draft, submitting: true));
    Result<Coffee> result;
    try {
      result = await _repository.promote(id, _revision);
    } catch (error) {
      result = Err(StorageFailure(cause: error));
    }
    if (_alive) {
      state = AsyncData(
        ScanReviewState(
          draft,
          failure: result is Err<Coffee> ? result.failure : null,
        ),
      );
      ref.invalidate(savedScanDraftsProvider);
    }
    _confirming = false;
    return result;
  }

  Future<bool> discard() async {
    if (_confirming) return false;
    _confirming = true;
    await _pending;
    try {
      if (!_alive) return false;
      await (await ref.read(captureServiceProvider.future)).discard(id);
      if (_alive) ref.invalidate(savedScanDraftsProvider);
      return true;
    } catch (_) {
      if (_alive) {
        state = AsyncData(
          ScanReviewState(
            state.asData!.value.draft,
            failure: const StorageFailure(),
          ),
        );
      }
      return false;
    } finally {
      _confirming = false;
    }
  }
}
