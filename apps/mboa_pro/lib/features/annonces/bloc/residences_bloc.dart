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

  Future<void> _onStatusChange(
    ResidenceStatusChangeRequested event,
    Emitter<ResidencesState> emit,
  ) async {
    final current = state;
    if (current is! ResidencesReady) return;

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
}
