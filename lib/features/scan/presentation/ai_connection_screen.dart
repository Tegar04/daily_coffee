import 'dart:async';

import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiConnectionScreen extends ConsumerStatefulWidget {
  const AiConnectionScreen({super.key});

  @override
  ConsumerState<AiConnectionScreen> createState() => _AiConnectionScreenState();
}

class _AiConnectionScreenState extends ConsumerState<AiConnectionScreen> {
  final _address = TextEditingController();
  final _token = TextEditingController();
  bool _busy = true;
  String _message = 'Memuat koneksi...';

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final result = await ref.read(aiConnectionServiceProvider).loadEndpoint();
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (result case Ok<Uri?>(:final value)) {
        _address.text = value?.origin ?? '';
        _message = value == null ? 'Belum ada koneksi pribadi tersimpan.' : 'Koneksi tersimpan. Token disembunyikan; masukkan token untuk memperbarui koneksi.';
      } else {
        _message = 'Koneksi tersimpan belum dapat dibaca.';
      }
    });
  }

  String _error(AppFailure failure) => switch (failure) {
    ValidationFailure() => 'Masukkan alamat HTTPS backend dan token perangkat yang valid (diawali dc_).',
    StorageFailure() =>
      'Penyimpanan aman belum tersedia. Koneksi belum dapat diubah.',
    NetworkFailure() =>
      'Backend belum dapat dihubungi. Periksa internet dan alamat server.',
    _ => switch (failure.diagnosticContext['status']) {
      401 => 'Token tidak valid, kedaluwarsa, atau sudah dicabut.',
      403 => 'Server menolak koneksi. Pastikan HTTPS dikonfigurasi.',
      429 => 'Terlalu banyak percobaan. Tunggu sebelum mencoba lagi.',
      503 => 'Konfigurasi akses atau penyimpanan kuota backend belum siap.',
      _ =>
        'Koneksi belum dapat diverifikasi. Koneksi lama tetap dipertahankan.',
    },
  };

  Future<void> _save() async {
    if (_busy) return;
    FocusScope.of(context).unfocus();
    setState(() => _busy = true);
    final result = await ref
        .read(aiConnectionServiceProvider)
        .connect(_address.text, _token.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (result is Ok<void>) {
        _token.clear();
        _message =
            'Koneksi berhasil disimpan. Buat scan baru untuk memakai AI.';
      } else {
        _message = _error((result as Err<void>).failure);
      }
    });
  }

  Future<void> _clear() async {
    if (_busy) return;
    setState(() => _busy = true);
    final result = await ref.read(aiConnectionServiceProvider).disconnect();
    if (!mounted) return;
    setState(() {
      _busy = false;
      if (result is Ok<void>) {
        _address.clear();
        _token.clear();
        _message = 'Koneksi pribadi dihapus dari HP. Pencabutan token dilakukan di backend.';
      } else {
        _message = _error((result as Err<void>).failure);
      }
    });
  }

  @override
  void dispose() {
    _address.dispose();
    _token.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const DailyAppBar(title: 'Koneksi AI'),
    body: DailyPageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Hubungkan HP ke backend pribadi. Masukkan token perangkat dari pengelola backend, bukan API key OpenAI.',
          ),
          const SizedBox(height: DailySpacing.md),
          TextField(
            controller: _address,
            enabled: !_busy,
            autocorrect: false,
            keyboardType: TextInputType.url,
            decoration: const InputDecoration(
              labelText: 'Alamat backend',
              hintText: 'https://backend.example.com',
            ),
          ),
          const SizedBox(height: DailySpacing.md),
          TextField(
            controller: _token,
            enabled: !_busy,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            enableIMEPersonalizedLearning: false,
            decoration: const InputDecoration(labelText: 'Token perangkat'),
          ),
          const SizedBox(height: DailySpacing.md),
          DailyPrimaryButton(
            label: 'Periksa & simpan',
            onPressed: _busy ? null : _save,
          ),
          DailyTextButton(
            label: 'Hapus koneksi tersimpan',
            onPressed: _busy ? null : _clear,
          ),
          if (_busy) const LinearProgressIndicator(),
          Text(_message),
          const SizedBox(height: DailySpacing.md),
          const Text(
            'Pemeriksaan koneksi tidak memanggil OpenAI atau mengirim teks label. Token disimpan dalam penyimpanan aman perangkat.',
          ),
        ],
      ),
    ),
  );
}
