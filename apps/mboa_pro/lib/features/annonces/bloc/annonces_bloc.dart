import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/annonce_repository.dart';
import '../models/annonce.dart';
import '../models/annonce_status.dart';

part 'annonces_event.dart';
part 'annonces_state.dart';

/// The Biens Uniques list (CDC M10).
///
/// Holds every listing and filters in memory: the API returns one page and the
/// two tabs are two views of the same data, so re-fetching per tab would be
/// wasted round-trips.
class AnnoncesBloc extends Bloc<AnnoncesEvent, AnnoncesState> {
  AnnoncesBloc({required AnnonceRepository repository})
      : _repository = repository,
        super(const AnnoncesInitial()) {
    on<AnnoncesLoadRequested>(_onLoad);
    on<AnnoncesRefreshRequested>(_onRefresh);
    on<AnnoncesFilterChanged>(_onFilterChanged);
    on<AnnonceStatusChangeRequested>(_onStatusChange);
    on<AnnonceDeleteRequested>(_onDelete);
  }

  final AnnonceRepository _repository;

  Future<void> _onLoad(
    AnnoncesLoadRequested event,
    Emitter<AnnoncesState> emit,
  ) async {
    emit(const AnnoncesLoadInProgress());
    await _load(emit, AnnonceFilter.available);
  }

  Future<void> _onRefresh(
    AnnoncesRefreshRequested event,
    Emitter<AnnoncesState> emit,
  ) async {
    final current = state;
    await _load(
      emit,
      current is AnnoncesReady ? current.filter : AnnonceFilter.available,
    );
  }

  void _onFilterChanged(
    AnnoncesFilterChanged event,
    Emitter<AnnoncesState> emit,
  ) {
    final current = state;
    if (current is! AnnoncesReady) return;
    emit(current.copyWith(filter: event.filter));
  }

  Future<void> _load(Emitter<AnnoncesState> emit, AnnonceFilter filter) async {
    try {
      emit(AnnoncesReady(items: await _repository.list(), filter: filter));
    } catch (_) {
      final current = state;
      // A failed refresh keeps whatever is on screen.
      if (current is! AnnoncesReady) emit(const AnnoncesFailure());
    }
  }

  Future<void> _onStatusChange(
    AnnonceStatusChangeRequested event,
    Emitter<AnnoncesState> emit,
  ) async {
    final current = state;
    if (current is! AnnoncesReady) return;

    emit(current.copyWith(mutatingId: event.id));
    try {
      final updated = await _repository.transition(event.id, event.transition);
      emit(
        current.copyWith(
          items: [
            for (final item in current.items)
              if (item.id == updated.id) updated else item,
          ],
          clearMutating: true,
        ),
      );
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onDelete(
    AnnonceDeleteRequested event,
    Emitter<AnnoncesState> emit,
  ) async {
    final current = state;
    if (current is! AnnoncesReady) return;

    emit(current.copyWith(mutatingId: event.id));
    try {
      await _repository.delete(event.id);
      emit(
        current.copyWith(
          items: current.items.where((i) => i.id != event.id).toList(),
          clearMutating: true,
        ),
      );
    } catch (_) {
      // RM-M10-07: the backend refuses when an active contract references it.
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }
}
