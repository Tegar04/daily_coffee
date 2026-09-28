import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

class JournalEntryCard extends StatelessWidget {
  const JournalEntryCard({
    required this.coffeeName,
    required this.brewMethod,
    required this.brewedAt,
    required this.onTap,
    this.rating,
    this.notes,
    super.key,
  }) : assert(rating == null || (rating >= 1 && rating <= 5));
  final String coffeeName;
  final String brewMethod;
  final DateTime brewedAt;
  final int? rating;
  final String? notes;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatMediumDate(brewedAt);
    final ratingLabel = rating == null
        ? 'Belum dinilai'
        : 'Nilai pribadi $rating dari 5';
    return DailyCard(
      onTap: onTap,
      semanticLabel:
          '$coffeeName, $brewMethod, $date, $ratingLabel${notes == null ? '' : ', $notes'}',
      child: Padding(
        padding: const EdgeInsetsDirectional.all(DailySpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: context.dailyColors.textSecondary),
            ),
            const SizedBox(height: DailySpacing.sm),
            Text(
              coffeeName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: DailySpacing.sm),
            Text(brewMethod),
            Text(ratingLabel, style: Theme.of(context).textTheme.bodyMedium),
            if (notes != null) ...[
              const SizedBox(height: DailySpacing.sm),
              Text(notes!, maxLines: 2, overflow: TextOverflow.ellipsis),
            ],
          ],
        ),
      ),
    );
  }
}
