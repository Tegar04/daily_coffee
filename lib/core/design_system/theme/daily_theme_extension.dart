import 'package:flutter/material.dart';

/// Semantic palette from DESIGN_SYSTEM.md, including non-Material roles.
@immutable
class DailyThemeExtension extends ThemeExtension<DailyThemeExtension> {
  const DailyThemeExtension({
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.surfaceStrong,
    required this.primary,
    required this.primaryPressed,
    required this.onPrimary,
    required this.accent,
    required this.onAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.iconPrimary,
    required this.iconSecondary,
    required this.border,
    required this.borderStrong,
    required this.divider,
    required this.focusRing,
    required this.scrim,
    required this.success,
    required this.warning,
    required this.error,
    required this.onStatus,
  });
  final Color background;
  final Color surface;
  final Color surfaceSubtle;
  final Color surfaceStrong;
  final Color primary;
  final Color primaryPressed;
  final Color onPrimary;
  final Color accent;
  final Color onAccent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color iconPrimary;
  final Color iconSecondary;
  final Color border;
  final Color borderStrong;
  final Color divider;
  final Color focusRing;
  final Color scrim;
  final Color success;
  final Color warning;
  final Color error;
  final Color onStatus;
  static const light = DailyThemeExtension(
    background: Color(0xFFF8F2EE),
    surface: Color(0xFFFFFDFC),
    surfaceSubtle: Color(0xFFF0E5DE),
    surfaceStrong: Color(0xFFE2D1C6),
    primary: Color(0xFF56392C),
    primaryPressed: Color(0xFF432B22),
    onPrimary: Color(0xFFFFFDFC),
    accent: Color(0xFFCE5618),
    onAccent: Color(0xFFFFFDFC),
    textPrimary: Color(0xFF0D0A09),
    textSecondary: Color(0xFF6F5A50),
    textDisabled: Color(0xFF9D8D84),
    iconPrimary: Color(0xFF2B1B16),
    iconSecondary: Color(0xFF7D675C),
    border: Color(0xFFD8C8BE),
    borderStrong: Color(0xFFA88F81),
    divider: Color(0xFFE2D1C6),
    focusRing: Color(0xFFCE5618),
    scrim: Color(0x990D0A09),
    success: Color(0xFF52705A),
    warning: Color(0xFFA66A18),
    error: Color(0xFFB7473E),
    onStatus: Color(0xFFFFFDFC),
  );
  static const dark = DailyThemeExtension(
    background: Color(0xFF1A110E),
    surface: Color(0xFF241713),
    surfaceSubtle: Color(0xFF2B1B16),
    surfaceStrong: Color(0xFF3A271F),
    primary: Color(0xFFD7B7A5),
    primaryPressed: Color(0xFFC49B84),
    onPrimary: Color(0xFF241713),
    accent: Color(0xFFE77A3F),
    onAccent: Color(0xFF1A110E),
    textPrimary: Color(0xFFF8F2EE),
    textSecondary: Color(0xFFC8B5AA),
    textDisabled: Color(0xFF806F66),
    iconPrimary: Color(0xFFF0E5DE),
    iconSecondary: Color(0xFFB6A096),
    border: Color(0xFF4B362D),
    borderStrong: Color(0xFF8A6A5A),
    divider: Color(0xFF3A271F),
    focusRing: Color(0xFFE77A3F),
    scrim: Color(0xB30D0A09),
    success: Color(0xFF7FA087),
    warning: Color(0xFFD4A052),
    error: Color(0xFFE17A71),
    onStatus: Color(0xFF1A110E),
  );
  @override
  DailyThemeExtension copyWith({
    Color? background,
    Color? surface,
    Color? surfaceSubtle,
    Color? surfaceStrong,
    Color? primary,
    Color? primaryPressed,
    Color? onPrimary,
    Color? accent,
    Color? onAccent,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? iconPrimary,
    Color? iconSecondary,
    Color? border,
    Color? borderStrong,
    Color? divider,
    Color? focusRing,
    Color? scrim,
    Color? success,
    Color? warning,
    Color? error,
    Color? onStatus,
  }) => DailyThemeExtension(
    background: background ?? this.background,
    surface: surface ?? this.surface,
    surfaceSubtle: surfaceSubtle ?? this.surfaceSubtle,
    surfaceStrong: surfaceStrong ?? this.surfaceStrong,
    primary: primary ?? this.primary,
    primaryPressed: primaryPressed ?? this.primaryPressed,
    onPrimary: onPrimary ?? this.onPrimary,
    accent: accent ?? this.accent,
    onAccent: onAccent ?? this.onAccent,
    textPrimary: textPrimary ?? this.textPrimary,
    textSecondary: textSecondary ?? this.textSecondary,
    textDisabled: textDisabled ?? this.textDisabled,
    iconPrimary: iconPrimary ?? this.iconPrimary,
    iconSecondary: iconSecondary ?? this.iconSecondary,
    border: border ?? this.border,
    borderStrong: borderStrong ?? this.borderStrong,
    divider: divider ?? this.divider,
    focusRing: focusRing ?? this.focusRing,
    scrim: scrim ?? this.scrim,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    error: error ?? this.error,
    onStatus: onStatus ?? this.onStatus,
  );
  @override
  DailyThemeExtension lerp(covariant DailyThemeExtension? other, double t) {
    if (other == null) return this;
    return DailyThemeExtension(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSubtle: Color.lerp(surfaceSubtle, other.surfaceSubtle, t)!,
      surfaceStrong: Color.lerp(surfaceStrong, other.surfaceStrong, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryPressed: Color.lerp(primaryPressed, other.primaryPressed, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      iconPrimary: Color.lerp(iconPrimary, other.iconPrimary, t)!,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      focusRing: Color.lerp(focusRing, other.focusRing, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      onStatus: Color.lerp(onStatus, other.onStatus, t)!,
    );
  }
}

extension DailyThemeContext on BuildContext {
  DailyThemeExtension get dailyColors =>
      Theme.of(this).extension<DailyThemeExtension>()!;
}
