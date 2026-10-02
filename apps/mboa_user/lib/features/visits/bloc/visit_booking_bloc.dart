import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/visits_repository.dart';
import '../models/bookable_visitor.dart';

part 'visit_booking_event.dart';
part 'visit_booking_state.dart';

/// Planning a visit, from the fiche (CDC M07).
///
/// Two steps in one bloc because they are one decision: who shows the place
/// decides which times exist, and CA-M07-01 wants the whole thing in three
/// taps. Splitting it would mean a second screen for a choice most listings
/// do not even offer — one visitor is the common case, and it is preselected.
class VisitBookingBloc extends Bloc<VisitBookingEvent, VisitBookingState> {
  VisitBookingBloc({required VisitsRepository repository})
      : _repository = repository,
        super(const BookingLoadInProgress()) {
    on<BookingStarted>(_onStarted);
    on<BookingVisitorSelected>(_onVisitorSelected);
    on<BookingSlotSelected>(_onSlotSelected);
    on<BookingSubmitted>(_onSubmitted);
  }

  final VisitsRepository _repository;

  Future<void> _onStarted(
    BookingStarted event,
    Emitter<VisitBookingState> emit,
  ) async {
    emit(const BookingLoadInProgress());
    try {
      final visitors = await _repository.visitorsFor(event.annonceId);
      final bookable = visitors.where((visitor) => visitor.isBookable).toList();

      if (bookable.isEmpty) {
        // CE-M07-01 — the reason, not an empty list. Several visitors can each
        // give a different one; the first is the one shown, since they are all
        // "nothing free" and the tenant can act on any of them.
        emit(
          BookingUnavailable(
            reason: visitors
                    .map((visitor) => visitor.reason)
                    .nonNulls
                    .firstOrNull ??
                NoSlotReason.unknown,
          ),
        );
        return;
      }

      emit(
        BookingReady(
          annonceId: event.annonceId,
          visitors: bookable,
          // One visitor is the common case; making them tap it would be a tap
          // for nothing (CA-M07-01).
          selectedVisitorId:
              bookable.length == 1 ? bookable.single.accountId : null,
        ),
      );
    } catch (_) {
      emit(const BookingFailure());
    }
  }

  void _onVisitorSelected(
    BookingVisitorSelected event,
    Emitter<VisitBookingState> emit,
  ) {
    if (state case final BookingReady ready) {
      // The slot belonged to the previous visitor's calendar.
      emit(ready.copyWith(selectedVisitorId: event.accountId, clearSlot: true));
    }
  }

  void _onSlotSelected(
    BookingSlotSelected event,
    Emitter<VisitBookingState> emit,
  ) {
    if (state case final BookingReady ready) {
      emit(ready.copyWith(selectedSlot: event.slot));
    }
  }

  Future<void> _onSubmitted(
    BookingSubmitted event,
    Emitter<VisitBookingState> emit,
  ) async {
    if (state case final BookingReady ready) {
      final visitor = ready.selectedVisitor;
      final slot = ready.selectedSlot;
      if (visitor == null || slot == null) return;

      emit(ready.copyWith(isSubmitting: true));
      try {
        final visit = await _repository.book(
          annonceId: ready.annonceId,
          visitorAccountId: visitor.accountId,
          startsAt: slot.startsAt,
        );
        emit(BookingDone(visit: visit, mode: visitor.mode));
      } on VisitAlreadyBooked {
        // RM-M07-03 — not a failure: they already have one on this property.
        emit(ready.copyWith(isSubmitting: false, alreadyBooked: true));
      } catch (_) {
        emit(ready.copyWith(isSubmitting: false, failed: true));
      }
    }
  }
}
