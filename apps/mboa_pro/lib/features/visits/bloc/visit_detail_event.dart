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

/// Takes a GPS fix and starts, or asks for a justification when beyond 500 m.
class VisitStartRequested extends VisitDetailEvent {
  const VisitStartRequested();
}

/// RM-M16-02 — the agent explained why they are outside the radius.
class VisitStartOverridden extends VisitDetailEvent {
  const VisitStartOverridden(this.reason);

  final String reason;

  @override
  List<Object?> get props => [reason];
}

class VisitOverrideDismissed extends VisitDetailEvent {
  const VisitOverrideDismissed();
}
