part of 'saved_searches_bloc.dart';

/// What the last action came to, for the listener to say — once.
enum SavedSearchOutcome { saved, limitReached, alreadySaved, failed }

sealed class SavedSearchesState extends Equatable {
  const SavedSearchesState();

  @override
  List<Object?> get props => [];
}

final class SavedSearchesInitial extends SavedSearchesState {
  const SavedSearchesInitial();
}

final class SavedSearchesLoading extends SavedSearchesState {
  const SavedSearchesLoading();
}

/// Not loaded, and nothing cached to show instead.
final class SavedSearchesFailure extends SavedSearchesState {
  const SavedSearchesFailure();
}

final class SavedSearchesReady extends SavedSearchesState {
  const SavedSearchesReady({
    required this.searches,
    this.isOffline = false,
    this.isSaving = false,
    this.busyId,
    this.outcome,
  });

  /// RM-M04-07 — the MVP keeps three.
  static const int limit = 3;

  /// Oldest first, as the server lists them.
  final List<SavedSearch> searches;

  /// The cached list: shown, not changed.
  final bool isOffline;
  final bool isSaving;

  /// The search being renamed, switched or deleted.
  final String? busyId;

  /// Set on the state that ends an action; cleared by the next one.
  final SavedSearchOutcome? outcome;

  bool get isFull => searches.length >= limit;

  /// Every change clears [outcome] and the busy flags unless it sets them
  /// again: an outcome is said once, not on every rebuild after it.
  SavedSearchesReady copyWith({
    List<SavedSearch>? searches,
    bool isSaving = false,
    String? busyId,
    SavedSearchOutcome? outcome,
  }) =>
      SavedSearchesReady(
        searches: searches ?? this.searches,
        isOffline: isOffline,
        isSaving: isSaving,
        busyId: busyId,
        outcome: outcome,
      );

  @override
  List<Object?> get props => [searches, isOffline, isSaving, busyId, outcome];
}
