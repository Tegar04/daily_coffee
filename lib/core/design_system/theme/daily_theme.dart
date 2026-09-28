import 'package:flutter/material.dart';

import 'daily_theme_extension.dart';
import 'daily_tokens.dart';
import 'daily_typography.dart';

abstract final class DailyTheme {
  static ThemeData get light =>
      _build(Brightness.light, DailyThemeExtension.light);
  static ThemeData get dark =>
      _build(Brightness.dark, DailyThemeExtension.dark);

  static ThemeData _build(Brightness brightness, DailyThemeExtension c) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DailyRadii.medium),
    );
    final text = DailyTypography.textTheme.apply(
      bodyColor: c.textPrimary,
      displayColor: c.textPrimary,
    );
    OutlineInputBorder border(
      Color color, [
      double width = DailySizes.border,
    ]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(DailyRadii.medium),
      borderSide: BorderSide(color: color, width: width),
    );
    final commonButton = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(
        Size(DailySizes.touchTarget, DailySizes.touchTarget),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsetsDirectional.symmetric(
          horizontal: DailySizes.buttonPadding,
          vertical: DailySpacing.compact,
        ),
      ),
      shape: WidgetStatePropertyAll(shape),
      textStyle: WidgetStatePropertyAll(text.labelLarge),
      side: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.focused)
            ? BorderSide(color: c.focusRing, width: DailySizes.focusBorder)
            : null,
      ),
      animationDuration: DailyMotion.fast,
    );
    // background -> scaffold; surface -> Material surfaces. Additional roles
    // stay in DailyThemeExtension rather than losing their semantic meaning.
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Inter',
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.onPrimary,
        primaryContainer: c.surfaceSubtle,
        onPrimaryContainer: c.primary,
        secondary: c.primary,
        onSecondary: c.onPrimary,
        secondaryContainer: c.surfaceSubtle,
        onSecondaryContainer: c.primary,
        tertiary: c.accent,
        onTertiary: c.onAccent,
        error: c.error,
        onError: c.onStatus,
        errorContainer: c.error.withValues(alpha: DailyOpacity.subtle),
        onErrorContainer: c.error,
        surface: c.surface,
        onSurface: c.textPrimary,
        onSurfaceVariant: c.textSecondary,
        surfaceContainerLowest: c.background,
        surfaceContainerLow: c.surface,
        surfaceContainer: c.surfaceSubtle,
        surfaceContainerHigh: c.surfaceStrong,
        surfaceContainerHighest: c.surfaceStrong,
        outline: c.borderStrong,
        outlineVariant: c.border,
        scrim: c.scrim,
        inverseSurface: c.textPrimary,
        onInverseSurface: c.background,
        surfaceTint: Colors.transparent,
      ),
      scaffoldBackgroundColor: c.background,
      extensions: [c],
      textTheme: text,
      iconTheme: IconThemeData(color: c.iconPrimary, size: DailySizes.icon),
      dividerColor: c.divider,
      focusColor: c.focusRing.withValues(alpha: DailyOpacity.subtle),
      splashColor: c.primary.withValues(alpha: DailyOpacity.pressed),
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        elevation: DailyElevation.none,
        scrolledUnderElevation: DailyElevation.none,
        centerTitle: false,
        titleTextStyle: text.headlineMedium,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: commonButton.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? c.textPrimary.withValues(alpha: DailyOpacity.subtle)
                : states.contains(WidgetState.pressed)
                ? c.primaryPressed
                : c.primary,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.disabled)
                ? c.textPrimary.withValues(alpha: DailyOpacity.disabled)
                : c.onPrimary,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: commonButton.copyWith(
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.focused)
                  ? c.focusRing
                  : c.borderStrong,
              width: states.contains(WidgetState.focused)
                  ? DailySizes.focusBorder
                  : DailySizes.border,
            ),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(style: commonButton),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(DailySizes.touchTarget),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surface,
        contentPadding: const EdgeInsetsDirectional.all(DailySpacing.md),
        constraints: const BoxConstraints(minHeight: DailySizes.input),
        border: border(c.border),
        enabledBorder: border(c.border),
        focusedBorder: border(c.primary, DailySizes.focusBorder),
        errorBorder: border(c.error),
        focusedErrorBorder: border(c.error, DailySizes.focusBorder),
        helperStyle: text.bodySmall?.copyWith(color: c.textSecondary),
        errorStyle: text.bodySmall?.copyWith(color: c.error),
        errorMaxLines: 4,
      ),
      cardTheme: CardThemeData(
        color: c.surface,
        elevation: DailyElevation.none,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DailyRadii.large),
          side: BorderSide(color: c.border),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.surfaceSubtle,
        selectedColor: c.primary.withValues(alpha: DailyOpacity.subtle),
        labelStyle: text.labelMedium?.copyWith(color: c.textSecondary),
        shape: const StadiumBorder(),
        side: BorderSide(color: c.border),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: DailySpacing.compact,
          vertical: DailySpacing.micro,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: c.surface,
        elevation: DailyElevation.none,
        indicatorColor: c.primary.withValues(alpha: DailyOpacity.subtle),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => text.labelMedium?.copyWith(
            color: states.contains(WidgetState.selected)
                ? c.primary
                : c.textSecondary,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? c.primary
                : c.iconSecondary,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: c.surface,
        modalBarrierColor: c.scrim,
        elevation: brightness == Brightness.dark
            ? DailyElevation.none
            : DailyElevation.high,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(DailyRadii.xlarge),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: c.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DailyRadii.xlarge),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: c.primary,
        foregroundColor: c.onPrimary,
        elevation: DailyElevation.low,
      ),
    );
  }
}
