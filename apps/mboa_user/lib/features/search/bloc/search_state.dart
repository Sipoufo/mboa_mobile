part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchReady extends SearchState {
  const SearchReady({
    required this.query,
    this.hits = const [],
    this.page = 0,
    this.isLast = true,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isEmpty = false,
    this.isOffline = false,
    this.loadMoreFailed = false,
  });

  final SearchQuery query;

  /// In the server's order — the visibility algorithm's, not ours.
  final List<SearchHit> hits;

  final int page;
  final bool isLast;
  final bool isLoading;
  final bool isLoadingMore;

  /// CE-M04-01 — searched, and nothing matched. Distinct from "not searched
  /// yet", which is [hits] empty with [isEmpty] false.
  final bool isEmpty;

  /// CE-M04-02 — these results come from the cache; the banner says so.
  final bool isOffline;

  final bool loadMoreFailed;

  /// RM-M04-01 — the city is what makes a search runnable.
  bool get canSubmit => query.isValid && !isLoading;

  SearchReady copyWith({
    SearchQuery? query,
    List<SearchHit>? hits,
    int? page,
    bool? isLast,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isOffline,
    bool loadMoreFailed = false,
    bool clearOutcome = false,
  }) =>
      SearchReady(
        query: query ?? this.query,
        hits: hits ?? this.hits,
        page: page ?? this.page,
        isLast: isLast ?? this.isLast,
        isLoading: isLoading ?? this.isLoading,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        isEmpty: clearOutcome ? false : isEmpty,
        isOffline: isOffline ?? (clearOutcome ? false : this.isOffline),
        loadMoreFailed: loadMoreFailed,
      );

  @override
  List<Object?> get props => [
        query,
        hits,
        page,
        isLast,
        isLoading,
        isLoadingMore,
        isEmpty,
        isOffline,
        loadMoreFailed,
      ];
}

/// CE-M04-03 — the server failed and there was nothing cached to fall back on.
class SearchFailure extends SearchState {
  const SearchFailure({required this.query});

  final SearchQuery query;

  @override
  List<Object?> get props => [query];
}
