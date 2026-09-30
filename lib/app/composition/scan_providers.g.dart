// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(scanReviewRepository)
final scanReviewRepositoryProvider = ScanReviewRepositoryProvider._();

final class ScanReviewRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScanReviewRepository>,
          ScanReviewRepository,
          FutureOr<ScanReviewRepository>
        >
    with
        $FutureModifier<ScanReviewRepository>,
        $FutureProvider<ScanReviewRepository> {
  ScanReviewRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'scanReviewRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanReviewRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ScanReviewRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScanReviewRepository> create(Ref ref) {
    return scanReviewRepository(ref);
  }
}

String _$scanReviewRepositoryHash() =>
    r'1f29c18ef91776917af3bed99a25929e56bef1ed';

@ProviderFor(labelTextRecognizer)
final labelTextRecognizerProvider = LabelTextRecognizerProvider._();

final class LabelTextRecognizerProvider
    extends
        $FunctionalProvider<
          AsyncValue<LabelTextRecognizer>,
          LabelTextRecognizer,
          FutureOr<LabelTextRecognizer>
        >
    with
        $FutureModifier<LabelTextRecognizer>,
        $FutureProvider<LabelTextRecognizer> {
  LabelTextRecognizerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'labelTextRecognizerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelTextRecognizerHash();

  @$internal
  @override
  $FutureProviderElement<LabelTextRecognizer> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LabelTextRecognizer> create(Ref ref) {
    return labelTextRecognizer(ref);
  }
}

String _$labelTextRecognizerHash() =>
    r'b92af702ae54ecdaba235d603282b7982f47d415';

@ProviderFor(scanDraftStore)
final scanDraftStoreProvider = ScanDraftStoreProvider._();

final class ScanDraftStoreProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScanDraftStore>,
          ScanDraftStore,
          FutureOr<ScanDraftStore>
        >
    with $FutureModifier<ScanDraftStore>, $FutureProvider<ScanDraftStore> {
  ScanDraftStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'scanDraftStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanDraftStoreHash();

  @$internal
  @override
  $FutureProviderElement<ScanDraftStore> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScanDraftStore> create(Ref ref) {
    return scanDraftStore(ref);
  }
}

String _$scanDraftStoreHash() => r'8439994fa9fc62e3c866cdef296943a585bfd308';

@ProviderFor(savedScanDrafts)
final savedScanDraftsProvider = SavedScanDraftsProvider._();

final class SavedScanDraftsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScanDraft>>,
          List<ScanDraft>,
          FutureOr<List<ScanDraft>>
        >
    with $FutureModifier<List<ScanDraft>>, $FutureProvider<List<ScanDraft>> {
  SavedScanDraftsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savedScanDraftsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savedScanDraftsHash();

  @$internal
  @override
  $FutureProviderElement<List<ScanDraft>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScanDraft>> create(Ref ref) {
    return savedScanDrafts(ref);
  }
}

String _$savedScanDraftsHash() => r'c70b7a3c5c8a7f7ef85534581af21c85b1735a9d';

@ProviderFor(aiConnectionStore)
final aiConnectionStoreProvider = AiConnectionStoreProvider._();

final class AiConnectionStoreProvider
    extends
        $FunctionalProvider<
          AiConnectionStore,
          AiConnectionStore,
          AiConnectionStore
        >
    with $Provider<AiConnectionStore> {
  AiConnectionStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiConnectionStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiConnectionStoreHash();

  @$internal
  @override
  $ProviderElement<AiConnectionStore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiConnectionStore create(Ref ref) {
    return aiConnectionStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiConnectionStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiConnectionStore>(value),
    );
  }
}

String _$aiConnectionStoreHash() => r'44906ee0afbf551a13d7835519b57ac8a6cdb113';

@ProviderFor(aiConnectionService)
final aiConnectionServiceProvider = AiConnectionServiceProvider._();

final class AiConnectionServiceProvider
    extends
        $FunctionalProvider<
          AiConnectionService,
          AiConnectionService,
          AiConnectionService
        >
    with $Provider<AiConnectionService> {
  AiConnectionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiConnectionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiConnectionServiceHash();

  @$internal
  @override
  $ProviderElement<AiConnectionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiConnectionService create(Ref ref) {
    return aiConnectionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiConnectionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiConnectionService>(value),
    );
  }
}

String _$aiConnectionServiceHash() =>
    r'012fc74106d6125aeedcc2cf71d7d6e34d859eda';

@ProviderFor(labelExtractor)
final labelExtractorProvider = LabelExtractorProvider._();

final class LabelExtractorProvider
    extends $FunctionalProvider<LabelExtractor, LabelExtractor, LabelExtractor>
    with $Provider<LabelExtractor> {
  LabelExtractorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'labelExtractorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$labelExtractorHash();

  @$internal
  @override
  $ProviderElement<LabelExtractor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LabelExtractor create(Ref ref) {
    return labelExtractor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LabelExtractor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LabelExtractor>(value),
    );
  }
}

String _$labelExtractorHash() => r'59e6758dd3f23bc34d3e6aabfd8cf045c6e9d2a7';
