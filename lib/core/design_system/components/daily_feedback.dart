import 'package:flutter/material.dart';

import '../theme/daily_theme_extension.dart';
import '../theme/daily_tokens.dart';
import 'daily_buttons.dart';

class DailyEmptyState extends StatelessWidget {
  const DailyEmptyState({
    required this.title,
    required this.message,
    this.icon = Icons.local_cafe_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });
  final String title;
  final String message;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(vertical: DailySpacing.xl),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(
          child: Icon(
            icon,
            size: DailySizes.iconSupporting,
            color: context.dailyColors.iconSecondary,
          ),
        ),
        const SizedBox(height: DailySpacing.md),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DailySpacing.sm),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: context.dailyColors.textSecondary),
        ),
        if (actionLabel != null) ...[
          const SizedBox(height: DailySpacing.lg),
          DailyPrimaryButton(label: actionLabel!, onPressed: onAction),
        ],
      ],
    ),
  );
}

class DailyErrorState extends StatelessWidget {
  const DailyErrorState({required this.message, this.onRetry, super.key});
  final String message;
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    child: DailyEmptyState(
      title: 'Belum berhasil',
      message: message,
      icon: Icons.error_outline_rounded,
      actionLabel: onRetry == null ? null : 'Coba lagi',
      onAction: onRetry,
    ),
  );
}

class DailyLoadingState extends StatelessWidget {
  const DailyLoadingState({required this.label, super.key});
  final String label;
  @override
  Widget build(BuildContext context) => Semantics(
    liveRegion: true,
    label: label,
    child: ExcludeSemantics(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (MediaQuery.disableAnimationsOf(context))
            const Icon(Icons.hourglass_top_rounded)
          else
            const CircularProgressIndicator(),
          const SizedBox(height: DailySpacing.md),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

/// Static by design: no decorative loop, including when reduce motion is on.
class DailyLoadingSkeleton extends StatelessWidget {
  const DailyLoadingSkeleton({this.label = 'Memuat koleksi kopi', super.key});
  final String label;
  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    liveRegion: true,
    child: ExcludeSemantics(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: DailySizes.photoRatio,
            child: _block(context),
          ),
          const SizedBox(height: DailySpacing.sm),
          SizedBox(height: DailySizes.icon, child: _block(context)),
          const SizedBox(height: DailySpacing.sm),
          FractionallySizedBox(
            widthFactor: 0.5,
            child: SizedBox(height: DailySpacing.md, child: _block(context)),
          ),
        ],
      ),
    ),
  );
  Widget _block(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.dailyColors.surfaceSubtle,
      borderRadius: BorderRadius.circular(DailyRadii.small),
    ),
  );
}
