import 'dart:math' as math;

import 'package:daily_coffee/app/routing/app_routes.dart';
import 'package:daily_coffee/core/design_system/design_system.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/application/coffee_queries.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/presentation/coffee_labels.dart';
import 'package:daily_coffee/features/coffee/presentation/widgets/coffee_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoffeeLibraryScreen extends ConsumerStatefulWidget {
  const CoffeeLibraryScreen({super.key});
  @override
  ConsumerState<CoffeeLibraryScreen> createState() =>
      _CoffeeLibraryScreenState();
}

class _CoffeeLibraryScreenState extends ConsumerState<CoffeeLibraryScreen> {
  List<Coffee>? _lastGood;

  @override
  void initState() {
    super.initState();
    ref.listenManual(coffeeLibraryProvider, (_, next) {
      if (next.asData?.value case Ok<List<Coffee>>(:final value)) {
        setState(() => _lastGood = value);
      }
    }, fireImmediately: true);
  }

  Future<void> _add(BuildContext context) => DailyBottomSheet.show<void>(
    context: context,
    builder: (sheetContext) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Tambah kopi', style: Theme.of(sheetContext).textTheme.titleLarge),
        const SizedBox(height: DailySpacing.sm),
        const Text('Isi informasi dari kemasan kopi Anda.'),
        ListTile(
          leading: const Icon(Icons.edit_outlined),
          title: const Text('Isi manual'),
          subtitle: const Text('Tanpa kamera atau koneksi internet'),
          onTap: () async {
            Navigator.pop(sheetContext);
            await const NewCoffeeRoute().push<void>(context);
          },
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(coffeeLibraryProvider);
    Widget error() => _lastGood?.isNotEmpty == true
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.all(DailySpacing.md),
                child: Column(
                  children: [
                    const Text(
                      'Pembaruan koleksi gagal. Koleksi terakhir tetap ditampilkan.',
                    ),
                    DailyTextButton(
                      label: 'Coba lagi',
                      onPressed: () => ref.invalidate(coffeeLibraryProvider),
                    ),
                  ],
                ),
              ),
              Expanded(child: _CoffeeGrid(coffees: _lastGood!)),
            ],
          )
        : DailyPageBody(
            child: DailyErrorState(
              message: 'Koleksi belum dapat dimuat. Coba lagi.',
              onRetry: () => ref.invalidate(coffeeLibraryProvider),
            ),
          );
    final coffees = switch (query.asData?.value) {
      Ok<List<Coffee>>(:final value) => value,
      _ => _lastGood ?? <Coffee>[],
    };
    return Scaffold(
      appBar: const DailyAppBar(title: 'Koleksi'),
      body: query.when(
        data: (result) => switch (result) {
          Ok<List<Coffee>>(:final value) =>
            value.isEmpty
                ? DailyPageBody(
                    child: DailyEmptyState(
                      title: 'Koleksi kopi masih kosong',
                      message: 'Tambahkan kemasan kopi pertama untuk mulai membangun perpustakaan pribadimu.',
                      actionLabel: 'Tambah kopi',
                      onAction: () => _add(context),
                    ),
                  )
                : _CoffeeGrid(coffees: value),
          Err<List<Coffee>>() => error(),
        },
        loading: () => const DailyPageBody(
          feed: true,
          child: DailyAdaptiveGrid(
            children: [DailyLoadingSkeleton(), DailyLoadingSkeleton()],
          ),
        ),
        error: (_, _) => error(),
      ),
      floatingActionButton: coffees.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _add(context),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Tambah kopi'),
            ),
    );
  }
}

class _CoffeeGrid extends StatelessWidget {
  const _CoffeeGrid({required this.coffees});
  final List<Coffee> coffees;
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: DailyLayout.feedMaxWidth),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final padding = constraints.maxWidth < DailyLayout.medium
                ? DailySpacing.md
                : DailySpacing.lg;
            final minWidth =
                DailyLayout.cardMinWidth *
                MediaQuery.textScalerOf(context).scale(16) /
                16;
            final columns = math.max(
              1,
              ((constraints.maxWidth - padding * 2 + DailySpacing.md) /
                      (minWidth + DailySpacing.md))
                  .floor(),
            );
            return ListView.builder(
              key: const PageStorageKey('coffee-library'),
              padding: EdgeInsetsDirectional.fromSTEB(
                padding,
                padding,
                padding,
                DailySpacing.hero + DailySpacing.lg,
              ),
              itemCount: (coffees.length / columns).ceil(),
              itemBuilder: (context, row) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: DailySpacing.md,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var col = 0; col < columns; col++) ...[
                      if (col > 0) const SizedBox(width: DailySpacing.md),
                      Expanded(
                        child: row * columns + col >= coffees.length
                            ? const SizedBox.shrink()
                            : _card(context, coffees[row * columns + col]),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
  Widget _card(BuildContext context, Coffee coffee) {
    final details = coffee.details;
    final metadata =
        details.originCountry ??
        details.process ??
        (details.roastLevel == null
            ? null
            : details.roastLevelCustom ?? roastLevelLabel(details.roastLevel!));
    return CoffeeLibraryCard(
      name: details.name,
      roastery: details.roastery,
      metadata: [?metadata, if (coffee.isFavorite) 'Favorit'],
      onTap: () =>
          CoffeeDetailRoute(coffeeId: coffee.id.value).push<void>(context),
    );
  }
}
