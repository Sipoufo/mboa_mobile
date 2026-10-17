part of 'visit_booking_bloc.dart';

sealed class VisitBookingState extends Equatable {
  const VisitBookingState();

  @override
  List<Object?> get props => const [];
}

final class BookingLoadInProgress extends VisitBookingState {
  const BookingLoadInProgress();
}

/// Who can show the place, and the time the tenant has picked so far.
final class BookingReady extends VisitBookingState {
  const BookingReady({
    required this.annonceId,
    required this.visitors,
    this.selectedVisitorId,
    this.selectedSlot,
    this.isSubmitting = false,
    this.alreadyBooked = false,
    this.failed = false,
    this.timeRejected = false,
    this.weekOffset = 0,
    this.windowStart,
    this.pageable = false,
  });

  final String annonceId;
  final List<BookableVisitor> visitors;
  final String? selectedVisitorId;
  final VisitSlot? selectedSlot;
  final bool isSubmitting;

  /// RM-M07-03 — a visit is already running on this property.
  final bool alreadyBooked;
  final bool failed;

  /// §19 — the proposed time was outside what the owner can be asked for.
  final bool timeRejected;

  /// §21 — which week of the calendar is on screen, 0 to
  /// [VisitBookingBloc.maxWeekOffset].
  final int weekOffset;

  /// Where that week starts, for the label. Null on the first week, which is
  /// "from now".
  final DateTime? windowStart;

  /// Whether this listing has any visitor who publishes slots — computed on
  /// the whole answer, before the full ones are filtered out. It decides the
  /// week navigation, not the selection: an agent full this week vanishes from
  /// [visitors], and paging is the only way to find them again.
  final bool pageable;

  bool get canGoPrevWeek => weekOffset > 0;
  bool get canGoNextWeek => weekOffset < VisitBookingBloc.maxWeekOffset;

  BookableVisitor? get selectedVisitor => visitors
      .where((visitor) => visitor.accountId == selectedVisitorId)
      .firstOrNull;

  /// A visitor and one of their times — `BookVisiteRequest` requires both.
  bool get canSubmit =>
      selectedVisitor != null && selectedSlot != null && !isSubmitting;

  /// More than one, so the choice is worth a screen of its own (CA-M07-01
  /// counts the visitor choice separately for exactly this reason).
  bool get hasVisitorChoice => visitors.length > 1;

  BookingReady copyWith({
    String? selectedVisitorId,
    VisitSlot? selectedSlot,
    bool clearSlot = false,
    bool isSubmitting = false,
    bool alreadyBooked = false,
    bool failed = false,
    bool timeRejected = false,
  }) =>
      BookingReady(
        annonceId: annonceId,
        visitors: visitors,
        selectedVisitorId: selectedVisitorId ?? this.selectedVisitorId,
        selectedSlot: clearSlot ? null : (selectedSlot ?? this.selectedSlot),
        isSubmitting: isSubmitting,
        alreadyBooked: alreadyBooked,
        failed: failed,
        timeRejected: timeRejected,
        weekOffset: weekOffset,
        windowStart: windowStart,
        pageable: pageable,
      );

  @override
  List<Object?> get props => [
        annonceId,
        visitors,
        selectedVisitorId,
        selectedSlot,
        isSubmitting,
        alreadyBooked,
        failed,
        timeRejected,
        weekOffset,
        windowStart,
        pageable,
      ];
}

/// CE-M07-01 — nothing free in this week, and why.
final class BookingUnavailable extends VisitBookingState {
  const BookingUnavailable({
    required this.reason,
    required this.annonceId,
    this.weekOffset = 0,
    this.windowStart,
  });

  final NoSlotReason reason;
  final String annonceId;
  final int weekOffset;
  final DateTime? windowStart;

  /// §21 — a full or blocked week is no longer a dead end: the next one may
  /// have room. A visitor who has declared no hours at all is a dead end in
  /// every week, so paging would only show the same message again.
  bool get canSeeNextWeek =>
      weekOffset < VisitBookingBloc.maxWeekOffset &&
      (reason == NoSlotReason.fullyBooked ||
          reason == NoSlotReason.allDaysBlocked);

  bool get canGoPrevWeek => weekOffset > 0;

  @override
  List<Object?> get props => [reason, annonceId, weekOffset, windowStart];
}

/// Booked. [mode] decides the wording: a published slot is confirmed, a
/// request still waits on the visitor (RM-M15-06).
final class BookingDone extends VisitBookingState {
  const BookingDone({required this.visit, required this.mode});

  final Visit visit;
  final BookingMode mode;

  @override
  List<Object?> get props => [visit, mode];
}

final class BookingFailure extends VisitBookingState {
  const BookingFailure();
}
