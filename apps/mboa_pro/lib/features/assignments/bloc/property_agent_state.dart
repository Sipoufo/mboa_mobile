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
    this.ownerVisitsEnabled,
    this.isSavingOwnerVisits = false,
    this.mutatingId,
    this.lastActionFailed = false,
    this.lastOutcome,
  });

  final AssignmentTarget target;
  final List<Assignment> assignments;
  final List<AgentApplication> applications;
  final List<AgentCandidateView> candidates;

  /// RM-M11-10 — whether the prestataire shows this property himself.
  ///
  /// **Null means "no such flag here"**: a residence has none, and a listing
  /// whose read failed has none either. The toggle is drawn only when it is
  /// non-null, so it never claims "off" for something nobody checked.
  final bool? ownerVisitsEnabled;

  final bool isSavingOwnerVisits;

  /// The agent whose row is mid-action, so one row spins instead of the screen.
  final String? mutatingId;

  final bool lastActionFailed;

  /// What the last offer or acceptance did. Carries the residence `skipped`
  /// list so RM-M10bis-06's "these units already had an agent" is shown rather
  /// than swallowed.
  final ResidenceOfferOutcome? lastOutcome;

  /// The agents actually working this property.
  ///
  /// **A list since 2026-08-13** (RM-M11-01): a property carries a pool, and
  /// the client picks their visitor from it at booking time. The single-agent
  /// exclusivity this screen used to enforce was repealed.
  List<Assignment> get liveAgents =>
      assignments.where((a) => a.status.isLive).toList();

  /// Offers the prestataire made that the agent has not answered yet.
  List<Assignment> get awaitingAgents => assignments
      .where((a) =>
          a.status == AssignmentStatus.pending &&
          a.initiatedBy == AssignmentInitiator.prestataire)
      .toList();

  /// Everyone attached to the property — working or still to answer. This is
  /// the list the prestataire manages; applications are separate, because they
  /// are somebody else's proposal and not yet part of the pool.
  ///
  /// **One row per person, not per unit.** A residence answers with an
  /// assignment per unit (`GET /residences/{id}/agent` — "which room has
  /// whom"), so the same agent comes back twenty times for a twenty-unit
  /// residence. [unitsCoveredBy] carries that count instead.
  List<Assignment> get pool {
    final seen = <String>{};
    return [
      for (final assignment in [...liveAgents, ...awaitingAgents])
        if (seen.add(assignment.agentAccountId ?? assignment.id)) assignment,
    ];
  }

  /// How many units of this property one agent covers.
  ///
  /// Reads the residence summary's own `unitCount` when the server supplied it,
  /// and otherwise counts the per-unit rows — a listing simply gives 1.
  int unitsCoveredBy(Assignment assignment) =>
      assignment.unitCount ??
      [...liveAgents, ...awaitingAgents]
          .where((a) => a.agentAccountId == assignment.agentAccountId)
          .length;

  /// Candidates who are not already in the pool.
  ///
  /// Offering the same agent twice is a 409, and a picker that lists people it
  /// cannot offer is a picker that lies.
  List<AgentCandidateView> get offerableCandidates {
    final taken = pool.map((a) => a.agentAccountId).nonNulls.toSet();
    return candidates.where((c) => !taken.contains(c.accountId)).toList();
  }

  /// RM-M11-06 — removing **one** agent among several has no endpoint:
  /// `DELETE /annonces/{id}/agent` names no agent (docs/backend-requests.md
  /// §12). Rather than guess which one the server would drop, the action is
  /// offered only while it is unambiguous.
  bool get canWithdraw => pool.length <= 1;

  PropertyAgentReady copyWith({
    List<Assignment>? assignments,
    List<AgentApplication>? applications,
    List<AgentCandidateView>? candidates,
    bool? ownerVisitsEnabled,
    bool? isSavingOwnerVisits,
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
        ownerVisitsEnabled: ownerVisitsEnabled ?? this.ownerVisitsEnabled,
        isSavingOwnerVisits:
            isSavingOwnerVisits ?? this.isSavingOwnerVisits,
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
        ownerVisitsEnabled,
        isSavingOwnerVisits,
        mutatingId,
        lastActionFailed,
        lastOutcome,
      ];
}

class PropertyAgentFailure extends PropertyAgentState {
  const PropertyAgentFailure();
}
