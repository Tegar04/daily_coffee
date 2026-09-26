import 'package:daily_coffee/app/bootstrap/app_preferences.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/app/routing/navigation_screens.dart';
import 'package:go_router/go_router.dart';

GoRouter createAppRouter(AppPreferences preferences) {
  final initialLocation = preferences.hasCompletedOnboarding
      ? rootLocationForIndex(preferences.lastRootIndex)
      : const OnboardingRoute().location;

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: initialLocation,
    routes: appRoutes,
    errorBuilder: (context, state) =>
        RouteErrorScreen(location: state.uri.toString()),
  );
}
