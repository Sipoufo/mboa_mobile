import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/search/bloc/search_bloc.dart';
import 'package:mboa_user/features/search/data/location_service.dart';
import 'package:mboa_user/features/search/data/search_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

class MockLocationService extends Mock implements LocationService {}

/// Doc 10 M04 « Quartier(s) » — the filter needs the chosen city's districts.
void main() {
  late MockSearchRepository repository;

  const douala = SearchQuery(cityId: 'dla', cityName: 'Douala');
  const yaounde = SearchQuery(cityId: 'yde', cityName: 'Yaoundé');
  const akwa = CityOption(id: 'd-akwa', name: 'Akwa');
  const bonapriso = CityOption(id: 'd-bonapriso', name: 'Bonapriso');
  const bastos = CityOption(id: 'd-bastos', name: 'Bastos');

  setUpAll(() {
    registerFallbackValue(const SearchQuery());
    registerFallbackValue(SearchSort.relevance);
  });

  setUp(() {
    repository = MockSearchRepository();
    when(() => repository.lastQuery()).thenReturn(null);
    when(() => repository.cachedFirstPage()).thenReturn(null);
    when(repository.isOffline).thenAnswer((_) async => true);
    when(() => repository.search(any(), page: any(named: 'page'), position: any(named: 'position'), sort: any(named: 'sort')))
        .thenAnswer((_) async => const SearchPage(hits: [], page: 0, isLast: true));
    when(() => repository.districts('dla')).thenAnswer((_) async => [akwa, bonapriso]);
    when(() => repository.districts('yde')).thenAnswer((_) async => [bastos]);
  });

  SearchBloc build() => SearchBloc(repository: repository, location: MockLocationService());

  blocTest<SearchBloc, SearchState>(
    'the restored city brings its districts, and the search keeps them',
    setUp: () => when(() => repository.lastQuery()).thenReturn(douala),
    build: build,
    act: (bloc) => bloc.add(const SearchStarted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.districts, [akwa, bonapriso]);
      expect(state.isLoading, isFalse);
    },
  );

  blocTest<SearchBloc, SearchState>(
    'another city: its districts replace the old ones, and the chosen ones go',
    seed: () => SearchReady(query: douala.copyWith(districtIds: ['d-akwa']), districts: const [akwa, bonapriso]),
    build: build,
    act: (bloc) => bloc
      ..add(const SearchFilterChanged(yaounde))
      ..add(const SearchSubmitted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.query.districtIds, isEmpty);
      expect(state.districts, [bastos]);
    },
  );

  blocTest<SearchBloc, SearchState>(
    'one read per city, however many searches run in it',
    setUp: () => when(() => repository.lastQuery()).thenReturn(douala),
    build: build,
    act: (bloc) async {
      bloc.add(const SearchStarted());
      await Future<void>.delayed(Duration.zero);
      bloc
        ..add(SearchFilterChanged(douala.copyWith(districtIds: ['d-akwa'])))
        ..add(const SearchSubmitted())
        ..add(const SearchSubmitted());
    },
    verify: (_) => verify(() => repository.districts('dla')).called(1),
  );

  test('a city left before its districts arrived does not get them', () async {
    final slow = Completer<List<CityOption>>();
    when(() => repository.districts('dla')).thenAnswer((_) => slow.future);
    final bloc = build()..emit(const SearchReady(query: SearchQuery()));

    bloc
      ..add(const SearchFilterChanged(douala))
      ..add(const SearchFilterChanged(yaounde));
    await Future<void>.delayed(Duration.zero);
    slow.complete([akwa, bonapriso]);
    await Future<void>.delayed(const Duration(milliseconds: 10));

    final state = bloc.state as SearchReady;
    expect(state.query.cityId, 'yde');
    expect(state.districts, [bastos]);
    await bloc.close();
  });

  blocTest<SearchBloc, SearchState>(
    'unreadable districts leave the filter without them, and the search runs',
    setUp: () {
      when(() => repository.lastQuery()).thenReturn(douala);
      when(() => repository.districts('dla')).thenThrow(Exception('offline, nothing cached'));
    },
    build: build,
    act: (bloc) => bloc.add(const SearchStarted()),
    verify: (bloc) {
      final state = bloc.state as SearchReady;
      expect(state.districts, isEmpty);
      verify(() => repository.search(douala, page: any(named: 'page'), position: any(named: 'position'), sort: any(named: 'sort')))
          .called(1);
    },
  );

  test('the city bar names the chosen districts in the catalogue order', () {
    final state = SearchReady(
      query: douala.copyWith(districtIds: ['d-bonapriso', 'd-akwa']),
      districts: const [akwa, bonapriso],
    );

    expect(state.districtNames, ['Akwa', 'Bonapriso']);
  });
}
