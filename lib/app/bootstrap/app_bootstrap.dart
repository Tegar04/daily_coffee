import 'package:daily_coffee/app/app.dart';
import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/bootstrap/bootstrap_state.dart';
import 'package:daily_coffee/app/composition/app_providers.dart';
import 'package:daily_coffee/app/composition/database_providers.dart';
import 'package:daily_coffee/app/localization/app_localizations.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyCoffeeBootstrap extends ConsumerWidget {
  const DailyCoffeeBootstrap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appEnvironmentProvider);
    ref.watch(appClockProvider);
    ref.watch(appIdGeneratorProvider);
    ref.watch(appLoggerProvider);

    final bootstrap = ref.watch(appBootstrapProvider);

    return bootstrap.when(
      loading: () => const BootstrapScreen(state: BootstrapInitializing()),
      error: (error, stackTrace) => BootstrapScreen(
        state: BootstrapRecoverableFailure(
          error is AppFailure
              ? error
              : StorageFailure(
                  cause: error,
                  diagnosticContext: const {'operation': 'bootstrap'},
                ),
        ),
        onRetry: () {
          ref.invalidate(appDatabaseProvider);
          ref.invalidate(databaseInitializationProvider);
          ref.invalidate(appBootstrapProvider);
        },
      ),
      data: (preferences) => DailyCoffeeApp(preferences: preferences),
    );
  }
}

final appBootstrapProvider = FutureProvider<AppPreferences>(
  retry: (_, _) => null,
  (ref) async {
    final initialization = ref.watch(databaseInitializationProvider.future);
    final preferences = ref.watch(appPreferencesProvider);
    await initialization;
    await preferences.load();
    return preferences;
  },
);

class BootstrapScreen extends StatelessWidget {
  const BootstrapScreen({required this.state, this.onRetry, super.key});

  final BootstrapState state;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = switch (state) {
      BootstrapRecoverableFailure(:final failure) => failure,
      BootstrapFatalFailure(:final failure) => failure,
      _ => null,
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: DailyLocalizations.delegates,
      supportedLocales: DailyLocalizations.supportedLocales,
      theme: DailyTheme.light,
      darkTheme: DailyTheme.dark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: DailyPageBody(
          child: failure == null
              ? const DailyLoadingState(label: 'Menyiapkan Daily Coffee')
              : DailyErrorState(
                  message: 'Aplikasi belum dapat disiapkan. Data Anda tidak dihapus.',
                  onRetry: onRetry,
                ),
        ),
      ),
    );
  }
}
