import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/incoming_reservations_repository.dart';

/// "Demandes de réservation" — all of them, one listing's, or a residence's
/// units' when built with an id. Offline, the last list read, marked.
class IncomingReservationsBloc extends Bloc<IncomingReservationsEvent, IncomingReservationsState> {
  IncomingReservationsBloc({required IncomingReservationsRepository repository, this.annonceId, this.residenceId})
      : _repository = repository,
        super(const IncomingReservationsLoading()) {
    on<IncomingReservationsRequested>(_onRequested);
  }

  final IncomingReservationsRepository _repository;

  /// Set when the list is one listing's (opened from its fiche).
  final String? annonceId;

  /// Set when the list is a residence's: its units' requests, narrowed by
  /// the server (§30).
  final String? residenceId;

  Future<void> _onRequested(IncomingReservationsRequested event, Emitter<IncomingReservationsState> emit) async {
    // A refresh keeps the list on screen rather than blanking it.
    if (state is! IncomingReservationsReady) emit(const IncomingReservationsLoading());
    try {
      final page = await _repository.list(annonceId: annonceId, residenceId: residenceId);
      emit(IncomingReservationsReady(items: page.items, isOffline: page.fromCache));
    } catch (_) {
      if (state is! IncomingReservationsReady) emit(const IncomingReservationsFailure());
    }
  }
}

sealed class IncomingReservationsEvent extends Equatable {
  const IncomingReservationsEvent();

  @override
  List<Object?> get props => [];
}

final class IncomingReservationsRequested extends IncomingReservationsEvent {
  const IncomingReservationsRequested();
}

sealed class IncomingReservationsState extends Equatable {
  const IncomingReservationsState();

  @override
  List<Object?> get props => [];
}

final class IncomingReservationsLoading extends IncomingReservationsState {
  const IncomingReservationsLoading();
}

final class IncomingReservationsFailure extends IncomingReservationsState {
  const IncomingReservationsFailure();
}

final class IncomingReservationsReady extends IncomingReservationsState {
  const IncomingReservationsReady({required this.items, this.isOffline = false});

  final List<Reservation> items;
  final bool isOffline;

  List<Reservation> get pending => [for (final r in items) if (r.status == ReservationStatus.pending) r];

  @override
  List<Object?> get props => [items, isOffline];
}
