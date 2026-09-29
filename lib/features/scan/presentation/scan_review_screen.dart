import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/coffee/presentation/coffee_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/scan_review_controller.dart';
import '../domain/coffee_draft.dart';

class ScanReviewScreen extends ConsumerWidget {
  const ScanReviewScreen({required this.draftId, super.key});
  final String? draftId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (draftId == null) {
      return Scaffold(
        appBar: const DailyAppBar(title: 'Periksa informasi'),
        body: DailyPageBody(
          child: DailyEmptyState(
            title: 'Pilih draft scan',
            message: 'Buka hasil scan untuk memeriksa informasinya.',
            actionLabel: 'Buka scan',
            onAction: () => const ScanRoute().go(context),
          ),
        ),
      );
    }
    final query = ref.watch(scanReviewControllerProvider(draftId!));
    return query.when(
      data: (value) =>
          _ReviewEditor(key: ValueKey(draftId), initial: value.draft),
      loading: () => const Scaffold(
        body: DailyPageBody(
          child: DailyLoadingState(label: 'Menyiapkan informasi kopi'),
        ),
      ),
      error: (_, _) => Scaffold(
        appBar: const DailyAppBar(title: 'Periksa informasi'),
        body: DailyPageBody(
          child: Column(
            children: [
              DailyErrorState(
                message: 'Draft belum dapat dibuka. Draft mungkin sudah disimpan atau dihapus.',
                onRetry: () =>
                    ref.invalidate(scanReviewControllerProvider(draftId!)),
              ),
              DailyTextButton(
                label: 'Kembali ke scan',
                onPressed: () => const ScanRoute().go(context),
              ),
              DailyTextButton(
                label: 'Isi manual',
                onPressed: () => const NewCoffeeRoute().go(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewEditor extends ConsumerStatefulWidget {
  const _ReviewEditor({required this.initial, super.key});
  final CoffeeDraft initial;
  @override
  ConsumerState<_ReviewEditor> createState() => _ReviewEditorState();
}

class _ReviewEditorState extends ConsumerState<_ReviewEditor> {
  late final _provider = scanReviewControllerProvider(widget.initial.id);
  late final _text = {
    for (final f in CoffeeField.values)
      f: TextEditingController(text: widget.initial.values[f]),
  };
  late final _varieties = TextEditingController(
    text: widget.initial.values.varieties.join('; '),
  );
  late final _notes = TextEditingController(
    text: widget.initial.values.tastingNotes.join('; '),
  );
  final _keys = {for (final f in CoffeeField.values) f: GlobalKey()};
  bool _confirmed = false;
  bool _showErrors = false;
  bool _allowLeave = false;
  bool _leaving = false;
  late bool _photo = widget.initial.includePhoto;
  @override
  void dispose() {
    for (final c in _text.values) {
      c.dispose();
    }
    _varieties.dispose();
    _notes.dispose();
    super.dispose();
  }

  List<String> _tags(String value) => value
      .split(RegExp(r'[,;]'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
  CoffeeFormValues get _values => CoffeeFormValues(
    fields: {for (final f in CoffeeField.values) f: _text[f]!.text},
    varieties: _tags(_varieties.text),
    tastingNotes: _tags(_notes.text),
  );
  void _change() {
    setState(() => _confirmed = false);
    ref.read(_provider.notifier).change(_values, _photo);
  }

  Future<void> _leave() async {
    if (_leaving || ref.read(_provider).asData!.value.submitting) return;
    setState(() => _leaving = true);
    final saved = await ref.read(_provider.notifier).flush();
    if (!mounted) return;
    setState(() => _leaving = false);
    if (!saved) return;
    await _exit();
  }

  Future<void> _exit() async {
    setState(() => _allowLeave = true);
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) const ScanRoute().go(context);
  }

  Future<void> _save() async {
    if (!_confirmed) return;
    FocusScope.of(context).unfocus();
    setState(() => _showErrors = true);
    final errors = CoffeeValidation.validate(_values);
    if (errors.isNotEmpty ||
        CoffeeValidation.validateTags(_values.varieties) != null ||
        CoffeeValidation.validateTags(_values.tastingNotes) != null) {
      await WidgetsBinding.instance.endOfFrame;
      if (!mounted || errors.isEmpty) return;
      final fieldContext = _keys[errors.keys.first]!.currentContext;
      if (fieldContext != null && fieldContext.mounted) {
        await Scrollable.ensureVisible(fieldContext, alignment: 0.2);
      }
      return;
    }
    final result = await ref.read(_provider.notifier).confirm();
    if (!mounted) return;
    if (result case Ok<Coffee>(:final value)) {
      setState(() => _allowLeave = true);
      await WidgetsBinding.instance.endOfFrame;
      if (mounted) CoffeeDetailRoute(coffeeId: value.id.value).go(context);
    }
  }

  String? _key(CoffeeField f) => switch (f) {
    CoffeeField.originCountry => 'origin_country',
    CoffeeField.roastDate => 'roast_date',
    CoffeeField.packageWeightGrams => 'package_weight',
    CoffeeField.altitudeMinMeters ||
    CoffeeField.altitudeMaxMeters => 'altitude',
    CoffeeField.roastLevelKey || CoffeeField.roastLevelCustom => 'roast_level',
    CoffeeField.purchaseDate || CoffeeField.personalNote => null,
    _ => f.name,
  };
  String _hint(CoffeeDraft draft, String? key) {
    final field = draft.fields.where((f) => f.key == key).firstOrNull;
    if (field == null) {
      return 'Isi jika diketahui; jangan menebak informasi yang tidak ada.';
    }
    final confidence = field.confidence == null
        ? ''
        : ' Keyakinan pembacaan teks: ${(field.confidence! * 100).round()}%.';
    return '${field.source == DraftValueSource.user
        ? 'Diubah oleh Anda.'
        : field.status == ScanReviewStatus.needsReview
        ? 'Perlu diperiksa.'
        : 'Dari label; periksa kembali.'} Label: ${field.rawValue}.$confidence';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider).asData!.value;
    final draft = state.draft;
    final errors = _showErrors
        ? CoffeeValidation.validate(_values)
        : <CoffeeField, CoffeeValidationIssue>{};
    final busy = state.submitting || _leaving;
    return PopScope(
      canPop: _allowLeave,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop) await _leave();
      },
      child: Scaffold(
        appBar: DailyAppBar(
          title: 'Periksa informasi',
          leading: IconButton(
            tooltip: 'Simpan draft dan kembali',
            icon: const Icon(Icons.arrow_back),
            onPressed: busy ? null : _leave,
          ),
        ),
        body: DailyPageBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Periksa hasil pembacaan label. Lengkapi atau koreksi informasi sebelum menyimpan kopi.',
              ),
              const SizedBox(height: DailySpacing.md),
              if (draft.image case final image?)
                SizedBox(
                  height: 220,
                  child: ref
                      .watch(managedPhotoProvider(image.localPath))
                      .when(
                        data: (p) => p == null
                            ? const Center(
                                child: Text(
                                  'Foto tidak tersedia. Nonaktifkan foto untuk menyimpan tanpa foto.',
                                ),
                              )
                            : Image(image: p, fit: BoxFit.contain),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (_, _) => const Text('Foto tidak tersedia.'),
                      ),
                ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Sertakan foto label'),
                value: _photo,
                onChanged: busy
                    ? null
                    : (v) {
                        _photo = v!;
                        _change();
                      },
              ),
              ExpansionTile(
                title: const Text('Lihat teks asli label'),
                children: [SelectableText(draft.text.text)],
              ),
              const SizedBox(height: DailySpacing.md),
              for (final field in CoffeeField.values)
                Padding(
                  key: _keys[field],
                  padding: const EdgeInsets.only(bottom: DailySpacing.md),
                  child: field == CoffeeField.roastLevelKey
                      ? DropdownButtonFormField<String>(
                          initialValue: _text[field]!.text.isEmpty
                              ? null
                              : _text[field]!.text,
                          decoration: InputDecoration(
                            labelText: 'Roast level',
                            helperText: _hint(draft, 'roast_level'),
                            helperMaxLines: 5,
                            errorText: coffeeIssueMessage(errors[field]),
                          ),
                          items: [
                            const DropdownMenuItem(
                              value: '',
                              child: Text('Belum diketahui'),
                            ),
                            for (final level in RoastLevel.values)
                              DropdownMenuItem(
                                value: level.key,
                                child: Text(roastLevelLabel(level)),
                              ),
                          ],
                          onChanged: busy
                              ? null
                              : (v) {
                                  _text[field]!.text = v ?? '';
                                  if (v != 'other') {
                                    _text[CoffeeField.roastLevelCustom]!
                                        .clear();
                                  }
                                  _change();
                                },
                        )
                      : field == CoffeeField.roastLevelCustom &&
                            _text[CoffeeField.roastLevelKey]!.text != 'other'
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DailyTextField(
                              label: coffeeFieldLabel(field),
                              controller: _text[field],
                              requiredField:
                                  field == CoffeeField.name ||
                                  field == CoffeeField.roastery,
                              enabled: !busy,
                              errorText: coffeeIssueMessage(errors[field]),
                              maxLines: field == CoffeeField.personalNote
                                  ? 4
                                  : 1,
                              helperText:
                                  field == CoffeeField.roastDate ||
                                      field == CoffeeField.purchaseDate
                                  ? 'Format YYYY-MM-DD, contoh 2026-09-29'
                                  : null,
                              onChanged: (_) => _change(),
                            ),
                            Text(
                              _hint(draft, _key(field)),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                ),
              DailyTextField(
                label: 'Varietas',
                controller: _varieties,
                enabled: !busy,
                helperText: 'Pisahkan dengan koma atau titik koma',
                errorText: _showErrors
                    ? coffeeIssueMessage(
                        CoffeeValidation.validateTags(_values.varieties),
                      )
                    : null,
                onChanged: (_) => _change(),
              ),
              Text(
                _hint(draft, 'varieties'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: DailySpacing.md),
              DailyTextField(
                label: 'Tasting notes',
                controller: _notes,
                enabled: !busy,
                helperText: 'Pisahkan dengan koma atau titik koma',
                errorText: _showErrors
                    ? coffeeIssueMessage(
                        CoffeeValidation.validateTags(_values.tastingNotes),
                      )
                    : null,
                onChanged: (_) => _change(),
              ),
              Text(
                _hint(draft, 'tasting_notes'),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: DailySpacing.md),
              if (state.failure case final failure?) ...[
                Text(coffeeFailureMessage(failure)),
                DailyTextButton(
                  label: 'Coba simpan draft lagi',
                  onPressed: busy
                      ? null
                      : () => ref.read(_provider.notifier).flush(),
                ),
              ] else
                Text(
                  state.saving
                      ? 'Menyimpan draft…'
                      : 'Draft tersimpan di perangkat.',
                ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Saya sudah memeriksa informasi kopi.'),
                value: _confirmed,
                onChanged: busy ? null : (v) => setState(() => _confirmed = v!),
              ),
              DailyPrimaryButton(
                label: state.submitting
                    ? 'Menyimpan kopi…'
                    : 'Konfirmasi & simpan kopi',
                onPressed: !_confirmed || busy ? null : _save,
              ),
              DailyTextButton(
                label: 'Simpan draft & kembali',
                onPressed: busy ? null : _leave,
              ),
              DailyTextButton(
                label: 'Hapus draft',
                onPressed: busy
                    ? null
                    : () async {
                        final delete = await DailyDialog.confirm(
                          context: context,
                          title: 'Hapus draft?',
                          message:
                              'Foto, teks label, dan isian draft akan dihapus.',
                          confirmLabel: 'Hapus',
                          cancelLabel: 'Batal',
                          destructive: true,
                        );
                        if (!delete || !mounted) return;
                        final removed = await ref
                            .read(_provider.notifier)
                            .discard();
                        if (removed && mounted) await _exit();
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
