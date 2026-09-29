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

String _$coffeeRepositoryHash() => r'f16196c2d181ac77b662d0ba98cf56962df971ce';
