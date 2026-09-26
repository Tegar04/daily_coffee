import 'package:daily_coffee/core/errors/app_failure.dart';

sealed class BootstrapState {
  const BootstrapState();
}

final class BootstrapInitializing extends BootstrapState {
  const BootstrapInitializing();
}

final class BootstrapReady extends BootstrapState {
  const BootstrapReady();
}

final class BootstrapRecoverableFailure extends BootstrapState {
  const BootstrapRecoverableFailure(this.failure);

  final AppFailure failure;
}

final class BootstrapFatalFailure extends BootstrapState {
  const BootstrapFatalFailure(this.failure);

  final AppFailure failure;
}
