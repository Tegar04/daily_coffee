import 'package:daily_coffee/app/composition/app_providers.dart';
import 'package:daily_coffee/core/config/app_environment.dart';
import 'package:daily_coffee/core/logging/app_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_doubles.dart';

void main() {
  test('foundation dependencies can be overridden deterministically', () {
    final clock = FixedAppClock(DateTime.utc(2026, 9, 26));
    final ids = SequenceAppIdGenerator(['coffee-1']);
    final container = ProviderContainer(
      overrides: [
        appEnvironmentProvider.overrideWithValue(
          const AppEnvironment(
            name: AppEnvironmentName.development,
            logLevel: AppLogLevel.off,
            enableDeveloperTools: false,
          ),
        ),
        appClockProvider.overrideWithValue(clock),
        appIdGeneratorProvider.overrideWithValue(ids),
        appLoggerProvider.overrideWithValue(const NoopAppLogger()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(appClockProvider).now(), DateTime.utc(2026, 9, 26));
    expect(container.read(appIdGeneratorProvider).generate(), 'coffee-1');
    expect(container.read(appLoggerProvider), isA<NoopAppLogger>());
  });
}
