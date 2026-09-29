import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

Map<String, Object?> encodeForm(CoffeeFormValues values) => {
  'fields': {for (final field in CoffeeField.values) field.name: values[field]},
  'varieties': values.varieties,
  'tastingNotes': values.tastingNotes,
};
CoffeeFormValues decodeForm(Map<String, dynamic> json) {
  final fields = json['fields'] as Map<String, dynamic>;
  return CoffeeFormValues(
    fields: {
      for (final field in CoffeeField.values)
        field: fields[field.name] as String? ?? '',
    },
    varieties: (json['varieties'] as List).cast<String>(),
    tastingNotes: (json['tastingNotes'] as List).cast<String>(),
  );
}
