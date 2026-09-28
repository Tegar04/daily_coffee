import 'package:flutter/material.dart';

abstract final class DailyTypography {
  static TextStyle _style(
    double size,
    double line,
    FontWeight weight, {
    bool editorial = false,
  }) => TextStyle(
    fontFamily: editorial ? 'Lora' : 'Inter',
    fontSize: size,
    height: line / size,
    fontWeight: weight,
  );

  /// caption maps to bodySmall; unused Material slots inherit the nearest role.
  static TextTheme get textTheme => TextTheme(
    displayLarge: _style(36, 44, FontWeight.w600, editorial: true),
    displayMedium: _style(30, 38, FontWeight.w600, editorial: true),
    displaySmall: _style(26, 34, FontWeight.w600, editorial: true),
    headlineLarge: _style(26, 34, FontWeight.w600, editorial: true),
    headlineMedium: _style(22, 28, FontWeight.w700),
    headlineSmall: _style(22, 28, FontWeight.w700),
    titleLarge: _style(20, 26, FontWeight.w700),
    titleMedium: _style(16, 22, FontWeight.w600),
    titleSmall: _style(14, 20, FontWeight.w600),
    bodyLarge: _style(16, 24, FontWeight.w400),
    bodyMedium: _style(14, 20, FontWeight.w400),
    bodySmall: _style(12, 16, FontWeight.w400),
    labelLarge: _style(14, 20, FontWeight.w600),
    labelMedium: _style(12, 16, FontWeight.w600),
    labelSmall: _style(12, 16, FontWeight.w600),
  );
}
