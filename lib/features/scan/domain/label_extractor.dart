import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

abstract interface class LabelExtractor {
  Future<Result<CoffeeFormValues>> extract(String rawText);
}
