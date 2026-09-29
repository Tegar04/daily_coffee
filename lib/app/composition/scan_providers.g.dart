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
