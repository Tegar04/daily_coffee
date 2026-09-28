import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/daily_tokens.dart';
import 'daily_buttons.dart';

class DailyTextField extends StatelessWidget {
  const DailyTextField({
    required this.label,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.helperText,
    this.errorText,
    this.requiredField = false,
    this.enabled = true,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
    this.focusNode,
    this.minLines = 1,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    super.key,
  });
  final String label;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final String? helperText;
  final String? errorText;
  final bool requiredField;
  final bool enabled;
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final int minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    initialValue: initialValue,
    onChanged: onChanged,
    validator: validator,
    autovalidateMode: AutovalidateMode.disabled,
    enabled: enabled,
    autofocus: autofocus,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    textCapitalization: textCapitalization,
    inputFormatters: inputFormatters,
    focusNode: focusNode,
    minLines: minLines,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: requiredField ? '$label (wajib)' : label,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    ),
  );
}

class DailyMultilineField extends DailyTextField {
  const DailyMultilineField({
    required super.label,
    super.controller,
    super.onChanged,
    super.validator,
    super.helperText,
    super.errorText,
    super.key,
  }) : super(
         minLines: 3,
         maxLines: 8,
         keyboardType: TextInputType.multiline,
         textInputAction: TextInputAction.newline,
       );
}

class DailySearchField extends StatefulWidget {
  const DailySearchField({
    this.controller,
    this.onChanged,
    this.autofocus = false,
    this.label = 'Cari kopi',
    super.key,
  });
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final String label;
  @override
  State<DailySearchField> createState() => _DailySearchFieldState();
}

class _DailySearchFieldState extends State<DailySearchField> {
  TextEditingController? _owned;
  TextEditingController get _controller =>
      widget.controller ?? (_owned ??= TextEditingController());
  @override
  void dispose() {
    _owned?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (context, value, child) => DailyTextField(
          label: widget.label,
          controller: _controller,
          autofocus: widget.autofocus,
          onChanged: widget.onChanged,
          textInputAction: TextInputAction.search,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: value.text.isEmpty
              ? null
              : DailyIconButton(
                  label: 'Hapus pencarian',
                  icon: Icons.close_rounded,
                  onPressed: () {
                    _controller.clear();
                    widget.onChanged?.call('');
                  },
                ),
        ),
      );
}

class DailySelectField extends StatelessWidget {
  const DailySelectField({
    required this.label,
    required this.valueLabel,
    required this.onTap,
    this.errorText,
    super.key,
  });
  final String label;
  final String? valueLabel;
  final VoidCallback? onTap;
  final String? errorText;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    value: valueLabel ?? 'Belum dipilih',
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DailyRadii.medium),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            errorText: errorText,
            enabled: onTap != null,
          ),
          child: Row(
            children: [
              Expanded(child: Text(valueLabel ?? 'Pilih')),
              const Icon(Icons.expand_more_rounded),
            ],
          ),
        ),
      ),
    ),
  );
}
