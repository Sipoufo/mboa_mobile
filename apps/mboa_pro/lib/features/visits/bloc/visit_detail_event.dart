part of 'visit_detail_bloc.dart';

sealed class VisitDetailEvent extends Equatable {
  const VisitDetailEvent();

  @override
  List<Object?> get props => [];
}

class VisitDetailRequested extends VisitDetailEvent {
  const VisitDetailRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// Takes a GPS fix and confirms the agent's presence, or asks for a
/// justification when beyond 500 m (RM-M07-05 / RM-M16-02).
class VisitPresenceConfirmed extends VisitDetailEvent {
  const VisitPresenceConfirmed();
}

/// RM-M16-02 — the agent explained why they are outside the radius.
class VisitPresenceOverridden extends VisitDetailEvent {
  const VisitPresenceOverridden(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

class VisitOverrideDismissed extends VisitDetailEvent {
  const VisitOverrideDismissed();
}

/// RM-M16-04 — allowed up to an hour before the slot.
class VisitCancelRequested extends VisitDetailEvent {
  const VisitCancelRequested();
}
