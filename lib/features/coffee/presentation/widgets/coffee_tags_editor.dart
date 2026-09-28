import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:flutter/material.dart';

class CoffeeTagsEditor extends StatelessWidget {
  const CoffeeTagsEditor({
    required this.label,
    required this.values,
    required this.pending,
    required this.onChanged,
    required this.onPendingChanged,
    this.error,
    super.key,
  });
  final String label;
  final List<String> values;
  final TextEditingController pending;
  final ValueChanged<List<String>> onChanged;
  final VoidCallback onPendingChanged;
  final String? error;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DailyTextField(
        label: label,
        controller: pending,
        errorText: error,
        helperText:
            'Tambahkan satu nilai tiap kali. Nilai kustom diperbolehkan.',
        onChanged: (_) => onPendingChanged(),
      ),
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: DailyTextButton(
          label: 'Tambahkan $label',
          onPressed: () {
            if (pending.text.trim().isEmpty) return;
            onChanged(CoffeeValidation.uniqueTags([...values, pending.text]));
            pending.clear();
            onPendingChanged();
          },
        ),
      ),
      Wrap(
        spacing: DailySpacing.sm,
        runSpacing: DailySpacing.sm,
        children: [
          for (final value in values)
            InputChip(
              label: Text(value),
              deleteButtonTooltipMessage: 'Hapus $value',
              onDeleted: () => onChanged(
                values
                    .where(
                      (tag) =>
                          normalizeCoffeeText(tag) !=
                          normalizeCoffeeText(value),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    ],
  );
}
