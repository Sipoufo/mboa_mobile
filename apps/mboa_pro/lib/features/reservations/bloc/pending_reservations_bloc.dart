import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/incoming_reservations_repository.dart';

/// The home's "N demandes en attente" (CDC M29) — a count, nothing more.
///
/// A failed read keeps the last count: the card is a nudge, and a blank one
/// would say there is nothing to answer.
class PendingReservationsBloc extends Bloc<PendingReservationsEvent, PendingReservationsState> {
  PendingReservationsBloc({required IncomingReservationsRepository repository})
      : _repository = repository,
        super(const PendingReservationsUnknown()) {
    on<PendingReservationsRequested>(_onRequested);
  }

  final IncomingReservationsRepository _repository;

  Future<void> _onRequested(PendingReservationsRequested event, Emitter<PendingReservationsState> emit) async {
    try {
      emit(PendingReservationsCounted(await _repository.pendingCount()));
    } catch (_) {
      // Kept as it was.
    }
  }
}

sealed class PendingReservationsEvent extends Equatable {
  const PendingReservationsEvent();

  @override
  List<Object?> get props => [];
}

final class PendingReservationsRequested extends PendingReservationsEvent {
  const PendingReservationsRequested();
}

sealed class PendingReservationsState extends Equatable {
  const PendingReservationsState();

  @override
  List<Object?> get props => [];
}

final class PendingReservationsUnknown extends PendingReservationsState {
  const PendingReservationsUnknown();
}

final class PendingReservationsCounted extends PendingReservationsState {
  const PendingReservationsCounted(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}
