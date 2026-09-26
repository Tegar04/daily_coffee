import 'package:daily_coffee/core/config/app_environment.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('environment and log level parsers have safe defaults', () {
    expect(
      AppEnvironmentName.parse('production'),
      AppEnvironmentName.production,
    );
    expect(AppEnvironmentName.parse('unknown'), AppEnvironmentName.development);
    expect(AppLogLevel.parse('warning'), AppLogLevel.warning);
    expect(AppLogLevel.parse('unknown'), AppLogLevel.info);
  });
}
