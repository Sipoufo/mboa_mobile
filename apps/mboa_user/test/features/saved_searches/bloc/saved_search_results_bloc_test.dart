import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/features/saved_searches/bloc/saved_search_results_bloc.dart';
import 'package:mboa_user/features/search/data/search_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

/// What one saved search finds — the screen N-01 opens.
void main() {
  late MockSavedSearchesRepository repository;

  const first = ListingHit(id: 'a-1', title: 'Studio Akwa');
  const second = ListingHit(id: 'a-2', title: 'Studio Bonapriso');

  setUp(() => repository = MockSavedSearchesRepository());

  SavedSearchResultsBloc build() => SavedSearchResultsBloc(repository: repository);

  blocTest<SavedSearchResultsBloc, SavedSearchResultsState>(
    'reads the first page',
    setUp: () => when(
      () => repository.results('s-1'),
    ).thenAnswer((_) async => const SearchPage(hits: [first], page: 0, isLast: false)),
    build: build,
    act: (bloc) => bloc.add(const SavedSearchResultsRequested('s-1')),
    expect: () => [
      const SavedSearchResultsLoading(),
      const SavedSearchResultsReady(id: 's-1', hits: [first], isLast: false),
    ],
  );

  blocTest<SavedSearchResultsBloc, SavedSearchResultsState>(
    'CE-M04-01 — nothing today is its own state',
    setUp: () => when(
      () => repository.results('s-1'),
    ).thenAnswer((_) async => const SearchPage(hits: [], page: 0, isLast: true)),
    build: build,
    act: (bloc) => bloc.add(const SavedSearchResultsRequested('s-1')),
    expect: () => [const SavedSearchResultsLoading(), const SavedSearchResultsEmpty(id: 's-1')],
  );

  blocTest<SavedSearchResultsBloc, SavedSearchResultsState>(
    'offline, a failure with a retry — never a page from a cache',
    setUp: () => when(() => repository.results('s-1')).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const SavedSearchResultsRequested('s-1')),
    expect: () => [const SavedSearchResultsLoading(), const SavedSearchResultsFailure(id: 's-1')],
  );

  blocTest<SavedSearchResultsBloc, SavedSearchResultsState>(
    'RM-M04-03 — the next page is appended',
    setUp: () => when(
      () => repository.results('s-1', page: 1),
    ).thenAnswer((_) async => const SearchPage(hits: [second], page: 1, isLast: true)),
    build: build,
    seed: () => const SavedSearchResultsReady(id: 's-1', hits: [first], isLast: false),
    act: (bloc) => bloc.add(const SavedSearchResultsNextPageRequested()),
    expect: () => [
      const SavedSearchResultsReady(id: 's-1', hits: [first], isLast: false, isLoadingMore: true),
      const SavedSearchResultsReady(id: 's-1', hits: [first, second], page: 1),
    ],
  );

  blocTest<SavedSearchResultsBloc, SavedSearchResultsState>(
    'a next page that fails keeps the first, and offers to try again',
    setUp: () => when(() => repository.results('s-1', page: 1)).thenThrow(Exception('offline')),
    build: build,
    seed: () => const SavedSearchResultsReady(id: 's-1', hits: [first], isLast: false),
    act: (bloc) => bloc.add(const SavedSearchResultsNextPageRequested()),
    skip: 1,
    expect: () => [
      const SavedSearchResultsReady(id: 's-1', hits: [first], isLast: false, loadMoreFailed: true),
    ],
  );

  blocTest<SavedSearchResultsBloc, SavedSearchResultsState>(
    'the last page asks for nothing more',
    build: build,
    seed: () => const SavedSearchResultsReady(id: 's-1', hits: [first]),
    act: (bloc) => bloc.add(const SavedSearchResultsNextPageRequested()),
    expect: () => const <SavedSearchResultsState>[],
  );
}
