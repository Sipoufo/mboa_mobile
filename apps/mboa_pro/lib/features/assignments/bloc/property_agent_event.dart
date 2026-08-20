part of 'property_agent_bloc.dart';

sealed class PropertyAgentEvent extends Equatable {
  const PropertyAgentEvent();

  @override
  List<Object?> get props => [];
}

class PropertyAgentLoadRequested extends PropertyAgentEvent {
  const PropertyAgentLoadRequested(this.target);

  final AssignmentTarget target;

  @override
  List<Object?> get props => [target];
}

/// RM-M11-04 — the agent still has to accept; this only proposes.
class AgentOffered extends PropertyAgentEvent {
  const AgentOffered(this.agentAccountId);

  final String agentAccountId;

  @override
  List<Object?> get props => [agentAccountId];
}

/// RM-M11-06 — planned visits are cancelled server-side.
class AssignmentWithdrawn extends PropertyAgentEvent {
  const AssignmentWithdrawn(this.assignment);

  final Assignment assignment;

  @override
  List<Object?> get props => [assignment];
}

/// RM-M11-10 — "je fais mes visites moi-même", on or off.
class OwnerVisitsToggled extends PropertyAgentEvent {
  const OwnerVisitsToggled({required this.enabled});

  final bool enabled;

  @override
  List<Object?> get props => [enabled];
}

/// RM-M11-07 — several applications may be accepted; the pool is not exclusive.
class ApplicationAccepted extends PropertyAgentEvent {
  const ApplicationAccepted(this.application);

  final AgentApplication application;

  @override
  List<Object?> get props => [application];
}

class ApplicationDeclined extends PropertyAgentEvent {
  const ApplicationDeclined(this.application);

  final AgentApplication application;

  @override
  List<Object?> get props => [application];
}
