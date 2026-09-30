part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];

  /// Asked by every heart in the app, including before the list has loaded —
  /// which is why it lives on the base state and answers false rather than
  /// making each caller pattern-match.
  bool contains(String annonceId) => false;
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoadInProgress extends FavoritesState {
  const FavoritesLoadInProgress();
}

class FavoritesReady extends FavoritesState {
  const FavoritesReady({
    this.items = const [],
    this.pendingId,
    this.limitReached = false,
    this.lastActionFailed = false,
  });

  final List<Favorite> items;

  /// The listing whose round trip is in flight.
  final String? pendingId;

  /// RM-M06-02 — 50 saved, and the 51st tap says so instead of failing.
  final bool limitReached;

  final bool lastActionFailed;

  /// Still saved, but the listing has been rented or archived: kept 30 days,
  /// flagged, so the list does not silently lose rows.
  List<Favorite> get unavailable =>
      items.where((f) => !f.isAvailable).toList();

  @override
  bool contains(String annonceId) =>
      items.any((f) => f.annonceId == annonceId);

  @override
  List<Object?> get props => [items, pendingId, limitReached, lastActionFailed];
}

class FavoritesFailure extends FavoritesState {
  const FavoritesFailure();
}
