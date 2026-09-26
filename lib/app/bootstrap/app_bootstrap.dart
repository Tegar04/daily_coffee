import 'package:daily_coffee/app/app.dart';
import 'package:daily_coffee/app/composition/app_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyCoffeeBootstrap extends ConsumerWidget {
  const DailyCoffeeBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appEnvironmentProvider);
    ref.watch(appClockProvider);
    ref.watch(appIdGeneratorProvider);
    ref.watch(appLoggerProvider);

    return const DailyCoffeeApp();
  }
}
