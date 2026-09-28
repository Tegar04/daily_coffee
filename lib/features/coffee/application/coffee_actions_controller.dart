import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_actions_controller.g.dart';

@riverpod
class CoffeeActionsController extends _$CoffeeActionsController {
  @override
  bool build(String id) => false;

  Future<Result<T>> _run<T>(Future<Result<T>> Function() action) async {
    if (state) return const Err(ConflictFailure());
    state = true;
    try {
      return await action();
    } on FormatException {
      return const Err(NotFoundFailure());
    } catch (_) {
      return const Err(UnexpectedFailure());
    } finally {
      if (ref.mounted) state = false;
    }
  }

  Future<Result<Coffee>> setFavorite(bool favorite) => _run(
    () =>
        ref.read(coffeeRepositoryProvider).setFavorite(CoffeeId(id), favorite),
  );
  Future<Result<CoffeeDeleteImpact>> inspectDelete() => _run(
    () => ref.read(coffeeRepositoryProvider).inspectDeleteImpact(CoffeeId(id)),
  );
  Future<Result<void>> delete(CoffeeDeleteImpact impact) => _run(() async {
    if (impact.coffeeId.value != id) return const Err(ConflictFailure());
    return ref.read(coffeeRepositoryProvider).delete(impact);
  });
}
