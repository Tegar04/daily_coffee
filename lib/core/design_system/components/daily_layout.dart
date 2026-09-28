import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/daily_tokens.dart';

/// Scrollable, keyboard-safe one-column form/detail or wider feed container.
class DailyPageBody extends StatelessWidget {
  const DailyPageBody({required this.child, this.feed = false, super.key});
  final Widget child;
  final bool feed;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: LayoutBuilder(
      builder: (context, constraints) {
        final padding = constraints.maxWidth < DailyLayout.medium
            ? DailySpacing.md
            : DailySpacing.lg;
        return SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: feed
                    ? DailyLayout.feedMaxWidth
                    : DailyLayout.formMaxWidth,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.all(padding),
                child: child,
              ),
            ),
          ),
        );
      },
    ),
  );
}

/// Content-sized cards avoid fixed grid aspect ratios clipping scaled text.
/// Intended for bounded collections/previews; use a lazy sliver for large feeds.
class DailyAdaptiveGrid extends StatelessWidget {
  const DailyAdaptiveGrid({required this.children, super.key});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final scale = MediaQuery.textScalerOf(context).scale(16) / 16;
      final minimum = DailyLayout.cardMinWidth * scale;
      final columns = math.max(
        1,
        ((constraints.maxWidth + DailySpacing.md) / (minimum + DailySpacing.md))
            .floor(),
      );
      final width =
          (constraints.maxWidth - DailySpacing.md * (columns - 1)) / columns;
      return Wrap(
        spacing: DailySpacing.md,
        runSpacing: DailySpacing.md,
        children: [
          for (final child in children) SizedBox(width: width, child: child),
        ],
      );
    },
  );
}
