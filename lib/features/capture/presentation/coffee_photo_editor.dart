import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/core/images/managed_image.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:daily_coffee/features/capture/domain/recovered_capture.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_photo_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeePhotoEditor extends ConsumerStatefulWidget {
  const CoffeePhotoEditor({
    required this.targetCoffeeId,
    required this.initialPath,
    required this.initialPhotoId,
    required this.edit,
    required this.checkpoint,
    required this.onChanged,
    required this.onBusy,
    required this.onRestore,
    super.key,
  });
  final String? targetCoffeeId;
  final String? initialPath;
  final String? initialPhotoId;
  final CoffeePhotoEdit? edit;
  final Map<String, Object?> Function() checkpoint;
  final ValueChanged<CoffeePhotoEdit?> onChanged;
  final ValueChanged<bool> onBusy;
  final ValueChanged<RecoveredCapture> onRestore;
  @override
  ConsumerState<CoffeePhotoEditor> createState() => _CoffeePhotoEditorState();
}

class _CoffeePhotoEditorState extends ConsumerState<CoffeePhotoEditor> {
  bool _busy = false;
  String? _error;
  String? get _expectedPhotoId => widget.edit == null
      ? widget.initialPhotoId
      : widget.edit!.expectedPhotoId;
  void _setBusy(bool value) {
    if (!mounted) return;
    setState(() => _busy = value);
    widget.onBusy(value);
  }

  String _message(AppFailure failure) => switch (failure) {
    PermissionDeniedFailure() =>
      'Akses foto/kamera ditolak. Pilih galeri atau lanjutkan tanpa foto.',
    PermissionPermanentlyDeniedFailure() =>
      'Aktifkan izin kamera di pengaturan aplikasi, atau lanjutkan tanpa foto.',
    ImageValidationFailure() =>
      'Gunakan JPEG, PNG, atau WebP statis, maksimal 25 MB dan 40 megapiksel.',
    CameraUnavailableFailure() =>
      'Kamera belum tersedia. Pilih galeri atau lanjutkan tanpa foto.',
    _ => 'Foto belum dapat diproses. Coba lagi atau lanjutkan tanpa foto.',
  };
  Future<void> _discard(ManagedImage? image) async {
    if (image == null) return;
    try {
      await (await ref.read(captureServiceProvider.future)).discard(image.id);
    } catch (_) {
      /* Retained recovery and cleanup handle temporary storage failure. */
    }
    if (mounted) ref.invalidate(recoveredCapturesProvider);
  }

  Future<void> _pick(PhotoSource source) async {
    if (_busy) return;
    final checkpoint = widget.checkpoint();
    _setBusy(true);
    setState(() => _error = null);
    try {
      final service = await ref.read(captureServiceProvider.future);
      final result = await service.acquire(
        source,
        targetCoffeeId: widget.targetCoffeeId,
        context: checkpoint,
      );
      if (!mounted) return;
      if (result case Err<ManagedImage?>(:final failure)) {
        setState(() => _error = _message(failure));
      } else if (result case Ok<ManagedImage?>(value: final image?)) {
        final use = await Navigator.of(context).push<bool>(
          MaterialPageRoute(builder: (_) => PhotoPreview(image: image)),
        );
        if (!mounted) return;
        if (use == true) {
          await _discard(widget.edit?.replacement);
          if (!mounted) return;
          widget.onChanged(
            CoffeePhotoEdit(
              replacement: image,
              expectedPhotoId: _expectedPhotoId,
            ),
          );
        } else {
          await _discard(image);
        }
      }
    } catch (_) {
      if (mounted) setState(() => _error = _message(const StorageFailure()));
    } finally {
      _setBusy(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final path = widget.edit == null
        ? widget.initialPath
        : widget.edit!.replacement?.localPath;
    final image = path == null
        ? null
        : ref.watch(managedPhotoProvider(path)).asData?.value;
    final recoveries =
        ref.watch(recoveredCapturesProvider).asData?.value ??
        const <RecoveredCapture>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Foto kemasan (opsional)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: DailySpacing.sm),
        if (path != null) ...[
          DailyPhoto(
            label: 'Preview foto kemasan',
            image: image,
            aspectRatio: 4 / 3,
          ),
          const SizedBox(height: DailySpacing.sm),
        ],
        const Text(
          'Foto disimpan di perangkat. Kamu tetap bisa mengisi kopi tanpa foto.',
        ),
        Wrap(
          spacing: DailySpacing.sm,
          children: [
            DailyTextButton(
              label: path == null ? 'Ambil foto' : 'Ambil ulang',
              onPressed: _busy ? null : () => _pick(PhotoSource.camera),
            ),
            DailyTextButton(
              label: path == null ? 'Pilih dari galeri' : 'Pilih ulang',
              onPressed: _busy ? null : () => _pick(PhotoSource.gallery),
            ),
            if (path != null)
              DailyTextButton(
                label: 'Hapus foto',
                destructive: true,
                onPressed: _busy
                    ? null
                    : () async {
                        final confirm = await DailyDialog.confirm(
                          context: context,
                          title: 'Hapus foto?',
                          message:
                              'Foto dihapus setelah perubahan kopi disimpan.',
                          confirmLabel: 'Hapus foto',
                          destructive: true,
                        );
                        if (!confirm || !mounted) return;
                        await _discard(widget.edit?.replacement);
                        if (mounted) {
                          widget.onChanged(
                            CoffeePhotoEdit(expectedPhotoId: _expectedPhotoId),
                          );
                        }
                      },
              ),
          ],
        ),
        if (_busy) const DailyLoadingState(label: 'Menyiapkan foto'),
        if (_error != null) Semantics(liveRegion: true, child: Text(_error!)),
        for (final recovery in recoveries.where(
          (r) =>
              r.targetCoffeeId == widget.targetCoffeeId &&
              r.image.id != widget.edit?.replacement?.id,
        ))
          Wrap(
            spacing: DailySpacing.sm,
            children: [
              DailyTextButton(
                label: 'Pulihkan foto dan isian sebelumnya',
                onPressed: _busy
                    ? null
                    : () async {
                        final use = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) => PhotoPreview(image: recovery.image),
                          ),
                        );
                        if (use == true && mounted) widget.onRestore(recovery);
                      },
              ),
              DailyTextButton(
                label: 'Buang foto sebelumnya',
                onPressed: _busy ? null : () => _discard(recovery.image),
              ),
            ],
          ),
      ],
    );
  }
}

class PhotoPreview extends ConsumerWidget {
  const PhotoPreview({required this.image, super.key});
  final ManagedImage image;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: const DailyAppBar(title: 'Periksa foto'),
    body: DailyPageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.55,
            child: DailyPhoto(
              fit: BoxFit.contain,
              label: 'Foto kemasan yang dipilih',
              aspectRatio: image.width / image.height,
              image: ref
                  .watch(managedPhotoProvider(image.localPath))
                  .asData
                  ?.value,
            ),
          ),
          const SizedBox(height: DailySpacing.md),
          const Text('Pastikan label jelas dan tidak terpotong.'),
          const SizedBox(height: DailySpacing.md),
          DailyPrimaryButton(
            label: 'Gunakan foto',
            onPressed: () => Navigator.pop(context, true),
          ),
          DailyTextButton(
            label: 'Ambil / pilih ulang',
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
    ),
  );
}
