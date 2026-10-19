import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/reservations_repository.dart';

/// "Mes demandes de réservation" — the list.
///
/// Offline it is the last one read, marked as such. Cancelling happens on a
/// request's own screen, which says what it means first; the list is read
/// again on the way back.
class MyReservationsBloc extends Bloc<MyReservationsEvent, MyReservationsState> {
  MyReservationsBloc({required ReservationsRepository repository})
      : _repository = repository,
        super(const MyReservationsLoading()) {
    on<MyReservationsRequested>(_onRequested);
  }

  final ReservationsRepository _repository;

  Future<void> _onRequested(MyReservationsRequested event, Emitter<MyReservationsState> emit) async {
    // A refresh keeps the list on screen rather than blanking it.
    if (state is! MyReservationsReady) emit(const MyReservationsLoading());
    try {
      final page = await _repository.mine();
      emit(MyReservationsReady(items: page.items, isOffline: page.fromCache));
    } catch (_) {
      if (state is! MyReservationsReady) emit(const MyReservationsFailure());
    }
  }
}

sealed class MyReservationsEvent extends Equatable {
  const MyReservationsEvent();

  @override
  List<Object?> get props => [];
}

final class MyReservationsRequested extends MyReservationsEvent {
  const MyReservationsRequested();
}

sealed class MyReservationsState extends Equatable {
  const MyReservationsState();

  @override
  List<Object?> get props => [];
}

final class MyReservationsLoading extends MyReservationsState {
  const MyReservationsLoading();
}

/// Not loaded, and nothing cached.
final class MyReservationsFailure extends MyReservationsState {
  const MyReservationsFailure();
}

final class MyReservationsReady extends MyReservationsState {
  const MyReservationsReady({required this.items, this.isOffline = false});

  final List<Reservation> items;

  /// The cached list: shown, marked.
  final bool isOffline;

  @override
  List<Object?> get props => [items, isOffline];
}
