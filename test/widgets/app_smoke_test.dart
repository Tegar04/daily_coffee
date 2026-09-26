import 'package:daily_coffee/app/bootstrap/app_bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders Daily Coffee through the root ProviderScope', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: DailyCoffeeBootstrap()));

    expect(find.text('Daily Coffee'), findsOneWidget);
  });
}
