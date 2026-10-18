import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/saved_searches_repository.dart';

part 'saved_search_results_event.dart';
part 'saved_search_results_state.dart';

/// What one saved search finds — the screen N-01 opens.
///
/// Not cached: reading the results is what resets the search's new-match
/// count on the server, so a cached page would show "new" listings the count
/// says were already seen. Offline, the screen says so and offers a retry.
class SavedSearchResultsBloc extends Bloc<SavedSearchResultsEvent, SavedSearchResultsState> {
  SavedSearchResultsBloc({required SavedSearchesRepository repository})
      : _repository = repository,
        super(const SavedSearchResultsLoading()) {
    on<SavedSearchResultsRequested>(_onRequested);
    on<SavedSearchResultsNextPageRequested>(_onNextPage);
  }

  final SavedSearchesRepository _repository;

  Future<void> _onRequested(SavedSearchResultsRequested event, Emitter<SavedSearchResultsState> emit) async {
    emit(const SavedSearchResultsLoading());
    try {
      final page = await _repository.results(event.id);
      emit(
        page.hits.isEmpty
            ? SavedSearchResultsEmpty(id: event.id)
            : SavedSearchResultsReady(id: event.id, hits: page.hits, page: page.page, isLast: page.isLast),
      );
    } catch (_) {
      emit(SavedSearchResultsFailure(id: event.id));
    }
  }

  /// RM-M04-03 — the next 20, as the list nears its end.
  Future<void> _onNextPage(
    SavedSearchResultsNextPageRequested event,
    Emitter<SavedSearchResultsState> emit,
  ) async {
    final current = state;
    if (current is! SavedSearchResultsReady || current.isLast || current.isLoadingMore) return;

    emit(current.copyWith(isLoadingMore: true));
    try {
      final next = await _repository.results(current.id, page: current.page + 1);
      emit(
        current.copyWith(
          hits: [...current.hits, ...next.hits],
          page: next.page,
          isLast: next.isLast,
        ),
      );
    } catch (_) {
      // The first pages stay; the end of the list offers to try again.
      emit(current.copyWith(loadMoreFailed: true));
    }
  }
}
