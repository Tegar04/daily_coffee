import 'package:flutter/material.dart';

import '../theme/daily_theme_extension.dart';
import '../theme/daily_tokens.dart';
import 'daily_buttons.dart';

/// Controlled nullable integer rating. No implicit rating is assigned.
class DailyRatingInput extends StatelessWidget {
  const DailyRatingInput({
    required this.value,
    required this.onChanged,
    super.key,
  }) : assert(value == null || (value >= 1 && value <= 5));
  final int? value;
  final ValueChanged<int?>? onChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Nilai pribadi (opsional)',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: DailySpacing.sm),
      Wrap(
        children: [
          for (var rating = 1; rating <= 5; rating++)
            Semantics(
              selected: value == rating,
              child: IconButton(
                tooltip: '$rating dari 5',
                color: context.dailyColors.primary,
                onPressed: onChanged == null ? null : () => onChanged!(rating),
                icon: Icon(
                  value != null && rating <= value!
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                ),
              ),
            ),
        ],
      ),
      Semantics(
        liveRegion: true,
        child: Text(
          value == null ? 'Belum dinilai' : 'Nilai pribadi $value dari 5',
        ),
      ),
      if (value != null)
        DailyTextButton(
          label: 'Hapus penilaian',
          onPressed: onChanged == null ? null : () => onChanged!(null),
        ),
    ],
  );
}
