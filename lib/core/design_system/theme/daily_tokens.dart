import 'package:flutter/material.dart';

abstract final class DailySpacing {
  static const zero = 0.0;
  static const micro = 4.0;
  static const sm = 8.0;
  static const compact = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 40.0;
  static const section = 48.0;
  static const hero = 64.0;
}

abstract final class DailyRadii {
  static const none = 0.0;
  static const small = 8.0;
  static const medium = 12.0;
  static const large = 16.0;
  static const xlarge = 24.0;
  static const full = 999.0;
}

abstract final class DailyElevation {
  static const none = 0.0;
  static const low = 1.0;
  static const medium = 3.0;
  static const high = 6.0;
  static const lowShadow = BoxShadow(
    color: Color(0x142B1B16),
    blurRadius: 8,
    offset: Offset(0, 2),
  );
  static const mediumShadow = BoxShadow(
    color: Color(0x242B1B16),
    blurRadius: 16,
    offset: Offset(0, 6),
  );
  static const highShadow = BoxShadow(
    color: Color(0x330D0A09),
    blurRadius: 28,
    offset: Offset(0, 12),
  );
}

abstract final class DailySizes {
  static const touchTarget = 48.0;
  static const input = 56.0;
  static const iconInline = 20.0;
  static const icon = 24.0;
  static const iconSupporting = 32.0;
  static const thumbnail = 80.0;
  static const buttonPadding = 20.0;
  static const border = 1.0;
  static const focusBorder = 2.0;
  static const photoRatio = 4 / 5;
}

abstract final class DailyLayout {
  static const medium = 600.0;
  static const expanded = 840.0;
  static const formMaxWidth = 720.0;
  static const feedMaxWidth = 1200.0;
  // Minimum readable card width; scale this with text size.
  static const cardMinWidth = 160.0;
}

abstract final class DailyOpacity {
  static const subtle = 0.12;
  static const pressed = 0.08;
  static const disabled = 0.38;
}

abstract final class DailyMotion {
  static const fast = Duration(milliseconds: 150);
  static const standard = Duration(milliseconds: 250);
  static const complex = Duration(milliseconds: 350);
  static const curve = Curves.easeInOutCubic;
  static Duration duration(BuildContext context, Duration duration) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;
}
