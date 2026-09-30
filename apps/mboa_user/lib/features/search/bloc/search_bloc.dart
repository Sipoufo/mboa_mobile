import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/search_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

/// The tenant's search (CDC M04) — the entry point of 90% of sessions.
///
/// Three things it is careful about: the city is the only mandatory criterion
/// (RM-M04-01), results arrive in the server's tier order and are never
/// re-sorted (CA-M04-02), and "no result" is a different screen from "no
/// network" and from "server error" (CE-M04-01 / -02 / -03).
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required SearchRepository repository})
      : _repository = repository,
        super(const SearchInitial()) {
    on<SearchStarted>(_onStarted);
    on<SearchFilterChanged>(_onFilterChanged);
    on<SearchSubmitted>(_onSubmitted);
    on<SearchNextPageRequested>(_onNextPage);
    on<SearchFiltersCleared>(_onFiltersCleared);
  }

  final SearchRepository _repository;

  /// RM-M04-02 — the last search comes back pre-filled, and runs itself when
  /// it is complete enough to run.
  Future<void> _onStarted(
    SearchStarted event,
    Emitter<SearchState> emit,
  ) async {
    final restored = _repository.lastQuery();
    if (restored == null || !restored.isValid) {
      emit(SearchReady(query: restored ?? const SearchQuery()));
      return;
    }
    emit(SearchReady(query: restored, isLoading: true));
    await _run(restored, emit);
  }

  void _onFilterChanged(SearchFilterChanged event, Emitter<SearchState> emit) {
    final current = state;
    if (current is! SearchReady) return;
    // Editing filters does not fire a request: the sheet has its own button,
    // and a search per keystroke would page the backend for nothing.
    emit(current.copyWith(query: event.query, clearOutcome: true));
  }

  void _onFiltersCleared(
    SearchFiltersCleared event,
    Emitter<SearchState> emit,
  ) {
    final current = state;
    if (current is! SearchReady) return;
    emit(current.copyWith(query: current.query.clearedFilters()));
  }

  Future<void> _onSubmitted(
    SearchSubmitted event,
    Emitter<SearchState> emit,
  ) async {
    final current = state;
    if (current is! SearchReady || !current.query.isValid) return;

    emit(current.copyWith(isLoading: true, clearOutcome: true));
    await _run(current.query, emit);
  }

  /// RM-M04-03 — 20 per page, loaded as the list is scrolled.
  Future<void> _onNextPage(
    SearchNextPageRequested event,
    Emitter<SearchState> emit,
  ) async {
    final current = state;
    if (current is! SearchReady) return;
    // Nothing more to fetch, already fetching, or looking at cached results —
    // an offline page 2 does not exist.
    if (current.isLast || current.isLoadingMore || current.isOffline) return;

    emit(current.copyWith(isLoadingMore: true));
    try {
      final page = await _repository.search(
        current.query,
        page: current.page + 1,
      );
      emit(
        current.copyWith(
          hits: [...current.hits, ...page.hits],
          page: page.page,
          isLast: page.isLast,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      // The pages already read stay on screen; only the appended one failed.
      emit(current.copyWith(isLoadingMore: false, loadMoreFailed: true));
    }
  }

  Future<void> _run(SearchQuery query, Emitter<SearchState> emit) async {
    try {
      final page = await _repository.search(query);
      emit(
        SearchReady(
          query: query,
          hits: page.hits,
          page: page.page,
          isLast: page.isLast,
          // CE-M04-01 — an empty answer is an answer: the screen suggests
          // widening rather than reporting a failure.
          isEmpty: page.hits.isEmpty,
        ),
      );
    } catch (_) {
      // CE-M04-02 — the last results, if they are still fresh, rather than a
      // blank screen. The banner says they are not live.
      final cached = _repository.cachedFirstPage();
      if (cached != null) {
        emit(
          SearchReady(
            query: query,
            hits: cached.hits,
            page: 0,
            isLast: true,
            isOffline: true,
          ),
        );
        return;
      }
      emit(SearchFailure(query: query));
    }
  }
}
