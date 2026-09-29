import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/features/scan/application/scan_controller.dart';
import 'package:daily_coffee/features/scan/presentation/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class FailedScanController extends ScanController {
  @override
  ScanState build() =>
      const ScanState(phase: ScanPhase.failure, failure: OcrNoTextFailure());
}

void main() {
  testWidgets('OCR failure keeps manual navigation usable with large text', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/coffee/scan',
      routes: [
        GoRoute(path: '/coffee/scan', builder: (_, _) => const ScanScreen()),
        GoRoute(
          path: '/coffee/new',
          builder: (_, _) => const Scaffold(body: Text('Form manual')),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          scanControllerProvider.overrideWith(FailedScanController.new),
          savedScanDraftsProvider.overrideWith((ref) async => []),
        ],
        child: MaterialApp.router(
          theme: DailyTheme.light,
          routerConfig: router,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Teks belum terbaca'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Isi manual'), 180);
    await tester.tap(find.text('Isi manual'));
    await tester.pumpAndSettle();
    expect(find.text('Form manual'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
