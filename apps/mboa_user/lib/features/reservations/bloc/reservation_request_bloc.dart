import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/reservations_repository.dart';

/// Sending a reservation request (CDC M29) — no payment, ever (RM-M29-09).
///
/// The form's own fields stay on the screen until sent; a refusal leaves
/// them as typed (CE-M29-02: the request is kept as a draft while the
/// profile is completed).
class ReservationRequestBloc extends Bloc<ReservationRequestEvent, ReservationRequestState> {
  ReservationRequestBloc({required ReservationsRepository repository})
      : _repository = repository,
        super(const ReservationRequestIdle()) {
    on<ReservationRequestSubmitted>(_onSubmitted);
  }

  final ReservationsRepository _repository;

  Future<void> _onSubmitted(ReservationRequestSubmitted event, Emitter<ReservationRequestState> emit) async {
    if (state is ReservationRequestSubmitting) return;
    emit(const ReservationRequestSubmitting());
    try {
      final reservation = await _repository.request(
        annonceId: event.annonceId,
        start: event.start,
        units: event.units,
        message: event.message,
      );
      emit(ReservationRequestSent(reservation));
    } on ReservationRequestRefused catch (refused) {
      emit(ReservationRequestRefusedState(refused.reason));
    } catch (_) {
      emit(const ReservationRequestFailed());
    }
  }
}

sealed class ReservationRequestEvent extends Equatable {
  const ReservationRequestEvent();

  @override
  List<Object?> get props => [];
}

final class ReservationRequestSubmitted extends ReservationRequestEvent {
  const ReservationRequestSubmitted({
    required this.annonceId,
    required this.start,
    required this.units,
    this.message,
  });

  final String annonceId;
  final DateTime start;
  final int units;
  final String? message;

  @override
  List<Object?> get props => [annonceId, start, units, message];
}

sealed class ReservationRequestState extends Equatable {
  const ReservationRequestState();

  @override
  List<Object?> get props => [];
}

final class ReservationRequestIdle extends ReservationRequestState {
  const ReservationRequestIdle();
}

final class ReservationRequestSubmitting extends ReservationRequestState {
  const ReservationRequestSubmitting();
}

final class ReservationRequestSent extends ReservationRequestState {
  const ReservationRequestSent(this.reservation);

  final Reservation reservation;

  @override
  List<Object?> get props => [reservation];
}

/// A refusal the screen explains (CE-M29-01 to 03).
final class ReservationRequestRefusedState extends ReservationRequestState {
  const ReservationRequestRefusedState(this.reason);

  final RequestRefusal reason;

  @override
  List<Object?> get props => [reason];
}

/// Offline, or the server failed — the form is kept, and can be sent again.
final class ReservationRequestFailed extends ReservationRequestState {
  const ReservationRequestFailed();
}
