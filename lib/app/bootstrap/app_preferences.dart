import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppPreferences {
  bool get hasCompletedOnboarding;
  int get lastRootIndex;

  Future<void> load();
  Future<void> completeOnboarding();
  Future<void> setLastRootIndex(int index);
}

final appPreferencesProvider = Provider<AppPreferences>(
  (ref) => SharedPreferencesAppPreferences(),
);

final class SharedPreferencesAppPreferences implements AppPreferences {
  static const _onboardingKey = 'onboarding_completed';
  static const _lastRootIndexKey = 'last_root_index';

  SharedPreferences? _preferences;

  SharedPreferences get _store => _preferences!;

  @override
  bool get hasCompletedOnboarding => _store.getBool(_onboardingKey) ?? false;

  @override
  int get lastRootIndex =>
      _normalizeRootIndex(_store.getInt(_lastRootIndexKey) ?? 0);

  @override
  Future<void> load() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  @override
  Future<void> completeOnboarding() async {
    await _store.setBool(_onboardingKey, true);
  }

  @override
  Future<void> setLastRootIndex(int index) async {
    await _store.setInt(_lastRootIndexKey, _normalizeRootIndex(index));
  }

  int _normalizeRootIndex(int index) => index < 0 ? 0 : (index > 2 ? 2 : index);
}
