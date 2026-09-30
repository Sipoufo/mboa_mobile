part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesLoadRequested extends FavoritesEvent {
  const FavoritesLoadRequested();
}

/// Saves or unsaves, from wherever the heart was tapped.
class FavoriteToggled extends FavoritesEvent {
  const FavoriteToggled(this.annonceId, {required this.optimistic});

  final String annonceId;

  /// What to show while the round trip is in flight — the card the tap came
  /// from already knows the title and the rent, so the list does not blink.
  final Favorite optimistic;

  @override
  List<Object?> get props => [annonceId, optimistic];
}

/// On sign-out.
class FavoritesCleared extends FavoritesEvent {
  const FavoritesCleared();
}
