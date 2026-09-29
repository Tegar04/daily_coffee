// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageStorage)
final imageStorageProvider = ImageStorageProvider._();

final class ImageStorageProvider
    extends
        $FunctionalProvider<
          AsyncValue<ImageStorage>,
          ImageStorage,
          FutureOr<ImageStorage>
        >
    with $FutureModifier<ImageStorage>, $FutureProvider<ImageStorage> {
  ImageStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'imageStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageStorageHash();

  @$internal
  @override
  $FutureProviderElement<ImageStorage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ImageStorage> create(Ref ref) {
    return imageStorage(ref);
  }
}

String _$imageStorageHash() => r'97b75f6d591525fe3e8599aeeef61a559e26a390';

@ProviderFor(photoPickerGateway)
final photoPickerGatewayProvider = PhotoPickerGatewayProvider._();

final class PhotoPickerGatewayProvider
    extends
        $FunctionalProvider<
          PhotoPickerGateway,
          PhotoPickerGateway,
          PhotoPickerGateway
        >
    with $Provider<PhotoPickerGateway> {
  PhotoPickerGatewayProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'photoPickerGatewayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoPickerGatewayHash();

  @$internal
  @override
  $ProviderElement<PhotoPickerGateway> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PhotoPickerGateway create(Ref ref) {
    return photoPickerGateway(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoPickerGateway value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoPickerGateway>(value),
    );
  }
}

String _$photoPickerGatewayHash() =>
    r'fbadb99d81abbddb5ae05e014cea70854bd2d74f';

@ProviderFor(captureService)
final captureServiceProvider = CaptureServiceProvider._();

final class CaptureServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<CaptureService>,
          CaptureService,
          FutureOr<CaptureService>
        >
    with $FutureModifier<CaptureService>, $FutureProvider<CaptureService> {
  CaptureServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'captureServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$captureServiceHash();

  @$internal
  @override
  $FutureProviderElement<CaptureService> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CaptureService> create(Ref ref) {
    return captureService(ref);
  }
}

String _$captureServiceHash() => r'fda6adff99b8a8a2a0c512ec8ca80624484f0d4c';

@ProviderFor(recoveredCaptures)
final recoveredCapturesProvider = RecoveredCapturesProvider._();

final class RecoveredCapturesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RecoveredCapture>>,
          List<RecoveredCapture>,
          FutureOr<List<RecoveredCapture>>
        >
    with
        $FutureModifier<List<RecoveredCapture>>,
        $FutureProvider<List<RecoveredCapture>> {
  RecoveredCapturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noImageRetry,
        name: r'recoveredCapturesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recoveredCapturesHash();

  @$internal
  @override
  $FutureProviderElement<List<RecoveredCapture>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RecoveredCapture>> create(Ref ref) {
    return recoveredCaptures(ref);
  }
}

String _$recoveredCapturesHash() => r'f802b9652693c307c793df588f3f36eacfac1e3a';

@ProviderFor(managedPhoto)
final managedPhotoProvider = ManagedPhotoFamily._();

final class ManagedPhotoProvider
    extends
        $FunctionalProvider<
          AsyncValue<ImageProvider<Object>?>,
          ImageProvider<Object>?,
          FutureOr<ImageProvider<Object>?>
        >
    with
        $FutureModifier<ImageProvider<Object>?>,
        $FutureProvider<ImageProvider<Object>?> {
  ManagedPhotoProvider._({
    required ManagedPhotoFamily super.from,
    required (String, {bool thumbnail}) super.argument,
  }) : super(
         retry: null,
         name: r'managedPhotoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$managedPhotoHash();

  @override
  String toString() {
    return r'managedPhotoProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<ImageProvider<Object>?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ImageProvider<Object>?> create(Ref ref) {
    final argument = this.argument as (String, {bool thumbnail});
    return managedPhoto(ref, argument.$1, thumbnail: argument.thumbnail);
  }

  @override
  bool operator ==(Object other) {
    return other is ManagedPhotoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$managedPhotoHash() => r'376874d3fc8b107d96a03ef08f4b22553d12c33d';

final class ManagedPhotoFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<ImageProvider<Object>?>,
          (String, {bool thumbnail})
        > {
  ManagedPhotoFamily._()
    : super(
        retry: null,
        name: r'managedPhotoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ManagedPhotoProvider call(String path, {bool thumbnail = false}) =>
      ManagedPhotoProvider._(
        argument: (path, thumbnail: thumbnail),
        from: this,
      );

  @override
  String toString() => r'managedPhotoProvider';
}
