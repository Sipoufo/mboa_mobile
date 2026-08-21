import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/annonces/bloc/annonces_bloc.dart';
import 'package:mboa_pro/features/annonces/data/annonce_repository.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';
import 'package:mocktail/mocktail.dart';

class MockAnnonceRepository extends Mock implements AnnonceRepository {}

Annonce annonce(String id, AnnonceStatus status) => Annonce(
  id: id,
  title: 'Bien $id',
  status: status,
  propertyType: PropertyType.apartment,
);

void main() {
  late MockAnnonceRepository repository;

  final published = annonce('a', AnnonceStatus.published);
  final draft = annonce('b', AnnonceStatus.draft);
  final rented = annonce('c', AnnonceStatus.rented);
  final reserved = annonce('d', AnnonceStatus.reserved);
  final archived = annonce('e', AnnonceStatus.archived);
  final all = [published, draft, rented, reserved, archived];

  setUpAll(() => registerFallbackValue(AnnonceTransition.publish));

  setUp(() => repository = MockAnnonceRepository());

  AnnoncesBloc build() => AnnoncesBloc(repository: repository);

  group('loading', () {
    blocTest<AnnoncesBloc, AnnoncesState>(
      'emits [loading, ready] on Disponibles',
      setUp: () => when(repository.list).thenAnswer((_) async => all),
      build: build,
      act: (bloc) => bloc.add(const AnnoncesLoadRequested()),
      expect: () => [
        const AnnoncesLoadInProgress(),
        AnnoncesReady(items: all, filter: AnnonceFilter.available),
      ],
    );

    blocTest<AnnoncesBloc, AnnoncesState>(
      'emits [loading, failure] when the load fails',
      setUp: () => when(repository.list).thenThrow(Exception('offline')),
      build: build,
      act: (bloc) => bloc.add(const AnnoncesLoadRequested()),
      expect: () => [const AnnoncesLoadInProgress(), const AnnoncesFailure()],
    );

    blocTest<AnnoncesBloc, AnnoncesState>(
      'keeps the current list when a refresh fails',
      setUp: () => when(repository.list).thenThrow(Exception('offline')),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(const AnnoncesRefreshRequested()),
      expect: () => const <AnnoncesState>[],
    );
  });

  group('tab filtering', () {
    test('Disponibles shows published listings AND drafts', () {
      final state = AnnoncesReady(items: all, filter: AnnonceFilter.available);

      // Drafts get a badge rather than being hidden — a created-but-unpublished
      // listing must not disappear from the app.
      expect(state.visible.map((a) => a.id), ['a', 'b']);
    });

    test('Occupés shows reserved and rented', () {
      final state = AnnoncesReady(items: all, filter: AnnonceFilter.occupied);

      expect(state.visible.map((a) => a.id), ['c', 'd']);
    });

    test('archived listings appear only under Archivés', () {
      for (final filter in [AnnonceFilter.available, AnnonceFilter.occupied]) {
        final state = AnnoncesReady(items: all, filter: filter);
        expect(state.visible.map((a) => a.id), isNot(contains('e')));
      }

      final archived = AnnoncesReady(items: all, filter: AnnonceFilter.archived);
      expect(archived.visible.map((a) => a.id), ['e']);
    });

    blocTest<AnnoncesBloc, AnnoncesState>(
      'switching tab does not refetch',
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(const AnnoncesFilterChanged(AnnonceFilter.occupied)),
      expect: () => [AnnoncesReady(items: all, filter: AnnonceFilter.occupied)],
      verify: (_) => verifyNever(repository.list),
    );
  });

  test('activeCount counts published and reserved only', () {
    final state = AnnoncesReady(items: all, filter: AnnonceFilter.available);

    // Drafts, rented and archived don't consume the tier's active allowance.
    expect(state.activeCount, 2);
  });

  group('transitions', () {
    blocTest<AnnoncesBloc, AnnoncesState>(
      'marks the card busy, then swaps in the updated listing',
      setUp: () =>
          when(() => repository.transition(any(), any())).thenAnswer((_) async => annonce('a', AnnonceStatus.rented)),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(
        const AnnonceStatusChangeRequested('a', AnnonceTransition.markRented),
      ),
      expect: () => [
        AnnoncesReady(
          items: all,
          filter: AnnonceFilter.available,
          mutatingId: 'a',
        ),
        AnnoncesReady(
          items: [annonce('a', AnnonceStatus.rented), ...all.skip(1)],
          filter: AnnonceFilter.available,
        ),
      ],
    );

    blocTest<AnnoncesBloc, AnnoncesState>(
      'clears the busy flag and reports a failed transition',
      setUp: () => when(() => repository.transition(any(), any())).thenThrow(Exception('boom')),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(
        const AnnonceStatusChangeRequested('a', AnnonceTransition.publish),
      ),
      skip: 1,
      expect: () => [
        AnnoncesReady(
          items: all,
          filter: AnnonceFilter.available,
          lastActionFailed: true,
        ),
      ],
    );
  });

  group('deletion (RM-M10-07)', () {
    blocTest<AnnoncesBloc, AnnoncesState>(
      'removes the listing on success',
      setUp: () => when(() => repository.delete(any())).thenAnswer((_) async {}),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(const AnnonceDeleteRequested('a')),
      skip: 1,
      expect: () => [
        AnnoncesReady(
          items: all.where((a) => a.id != 'a').toList(),
          filter: AnnonceFilter.available,
        ),
      ],
    );

    blocTest<AnnoncesBloc, AnnoncesState>(
      'keeps the listing when the backend refuses (active contract)',
      setUp: () => when(() => repository.delete(any())).thenThrow(Exception('409')),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(const AnnonceDeleteRequested('a')),
      skip: 1,
      expect: () => [
        AnnoncesReady(
          items: all,
          filter: AnnonceFilter.available,
          lastActionFailed: true,
        ),
      ],
    );
  });

  group('RM-M11-10 — the owner as a visitor', () {
    blocTest<AnnoncesBloc, AnnoncesState>(
      'putting himself in the pool writes the listing and keeps the answer',
      setUp: () => when(() => repository.setOwnerVisits('a', enabled: true)).thenAnswer(
        (_) async => const Annonce(
          id: 'a',
          title: 'Bien a',
          status: AnnonceStatus.published,
          propertyType: PropertyType.apartment,
          ownerVisitsEnabled: true,
        ),
      ),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(const AnnonceOwnerVisitsToggled('a', enabled: true)),
      skip: 1,
      verify: (bloc) {
        final state = bloc.state as AnnoncesReady;
        // What comes back is the listing as the server now holds it — the
        // repository re-reads it before writing, because PUT replaces it whole.
        expect(
          state.items.firstWhere((a) => a.id == 'a').ownerVisitsEnabled,
          isTrue,
        );
        expect(state.mutatingId, isNull);
      },
    );

    blocTest<AnnoncesBloc, AnnoncesState>(
      'a refused write leaves the switch where it was',
      setUp: () => when(() => repository.setOwnerVisits('a', enabled: true)).thenThrow(Exception('500')),
      build: build,
      seed: () => AnnoncesReady(items: all, filter: AnnonceFilter.available),
      act: (bloc) => bloc.add(const AnnonceOwnerVisitsToggled('a', enabled: true)),
      skip: 1,
      verify: (bloc) {
        final state = bloc.state as AnnoncesReady;
        expect(state.lastActionFailed, isTrue);
        expect(
          state.items.firstWhere((a) => a.id == 'a').ownerVisitsEnabled,
          isFalse,
        );
      },
    );
  });
}
