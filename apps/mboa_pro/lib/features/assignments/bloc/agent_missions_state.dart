part of 'agent_missions_bloc.dart';

/// The three things an agent looks at, in the order they matter: work waiting
/// on *them*, work they hold, and work they could ask for.
enum MissionFilter { offers, mine, opportunities }

sealed class AgentMissionsState extends Equatable {
  const AgentMissionsState();

  @override
  List<Object?> get props => [];
}

class MissionsInitial extends AgentMissionsState {
  const MissionsInitial();
}

class MissionsLoadInProgress extends AgentMissionsState {
  const MissionsLoadInProgress();
}

class MissionsReady extends AgentMissionsState {
  const MissionsReady({
    this.assignments = const [],
    this.opportunities = const [],
    this.applications = const [],
    this.filter = MissionFilter.offers,
    this.mutatingId,
    this.lastActionFailed = false,
  });

  final List<Assignment> assignments;
  final List<Opportunity> opportunities;

  /// Applications this agent made and the prestataire has not answered.
  final List<Assignment> applications;

  final MissionFilter filter;
  final String? mutatingId;
  final bool lastActionFailed;

  /// Offers the prestataire made that this agent has not answered.
  ///
  /// Only `pending` — an `applied` row is the agent's own application waiting on
  /// the prestataire, which belongs under [pendingApplications], not here.
  List<Assignment> get offers => assignments
      .where((a) => a.status == AssignmentStatus.pending)
      .toList();

  /// Work the agent actually holds.
  ///
  /// RM-M11-09 — filtered on **status, not origin**: an offer they accepted and
  /// an application that was accepted are both simply their missions.
  List<Assignment> get mine =>
      assignments.where((a) => a.status.isLive).toList();

  List<Assignment> get pendingApplications =>
      applications.where((a) => a.status.isPending).toList();

  /// Badge on the offers segment — the only count worth interrupting for.
  int get offerCount => offers.length;

  MissionsReady copyWith({
    List<Assignment>? assignments,
    List<Opportunity>? opportunities,
    List<Assignment>? applications,
    MissionFilter? filter,
    String? mutatingId,
    bool clearMutating = false,
    bool lastActionFailed = false,
  }) =>
      MissionsReady(
        assignments: assignments ?? this.assignments,
        opportunities: opportunities ?? this.opportunities,
        applications: applications ?? this.applications,
        filter: filter ?? this.filter,
        mutatingId: clearMutating ? null : (mutatingId ?? this.mutatingId),
        lastActionFailed: lastActionFailed,
      );

  @override
  List<Object?> get props => [
        assignments,
        opportunities,
        applications,
        filter,
        mutatingId,
        lastActionFailed,
      ];
}

class MissionsFailure extends AgentMissionsState {
  const MissionsFailure();
}
