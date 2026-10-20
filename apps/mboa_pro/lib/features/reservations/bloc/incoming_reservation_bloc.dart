import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../annonces/data/annonce_repository.dart';
import '../../annonces/models/annonce.dart';
import '../data/incoming_reservations_repository.dart';

/// What an answer was.
enum ReservationDecision { accepted, refused, extended, cancelled }

/// One incoming request (CDC M29), and the prestataire's answers to it.
///
/// What may be done is the server's `can*`, never the status read here: the
/// 48 h, the one extension and the listing's state all weigh on it. The
/// listing itself (photo, rent) and the other requests waiting on it are
/// read alongside, best-effort — the request stands without them.
class IncomingReservationBloc extends Bloc<IncomingReservationEvent, IncomingReservationState> {
  IncomingReservationBloc({
    required IncomingReservationsRepository repository,
    required AnnonceRepository annonces,
  })  : _repository = repository,
        _annonces = annonces,
        super(const IncomingReservationLoading()) {
    on<IncomingReservationRequested>(_onRequested);
    on<IncomingReservationAccepted>((event, emit) => _decide(
          emit,
          ReservationDecision.accepted,
          allowed: (r) => r.canAccept,
          call: (id) => _repository.accept(id),
        ));
    on<IncomingReservationRefused>((event, emit) => _decide(
          emit,
          ReservationDecision.refused,
          allowed: (r) => r.canRefuse,
          call: (id) => _repository.refuse(id, reason: event.reason, note: event.note),
        ));
    on<IncomingReservationExtended>((event, emit) => _decide(
          emit,
          ReservationDecision.extended,
          allowed: (r) => r.canExtend,
          call: (id) => _repository.extend(id),
        ));
    on<IncomingReservationCancelled>((event, emit) => _decide(
          emit,
          ReservationDecision.cancelled,
          allowed: (r) => r.canCancel,
          call: (id) => _repository.cancel(id, reason: event.reason, note: event.note),
        ));
  }

  final IncomingReservationsRepository _repository;
  final AnnonceRepository _annonces;

  Future<void> _onRequested(IncomingReservationRequested event, Emitter<IncomingReservationState> emit) async {
    emit(const IncomingReservationLoading());
    final Reservation reservation;
    try {
      reservation = await _repository.get(event.id);
    } catch (_) {
      emit(IncomingReservationFailure(event.id));
      return;
    }

    final annonceId = reservation.annonceId;
    final (listing, waiting) = await (
      annonceId == null ? Future<Annonce?>.value() : _listing(annonceId),
      annonceId == null ? Future.value(0) : _waiting(annonceId),
    ).wait;

    emit(
      IncomingReservationReady(
        reservation,
        listing: listing,
        // The others: this one, while it waits, is among them.
        otherPending: reservation.status == ReservationStatus.pending && waiting > 0 ? waiting - 1 : waiting,
      ),
    );
  }

  Future<Annonce?> _listing(String annonceId) async {
    try {
      return await _annonces.getOne(annonceId);
    } catch (_) {
      return null;
    }
  }

  Future<int> _waiting(String annonceId) async {
    try {
      return await _repository.pendingCount(annonceId: annonceId);
    } catch (_) {
      return 0;
    }
  }

  Future<void> _decide(
    Emitter<IncomingReservationState> emit,
    ReservationDecision decision, {
    required bool Function(Reservation) allowed,
    required Future<Reservation> Function(String id) call,
  }) async {
    final current = state;
    if (current is! IncomingReservationReady || current.isBusy || !allowed(current.reservation)) return;
    emit(current.copyWith(isBusy: true));
    try {
      final updated = await call(current.reservation.id);
      emit(
        current.copyWith(
          reservation: updated,
          // Accepting closes every other waiting request (RM-M29-04).
          otherPending: decision == ReservationDecision.accepted ? 0 : current.otherPending,
          done: decision,
        ),
      );
    } on ReservationDecisionRefused catch (refused) {
      // The request moved on without us — show where it stands now.
      Reservation fresh;
      try {
        fresh = await _repository.get(current.reservation.id);
      } catch (_) {
        fresh = current.reservation;
      }
      emit(current.copyWith(reservation: fresh, refusal: refused.reason));
    } catch (_) {
      emit(current.copyWith(failed: true));
    }
  }
}

sealed class IncomingReservationEvent extends Equatable {
  const IncomingReservationEvent();

  @override
  List<Object?> get props => [];
}

final class IncomingReservationRequested extends IncomingReservationEvent {
  const IncomingReservationRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class IncomingReservationAccepted extends IncomingReservationEvent {
  const IncomingReservationAccepted();
}

final class IncomingReservationRefused extends IncomingReservationEvent {
  const IncomingReservationRefused({required this.reason, this.note});

  final RefusalReason reason;
  final String? note;

  @override
  List<Object?> get props => [reason, note];
}

final class IncomingReservationExtended extends IncomingReservationEvent {
  const IncomingReservationExtended();
}

final class IncomingReservationCancelled extends IncomingReservationEvent {
  const IncomingReservationCancelled({required this.reason, this.note});

  final RefusalReason reason;
  final String? note;

  @override
  List<Object?> get props => [reason, note];
}

sealed class IncomingReservationState extends Equatable {
  const IncomingReservationState();

  @override
  List<Object?> get props => [];
}

final class IncomingReservationLoading extends IncomingReservationState {
  const IncomingReservationLoading();
}

final class IncomingReservationFailure extends IncomingReservationState {
  const IncomingReservationFailure(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class IncomingReservationReady extends IncomingReservationState {
  const IncomingReservationReady(
    this.reservation, {
    this.listing,
    this.otherPending = 0,
    this.isBusy = false,
    this.done,
    this.refusal,
    this.failed = false,
  });

  final Reservation reservation;

  /// The prestataire's own listing — its photo and rent. Null if unread.
  final Annonce? listing;

  /// Other requests waiting on the same listing.
  final int otherPending;

  final bool isBusy;

  /// The answer that just went through — said once, by the listener.
  final ReservationDecision? done;

  /// Why the server turned the answer down — said once.
  final DecisionRefusal? refusal;

  /// The answer did not go through.
  final bool failed;

  /// Transient outcomes are not carried over.
  IncomingReservationReady copyWith({
    Reservation? reservation,
    int? otherPending,
    bool isBusy = false,
    ReservationDecision? done,
    DecisionRefusal? refusal,
    bool failed = false,
  }) =>
      IncomingReservationReady(
        reservation ?? this.reservation,
        listing: listing,
        otherPending: otherPending ?? this.otherPending,
        isBusy: isBusy,
        done: done,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props => [reservation, listing, otherPending, isBusy, done, refusal, failed];
}
