// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_review_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScanReviewController)
final scanReviewControllerProvider = ScanReviewControllerFamily._();

final class ScanReviewControllerProvider
    extends $AsyncNotifierProvider<ScanReviewController, ScanReviewState> {
  ScanReviewControllerProvider._({
    required ScanReviewControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'scanReviewControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$scanReviewControllerHash();

  @override
  String toString() {
    return r'scanReviewControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ScanReviewController create() => ScanReviewController();

  @override
  bool operator ==(Object other) {
    return other is ScanReviewControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$scanReviewControllerHash() =>
    r'85b4eb2848f6aae1ac6887fc4ddb13216824a30c';

final class ScanReviewControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ScanReviewController,
          AsyncValue<ScanReviewState>,
          ScanReviewState,
          FutureOr<ScanReviewState>,
          String
        > {
  ScanReviewControllerFamily._()
    : super(
        retry: null,
        name: r'scanReviewControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ScanReviewControllerProvider call(String id) =>
      ScanReviewControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'scanReviewControllerProvider';
}

abstract class _$ScanReviewController extends $AsyncNotifier<ScanReviewState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ScanReviewState> build(String id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ScanReviewState>, ScanReviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ScanReviewState>, ScanReviewState>,
              AsyncValue<ScanReviewState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
