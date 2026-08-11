part of 'agent_missions_bloc.dart';

sealed class AgentMissionsEvent extends Equatable {
  const AgentMissionsEvent();

  @override
  List<Object?> get props => [];
}

class MissionsLoadRequested extends AgentMissionsEvent {
  const MissionsLoadRequested();
}

class MissionsRefreshRequested extends AgentMissionsEvent {
  const MissionsRefreshRequested();
}

class MissionsFilterChanged extends AgentMissionsEvent {
  const MissionsFilterChanged(this.filter);

  final MissionFilter filter;

  @override
  List<Object?> get props => [filter];
}

/// RM-M11-07 — applying is not self-assignment; the prestataire still chooses.
class OpportunityApplied extends AgentMissionsEvent {
  const OpportunityApplied(this.opportunity);

  final Opportunity opportunity;

  @override
  List<Object?> get props => [opportunity];
}

class MissionAccepted extends AgentMissionsEvent {
  const MissionAccepted(this.assignment);

  final Assignment assignment;

  @override
  List<Object?> get props => [assignment];
}

class MissionDeclined extends AgentMissionsEvent {
  const MissionDeclined(this.assignment);

  final Assignment assignment;

  @override
  List<Object?> get props => [assignment];
}

/// RM-M11-06 — stepping down cancels the visits already planned.
class MissionResigned extends AgentMissionsEvent {
  const MissionResigned(this.assignment);

  final Assignment assignment;

  @override
  List<Object?> get props => [assignment];
}

class ApplicationWithdrawn extends AgentMissionsEvent {
  const ApplicationWithdrawn(this.assignment);

  final Assignment assignment;

  @override
  List<Object?> get props => [assignment];
}
