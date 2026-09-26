// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appEnvironment)
final appEnvironmentProvider = AppEnvironmentProvider._();

final class AppEnvironmentProvider
    extends $FunctionalProvider<AppEnvironment, AppEnvironment, AppEnvironment>
    with $Provider<AppEnvironment> {
  AppEnvironmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appEnvironmentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appEnvironmentHash();

  @$internal
  @override
  $ProviderElement<AppEnvironment> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppEnvironment create(Ref ref) {
    return appEnvironment(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppEnvironment value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppEnvironment>(value),
    );
  }
}

String _$appEnvironmentHash() => r'e68326545f2c52b5e24a1040210d7658eb2e8fe0';

@ProviderFor(appClock)
final appClockProvider = AppClockProvider._();

final class AppClockProvider
    extends $FunctionalProvider<AppClock, AppClock, AppClock>
    with $Provider<AppClock> {
  AppClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appClockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appClockHash();

  @$internal
  @override
  $ProviderElement<AppClock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppClock create(Ref ref) {
    return appClock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppClock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppClock>(value),
    );
  }
}

String _$appClockHash() => r'e1fb0e382f31b2588127780c0985e470e145cba3';

@ProviderFor(appIdGenerator)
final appIdGeneratorProvider = AppIdGeneratorProvider._();

final class AppIdGeneratorProvider
    extends $FunctionalProvider<AppIdGenerator, AppIdGenerator, AppIdGenerator>
    with $Provider<AppIdGenerator> {
  AppIdGeneratorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appIdGeneratorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appIdGeneratorHash();

  @$internal
  @override
  $ProviderElement<AppIdGenerator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppIdGenerator create(Ref ref) {
    return appIdGenerator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppIdGenerator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppIdGenerator>(value),
    );
  }
}

String _$appIdGeneratorHash() => r'b5eb72aa99fe2ef55aabc6ed2f0e45fcb52ef075';

@ProviderFor(appLogger)
final appLoggerProvider = AppLoggerProvider._();

final class AppLoggerProvider
    extends $FunctionalProvider<AppLogger, AppLogger, AppLogger>
    with $Provider<AppLogger> {
  AppLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLoggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLoggerHash();

  @$internal
  @override
  $ProviderElement<AppLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLogger create(Ref ref) {
    return appLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLogger>(value),
    );
  }
}

String _$appLoggerHash() => r'666104f6aa57510cb43bc19cff4853657649e882';
