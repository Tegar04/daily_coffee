import 'package:daily_coffee/core/errors/app_failure.dart';
import 'package:daily_coffee/core/errors/result.dart';
import 'package:daily_coffee/features/coffee/domain/coffee.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_repository.dart';
import 'package:daily_coffee/features/coffee/domain/coffee_values.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/coffee_fakes.dart';

void main() {
  test(
    'writes validate at boundary and publish initial plus committed snapshots',
    () async {
      final repository = TestCoffeeRepository();
      addTearDown(repository.dispose);
      final snapshots = repository.watchLibrary().take(3).toList();
      expect(
        await repository.create(coffeeInput(name: ' ')),
        isA<Err<Coffee>>(),
      );
      final first = (await repository.create(coffeeInput())) as Ok<Coffee>;
      await repository.create(coffeeInput(name: 'Second'));
      final values = await snapshots;
      expect(
        values.map((result) => (result as Ok<List<Coffee>>).value.length),
        [0, 1, 2],
      );
      expect(first.value.createdAt.isUtc, isTrue);
      expect(first.value.updatedAt.isBefore(first.value.createdAt), isFalse);
      expect(
        () => first.value.varieties.add(
          CoffeeVariety(
            id: 'x',
            coffeeId: first.value.id,
            displayValue: 'x',
            position: 0,
            createdAt: DateTime.utc(2026),
          ),
        ),
        throwsUnsupportedError,
      );
    },
  );

  test('edit retains child identity, favorite and photo metadata; stale save fails', () async {
    final original = sampleCoffee();
    final photo = CoffeePhoto(
      id: 'photo',
      coffeeId: original.id,
      localPath: 'coffee/cover.jpg',
      mimeType: 'image/jpeg',
      widthPixels: 100,
      heightPixels: 100,
      byteSize: 500,
      source: CoffeePhotoSource.gallery,
      createdAt: DateTime.utc(2026),
    );
    final repository = TestCoffeeRepository(
      seed: [
        sampleCoffee(photos: [photo]),
      ],
    );
    addTearDown(repository.dispose);
    final first = (await repository.update(
      original.id,
      original.toFormValues().withTags(
        varieties: ['Gesha', 'gesha'],
        tastingNotes: ['Café'],
      ),
      expected: original.toFormValues(),
    ) as Ok<Coffee>).value;
    await repository.setFavorite(first.id, true);
    final edited = (await repository.update(
      first.id,
      first.toFormValues().set(CoffeeField.name, 'New name'),
      expected: first.toFormValues(),
    ) as Ok<Coffee>).value;
    expect(edited.varieties.single.id, first.varieties.single.id);
    expect(edited.photos.single, photo);
    expect(edited.isFavorite, isTrue);
    expect(edited.createdAt, original.createdAt);
    final stale = await repository.update(
      first.id,
      first.toFormValues(),
      expected: first.toFormValues(),
    );
    expect((stale as Err<Coffee>).failure, isA<ConflictFailure>());
    expect(
      ((await repository.watchCoffee(first.id).first) as Ok<Coffee?>)
          .value
          ?.details
          .name,
      'New name',
    );
  });

  test(
    'confirmed cascade removes only its graph and rejects stale impact',
    () async {
      final coffee = sampleCoffee();
      final other = sampleCoffee(id: '00000000-0000-4000-8000-000000000002');
      final repository = TestCoffeeRepository(
        seed: [coffee, other],
        journalLinks: {
          'brew-a': coffee.id,
          'brew-b': coffee.id,
          'keep': other.id,
        },
      );
      addTearDown(repository.dispose);
      final impact = (await repository.inspectDeleteImpact(
        coffee.id,
      ) as Ok<CoffeeDeleteImpact>).value;
      expect(impact.journalCount, 2);
      await repository.setFavorite(coffee.id, true);
      expect(
        (await repository.delete(impact) as Err<void>).failure,
        isA<ConflictFailure>(),
      );
      expect(repository.journalLinks.length, 3);
      final updatedImpact = (await repository.inspectDeleteImpact(
        coffee.id,
      ) as Ok<CoffeeDeleteImpact>).value;
      expect(await repository.delete(updatedImpact), isA<Ok<void>>());
      expect(repository.journalLinks, {'keep': other.id});
      expect(
        (await repository.watchCoffee(coffee.id).first as Ok<Coffee?>).value,
        isNull,
      );
      expect(
        (await repository.watchLibrary().first as Ok<List<Coffee>>)
            .value
            .single
            .id,
        other.id,
      );
    },
  );
}
