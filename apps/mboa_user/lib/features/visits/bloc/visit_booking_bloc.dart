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
  VisitBookingBloc({
    required VisitsRepository repository,
    DateTime Function()? now,
  })  : _repository = repository,
        _now = now ?? DateTime.now,
        super(const BookingLoadInProgress()) {
    on<BookingStarted>(_onStarted);
    on<BookingWeekChanged>(_onWeekChanged);
    on<BookingVisitorSelected>(_onVisitorSelected);
    on<BookingSlotSelected>(_onSlotSelected);
    on<BookingSubmitted>(_onSubmitted);
  }

  /// §21 — the calendar reaches 28 days ahead: four windows of seven.
  static const maxWeekOffset = 3;

  final VisitsRepository _repository;
  final DateTime Function() _now;

  Future<void> _onStarted(
    BookingStarted event,
    Emitter<VisitBookingState> emit,
  ) =>
      _load(emit, event.annonceId, weekOffset: 0);

  Future<void> _onWeekChanged(
    BookingWeekChanged event,
    Emitter<VisitBookingState> emit,
  ) async {
    final (annonceId, keep) = switch (state) {
      BookingReady(:final annonceId, :final selectedVisitorId) =>
        (annonceId, selectedVisitorId),
      BookingUnavailable(:final annonceId) => (annonceId, null),
      _ => (null, null),
    };
    if (annonceId == null) return;
    await _load(
      emit,
      annonceId,
      weekOffset: event.weekOffset.clamp(0, maxWeekOffset),
      keepVisitorId: keep,
    );
  }

  Future<void> _load(
    Emitter<VisitBookingState> emit,
    String annonceId, {
    required int weekOffset,
    String? keepVisitorId,
  }) async {
    emit(const BookingLoadInProgress());

    // Week 0 is "from now" (the server's default). Later weeks start at local
    // midnight, so a page is a whole number of days and the last one ends
    // exactly on the 28th day — never beyond what `/visites/slots` accepts.
    final now = _now();
    final today = DateTime(now.year, now.month, now.day);
    final from =
        weekOffset == 0 ? null : today.add(Duration(days: 7 * weekOffset));

    try {
      final visitors = await _repository.visitorsFor(annonceId, from: from);
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
            annonceId: annonceId,
            weekOffset: weekOffset,
            windowStart: from,
          ),
        );
        return;
      }

      // Turning the page should not lose who the tenant had chosen.
      final kept = bookable.any((visitor) => visitor.accountId == keepVisitorId)
          ? keepVisitorId
          : null;

      emit(
        BookingReady(
          annonceId: annonceId,
          visitors: bookable,
          // One visitor is the common case; making them tap it would be a tap
          // for nothing (CA-M07-01).
          selectedVisitorId: kept ??
              (bookable.length == 1 ? bookable.single.accountId : null),
          weekOffset: weekOffset,
          windowStart: from,
          pageable: visitors.any((visitor) => visitor.mode == BookingMode.slots),
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

      // §19 — a proposal that has drifted out of bounds (the sheet left open
      // past it) is not sent only to be refused.
      if (visitor.mode == BookingMode.onRequest &&
          !ProposalWindow.accepts(slot.startsAt, _now())) {
        emit(ready.copyWith(timeRejected: true));
        return;
      }

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
      } on VisitTimeRejected {
        emit(ready.copyWith(isSubmitting: false, timeRejected: true));
      } catch (_) {
        emit(ready.copyWith(isSubmitting: false, failed: true));
      }
    }
  }
}
