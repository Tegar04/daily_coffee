import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/application/coffee_form_controller.dart';
import 'package:daily_coffee/features/coffee/application/coffee_queries.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/coffee/presentation/coffee_labels.dart';
import 'package:daily_coffee/features/coffee/presentation/widgets/coffee_tags_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CoffeeFormScreen extends ConsumerWidget {
  const CoffeeFormScreen({this.coffeeId, super.key});
  final String? coffeeId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (coffeeId == null) return const _CoffeeEditor();
    final query = ref.watch(coffeeDetailProvider(coffeeId!));
    Widget loadError() => Scaffold(
      appBar: const DailyAppBar(title: 'Edit kopi'),
      body: DailyPageBody(
        child: DailyErrorState(
          message: 'Kopi belum dapat dimuat.',
          onRetry: () => ref.invalidate(coffeeDetailProvider(coffeeId!)),
        ),
      ),
    );
    return query.when(
      data: (result) => switch (result) {
        Ok<Coffee?>(value: final coffee?) => _CoffeeEditor(
          key: ValueKey(coffeeId),
          initial: coffee,
        ),
        Err<Coffee?>(failure: final failure) when failure is! NotFoundFailure =>
          loadError(),
        _ => Scaffold(
          appBar: const DailyAppBar(title: 'Edit kopi'),
          body: DailyPageBody(
            child: DailyEmptyState(
              title: 'Kopi tidak tersedia',
              message: 'Kembali ke koleksi untuk memilih kopi.',
              actionLabel: 'Kembali ke Koleksi',
              onAction: () => const LibraryRoute().go(context),
            ),
          ),
        ),
      },
      loading: () => const Scaffold(
        body: DailyPageBody(child: DailyLoadingState(label: 'Memuat kopi')),
      ),
      error: (_, _) => loadError(),
    );
  }
}

class _CoffeeEditor extends ConsumerStatefulWidget {
  const _CoffeeEditor({this.initial, super.key});
  final Coffee? initial;
  @override
  ConsumerState<_CoffeeEditor> createState() => _CoffeeEditorState();
}

class _CoffeeEditorState extends ConsumerState<_CoffeeEditor> {
  late final Coffee? _initial = widget.initial;
  late final _provider = coffeeFormControllerProvider(_initial);
  late final _text = {
    for (final field in CoffeeField.values)
      field: TextEditingController(text: _initial?.toFormValues()[field] ?? ''),
  };
  final _variety = TextEditingController();
  final _tasting = TextEditingController();
  final _keys = {for (final field in CoffeeField.values) field: GlobalKey()};
  final _focus = {for (final field in CoffeeField.values) field: FocusNode()};
  var _expanded = false;
  var _allowLeave = false;
  var _confirming = false;
  @override
  void dispose() {
    for (final controller in _text.values) {
      controller.dispose();
    }
    for (final node in _focus.values) {
      node.dispose();
    }
    _variety.dispose();
    _tasting.dispose();
    super.dispose();
  }

  bool _dirty(CoffeeFormState state) =>
      state.isDirty ||
      _variety.text.trim().isNotEmpty ||
      _tasting.text.trim().isNotEmpty;

  Future<void> _leave() async {
    final state = ref.read(_provider);
    if (state.submitting || _confirming) return;
    _confirming = true;
    final discard =
        !_dirty(state) ||
        await DailyDialog.confirm(
          context: context,
          title: 'Buang perubahan?',
          message: 'Perubahan yang belum disimpan akan hilang.',
          confirmLabel: 'Buang',
          cancelLabel: 'Tetap mengedit',
          destructive: true,
        );
    _confirming = false;
    if (!discard || !mounted) return;
    setState(() => _allowLeave = true);
    await WidgetsBinding.instance.endOfFrame;
    if (!mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      const LibraryRoute().go(context);
    }
  }

