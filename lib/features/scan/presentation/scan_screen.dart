import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/composition/scan_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/features/capture/domain/photo_picker_gateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/scan_controller.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scanControllerProvider);
    final controller = ref.read(scanControllerProvider.notifier);
    final drafts = ref.watch(savedScanDraftsProvider);
    return Scaffold(
      appBar: const DailyAppBar(title: 'Membaca label'),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(DailySpacing.md),
          children: [
            const Text(
              'Ambil foto label yang terang dan tajam. Teks label akan diproses otomatis oleh OpenAI untuk mengisi informasi kopi. Memerlukan internet; foto tidak dikirim. Hasil tetap bisa diedit.',
            ),
            const SizedBox(height: DailySpacing.md),
            if (state.image case final image?) ...[
              SizedBox(
                height: 240,
                child: ref
                    .watch(managedPhotoProvider(image.localPath))
                    .when(
                      data: (provider) => provider == null
                          ? const Center(child: Text('Foto tidak tersedia'))
                          : Image(image: provider, fit: BoxFit.contain),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (_, _) =>
                          const Center(child: Text('Foto tidak tersedia')),
                    ),
              ),
              const SizedBox(height: DailySpacing.md),
            ],
            if (state.busy) ...[
              const LinearProgressIndicator(),
              Text(
                state.phase == ScanPhase.acquiring
                    ? 'Menyiapkan foto…'
                    : 'Membaca teks label…',
              ),
              DailyTextButton(label: 'Batalkan', onPressed: controller.cancel),
            ] else ...[
              if (state.phase == ScanPhase.cancelled)
                const Text(
                  'Scan dihentikan. Anda dapat mencoba lagi atau mengisi manual.',
                ),
              if (state.failure != null)
                Text(switch (state.failure) {
                  OcrNoTextFailure() => 'Teks belum terbaca. Coba foto lebih dekat dengan pencahayaan yang cukup.',
                  OcrUnavailableFailure(:final diagnosticContext)
                      when diagnosticContext['reason'] == 'timeout' =>
                    'Pembacaan terlalu lama. Coba lagi atau isi manual.',
                  PermissionDeniedFailure() ||
                  PermissionPermanentlyDeniedFailure() => 'Akses foto atau kamera tidak diizinkan. Pilih sumber lain atau isi manual.',
                  ConflictFailure() => 'Draft sudah masuk tahap review. Buka Periksa informasi kopi untuk melanjutkan edit.',
                  _ => 'Label belum dapat dibaca atau disimpan. Coba lagi atau isi manual.',
                }),
              if (state.result case final result?) ...[
                Text(
                  'Teks label',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text(
                  'Tersimpan sebagai draft. Periksa teks berikut sebelum menggunakannya.',
                ),
                const SizedBox(height: DailySpacing.sm),
                SelectableText(result.text),
                DailyPrimaryButton(
                  label: 'Periksa informasi kopi',
                  onPressed: () =>
                      ReviewRoute(draftId: state.image!.id).go(context),
                ),
              ],
              if (state.image != null && state.failure is ConflictFailure)
                DailyTextButton(
                  label: 'Periksa informasi kopi',
                  onPressed: () =>
                      ReviewRoute(draftId: state.image!.id).go(context),
                ),
              if (state.image != null)
                DailyTextButton(
                  label: 'Baca ulang foto',
                  onPressed: controller.retry,
                ),
              DailyPrimaryButton(
                label: 'Ambil foto label',
                onPressed: () => controller.acquire(PhotoSource.camera),
              ),
              DailyTextButton(
                label: 'Pilih dari galeri',
                onPressed: () => controller.acquire(PhotoSource.gallery),
              ),
            ],
            DailyTextButton(
              label: 'Isi manual',
              onPressed: () async {
                if (state.busy) await controller.cancel();
                if (context.mounted) {
                  await const NewCoffeeRoute().push<void>(context);
                }
              },
            ),
            const Divider(),
            Text(
              'Draft scan tersimpan',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            drafts.when(
              data: (items) => Column(
                children: [
                  if (items.isEmpty) const Text('Belum ada draft scan.'),
                  for (final draft in items)
                    ListTile(
                      title: Text(
                        draft.result?.text.split('\n').first ??
                            'Foto belum selesai dibaca',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        draft.result == null
                            ? 'Ketuk untuk melanjutkan'
                            : 'Ketuk untuk melihat teks',
                      ),
                      onTap: state.busy
                          ? null
                          : () => controller.restore(draft),
                      trailing: IconButton(
                        tooltip: 'Hapus draft scan',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: state.busy
                            ? null
                            : () async {
                                final remove = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Hapus draft scan?'),
                                    content: const Text(
                                      'Foto sementara dan teks draft akan dihapus.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, false),
                                        child: const Text('Batal'),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, true),
                                        child: const Text('Hapus'),
                                      ),
                                    ],
                                  ),
                                );
                                if (remove == true && context.mounted) {
                                  await controller.discard(draft);
                                }
                              },
                      ),
                    ),
                ],
              ),
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => DailyTextButton(
                label: 'Muat ulang draft',
                onPressed: () {
                  ref.invalidate(recoveredCapturesProvider);
                  ref.invalidate(savedScanDraftsProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
