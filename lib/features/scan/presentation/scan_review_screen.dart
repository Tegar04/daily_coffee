import 'dart:async';

import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
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
  void initState() {
    super.initState();
    if (widget.initial.revision == 1) {
      _aiBusy = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_fillWithAi());
      });
    }
  }

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
    ++_aiGeneration;
    ref.read(_provider.notifier).cancelAi();
    setState(() {
      _leaving = true;
      _aiBusy = false;
      _aiSending = false;
    });
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

  int _aiGeneration = 0;
  bool _aiBusy = false;
  bool _aiSending = false;
  String? _aiMessage;

  String _aiError(AppFailure failure) {
    if (failure is NetworkFailure) {
      return 'Backend belum dapat dihubungi atau waktu tunggu habis. Isian tetap tersimpan; Anda bisa melanjutkan manual.';
    }
    if (failure is StorageFailure) {
      return 'Simpan draft belum berhasil. Coba simpan draft lagi sebelum memakai AI.';
    }
    if (failure is ConflictFailure) {
      return 'Isian berubah saat AI memproses. Hasil AI tidak diterapkan.';
    }
    if (failure is ValidationFailure) {
      return 'Teks label kosong atau terlalu panjang untuk diproses.';
    }
    return switch (failure.diagnosticContext['status']) {
      401 => 'Akses AI kedaluwarsa atau dicabut. Perbarui token di Pengaturan > Koneksi AI, lalu buat scan baru. Isian ini tetap bisa dilengkapi manual.',
      429 => 'Batas penggunaan AI tercapai. Coba lagi nanti atau isi manual.',
      403 => 'Akses backend ditolak. Periksa alamat HTTPS di Pengaturan > Koneksi AI atau koneksi USB untuk pengujian lokal.',
      503 => 'Layanan AI belum siap. Periksa konfigurasi backend.',
      _ =>
        failure.diagnosticContext['reason'] == 'not_configured'
            ? 'Layanan AI belum tersedia pada versi aplikasi ini. Anda tetap bisa mengisi manual.'
            : 'Hasil AI belum dapat digunakan. Isian tetap tersedia untuk diperbaiki manual.',
    };
  }

  Future<void> _fillWithAi() async {
    final generation = ++_aiGeneration;
    FocusScope.of(context).unfocus();
    setState(() {
      _aiBusy = true;
      _aiMessage = null;
    });
    setState(() => _aiSending = true);
    final result = await ref
        .read(_provider.notifier)
        .fillWithAi(onlyIfNew: true);
    if (!mounted) return;
    // Navigation/cancellation may have invalidated this request while awaiting.
    if (!_aiBusy || generation != _aiGeneration) return;
    if (result case Ok<CoffeeFormValues>(:final value)) {
      for (final field in CoffeeField.values) {
        _text[field]!.text = value[field];
      }
      _varieties.text = value.varieties.join('; ');
      _notes.text = value.tastingNotes.join('; ');
      setState(() {
        _aiBusy = false;
        _aiSending = false;
        _confirmed = false;
        _aiMessage = 'Hasil AI diterapkan ke draft. Periksa seluruh informasi sebelum menyimpan kopi.';
      });
    } else {
      setState(() {
        _aiBusy = false;
        _aiSending = false;
        _aiMessage = _aiError((result as Err<CoffeeFormValues>).failure);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_provider).asData!.value;
    final draft = state.draft;
    final errors = _showErrors
        ? CoffeeValidation.validate(_values)
        : <CoffeeField, CoffeeValidationIssue>{};
    final busy = state.submitting || _leaving || _aiBusy;
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
            onPressed: state.submitting || _leaving ? null : _leave,
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
              if (_aiBusy) const Text('Mengisi informasi dari label...'),
              const Text(
                'Informasi label diisi otomatis dengan AI. Periksa hasilnya dan edit bila diperlukan.',
              ),
              if (_aiSending) const LinearProgressIndicator(),
              if (_aiMessage != null)
                Text(_aiMessage!, semanticsLabel: _aiMessage),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      field == CoffeeField.roastLevelKey
                          ? DropdownButtonFormField<String>(
                              key: ValueKey(_text[field]!.text),
                              initialValue: _text[field]!.text.isEmpty
                                  ? null
                                  : _text[field]!.text,
                              decoration: InputDecoration(
                                labelText: 'Roast level',

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
                                _text[CoffeeField.roastLevelKey]!.text !=
                                    'other'
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
                              ],
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
                onPressed: state.submitting || _leaving ? null : _leave,
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