  Future<void> _save() async {
    if (ref.read(_provider).submitting) return;
    FocusScope.of(context).unfocus();
    final controller = ref.read(_provider.notifier);
    final values = ref.read(_provider).values;
    controller.change(
      values.withTags(
        varieties: CoffeeValidation.uniqueTags([
          ...values.varieties,
          if (_variety.text.trim().isNotEmpty) _variety.text,
        ]),
        tastingNotes: CoffeeValidation.uniqueTags([
          ...values.tastingNotes,
          if (_tasting.text.trim().isNotEmpty) _tasting.text,
        ]),
      ),
    );
    _variety.clear();
    _tasting.clear();
    final result = await controller.submit();
    if (!mounted) return;
    switch (result) {
      case Ok<Coffee>(:final value):
        setState(() => _allowLeave = true);
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        if (_initial != null && context.canPop()) {
          context.pop();
        } else {
          context.replace(CoffeeDetailRoute(coffeeId: value.id.value).location);
        }
      case Err<Coffee>():
        final errors = ref.read(_provider).errors;
        setState(() => _expanded = true);
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted || errors.isEmpty) return;
        final field = errors.keys.first;
        _focus[field]?.requestFocus();
        final target = _keys[field]?.currentContext;
        if (target != null && target.mounted) {
          await Scrollable.ensureVisible(target);
        }
    }
  }

  Future<void> _date(CoffeeField field) async {
    final current = CoffeeDate.tryParse(ref.read(_provider).values[field]);
    final picked = await showDatePicker(
      context: context,
      initialDate: current?.toLocalDate() ?? DateTime.now(),
      firstDate: DateTime(1),
      lastDate: DateTime(9999, 12, 31),
    );
    if (!mounted || picked == null) return;
    ref
        .read(_provider.notifier)
        .setField(
          field,
          CoffeeDate(picked.year, picked.month, picked.day).toString(),
        );
  }

  Widget _field(
    CoffeeField field,
    CoffeeFormState state, {
    bool required = false,
    bool number = false,
    bool multiline = false,
  }) => Padding(
    padding: const EdgeInsetsDirectional.only(bottom: DailySpacing.md),
    child: DailyTextField(
      key: _keys[field],
      label: coffeeFieldLabel(field),
      controller: _text[field],
      focusNode: _focus[field],
      requiredField: required,
      enabled: !state.submitting,
      errorText: coffeeIssueMessage(state.errors[field]),
      keyboardType: number
          ? TextInputType.number
          : multiline
          ? TextInputType.multiline
          : TextInputType.text,
      textInputAction: multiline
          ? TextInputAction.newline
          : TextInputAction.next,
      minLines: multiline ? 3 : 1,
      maxLines: multiline ? 8 : 1,
      onChanged: (value) => ref.read(_provider.notifier).setField(field, value),
    ),
  );

  Widget _dateField(CoffeeField field, CoffeeFormState state) {
    final date = CoffeeDate.tryParse(state.values[field]);
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: DailySpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DailySelectField(
            label: coffeeFieldLabel(field),
            valueLabel: date == null
                ? null
                : MaterialLocalizations.of(context)
                      .formatMediumDate(date.toLocalDate()),
            onTap: () => _date(field),
            errorText: coffeeIssueMessage(state.errors[field]),
          ),
          if (date != null)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: DailyTextButton(
                label: 'Hapus ${coffeeFieldLabel(field).toLowerCase()}',
                onPressed: () =>
                    ref.read(_provider.notifier).setField(field, ''),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider);
    final controller = ref.read(_provider.notifier);
    final roastKey = state.values[CoffeeField.roastLevelKey];
    final process = state.values[CoffeeField.process];
    const processes = ['Washed', 'Natural', 'Honey', 'Anaerobic'];
    return PopScope(
      canPop:
          !state.submitting &&
          (_allowLeave || !_dirty(state)) &&
          context.canPop(),
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) await _leave();
      },
      child: Scaffold(
        appBar: DailyAppBar(
          title: _initial == null ? 'Tambah kopi' : 'Edit kopi',
          leading: DailyIconButton(
            label: 'Kembali',
            icon: Icons.arrow_back,
            onPressed: state.submitting ? null : _leave,
          ),
        ),
        body: DailyPageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Isi yang kamu ketahui. Detail lain dapat ditambahkan nanti.',
              ),
              const SizedBox(height: DailySpacing.lg),
              if (state.failure != null) ...[
                Semantics(
                  liveRegion: true,
                  child: Text(
                    coffeeFailureMessage(state.failure!),
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(color: context.dailyColors.error),
                  ),
                ),
                const SizedBox(height: DailySpacing.md),
              ],
              AbsorbPointer(
                absorbing: state.submitting,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _field(CoffeeField.name, state, required: true),
                    _field(CoffeeField.roastery, state, required: true),
                    _field(CoffeeField.originCountry, state),
                    ControlledValuePicker(
                      label: 'Proses',
                      options: [
                        for (final value in processes)
                          DailyValueOption(key: value, label: value),
                      ],
                      value: process.isEmpty
                          ? null
                          : processes.contains(process)
                          ? DailySelectedValue.known(process)
                          : DailySelectedValue.custom(process),
                      onChanged: (value) => controller.setField(
                        CoffeeField.process,
                        value?.customValue ?? value?.key ?? '',
                      ),
                    ),
                    const SizedBox(height: DailySpacing.md),
                    ControlledValuePicker(
                      label: 'Roast level',
                      options: [
                        for (final level in RoastLevel.values.where(
                          (level) => level != RoastLevel.other,
                        ))
                          DailyValueOption(
                            key: level.key,
                            label: roastLevelLabel(level),
                          ),
                      ],
                      value: roastKey.isEmpty
                          ? null
                          : roastKey == 'other'
                          ? DailySelectedValue.custom(
                              state.values[CoffeeField.roastLevelCustom],
                            )
                          : DailySelectedValue.known(roastKey),
                      onChanged: (value) => controller.change(
                        state.values
                            .set(CoffeeField.roastLevelKey, value?.key ?? '')
                            .set(
                              CoffeeField.roastLevelCustom,
                              value?.customValue ?? '',
                            ),
                      ),
                    ),
                    const SizedBox(height: DailySpacing.lg),
                    CoffeeTagsEditor(
                      label: 'Tasting notes',
                      values: state.values.tastingNotes,
                      pending: _tasting,
                      error: coffeeIssueMessage(state.tastingError),
                      onPendingChanged: () => setState(() {}),
                      onChanged: (values) => controller.change(
                        ref
                            .read(_provider)
                            .values
                            .withTags(tastingNotes: values),
                      ),
                    ),
                    const SizedBox(height: DailySpacing.lg),
                    Semantics(
                      expanded: _expanded,
                      child: DailySecondaryButton(
                        label: _expanded
                            ? 'Sembunyikan detail lainnya'
                            : 'Detail lainnya',
                        icon: _expanded
                            ? Icons.expand_less_rounded
                            : Icons.expand_more_rounded,
                        onPressed: () => setState(() => _expanded = !_expanded),
                      ),
                    ),
                    if (_expanded) ...[
                      const SizedBox(height: DailySpacing.lg),
                      _field(CoffeeField.region, state),
                      _field(CoffeeField.producer, state),
                      CoffeeTagsEditor(
                        label: 'Varietas',
                        values: state.values.varieties,
                        pending: _variety,
                        error: coffeeIssueMessage(state.varietyError),
                        onPendingChanged: () => setState(() {}),
                        onChanged: (values) => controller.change(
                          ref
                              .read(_provider)
                              .values
                              .withTags(varieties: values),
                        ),
                      ),
                      const SizedBox(height: DailySpacing.md),
                      _field(
                        CoffeeField.altitudeMinMeters,
                        state,
                        number: true,
                      ),
                      _field(
                        CoffeeField.altitudeMaxMeters,
                        state,
                        number: true,
                      ),
                      _dateField(CoffeeField.roastDate, state),
                      _dateField(CoffeeField.purchaseDate, state),
                      _field(
                        CoffeeField.packageWeightGrams,
                        state,
                        number: true,
                      ),
                      _field(CoffeeField.personalNote, state, multiline: true),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: DailySpacing.lg),
              DailyPrimaryButton(
                label: _initial == null ? 'Simpan kopi' : 'Simpan perubahan',
                loading: state.submitting,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
