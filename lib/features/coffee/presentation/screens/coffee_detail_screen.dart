import 'package:daily_coffee/app/composition/image_providers.dart';
import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/application/coffee_actions_controller.dart';
import 'package:daily_coffee/features/coffee/application/coffee_queries.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:daily_coffee/features/coffee/presentation/coffee_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CoffeeDetailScreen extends ConsumerStatefulWidget {
  const CoffeeDetailScreen({required this.coffeeId, super.key});
  final String coffeeId;
  @override
  ConsumerState<CoffeeDetailScreen> createState() => _CoffeeDetailScreenState();
}

class _CoffeeDetailScreenState extends ConsumerState<CoffeeDetailScreen> {
  var _confirmingDelete = false;
  void _back() {
    if (context.canPop()) {
      context.pop();
    } else {
      const LibraryRoute().go(context);
    }
  }

  void _failure(AppFailure failure) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(coffeeFailureMessage(failure))));
  Future<void> _favorite(Coffee coffee) async {
    final result = await ref
        .read(coffeeActionsControllerProvider(widget.coffeeId).notifier)
        .setFavorite(!coffee.isFavorite);
    if (!mounted) return;
    if (result case Err<Coffee>(:final failure)) _failure(failure);
  }

  Future<void> _delete() async {
    if (_confirmingDelete) return;
    setState(() => _confirmingDelete = true);
    final controller = ref.read(
      coffeeActionsControllerProvider(widget.coffeeId).notifier,
    );
    try {
      final result = await controller.inspectDelete();
      if (!mounted) return;
      if (result case Err<CoffeeDeleteImpact>(:final failure)) {
        _failure(failure);
        return;
      }
      final impact = (result as Ok<CoffeeDeleteImpact>).value;
      final confirmed = await DailyDialog.confirm(
        context: context,
        title: 'Hapus kopi?',
        message:
            'Kopi ini, ${impact.journalCount} catatan seduh, dan ${impact.photoCount} foto terkait akan dihapus. Tindakan ini tidak dapat dibatalkan.',
        confirmLabel: 'Hapus kopi',
        destructive: true,
      );
      if (!confirmed || !mounted) return;
      final deleted = await controller.delete(impact);
      if (!mounted) return;
      if (deleted case Err<void>(:final failure)) {
        _failure(failure);
      } else {
        const LibraryRoute().go(context);
      }
    } finally {
      if (mounted) setState(() => _confirmingDelete = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(coffeeDetailProvider(widget.coffeeId));
    final busy =
        ref.watch(coffeeActionsControllerProvider(widget.coffeeId)) ||
        _confirmingDelete;
    final coffee = switch (query.asData?.value) {
      Ok<Coffee?>(:final value) => value,
      _ => null,
    };
    Widget unavailable() => DailyEmptyState(
      title: 'Kopi tidak ditemukan',
      message: 'Kopi mungkin sudah dihapus. Pilih kopi lain dari koleksi.',
      actionLabel: 'Kembali ke Koleksi',
      onAction: () => const LibraryRoute().go(context),
    );
    Widget error() => DailyErrorState(
      message: 'Detail kopi belum dapat dimuat.',
      onRetry: () => ref.invalidate(coffeeDetailProvider(widget.coffeeId)),
    );
    return PopScope(
      canPop: context.canPop(),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: DailyAppBar(
          title: 'Detail kopi',
          leading: DailyIconButton(
            label: 'Kembali',
            icon: Icons.arrow_back,
            onPressed: _back,
          ),
          actions: [
            if (coffee != null)
              DailyIconButton(
                label: coffee.isFavorite
                    ? 'Hapus dari favorit'
                    : 'Tambahkan ke favorit',
                icon: coffee.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                selected: coffee.isFavorite,
                onPressed: busy ? null : () => _favorite(coffee),
              ),
          ],
        ),
        body: DailyPageBody(
          child: query.when(
            data: (result) => switch (result) {
              Ok<Coffee?>(value: final value?) => _content(
                context,
                value,
                busy,
              ),
              Ok<Coffee?>() => unavailable(),
              Err<Coffee?>(failure: NotFoundFailure()) => unavailable(),
              Err<Coffee?>() => error(),
            },
            loading: () => const DailyLoadingState(label: 'Memuat kopi'),
            error: (_, _) => error(),
          ),
        ),
      ),
    );
  }

  Widget _content(BuildContext context, Coffee coffee, bool busy) {
    final d = coffee.details;
    String? date(CoffeeDate? value) => value == null
        ? null
        : MaterialLocalizations.of(context)
              .formatMediumDate(value.toLocalDate());
    final about = <String, String?>{
      'Negara asal': d.originCountry,
      'Region / farm': d.region,
      'Produsen': d.producer,
      'Proses': d.process,
      'Roast level': d.roastLevel == null
          ? null
          : d.roastLevelCustom ?? roastLevelLabel(d.roastLevel!),
      'Varietas': coffee.varieties.isEmpty
          ? null
          : coffee.varieties.map((tag) => tag.displayValue).join(', '),
      'Ketinggian': d.altitudeMinMeters == null && d.altitudeMaxMeters == null
          ? null
          : d.altitudeMinMeters != null && d.altitudeMaxMeters != null
          ? '${d.altitudeMinMeters}–${d.altitudeMaxMeters} m'
          : '${d.altitudeMinMeters ?? d.altitudeMaxMeters} m',
    };
    final packaging = <String, String?>{
      'Tanggal roasting': date(d.roastDate),
      'Tanggal pembelian': date(d.purchaseDate),
      'Berat kemasan': d.packageWeightGrams == null
          ? null
          : '${d.packageWeightGrams} g',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DailyPhoto(
          label: 'Kemasan ${d.name}',
          aspectRatio: 4 / 3,
          image: coffee.photos.isEmpty
              ? null
              : ref
                    .watch(managedPhotoProvider(coffee.photos.first.localPath))
                    .asData
                    ?.value,
        ),
        const SizedBox(height: DailySpacing.lg),
        Text(d.name, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: DailySpacing.sm),
        Text(d.roastery, style: Theme.of(context).textTheme.titleMedium),
        if (coffee.tastingNotes.isNotEmpty) ...[
          const SizedBox(height: DailySpacing.md),
          Wrap(
            spacing: DailySpacing.sm,
            runSpacing: DailySpacing.sm,
            children: [
              for (final tag in coffee.tastingNotes)
                DailyTagChip(label: tag.displayValue),
            ],
          ),
        ],
        const SizedBox(height: DailySpacing.lg),
        if (about.values.any((value) => value != null)) ...[
          _section('Tentang kopi', about),
          const SizedBox(height: DailySpacing.lg),
        ],
        if (packaging.values.any((value) => value != null)) ...[
          _section('Kemasan', packaging),
          const SizedBox(height: DailySpacing.lg),
        ],
        if (d.personalNote != null) ...[
          InfoSectionCard(
            title: 'Catatan pribadi',
            child: Text(d.personalNote!),
          ),
          const SizedBox(height: DailySpacing.lg),
        ],
        DailySecondaryButton(
          label: 'Edit kopi',
          icon: Icons.edit_outlined,
          onPressed: busy
              ? null
              : () =>
                    EditCoffeeRoute(coffeeId: coffee.id.value)
                        .push<void>(context),
        ),
        const SizedBox(height: DailySpacing.lg),
        const InfoSectionCard(
          title: 'Jurnal seduh',
          child: Text('Belum ada catatan seduh untuk kopi ini.'),
        ),
        const SizedBox(height: DailySpacing.md),
        DailySecondaryButton(
          label: 'Tambah catatan seduh',
          onPressed: () =>
              NewJournalRoute(coffeeId: coffee.id.value).push<void>(context),
        ),
        const SizedBox(height: DailySpacing.lg),
        DailyTextButton(
          label: 'Hapus kopi',
          destructive: true,
          onPressed: busy ? null : _delete,
        ),
      ],
    );
  }

  Widget _section(String title, Map<String, String?> rows) => InfoSectionCard(
    title: title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final row in rows.entries.where((row) => row.value != null))
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: DailySpacing.sm),
            child: Text('${row.key}: ${row.value}'),
          ),
      ],
    ),
  );
}
