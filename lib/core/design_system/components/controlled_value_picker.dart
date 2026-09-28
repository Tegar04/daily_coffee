import 'package:flutter/material.dart';

import '../theme/daily_tokens.dart';
import 'daily_buttons.dart';
import 'daily_inputs.dart';
import 'daily_surfaces.dart';

@immutable
class DailyValueOption {
  const DailyValueOption({required this.key, required this.label})
    : assert(key != 'other');
  final String key;
  final String label;
}

/// Presentation value only. Features map this to their domain value objects.
@immutable
class DailySelectedValue {
  const DailySelectedValue.known(this.key)
    : assert(key != 'other'),
      customValue = null;
  const DailySelectedValue.custom(String value)
    : key = 'other',
      customValue = value;
  final String key;
  final String? customValue;
}

class ControlledValuePicker extends StatelessWidget {
  const ControlledValuePicker({
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
    this.allowCustom = true,
    this.allowClear = true,
    this.searchable = true,
    super.key,
  });
  final String label;
  final List<DailyValueOption> options;
  final DailySelectedValue? value;
  final ValueChanged<DailySelectedValue?>? onChanged;
  final bool allowCustom;
  final bool allowClear;
  final bool searchable;

  String? get _valueLabel {
    if (value == null) return null;
    if (value!.key == 'other') return value!.customValue;
    for (final option in options) {
      if (option.key == value!.key) return option.label;
    }
    return value!.key;
  }

  @override
  Widget build(BuildContext context) => DailySelectField(
    label: label,
    valueLabel: _valueLabel,
    onTap: onChanged == null
        ? null
        : () async {
            final result = await DailyBottomSheet.show<_PickerResult>(
              context: context,
              builder: (context) => _PickerContent(picker: this),
            );
            if (result != null) onChanged?.call(result.value);
          },
  );
}

class _PickerResult {
  const _PickerResult(this.value);
  final DailySelectedValue? value;
}

class _PickerContent extends StatefulWidget {
  const _PickerContent({required this.picker});
  final ControlledValuePicker picker;
  @override
  State<_PickerContent> createState() => _PickerContentState();
}

class _PickerContentState extends State<_PickerContent> {
  final _formKey = GlobalKey<FormState>();
  late final _custom = TextEditingController(
    text: widget.picker.value?.customValue,
  );
  late bool _editingCustom = widget.picker.value?.key == 'other';
  var _query = '';
  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final picker = widget.picker;
    final options = picker.options
        .where(
          (option) => option.label.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(picker.label, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: DailySpacing.md),
        if (picker.searchable)
          DailySearchField(
            label: 'Cari pilihan',
            onChanged: (value) => setState(() => _query = value),
          ),
        for (final option in options)
          Semantics(
            selected: picker.value?.key == option.key,
            child: ListTile(
              title: Text(option.label),
              trailing: picker.value?.key == option.key
                  ? const Icon(Icons.check_rounded)
                  : null,
              onTap: () => Navigator.pop(
                context,
                _PickerResult(DailySelectedValue.known(option.key)),
              ),
            ),
          ),
        if (options.isEmpty)
          const Padding(
            padding: EdgeInsetsDirectional.all(DailySpacing.md),
            child: Text('Tidak ada pilihan yang cocok.'),
          ),
        if (picker.allowCustom) ...[
          DailyTextButton(
            label: 'Tambahkan nilai lain',
            onPressed: () => setState(() => _editingCustom = true),
          ),
          if (_editingCustom)
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DailyTextField(
                    label: 'Nilai lain',
                    controller: _custom,
                    requiredField: true,
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Isi nilai yang ingin digunakan.'
                        : null,
                  ),
                  const SizedBox(height: DailySpacing.sm),
                  DailyPrimaryButton(
                    label: 'Gunakan nilai',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(
                          context,
                          _PickerResult(
                            DailySelectedValue.custom(_custom.text.trim()),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
        ],
        if (picker.allowClear && picker.value != null)
          DailyTextButton(
            label: 'Kosongkan pilihan',
            onPressed: () => Navigator.pop(context, const _PickerResult(null)),
          ),
      ],
    );
  }
}
