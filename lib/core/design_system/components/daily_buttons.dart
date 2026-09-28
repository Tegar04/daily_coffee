import 'package:flutter/material.dart';

import '../theme/daily_theme_extension.dart';
import '../theme/daily_tokens.dart';

enum DailyButtonVariant { primary, secondary, text }

class DailyButton extends StatelessWidget {
  const DailyButton({
    required this.label,
    required this.onPressed,
    this.variant = DailyButtonVariant.primary,
    this.icon,
    this.loading = false,
    this.destructive = false,
    super.key,
  });
  final String label;
  final VoidCallback? onPressed;
  final DailyButtonVariant variant;
  final IconData? icon;
  final bool loading;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final c = context.dailyColors;
    final content = Semantics(
      liveRegion: loading,
      label: loading ? '$label, sedang diproses' : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: loading ? 0 : 1,
            child: ExcludeSemantics(
              excluding: loading,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: DailySizes.iconInline),
                    const SizedBox(width: DailySpacing.sm),
                  ],
                  Flexible(child: Text(label, textAlign: TextAlign.center)),
                ],
              ),
            ),
          ),
          if (loading)
            SizedBox.square(
              dimension: DailySizes.iconInline,
              child: MediaQuery.disableAnimationsOf(context)
                  ? const Icon(
                      Icons.hourglass_top_rounded,
                      size: DailySizes.iconInline,
                    )
                  : const CircularProgressIndicator(
                      strokeWidth: DailySizes.focusBorder,
                    ),
            ),
        ],
      ),
    );
    final style = destructive
        ? ButtonStyle(
            backgroundColor: variant == DailyButtonVariant.primary
                ? WidgetStateProperty.resolveWith(
                    (states) =>
                        states.contains(WidgetState.disabled) ? null : c.error,
                  )
                : null,
            foregroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.disabled)
                  ? null
                  : variant == DailyButtonVariant.primary
                  ? c.onStatus
                  : c.error,
            ),
          )
        : null;
    final callback = loading ? null : onPressed;
    return switch (variant) {
      DailyButtonVariant.primary => FilledButton(
        onPressed: callback,
        style: style,
        child: content,
      ),
      DailyButtonVariant.secondary => OutlinedButton(
        onPressed: callback,
        style: style,
        child: content,
      ),
      DailyButtonVariant.text => TextButton(
        onPressed: callback,
        style: style,
        child: content,
      ),
    };
  }
}

class DailyPrimaryButton extends DailyButton {
  const DailyPrimaryButton({
    required super.label,
    required super.onPressed,
    super.icon,
    super.loading,
    super.destructive,
    super.key,
  });
}

class DailySecondaryButton extends DailyButton {
  const DailySecondaryButton({
    required super.label,
    required super.onPressed,
    super.icon,
    super.loading,
    super.key,
  }) : super(variant: DailyButtonVariant.secondary);
}

class DailyTextButton extends DailyButton {
  const DailyTextButton({
    required super.label,
    required super.onPressed,
    super.destructive,
    super.key,
  }) : super(variant: DailyButtonVariant.text);
}

class DailyIconButton extends StatelessWidget {
  const DailyIconButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.selected,
    super.key,
  });
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool? selected;
  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: label,
    isSelected: selected,
    onPressed: onPressed,
    icon: Icon(icon),
  );
}
