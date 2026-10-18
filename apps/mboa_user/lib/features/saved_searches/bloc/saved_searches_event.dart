part of 'saved_searches_bloc.dart';

sealed class SavedSearchesEvent extends Equatable {
  const SavedSearchesEvent();

  @override
  List<Object?> get props => [];
}

/// Load the list — at sign-in, on opening the screen, and on "Réessayer".
final class SavedSearchesRequested extends SavedSearchesEvent {
  const SavedSearchesRequested();
}

/// Save the search on screen. Without a [name], the server names it.
final class SavedSearchSaveRequested extends SavedSearchesEvent {
  const SavedSearchSaveRequested(this.query, {this.name, this.alertsEnabled = true});

  final SearchQuery query;
  final String? name;
  final bool alertsEnabled;

  @override
  List<Object?> get props => [query, name, alertsEnabled];
}

final class SavedSearchRenamed extends SavedSearchesEvent {
  const SavedSearchRenamed(this.id, this.name);

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}

/// N-01 on or off for one search.
final class SavedSearchAlertsToggled extends SavedSearchesEvent {
  const SavedSearchAlertsToggled(this.id, {required this.enabled});

  final String id;
  final bool enabled;

  @override
  List<Object?> get props => [id, enabled];
}

final class SavedSearchDeleted extends SavedSearchesEvent {
  const SavedSearchDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Its results were opened, which resets its new-match count.
final class SavedSearchOpened extends SavedSearchesEvent {
  const SavedSearchOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
