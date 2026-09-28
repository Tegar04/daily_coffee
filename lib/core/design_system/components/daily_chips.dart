import 'package:flutter/material.dart';

import '../theme/daily_theme_extension.dart';
import '../theme/daily_tokens.dart';

class DailyFilterChip extends StatelessWidget {
  const DailyFilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    super.key,
  });
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  @override
  Widget build(BuildContext context) => FilterChip(
    label: Text(label),
    selected: selected,
    onSelected: onSelected,
    showCheckmark: true,
    side: BorderSide(
      color: selected
          ? context.dailyColors.primary
          : context.dailyColors.border,
    ),
    labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
      color: selected
          ? context.dailyColors.primary
          : context.dailyColors.textSecondary,
    ),
  );
}

class DailyTagChip extends StatelessWidget {
  const DailyTagChip({required this.label, super.key});
  final String label;
  @override
  Widget build(BuildContext context) => Chip(label: Text(label));
}

enum DailyStatus { success, warning, error }

class DailyStatusBadge extends StatelessWidget {
  const DailyStatusBadge({
    required this.label,
    required this.status,
    super.key,
  });
  final String label;
  final DailyStatus status;
  @override
  Widget build(BuildContext context) {
    final c = context.dailyColors;
    final (color, icon) = switch (status) {
      DailyStatus.success => (c.success, Icons.check_circle_outline_rounded),
      DailyStatus.warning => (c.warning, Icons.info_outline_rounded),
      DailyStatus.error => (c.error, Icons.error_outline_rounded),
    };
    return Semantics(
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color.withValues(alpha: DailyOpacity.subtle),
          borderRadius: BorderRadius.circular(DailyRadii.small),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: DailySpacing.compact,
            vertical: DailySpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: DailySizes.iconInline),
              const SizedBox(width: DailySpacing.sm),
              Flexible(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelMedium
                      ?.copyWith(color: c.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
