import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/residence_repository.dart';
import '../models/annonce_status.dart';
import '../models/residence.dart';

part 'residences_event.dart';
part 'residences_state.dart';

/// The Biens Multiples list (CDC M10).
///
/// Mirrors [AnnoncesBloc], but the transitions here are the bulk ones — they
/// act on every unit in the residence at once.
class ResidencesBloc extends Bloc<ResidencesEvent, ResidencesState> {
  ResidencesBloc({required ResidenceRepository repository})
      : _repository = repository,
        super(const ResidencesInitial()) {
    on<ResidencesLoadRequested>(_onLoad);
    on<ResidencesRefreshRequested>(_onRefresh);
    on<ResidenceDetailRequested>(_onDetailRequested);
    on<ResidenceStatusChangeRequested>(_onStatusChange);
    on<ResidenceDeleteRequested>(_onDelete);
  }

  final ResidenceRepository _repository;

  Future<void> _onLoad(
    ResidencesLoadRequested event,
    Emitter<ResidencesState> emit,
  ) async {
    emit(const ResidencesLoadInProgress());
    await _load(emit);
  }

  Future<void> _onRefresh(
    ResidencesRefreshRequested event,
    Emitter<ResidencesState> emit,
  ) =>
      _load(emit);

  Future<void> _load(Emitter<ResidencesState> emit) async {
    try {
      emit(ResidencesReady(items: await _repository.list()));
    } catch (_) {
      if (state is! ResidencesReady) emit(const ResidencesFailure());
    }
  }

  /// Fetches the full residence and merges it into the list, so the detail and
  /// the list stay one source of truth.
  Future<void> _onDetailRequested(
    ResidenceDetailRequested event,
    Emitter<ResidencesState> emit,
  ) async {
    try {
      final residence = await _repository.getOne(event.id);
      final current = state;
      final items = current is ResidencesReady ? [...current.items] : <Residence>[];

      final index = items.indexWhere((r) => r.id == residence.id);
      if (index >= 0) {
        items[index] = residence;
      } else {
        // Deep link straight to a detail: the list was never loaded.
        items.add(residence);
      }
      emit(ResidencesReady(items: items));
    } catch (_) {
      if (state is! ResidencesReady) emit(const ResidencesFailure());
    }
  }

  Future<void> _onDelete(
    ResidenceDeleteRequested event,
    Emitter<ResidencesState> emit,
  ) async {
    final current = state;
    if (current is! ResidencesReady) return;

    emit(current.copyWith(mutatingId: event.id));
    try {
      await _repository.delete(event.id);
      emit(
        current.copyWith(
          items: current.items.where((r) => r.id != event.id).toList(),
          clearMutating: true,
        ),
      );
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  Future<void> _onStatusChange(
    ResidenceStatusChangeRequested event,
    Emitter<ResidencesState> emit,
  ) async {
    final current = state;
    if (current is! ResidencesReady) return;

    final held = current.items.indexWhere((r) => r.id == event.id);
    final hadUnits = held >= 0 && current.items[held].units.isNotEmpty;

    emit(current.copyWith(mutatingId: event.id));
    try {
      final updated = await _repository.transition(event.id, event.transition);
      emit(
        current.copyWith(
          items: [
            for (final item in current.items)
              if (item.id == updated.id)
                await _withUnits(updated, refetch: hadUnits)
              else
                item,
          ],
          clearMutating: true,
        ),
      );
    } catch (_) {
      emit(current.copyWith(clearMutating: true, lastActionFailed: true));
    }
  }

  /// A bulk transition answers with the aggregate shape, whose `units` array is
  /// empty by design — so writing it straight back over a residence we were
  /// holding units for empties the detail screen's list.
  ///
  /// Refetching rather than carrying the old units forward, because the
  /// transition just changed every unit's own status (unarchive returns them
  /// all to DRAFT); keeping the stale ones would show the wrong chips.
  Future<Residence> _withUnits(Residence updated, {required bool refetch}) async {
    if (!refetch || updated.units.isNotEmpty) return updated;
    try {
      return await _repository.getOne(updated.id);
    } catch (_) {
      // The transition itself succeeded — reporting a failure here would be a
      // lie. Pull-to-refresh recovers the units.
      return updated;
    }
  }
}
