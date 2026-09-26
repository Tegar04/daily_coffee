import 'package:daily_coffee/app/app.dart';
import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/bootstrap/bootstrap_state.dart';
import 'package:daily_coffee/app/composition/app_providers.dart';
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
          StorageFailure(
            cause: error,
            diagnosticContext: const {'operation': 'bootstrap_preferences'},
          ),
        ),
        onRetry: () => ref.invalidate(appBootstrapProvider),
      ),
      data: (preferences) => DailyCoffeeApp(preferences: preferences),
    );
  }
}

final appBootstrapProvider = FutureProvider<AppPreferences>((ref) async {
  final preferences = ref.watch(appPreferencesProvider);
  await preferences.load();
  return preferences;
});

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
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: failure == null
                  ? const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Daily Coffee', style: TextStyle(fontSize: 28)),
                        SizedBox(height: 24),
                        CircularProgressIndicator(),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline, size: 48),
                        const SizedBox(height: 16),
                        const Text(
                          'Aplikasi belum dapat disiapkan. Data Anda tidak dihapus.',
                          textAlign: TextAlign.center,
                        ),
                        if (onRetry != null) ...[
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: onRetry,
                            child: const Text('Coba lagi'),
                          ),
                        ],
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
