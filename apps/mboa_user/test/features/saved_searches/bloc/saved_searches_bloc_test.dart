import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/saved_searches/bloc/saved_searches_bloc.dart';
import 'package:mboa_user/features/saved_searches/data/saved_searches_repository.dart';
import 'package:mboa_user/features/saved_searches/models/saved_search.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

/// RM-M04-07 — up to three searches, each with its own N-01 switch.
void main() {
  late MockSavedSearchesRepository repository;

  const akwa = SavedSearch(id: 's-1', name: 'Appartement · Akwa', newMatchCount: 3);
  const bonapriso = SavedSearch(id: 's-2', name: 'Bonapriso');
  const query = SearchQuery(cityId: 'douala');

  setUpAll(() => registerFallbackValue(query));
  setUp(() => repository = MockSavedSearchesRepository());

  SavedSearchesBloc build() => SavedSearchesBloc(repository: repository);

  group('loading', () {
    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'reads the list',
      setUp: () => when(() => repository.list()).thenAnswer((_) async => const SavedSearchList([akwa])),
      build: build,
      act: (bloc) => bloc.add(const SavedSearchesRequested()),
      expect: () => [
        const SavedSearchesLoading(),
        const SavedSearchesReady(searches: [akwa]),
      ],
    );

    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'offline, the kept list is shown read-only',
      setUp: () =>
          when(() => repository.list()).thenAnswer((_) async => const SavedSearchList([akwa], fromCache: true)),
      build: build,
      act: (bloc) => bloc.add(const SavedSearchesRequested()),
      expect: () => [
        const SavedSearchesLoading(),
        const SavedSearchesReady(searches: [akwa], isOffline: true),
      ],
    );

    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'nothing to show is a failure with a retry, not an empty list',
      setUp: () => when(() => repository.list()).thenThrow(Exception('offline')),
      build: build,
      act: (bloc) => bloc.add(const SavedSearchesRequested()),
      expect: () => [const SavedSearchesLoading(), const SavedSearchesFailure()],
    );
  });

  group('saving', () {
    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'lands at the end of the list, and says so',
      setUp: () => when(
        () => repository.save(
          any(),
          name: any(named: 'name'),
          alertsEnabled: any(named: 'alertsEnabled'),
        ),
      ).thenAnswer((_) async => bonapriso),
      build: build,
      seed: () => const SavedSearchesReady(searches: [akwa]),
      act: (bloc) => bloc.add(const SavedSearchSaveRequested(query, name: 'Bonapriso')),
      expect: () => [
        const SavedSearchesReady(searches: [akwa], isSaving: true),
        const SavedSearchesReady(searches: [akwa, bonapriso], outcome: SavedSearchOutcome.saved),
      ],
      verify: (_) => verify(() => repository.save(query, name: 'Bonapriso', alertsEnabled: true)).called(1),
    );

    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'RM-M04-07 — a fourth is told the limit',
      setUp: () => when(
        () => repository.save(
          any(),
          name: any(named: 'name'),
          alertsEnabled: any(named: 'alertsEnabled'),
        ),
      ).thenThrow(const SaveSearchRefused(SaveRefusal.limit)),
      build: build,
      seed: () => const SavedSearchesReady(searches: [akwa]),
      act: (bloc) => bloc.add(const SavedSearchSaveRequested(query)),
      skip: 1,
      expect: () => [
        const SavedSearchesReady(searches: [akwa], outcome: SavedSearchOutcome.limitReached),
      ],
    );

    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'the same filters again are told they are already saved',
      setUp: () => when(
        () => repository.save(
          any(),
          name: any(named: 'name'),
          alertsEnabled: any(named: 'alertsEnabled'),
        ),
      ).thenThrow(const SaveSearchRefused(SaveRefusal.duplicate)),
      build: build,
      seed: () => const SavedSearchesReady(searches: [akwa]),
      act: (bloc) => bloc.add(const SavedSearchSaveRequested(query)),
      skip: 1,
      expect: () => [
        const SavedSearchesReady(searches: [akwa], outcome: SavedSearchOutcome.alreadySaved),
      ],
    );

    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'saved before the list was read, the list is then read',
      setUp: () {
        when(
          () => repository.save(
            any(),
            name: any(named: 'name'),
            alertsEnabled: any(named: 'alertsEnabled'),
          ),
        ).thenAnswer((_) async => bonapriso);
        when(() => repository.list()).thenAnswer((_) async => const SavedSearchList([akwa, bonapriso]));
      },
      build: build,
      act: (bloc) => bloc.add(const SavedSearchSaveRequested(query)),
      expect: () => [
        const SavedSearchesReady(searches: [], isSaving: true),
        const SavedSearchesReady(searches: [bonapriso], outcome: SavedSearchOutcome.saved),
        const SavedSearchesReady(searches: [akwa, bonapriso]),
      ],
    );
  });

  group('the alerts switch', () {
    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'moves at once, and stays where the server put it',
      setUp: () => when(
        () => repository.setAlerts('s-1', enabled: false),
      ).thenAnswer((_) async => akwa.copyWith(alertsEnabled: false)),
      build: build,
      seed: () => const SavedSearchesReady(searches: [akwa]),
      act: (bloc) => bloc.add(const SavedSearchAlertsToggled('s-1', enabled: false)),
      expect: () => [
        SavedSearchesReady(searches: [akwa.copyWith(alertsEnabled: false)], busyId: 's-1'),
        SavedSearchesReady(searches: [akwa.copyWith(alertsEnabled: false)]),
      ],
    );

    blocTest<SavedSearchesBloc, SavedSearchesState>(
      'goes back when the save fails',
      setUp: () => when(() => repository.setAlerts('s-1', enabled: false)).thenThrow(Exception('offline')),
      build: build,
      seed: () => const SavedSearchesReady(searches: [akwa]),
      act: (bloc) => bloc.add(const SavedSearchAlertsToggled('s-1', enabled: false)),
      skip: 1,
      expect: () => [
        const SavedSearchesReady(searches: [akwa], outcome: SavedSearchOutcome.failed),
      ],
    );
  });

  blocTest<SavedSearchesBloc, SavedSearchesState>(
    'offline, nothing is changed — not even tried',
    build: build,
    seed: () => const SavedSearchesReady(searches: [akwa], isOffline: true),
    act: (bloc) => bloc
      ..add(const SavedSearchAlertsToggled('s-1', enabled: false))
      ..add(const SavedSearchRenamed('s-1', 'Akwa'))
      ..add(const SavedSearchDeleted('s-1')),
    expect: () => const <SavedSearchesState>[],
    verify: (_) => verifyZeroInteractions(repository),
  );

  blocTest<SavedSearchesBloc, SavedSearchesState>(
    'a renamed search keeps its place',
    setUp: () => when(() => repository.rename('s-1', 'Akwa')).thenAnswer((_) async => akwa.copyWith(name: 'Akwa')),
    build: build,
    seed: () => const SavedSearchesReady(searches: [akwa, bonapriso]),
    act: (bloc) => bloc.add(const SavedSearchRenamed('s-1', 'Akwa')),
    skip: 1,
    expect: () => [
      SavedSearchesReady(
        searches: [
          akwa.copyWith(name: 'Akwa'),
          bonapriso,
        ],
      ),
    ],
  );

  blocTest<SavedSearchesBloc, SavedSearchesState>(
    'a deleted search leaves the list',
    setUp: () => when(() => repository.delete('s-1')).thenAnswer((_) async {}),
    build: build,
    seed: () => const SavedSearchesReady(searches: [akwa, bonapriso]),
    act: (bloc) => bloc.add(const SavedSearchDeleted('s-1')),
    skip: 1,
    expect: () => [
      const SavedSearchesReady(searches: [bonapriso]),
    ],
  );

  blocTest<SavedSearchesBloc, SavedSearchesState>(
    'opening its results clears what was new, without a reload',
    build: build,
    seed: () => const SavedSearchesReady(searches: [akwa]),
    act: (bloc) => bloc.add(const SavedSearchOpened('s-1')),
    expect: () => [
      SavedSearchesReady(searches: [akwa.copyWith(newMatchCount: 0)]),
    ],
    verify: (_) => verifyNever(() => repository.list()),
  );
}
