import 'package:flutter/material.dart';

import '../theme/daily_theme_extension.dart';
import '../theme/daily_tokens.dart';

/// Accepts an injected image provider; does not read files or request permission.
class DailyPhoto extends StatelessWidget {
  const DailyPhoto({
    required this.label,
    this.image,
    this.aspectRatio = DailySizes.photoRatio,
    this.fit = BoxFit.cover,
    super.key,
  });
  final String label;
  final ImageProvider<Object>? image;
  final double aspectRatio;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) => Semantics(
    image: true,
    label: label,
    child: ExcludeSemantics(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(DailyRadii.small),
          child: image == null
              ? _fallback(context)
              : Image(
                  image: image!,
                  fit: fit,
                  frameBuilder: (context, child, frame, synchronous) =>
                      synchronous || frame != null ? child : _fallback(context),
                  errorBuilder: (context, error, stack) => _fallback(context),
                ),
        ),
      ),
    ),
  );
  Widget _fallback(BuildContext context) => ColoredBox(
    color: context.dailyColors.surfaceSubtle,
    child: Center(
      child: Icon(
        Icons.coffee_outlined,
        size: DailySizes.iconSupporting,
        color: context.dailyColors.iconSecondary,
      ),
    ),
  );
}
