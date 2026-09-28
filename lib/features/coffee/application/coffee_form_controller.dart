import 'package:daily_coffee/app/composition/coffee_providers.dart';
import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coffee_form_controller.g.dart';

final class CoffeeFormState {
  CoffeeFormState({
    required this.values,
    required this.baseline,
    this.submitting = false,
    Map<CoffeeField, CoffeeValidationIssue> errors = const {},
    this.varietyError,
    this.tastingError,
    this.failure,
  }) : errors = Map.unmodifiable(errors);
  final CoffeeFormValues values;
  final CoffeeFormValues baseline;
  final bool submitting;
  final Map<CoffeeField, CoffeeValidationIssue> errors;
  final CoffeeValidationIssue? varietyError;
  final CoffeeValidationIssue? tastingError;
  final AppFailure? failure;
  bool get isDirty => values != baseline;
}

@riverpod
class CoffeeFormController extends _$CoffeeFormController {
  @override
  CoffeeFormState build(Coffee? initial) {
    final values = initial?.toFormValues() ?? CoffeeFormValues();
    return CoffeeFormState(values: values, baseline: values);
  }

  void change(CoffeeFormValues values) {
    if (state.submitting) return;
    state = CoffeeFormState(values: values, baseline: state.baseline);
  }

  void setField(CoffeeField field, String value) =>
      change(state.values.set(field, value));

  Future<Result<Coffee>> submit() async {
    if (state.submitting) return const Err(ConflictFailure());
    final values = state.values;
    final errors = CoffeeValidation.validate(values);
    final varietyError = CoffeeValidation.validateTags(values.varieties);
    final tastingError = CoffeeValidation.validateTags(values.tastingNotes);
    if (errors.isNotEmpty || varietyError != null || tastingError != null) {
      state = CoffeeFormState(
        values: values,
        baseline: state.baseline,
        errors: errors,
        varietyError: varietyError,
        tastingError: tastingError,
        failure: const ValidationFailure(),
      );
      return const Err(ValidationFailure());
    }
    state = CoffeeFormState(
      values: values,
      baseline: state.baseline,
      submitting: true,
    );
    Result<Coffee> result;
    try {
      final repository = ref.read(coffeeRepositoryProvider);
      result = initial == null
          ? await repository.create(values)
          : await repository.update(
              initial!.id,
              values,
              expected: state.baseline,
            );
    } catch (_) {
      result = const Err(UnexpectedFailure());
    }
    if (ref.mounted) {
      state = CoffeeFormState(
        values: values,
        baseline: result is Ok<Coffee> ? values : state.baseline,
        failure: switch (result) {
          Err<Coffee>(:final failure) => failure,
          _ => null,
        },
      );
    }
    return result;
  }
}
