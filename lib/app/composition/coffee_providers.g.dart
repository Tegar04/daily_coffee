// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(coffeeRepository)
final coffeeRepositoryProvider = CoffeeRepositoryProvider._();

final class CoffeeRepositoryProvider
    extends
        $FunctionalProvider<
          CoffeeRepository,
          CoffeeRepository,
          CoffeeRepository
        >
    with $Provider<CoffeeRepository> {
  CoffeeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coffeeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coffeeRepositoryHash();

  @$internal
  @override
  $ProviderElement<CoffeeRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CoffeeRepository create(Ref ref) {
    return coffeeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CoffeeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CoffeeRepository>(value),
    );
  }
}

String _$coffeeRepositoryHash() => r'de54e8fbb38df2f589188515affc2a6c54854a77';

@ProviderFor(driftCoffeeRepository)
final driftCoffeeRepositoryProvider = DriftCoffeeRepositoryProvider._();

final class DriftCoffeeRepositoryProvider
    extends
        $FunctionalProvider<
          DriftCoffeeRepository,
          DriftCoffeeRepository,
          DriftCoffeeRepository
        >
    with $Provider<DriftCoffeeRepository> {
  DriftCoffeeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'driftCoffeeRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$driftCoffeeRepositoryHash();

  @$internal
  @override
  $ProviderElement<DriftCoffeeRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DriftCoffeeRepository create(Ref ref) {
    return driftCoffeeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DriftCoffeeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DriftCoffeeRepository>(value),
    );
  }
}

String _$driftCoffeeRepositoryHash() =>
    r'685a6ae063c1b999e5cb77c071b418a0bb7b686a';
