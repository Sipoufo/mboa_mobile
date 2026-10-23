import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_user/features/search/bloc/search_bloc.dart';
import 'package:mboa_user/features/search/data/location_service.dart';
import 'package:mboa_user/features/search/data/search_repository.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

class MockLocationService extends Mock implements LocationService {}

ListingHit hit(String id, {int? tierRank}) => ListingHit(
      id: id,
      title: 'Studio $id',
      city: 'Douala',
      district: 'Deido',
      price: 110000,
      tierRank: tierRank,
    );

SearchPage page(List<SearchHit> hits, {int page = 0, bool isLast = true}) =>
    SearchPage(hits: hits, page: page, isLast: isLast);

/// The tenant's search (CDC M04).
void main() {
  late MockSearchRepository repository;
  late MockLocationService location;

  const douala = SearchQuery(cityId: 'c-1', cityName: 'Douala');

  setUpAll(() {
    registerFallbackValue(const SearchQuery());
    registerFallbackValue(const UserPosition(0, 0));
    registerFallbackValue(SearchSort.relevance);
    registerFallbackValue(LocationRefusal.denied);
  });

  setUp(() {
    repository = MockSearchRepository();
    location = MockLocationService();
    when(() => repository.lastQuery()).thenReturn(null);
    when(() => repository.cachedFirstPage()).thenReturn(null);
    // Asked only once a search has failed; each test that cares says which
    // failure it is simulating.
    when(repository.isOffline).thenAnswer((_) async => true);
  });

  SearchBloc build() => SearchBloc(repository: repository, location: location);

  blocTest<SearchBloc, SearchState>(
    'RM-M04-01 — without a city there is nothing to search',
    build: build,
    act: (bloc) => bloc
      ..add(const SearchStarted())
      ..add(const SearchSubmitted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.canSubmit, isFalse);
      verifyNever(() => repository.search(any(), page: any(named: 'page')));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'RM-M04-02 — the last search comes back and runs itself',
    setUp: () {
      when(() => repository.lastQuery()).thenReturn(douala);
      when(() => repository.search(douala, page: 0))
          .thenAnswer((_) async => page([hit('a')]));
    },
    build: build,
    act: (bloc) => bloc.add(const SearchStarted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.query, douala);
      expect(state.hits, hasLength(1));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'CA-M04-02 — results keep the server\'s tier order',
    setUp: () {
      when(() => repository.search(douala, page: 0)).thenAnswer(
        (_) async => page([
          hit('pro-plus', tierRank: 3),
          hit('gratuit', tierRank: 0),
          hit('pro', tierRank: 2),
        ]),
      );
    },
    build: build,
    seed: () => const SearchReady(query: douala),
    act: (bloc) => bloc.add(const SearchSubmitted()),
    verify: (bloc) {
      // The visibility algorithm is the server's; re-sorting here would be a
      // second implementation of it, and the two would drift.
      final state = bloc.state as SearchReady;
      expect(state.hits.map((h) => h.id), ['pro-plus', 'gratuit', 'pro']);
    },
  );

  blocTest<SearchBloc, SearchState>(
    'CE-M04-01 — nothing found is an answer, not a failure',
    setUp: () => when(() => repository.search(douala, page: 0))
        .thenAnswer((_) async => page([])),
    build: build,
    seed: () => const SearchReady(query: douala),
    act: (bloc) => bloc.add(const SearchSubmitted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.isEmpty, isTrue);
      expect(state.isOffline, isFalse);
    },
  );

  blocTest<SearchBloc, SearchState>(
    'CE-M04-02 — offline falls back to the cached page, and says so',
    setUp: () {
      when(() => repository.search(douala, page: 0))
          .thenThrow(Exception('offline'));
      when(() => repository.cachedFirstPage()).thenReturn(
        SearchPage(hits: [hit('cached')], page: 0, isLast: true, fromCache: true),
      );
    },
    build: build,
    seed: () => const SearchReady(query: douala),
    act: (bloc) => bloc.add(const SearchSubmitted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.isOffline, isTrue);
      expect(state.hits.single.id, 'cached');
    },
  );

  blocTest<SearchBloc, SearchState>(
    'CE-M04-03 — a server error with nothing cached is a failure screen',
    setUp: () => when(() => repository.search(douala, page: 0))
        .thenThrow(Exception('500')),
    build: build,
    seed: () => const SearchReady(query: douala),
    act: (bloc) => bloc.add(const SearchSubmitted()),
    // An empty result and an unreachable server look the same on screen, and
    // one of them tells the tenant their filters are wrong.
    verify: (bloc) => expect(bloc.state, isA<SearchFailure>()),
  );

  blocTest<SearchBloc, SearchState>(
    'RM-M04-03 — the next page appends to what is already read',
    setUp: () => when(() => repository.search(douala, page: 1))
        .thenAnswer((_) async => page([hit('b')], page: 1, isLast: true)),
    build: build,
    seed: () => SearchReady(query: douala, hits: [hit('a')], isLast: false),
    act: (bloc) => bloc.add(const SearchNextPageRequested()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.hits.map((h) => h.id), ['a', 'b']);
      expect(state.isLast, isTrue);
    },
  );

  blocTest<SearchBloc, SearchState>(
    'the last page asks for nothing more',
    build: build,
    seed: () => SearchReady(query: douala, hits: [hit('a')]),
    act: (bloc) => bloc.add(const SearchNextPageRequested()),
    verify: (_) =>
        verifyNever(() => repository.search(any(), page: any(named: 'page'))),
  );

  group('CE-M04-02 vs CE-M04-03 — why the cache is on screen', () {
    blocTest<SearchBloc, SearchState>(
      'no connection — the results are offline',
      setUp: () {
        when(() => repository.search(any(), page: any(named: 'page')))
            .thenThrow(Exception('down'));
        when(repository.cachedFirstPage).thenReturn(
          SearchPage(hits: [hit('cached')], page: 0, isLast: true,
              fromCache: true),
        );
        when(repository.isOffline).thenAnswer((_) async => true);
      },
      build: build,
      seed: () => const SearchReady(query: douala),
      act: (bloc) => bloc.add(const SearchSubmitted()),
      verify: (bloc) => expect(
        (bloc.state as SearchReady).cachedBecause,
        CacheReason.offline,
      ),
    );

    blocTest<SearchBloc, SearchState>(
      'a line, but the server failed — not "offline"',
      setUp: () {
        when(() => repository.search(any(), page: any(named: 'page')))
            .thenThrow(Exception('500'));
        when(repository.cachedFirstPage).thenReturn(
          SearchPage(hits: [hit('cached')], page: 0, isLast: true,
              fromCache: true),
        );
        when(repository.isOffline).thenAnswer((_) async => false);
      },
      build: build,
      seed: () => const SearchReady(query: douala),
      act: (bloc) => bloc.add(const SearchSubmitted()),
      // Reported as offline, this sent people to check a connection that was
      // working — seen on a simulator with the backend answering 200.
      verify: (bloc) => expect(
        (bloc.state as SearchReady).cachedBecause,
        CacheReason.unreachable,
      ),
    );
  });

  blocTest<SearchBloc, SearchState>(
    'cached results have no page 2',
    build: build,
    seed: () => SearchReady(
      query: douala,
      hits: [hit('cached')],
      isLast: false,
      cachedBecause: CacheReason.offline,
    ),
    act: (bloc) => bloc.add(const SearchNextPageRequested()),
    verify: (_) =>
        verifyNever(() => repository.search(any(), page: any(named: 'page'))),
  );

  blocTest<SearchBloc, SearchState>(
    'a failed next page keeps the pages already read',
    setUp: () => when(() => repository.search(douala, page: 1))
        .thenThrow(Exception('offline')),
    build: build,
    seed: () => SearchReady(query: douala, hits: [hit('a')], isLast: false),
    act: (bloc) => bloc.add(const SearchNextPageRequested()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.hits, hasLength(1));
      expect(state.loadMoreFailed, isTrue);
    },
  );

  blocTest<SearchBloc, SearchState>(
    'editing a filter does not fire a request',
    build: build,
    seed: () => const SearchReady(query: douala),
    act: (bloc) => bloc.add(
      SearchFilterChanged(douala.copyWith(rentMax: 150000)),
    ),
    verify: (_) =>
        verifyNever(() => repository.search(any(), page: any(named: 'page'))),
  );

  blocTest<SearchBloc, SearchState>(
    'RM-M04-01 — resetting the filters keeps the city',
    build: build,
    seed: () => SearchReady(
      query: douala.copyWith(rentMax: 150000, roomsMin: 3),
    ),
    act: (bloc) => bloc.add(const SearchFiltersCleared()),
    verify: (bloc) {
      final query = (bloc.state as SearchReady).query;
      expect(query.cityId, 'c-1');
      expect(query.activeFilterCount, 0);
    },
  );

  group('RM-M04-08 — the nearest first', () {
    const here = UserPosition(4.05, 9.7);
    const near = ListingHit(id: 'n', title: 'Près', distanceKm: 0.7);

    blocTest<SearchBloc, SearchState>(
      'asks for the position, then searches nearest first with it',
      setUp: () {
        when(location.current).thenAnswer((_) async => here);
        when(() => repository.search(douala, page: 0, position: here, sort: SearchSort.distance))
            .thenAnswer((_) async => page([near]));
      },
      build: build,
      seed: () => SearchReady(query: douala, hits: [hit('a')]),
      act: (bloc) => bloc.add(const SearchSortChanged(SearchSort.distance)),
      expect: () => [
        SearchReady(query: douala, hits: [hit('a')], isLocating: true),
        SearchReady(query: douala, hits: [hit('a')], isLoading: true, sort: SearchSort.distance, position: here),
        const SearchReady(query: douala, hits: [near], sort: SearchSort.distance, position: here),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'refused: the order stays, the screen is told why — nothing is searched',
      setUp: () => when(location.current).thenThrow(const LocationUnavailable(LocationRefusal.deniedForever)),
      build: build,
      seed: () => SearchReady(query: douala, hits: [hit('a')]),
      act: (bloc) => bloc.add(const SearchSortChanged(SearchSort.distance)),
      expect: () => [
        SearchReady(query: douala, hits: [hit('a')], isLocating: true),
        SearchReady(query: douala, hits: [hit('a')], locationRefusal: LocationRefusal.deniedForever),
      ],
      verify: (_) => verifyNever(
        () => repository.search(any(), page: any(named: 'page'), position: any(named: 'position'), sort: any(named: 'sort')),
      ),
    );

    blocTest<SearchBloc, SearchState>(
      'back to relevance: the cards still say how far',
      setUp: () => when(() => repository.search(douala, page: 0, position: here))
          .thenAnswer((_) async => page([near])),
      build: build,
      seed: () => const SearchReady(query: douala, hits: [near], sort: SearchSort.distance, position: here),
      act: (bloc) => bloc.add(const SearchSortChanged(SearchSort.relevance)),
      expect: () => [
        const SearchReady(query: douala, hits: [near], isLoading: true, position: here),
        const SearchReady(query: douala, hits: [near], position: here),
      ],
    );

    blocTest<SearchBloc, SearchState>(
      'the next page keeps the order and the position',
      setUp: () => when(() => repository.search(douala, page: 1, position: here, sort: SearchSort.distance))
          .thenAnswer((_) async => page([hit('b')], page: 1)),
      build: build,
      seed: () => const SearchReady(query: douala, hits: [near], isLast: false, sort: SearchSort.distance, position: here),
      act: (bloc) => bloc.add(const SearchNextPageRequested()),
      verify: (bloc) => expect((bloc.state as SearchReady).hits.map((h) => h.id), ['n', 'b']),
    );

    blocTest<SearchBloc, SearchState>(
      'the settings, where the reader can change their mind',
      setUp: () => when(() => location.openSettings(LocationRefusal.serviceOff)).thenAnswer((_) async {}),
      build: build,
      act: (bloc) => bloc.add(const SearchLocationSettingsRequested(LocationRefusal.serviceOff)),
      verify: (_) => verify(() => location.openSettings(LocationRefusal.serviceOff)).called(1),
    );
  });

  blocTest<SearchBloc, SearchState>(
    'CE-M04-03 — « Réessayer » after a failure runs the search again',
    setUp: () => when(() => repository.search(douala, page: 0)).thenAnswer((_) async => page([hit('a')])),
    build: build,
    seed: () => const SearchFailure(query: douala),
    act: (bloc) => bloc.add(const SearchSubmitted()),
    expect: () => [
      const SearchReady(query: douala, isLoading: true),
      SearchReady(query: douala, hits: [hit('a')]),
    ],
  );
}
