part of 'saved_search_results_bloc.dart';

sealed class SavedSearchResultsEvent extends Equatable {
  const SavedSearchResultsEvent();

  @override
  List<Object?> get props => [];
}

/// Read the first page — on opening, and on "Réessayer".
final class SavedSearchResultsRequested extends SavedSearchResultsEvent {
  const SavedSearchResultsRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class SavedSearchResultsNextPageRequested extends SavedSearchResultsEvent {
  const SavedSearchResultsNextPageRequested();
}
