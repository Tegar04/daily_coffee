// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CoffeeFormController)
final coffeeFormControllerProvider = CoffeeFormControllerFamily._();

final class CoffeeFormControllerProvider
    extends $NotifierProvider<CoffeeFormController, CoffeeFormState> {
  CoffeeFormControllerProvider._({
    required CoffeeFormControllerFamily super.from,
    required Coffee? super.argument,
  }) : super(
         retry: null,
         name: r'coffeeFormControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$coffeeFormControllerHash();

  @override
  String toString() {
    return r'coffeeFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CoffeeFormController create() => CoffeeFormController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CoffeeFormState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CoffeeFormState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CoffeeFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$coffeeFormControllerHash() =>
    r'8d3aebf2301c1bff4d49cae2ae116f8b99bfa0bd';

final class CoffeeFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CoffeeFormController,
          CoffeeFormState,
          CoffeeFormState,
          CoffeeFormState,
          Coffee?
        > {
  CoffeeFormControllerFamily._()
    : super(
        retry: null,
        name: r'coffeeFormControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CoffeeFormControllerProvider call(Coffee? initial) =>
      CoffeeFormControllerProvider._(argument: initial, from: this);

  @override
  String toString() => r'coffeeFormControllerProvider';
}

abstract class _$CoffeeFormController extends $Notifier<CoffeeFormState> {
  late final _$args = ref.$arg as Coffee?;
  Coffee? get initial => _$args;

  CoffeeFormState build(Coffee? initial);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CoffeeFormState, CoffeeFormState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CoffeeFormState, CoffeeFormState>,
              CoffeeFormState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
