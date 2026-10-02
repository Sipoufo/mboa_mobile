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
  });

  final String annonceId;
  final List<BookableVisitor> visitors;
  final String? selectedVisitorId;
  final VisitSlot? selectedSlot;
  final bool isSubmitting;

  /// RM-M07-03 — a visit is already running on this property.
  final bool alreadyBooked;
  final bool failed;

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
  }) =>
      BookingReady(
        annonceId: annonceId,
        visitors: visitors,
        selectedVisitorId: selectedVisitorId ?? this.selectedVisitorId,
        selectedSlot: clearSlot ? null : (selectedSlot ?? this.selectedSlot),
        isSubmitting: isSubmitting,
        alreadyBooked: alreadyBooked,
        failed: failed,
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
      ];
}

/// CE-M07-01 — nothing free in the next seven days, and why.
final class BookingUnavailable extends VisitBookingState {
  const BookingUnavailable({required this.reason});

  final NoSlotReason reason;

  @override
  List<Object?> get props => [reason];
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
