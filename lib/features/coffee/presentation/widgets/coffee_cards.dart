import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Pure presentation API, ready for the Coffee model in Phase 4.
class CoffeeLibraryCard extends StatelessWidget {
  const CoffeeLibraryCard({
    required this.name,
    required this.roastery,
    required this.onTap,
    this.metadata = const [],
    this.image,
    super.key,
  });
  final String name;
  final String roastery;
  final List<String> metadata;
  final ImageProvider<Object>? image;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => DailyCard(
    onTap: onTap,
    semanticLabel: [name, roastery, ...metadata.take(2)].join(', '),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DailyPhoto(label: 'Kemasan $name', image: image),
        Padding(
          padding: const EdgeInsetsDirectional.all(DailySpacing.md),
          child: _CoffeeSummary(
            name: name,
            roastery: roastery,
            metadata: metadata,
          ),
        ),
      ],
    ),
  );
}

class CoffeeListCard extends StatelessWidget {
  const CoffeeListCard({
    required this.name,
    required this.roastery,
    required this.onTap,
    this.image,
    this.metadata = const [],
    super.key,
  });
  final String name;
  final String roastery;
  final VoidCallback onTap;
  final ImageProvider<Object>? image;
  final List<String> metadata;
  @override
  Widget build(BuildContext context) => DailyCard(
    onTap: onTap,
    semanticLabel: [name, roastery, ...metadata.take(2)].join(', '),
    child: Padding(
      padding: const EdgeInsetsDirectional.all(DailySpacing.md),
      child: Row(
        children: [
          SizedBox(
            width: DailySizes.thumbnail,
            child: DailyPhoto(
              label: 'Kemasan $name',
              image: image,
              aspectRatio: 1,
            ),
          ),
          const SizedBox(width: DailySpacing.md),
          Expanded(
            child: _CoffeeSummary(
              name: name,
              roastery: roastery,
              metadata: metadata,
            ),
          ),
        ],
      ),
    ),
  );
}

class _CoffeeSummary extends StatelessWidget {
  const _CoffeeSummary({
    required this.name,
    required this.roastery,
    required this.metadata,
  });
  final String name;
  final String roastery;
  final List<String> metadata;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: DailySpacing.sm),
      Text(
        roastery,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: context.dailyColors.textSecondary),
      ),
      for (final value in metadata.take(2)) ...[
        const SizedBox(height: DailySpacing.micro),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: context.dailyColors.textSecondary),
        ),
      ],
    ],
  );
}
