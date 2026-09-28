// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_queries.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(coffeeLibrary)
final coffeeLibraryProvider = CoffeeLibraryProvider._();

final class CoffeeLibraryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<List<Coffee>>>,
          Result<List<Coffee>>,
          Stream<Result<List<Coffee>>>
        >
    with
        $FutureModifier<Result<List<Coffee>>>,
        $StreamProvider<Result<List<Coffee>>> {
  CoffeeLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'coffeeLibraryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$coffeeLibraryHash();

  @$internal
  @override
  $StreamProviderElement<Result<List<Coffee>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Result<List<Coffee>>> create(Ref ref) {
    return coffeeLibrary(ref);
  }
}

String _$coffeeLibraryHash() => r'987c379dea62ec16a36122ed869b198505ac2879';

@ProviderFor(coffeeDetail)
final coffeeDetailProvider = CoffeeDetailFamily._();

final class CoffeeDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<Coffee?>>,
          Result<Coffee?>,
          Stream<Result<Coffee?>>
        >
    with $FutureModifier<Result<Coffee?>>, $StreamProvider<Result<Coffee?>> {
  CoffeeDetailProvider._({
    required CoffeeDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'coffeeDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$coffeeDetailHash();

  @override
  String toString() {
    return r'coffeeDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Result<Coffee?>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Result<Coffee?>> create(Ref ref) {
    final argument = this.argument as String;
    return coffeeDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CoffeeDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$coffeeDetailHash() => r'95d621802546b91df69bd6ee3d49e94643c2f5bf';

final class CoffeeDetailFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Result<Coffee?>>, String> {
  CoffeeDetailFamily._()
    : super(
        retry: null,
        name: r'coffeeDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CoffeeDetailProvider call(String id) =>
      CoffeeDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'coffeeDetailProvider';
}
