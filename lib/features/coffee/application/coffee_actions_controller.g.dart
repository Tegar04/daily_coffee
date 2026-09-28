// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_actions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CoffeeActionsController)
final coffeeActionsControllerProvider = CoffeeActionsControllerFamily._();

final class CoffeeActionsControllerProvider
    extends $NotifierProvider<CoffeeActionsController, bool> {
  CoffeeActionsControllerProvider._({
    required CoffeeActionsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'coffeeActionsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$coffeeActionsControllerHash();

  @override
  String toString() {
    return r'coffeeActionsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CoffeeActionsController create() => CoffeeActionsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CoffeeActionsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$coffeeActionsControllerHash() =>
    r'13deea6bcfa9f63a05b29740a104870ce218375e';

final class CoffeeActionsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CoffeeActionsController,
          bool,
          bool,
          bool,
          String
        > {
  CoffeeActionsControllerFamily._()
    : super(
        retry: null,
        name: r'coffeeActionsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CoffeeActionsControllerProvider call(String id) =>
      CoffeeActionsControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'coffeeActionsControllerProvider';
}

abstract class _$CoffeeActionsController extends $Notifier<bool> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  bool build(String id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
