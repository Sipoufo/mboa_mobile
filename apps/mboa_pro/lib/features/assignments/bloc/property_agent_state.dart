part of 'property_agent_bloc.dart';

sealed class PropertyAgentState extends Equatable {
  const PropertyAgentState();

  @override
  List<Object?> get props => [];
}

class PropertyAgentInitial extends PropertyAgentState {
  const PropertyAgentInitial();
}

class PropertyAgentLoadInProgress extends PropertyAgentState {
  const PropertyAgentLoadInProgress();
}

class PropertyAgentReady extends PropertyAgentState {
  const PropertyAgentReady({
    required this.target,
    this.assignments = const [],
    this.applications = const [],
    this.candidates = const [],
    this.mutatingId,
    this.lastActionFailed = false,
    this.lastOutcome,
  });

  final AssignmentTarget target;
  final List<Assignment> assignments;
  final List<AgentApplication> applications;
  final List<AgentCandidateView> candidates;

  /// The agent whose row is mid-action, so one row spins instead of the screen.
  final String? mutatingId;

  final bool lastActionFailed;

  /// What the last offer or acceptance did. Carries the residence `skipped`
  /// list so RM-M10bis-06's "these units already had an agent" is shown rather
  /// than swallowed.
  final ResidenceOfferOutcome? lastOutcome;

  /// The agent actually working this property, if any.
  Assignment? get live =>
      assignments.where((a) => a.status.isLive).firstOrNull;

  /// An offer the prestataire made that the agent has not answered yet.
  Assignment? get awaitingAgent => assignments
      .where((a) =>
          a.status == AssignmentStatus.pending &&
          a.initiatedBy == AssignmentInitiator.prestataire)
      .firstOrNull;

  /// RM-M11-01 — one active agent per property, so nothing may be offered while
  /// somebody holds it or is being waited on.
  bool get canOffer => live == null && awaitingAgent == null;

  PropertyAgentReady copyWith({
    List<Assignment>? assignments,
    List<AgentApplication>? applications,
    List<AgentCandidateView>? candidates,
    String? mutatingId,
    bool clearMutating = false,
    bool lastActionFailed = false,
    ResidenceOfferOutcome? lastOutcome,
  }) =>
      PropertyAgentReady(
        target: target,
        assignments: assignments ?? this.assignments,
        applications: applications ?? this.applications,
        candidates: candidates ?? this.candidates,
        mutatingId: clearMutating ? null : (mutatingId ?? this.mutatingId),
        lastActionFailed: lastActionFailed,
        lastOutcome: lastOutcome,
      );

  @override
  List<Object?> get props => [
        target,
        assignments,
        applications,
        candidates,
        mutatingId,
        lastActionFailed,
        lastOutcome,
      ];
}

class PropertyAgentFailure extends PropertyAgentState {
  const PropertyAgentFailure();
}
