import 'package:daily_coffee/features/scan/data/ai_connection_service.dart';
import 'package:daily_coffee/features/scan/data/ai_connection_store.dart';
import 'package:daily_coffee/features/scan/data/backend_label_extractor.dart';
import 'package:daily_coffee/features/scan/data/configured_label_extractor.dart';
import 'package:daily_coffee/features/scan/data/drift_scan_review_repository.dart';
import 'package:daily_coffee/features/scan/data/mlkit_label_text_recognizer.dart';
import 'package:daily_coffee/features/scan/data/scan_draft_store.dart';
import 'package:daily_coffee/features/scan/domain/label_extractor.dart';
import 'package:daily_coffee/features/scan/domain/recognized_label_text.dart';
import 'package:daily_coffee/features/scan/domain/scan_review_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
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

@Riverpod(keepAlive: true)
AiConnectionStore aiConnectionStore(Ref ref) =>
    const SecureAiConnectionStore(FlutterSecureStorage());

@Riverpod(keepAlive: true)
AiConnectionService aiConnectionService(Ref ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return AiConnectionService(ref.watch(aiConnectionStoreProvider), client);
}

@Riverpod(keepAlive: true)
LabelExtractor labelExtractor(Ref ref) {
  const configured = String.fromEnvironment(
    'COFFEE_API_URL',
    defaultValue: kDebugMode
        ? 'http://127.0.0.1:8000/api/coffee-label/extract'
        : '',
  );
  final uri = Uri.tryParse(configured);
  final allowed =
      uri != null &&
      uri.host.isNotEmpty &&
      uri.userInfo.isEmpty &&
      !uri.hasQuery &&
      !uri.hasFragment &&
      (uri.scheme == 'https' ||
          (kDebugMode &&
              uri.scheme == 'http' &&
              ['127.0.0.1', 'localhost'].contains(uri.host)));
  final client = http.Client();
  ref.onDispose(client.close);
  return ConfiguredLabelExtractor(
    ref.watch(aiConnectionStoreProvider),
    client,
    BackendLabelExtractor(client, allowed ? uri : null),
  );
}
