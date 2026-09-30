part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

/// Opens the screen: restores the last search and runs it (RM-M04-02).
class SearchStarted extends SearchEvent {
  const SearchStarted();
}

/// A criterion moved in the filters sheet. Does not search on its own.
class SearchFilterChanged extends SearchEvent {
  const SearchFilterChanged(this.query);

  final SearchQuery query;

  @override
  List<Object?> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  const SearchSubmitted();
}

/// RM-M04-03 — infinite scroll.
class SearchNextPageRequested extends SearchEvent {
  const SearchNextPageRequested();
}

/// Keeps the city, drops everything else (RM-M04-01).
class SearchFiltersCleared extends SearchEvent {
  const SearchFiltersCleared();
}
