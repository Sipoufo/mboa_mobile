import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/reservations_repository.dart';

/// One reservation request, from the tenant's side — where it stands, and
/// withdrawing it. Opened from the list, the fiche ("Demande envoyée") and
/// the N-33 / N-34 pushes.
class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  ReservationBloc({required ReservationsRepository repository})
      : _repository = repository,
        super(const ReservationLoading()) {
    on<ReservationRequested>(_onRequested);
    on<ReservationCancelRequested>(_onCancel);
  }

  final ReservationsRepository _repository;

  Future<void> _onRequested(ReservationRequested event, Emitter<ReservationState> emit) async {
    emit(const ReservationLoading());
    try {
      emit(ReservationReady(await _repository.get(event.id)));
    } catch (_) {
      emit(ReservationFailure(event.id));
    }
  }

  Future<void> _onCancel(ReservationCancelRequested event, Emitter<ReservationState> emit) async {
    final current = state;
    if (current is! ReservationReady || !current.reservation.canCancel || current.isBusy) return;
    emit(ReservationReady(current.reservation, isBusy: true));
    try {
      emit(ReservationReady(await _repository.cancel(current.reservation.id)));
    } catch (_) {
      emit(ReservationReady(current.reservation, failed: true));
    }
  }
}

sealed class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

final class ReservationRequested extends ReservationEvent {
  const ReservationRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ReservationCancelRequested extends ReservationEvent {
  const ReservationCancelRequested();
}

sealed class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

final class ReservationLoading extends ReservationState {
  const ReservationLoading();
}

final class ReservationFailure extends ReservationState {
  const ReservationFailure(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ReservationReady extends ReservationState {
  const ReservationReady(this.reservation, {this.isBusy = false, this.failed = false});

  final Reservation reservation;
  final bool isBusy;

  /// The cancellation failed — said once, by the listener.
  final bool failed;

  @override
  List<Object?> get props => [reservation, isBusy, failed];
}
