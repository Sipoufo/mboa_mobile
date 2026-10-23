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

/// RM-M04-08 — « Pertinence » or « Proche de vous ». The nearest first asks
/// for the position, each time — the reader may have moved.
class SearchSortChanged extends SearchEvent {
  const SearchSortChanged(this.sort);

  final SearchSort sort;

  @override
  List<Object?> get props => [sort];
}

/// Where the reader can allow the position, after a refusal.
class SearchLocationSettingsRequested extends SearchEvent {
  const SearchLocationSettingsRequested(this.reason);

  final LocationRefusal reason;

  @override
  List<Object?> get props => [reason];
}
