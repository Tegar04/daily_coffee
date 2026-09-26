import 'package:daily_coffee/core/config/app_environment.dart';
import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/logging/app_logger.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
AppEnvironment appEnvironment(Ref ref) => AppEnvironment.fromDartDefines();

@Riverpod(keepAlive: true)
AppClock appClock(Ref ref) => const SystemAppClock();

@Riverpod(keepAlive: true)
AppIdGenerator appIdGenerator(Ref ref) => RandomAppIdGenerator();

@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) {
  final environment = ref.watch(appEnvironmentProvider);

  return DeveloperAppLogger(minimumLevel: environment.logLevel);
}
