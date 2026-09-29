import 'package:daily_coffee/core/identifiers/app_id_generator.dart';
import 'package:daily_coffee/core/time/app_clock.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_validation.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';

/// Shared validated aggregate construction for local and test adapters.
final class CoffeeAggregateBuilder {
  CoffeeAggregateBuilder({required this._clock, required this._ids});
  final AppClock _clock;
  final AppIdGenerator _ids;

  Coffee build(
    CoffeeId id,
    CoffeeFormValues input, {
    Coffee? previous,
    bool? favorite,
  }) {
    final clockNow = _clock.now().toUtc();
    final now = previous != null && clockNow.isBefore(previous.updatedAt)
        ? previous.updatedAt
        : clockNow;
    final varieties = CoffeeValidation.uniqueTags(input.varieties);
    final notes = CoffeeValidation.uniqueTags(input.tastingNotes);
    CoffeeTag? existing(List<CoffeeTag> tags, String value) {
      for (final tag in tags) {
        if (tag.normalizedValue == normalizeCoffeeText(value)) return tag;
      }
      return null;
    }

    final details = CoffeeValidation.details(input);
    return Coffee(
      id: id,
      details: details,
      createdAt: previous?.createdAt ?? now,
      updatedAt: now,
      isFavorite: favorite ?? previous?.isFavorite ?? false,
      // Invalidate derived provenance only when its source has changed.
      originCountryCode:
          previous?.details.originCountry == details.originCountry
          ? previous?.originCountryCode
          : null,
      altitudeSourceText:
          previous?.details.altitudeMinMeters == details.altitudeMinMeters &&
              previous?.details.altitudeMaxMeters == details.altitudeMaxMeters
          ? previous?.altitudeSourceText
          : null,
      photos: previous?.photos ?? const [],
      varieties: [
        for (var i = 0; i < varieties.length; i++)
          CoffeeVariety(
            id:
                existing(previous?.varieties ?? const [], varieties[i])?.id ??
                _ids.generate(),
            coffeeId: id,
            displayValue: varieties[i],
            position: i,
            createdAt:
                existing(
                  previous?.varieties ?? const [],
                  varieties[i],
                )?.createdAt ??
                now,
          ),
      ],
      tastingNotes: [
        for (var i = 0; i < notes.length; i++)
          CoffeeTastingNote(
            id:
                existing(previous?.tastingNotes ?? const [], notes[i])?.id ??
                _ids.generate(),
            coffeeId: id,
            displayValue: notes[i],
            position: i,
            createdAt:
                existing(
                  previous?.tastingNotes ?? const [],
                  notes[i],
                )?.createdAt ??
                now,
          ),
      ],
    );
  }
}
