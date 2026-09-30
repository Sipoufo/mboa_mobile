import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/favorites_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

/// Saved listings (CDC M06).
///
/// Session-scoped and read from three places — the Favoris tab, the heart on a
/// search card, the heart on a fiche — so it is a single instance held above
/// them all. A per-screen bloc would let two hearts disagree about the same
/// listing.
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required FavoritesRepository repository})
      : _repository = repository,
        super(const FavoritesInitial()) {
    on<FavoritesLoadRequested>(_onLoad);
    on<FavoriteToggled>(_onToggle);
    on<FavoritesCleared>(_onCleared);
  }

  final FavoritesRepository _repository;

  Future<void> _onLoad(
    FavoritesLoadRequested event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoadInProgress());
    try {
      emit(FavoritesReady(items: await _repository.list()));
    } catch (_) {
      emit(const FavoritesFailure());
    }
  }

  /// Signing out empties it: favourites belong to an account, and the next
  /// person to open the app must not see the last one's.
  void _onCleared(FavoritesCleared event, Emitter<FavoritesState> emit) {
    emit(const FavoritesInitial());
  }

  /// The heart flips **first**, and rolls back if the server refuses.
  ///
  /// Waiting for the round trip makes the tap feel broken on a slow
  /// connection; leaving it flipped after a failure would lie about what is
  /// saved. RM-M06-02's cap of 50 is enforced server-side, and a refusal there
  /// is what surfaces it.
  Future<void> _onToggle(
    FavoriteToggled event,
    Emitter<FavoritesState> emit,
  ) async {
    final current = state;
    final items = current is FavoritesReady ? current.items : <Favorite>[];
    final wasSaved = items.any((f) => f.annonceId == event.annonceId);

    if (!wasSaved && items.length >= FavoritesRepository.maxFavorites) {
      emit(FavoritesReady(items: items, limitReached: true));
      return;
    }

    emit(
      FavoritesReady(
        items: wasSaved
            ? items.where((f) => f.annonceId != event.annonceId).toList()
            : [...items, event.optimistic],
        pendingId: event.annonceId,
      ),
    );

    try {
      wasSaved
          ? await _repository.remove(event.annonceId)
          : await _repository.add(event.annonceId);
      // Re-read rather than trust the local guess: the server owns the list,
      // including the 30-day grace on a listing that has since been rented.
      emit(FavoritesReady(items: await _repository.list()));
    } catch (_) {
      emit(FavoritesReady(items: items, lastActionFailed: true));
    }
  }
}
