part of 'my_visits_bloc.dart';

sealed class MyVisitsEvent extends Equatable {
  const MyVisitsEvent();

  @override
  List<Object?> get props => const [];
}

/// Load, or reload — opening the screen, pulling it down, and coming back
/// from a booking are the same request.
final class MyVisitsRequested extends MyVisitsEvent {
  const MyVisitsRequested();
}

/// RM-M07-05 — "I am here". Half of the mutual confirmation.
final class VisitPresenceConfirmed extends MyVisitsEvent {
  const VisitPresenceConfirmed(this.visitId);

  final String visitId;

  @override
  List<Object?> get props => [visitId];
}

/// RM-M07-04 — up to four hours before the slot.
final class VisitCancelled extends MyVisitsEvent {
  const VisitCancelled(this.visitId);

  final String visitId;

  @override
  List<Object?> get props => [visitId];
}

/// RM-M07-07 — the agent's service, 1–5, optional and once.
final class VisitorRated extends MyVisitsEvent {
  const VisitorRated({required this.visitId, required this.rating});

  final String visitId;
  final int rating;

  @override
  List<Object?> get props => [visitId, rating];
}
