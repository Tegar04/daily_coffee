import 'package:daily_coffee/features/scan/data/drift_scan_review_repository.dart';
import 'package:daily_coffee/features/scan/data/mlkit_label_text_recognizer.dart';
import 'package:daily_coffee/features/scan/data/scan_draft_store.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:daily_coffee/features/scan/domain/scan_review_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_providers.dart';
import 'coffee_providers.dart';
import 'database_providers.dart';
import 'image_providers.dart';

part 'scan_providers.g.dart';

@Riverpod(keepAlive: true, retry: noImageRetry)
Future<ScanReviewRepository> scanReviewRepository(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final clock = ref.watch(appClockProvider);
  final ids = ref.watch(appIdGeneratorProvider);
  final coffees = ref.watch(driftCoffeeRepositoryProvider);
  final storage = await ref.watch(imageStorageProvider.future);
  return DriftScanReviewRepository(db, storage, clock, ids, coffees);
}

@Riverpod(keepAlive: true, retry: noImageRetry)
Future<LabelTextRecognizer> labelTextRecognizer(Ref ref) async =>
    MlkitLabelTextRecognizer(await ref.watch(imageStorageProvider.future));

@Riverpod(keepAlive: true, retry: noImageRetry)
Future<ScanDraftStore> scanDraftStore(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final clock = ref.watch(appClockProvider);
  final storage = await ref.watch(imageStorageProvider.future);
  return ScanDraftStore(db, storage, clock);
}

@riverpod
Future<List<ScanDraft>> savedScanDrafts(Ref ref) async {
  // Resolve native lost-data ownership before listing scan drafts.
  await ref.watch(recoveredCapturesProvider.future);
  return (await ref.watch(scanDraftStoreProvider.future)).load();
}
