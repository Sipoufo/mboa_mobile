import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_user/features/favorites/bloc/favorites_bloc.dart';
import 'package:mboa_user/features/favorites/data/favorites_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoritesRepository extends Mock implements FavoritesRepository {}

Favorite favorite(String id, {bool isAvailable = true}) => Favorite(
      annonceId: id,
      title: 'Studio $id',
      isAvailable: isAvailable,
    );

/// Saved listings (CDC M06).
void main() {
  late MockFavoritesRepository repository;

  setUp(() => repository = MockFavoritesRepository());

  FavoritesBloc build() => FavoritesBloc(repository: repository);

  blocTest<FavoritesBloc, FavoritesState>(
    'saving flips the heart before the server answers',
    setUp: () {
      when(() => repository.add('a-2')).thenAnswer((_) async {});
      when(repository.list)
          .thenAnswer((_) async => [favorite('a-1'), favorite('a-2')]);
    },
    build: build,
    seed: () => FavoritesReady(items: [favorite('a-1')]),
    act: (bloc) =>
        bloc.add(FavoriteToggled('a-2', optimistic: favorite('a-2'))),
    expect: () => [
      // Waiting for the round trip makes the tap feel broken on a slow line.
      isA<FavoritesReady>().having((s) => s.contains('a-2'), 'saved', isTrue),
      isA<FavoritesReady>().having((s) => s.items, 'items', hasLength(2)),
    ],
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'a refused save rolls the heart back',
    setUp: () => when(() => repository.add('a-2')).thenThrow(Exception('500')),
    build: build,
    seed: () => FavoritesReady(items: [favorite('a-1')]),
    act: (bloc) =>
        bloc.add(FavoriteToggled('a-2', optimistic: favorite('a-2'))),
    verify: (bloc) {
      // Leaving it flipped would lie about what is saved.
      final state = bloc.state as FavoritesReady;
      expect(state.contains('a-2'), isFalse);
      expect(state.lastActionFailed, isTrue);
    },
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'unsaving calls remove, not add',
    setUp: () {
      when(() => repository.remove('a-1')).thenAnswer((_) async {});
      when(repository.list).thenAnswer((_) async => []);
    },
    build: build,
    seed: () => FavoritesReady(items: [favorite('a-1')]),
    act: (bloc) =>
        bloc.add(FavoriteToggled('a-1', optimistic: favorite('a-1'))),
    verify: (_) {
      verify(() => repository.remove('a-1')).called(1);
      verifyNever(() => repository.add(any()));
    },
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'RM-M06-02 — the 51st is refused with a reason, not a failed call',
    build: build,
    seed: () => FavoritesReady(
      items: [for (var i = 0; i < 50; i++) favorite('a-$i')],
    ),
    act: (bloc) =>
        bloc.add(FavoriteToggled('a-51', optimistic: favorite('a-51'))),
    verify: (bloc) {
      expect((bloc.state as FavoritesReady).limitReached, isTrue);
      verifyNever(() => repository.add(any()));
    },
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'a rented listing stays in the list, flagged',
    setUp: () => when(repository.list).thenAnswer(
      (_) async => [favorite('a-1'), favorite('a-2', isAvailable: false)],
    ),
    build: build,
    act: (bloc) => bloc.add(const FavoritesLoadRequested()),
    verify: (bloc) {
      // 30 days of grace: dropping the row would look like the app lost it.
      final state = bloc.state as FavoritesReady;
      expect(state.items, hasLength(2));
      expect(state.unavailable.single.annonceId, 'a-2');
    },
  );

  blocTest<FavoritesBloc, FavoritesState>(
    'signing out empties the list',
    build: build,
    seed: () => FavoritesReady(items: [favorite('a-1')]),
    act: (bloc) => bloc.add(const FavoritesCleared()),
    verify: (bloc) {
      // Favourites belong to an account; the next person to open the app must
      // not see the last one's.
      expect(bloc.state.contains('a-1'), isFalse);
    },
  );
}
