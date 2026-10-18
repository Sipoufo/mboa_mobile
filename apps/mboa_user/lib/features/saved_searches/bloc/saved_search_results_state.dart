part of 'saved_search_results_bloc.dart';

sealed class SavedSearchResultsState extends Equatable {
  const SavedSearchResultsState();

  @override
  List<Object?> get props => [];
}

final class SavedSearchResultsLoading extends SavedSearchResultsState {
  const SavedSearchResultsLoading();
}

/// CE-M04-01 — the search runs, and nothing matches today.
final class SavedSearchResultsEmpty extends SavedSearchResultsState {
  const SavedSearchResultsEmpty({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Offline, the search was deleted elsewhere, or the server failed.
final class SavedSearchResultsFailure extends SavedSearchResultsState {
  const SavedSearchResultsFailure({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];
}

final class SavedSearchResultsReady extends SavedSearchResultsState {
  const SavedSearchResultsReady({
    required this.id,
    required this.hits,
    this.page = 0,
    this.isLast = true,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });

  final String id;

  /// In the server's order — the visibility algorithm's (CA-M04-02).
  final List<SearchHit> hits;
  final int page;
  final bool isLast;
  final bool isLoadingMore;
  final bool loadMoreFailed;

  SavedSearchResultsReady copyWith({
    List<SearchHit>? hits,
    int? page,
    bool? isLast,
    bool isLoadingMore = false,
    bool loadMoreFailed = false,
  }) =>
      SavedSearchResultsReady(
        id: id,
        hits: hits ?? this.hits,
        page: page ?? this.page,
        isLast: isLast ?? this.isLast,
        isLoadingMore: isLoadingMore,
        loadMoreFailed: loadMoreFailed,
      );

  @override
  List<Object?> get props => [id, hits, page, isLast, isLoadingMore, loadMoreFailed];
}
