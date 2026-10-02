part of 'visit_booking_bloc.dart';

sealed class VisitBookingEvent extends Equatable {
  const VisitBookingEvent();

  @override
  List<Object?> get props => const [];
}

/// The sheet opened on a listing: load who can show it, and when.
final class BookingStarted extends VisitBookingEvent {
  const BookingStarted(this.annonceId);

  final String annonceId;

  @override
  List<Object?> get props => [annonceId];
}

final class BookingVisitorSelected extends VisitBookingEvent {
  const BookingVisitorSelected(this.accountId);

  final String accountId;

  @override
  List<Object?> get props => [accountId];
}

final class BookingSlotSelected extends VisitBookingEvent {
  const BookingSlotSelected(this.slot);

  final VisitSlot slot;

  @override
  List<Object?> get props => [slot];
}

final class BookingSubmitted extends VisitBookingEvent {
  const BookingSubmitted();
}
