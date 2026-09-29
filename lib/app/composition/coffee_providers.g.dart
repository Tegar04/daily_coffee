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

String _$coffeeRepositoryHash() => r'a165e0f8621c6e78fb27cf5670b3c2e50bcf7bbb';
