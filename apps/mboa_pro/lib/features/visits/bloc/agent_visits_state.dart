part of 'agent_visits_bloc.dart';

/// Today first: an agent opens this to find out where they are going now.
enum VisitFilter { today, upcoming, past }

sealed class AgentVisitsState extends Equatable {
  const AgentVisitsState();

  @override
  List<Object?> get props => [];
}

class VisitsInitial extends AgentVisitsState {
  const VisitsInitial();
}

class VisitsLoadInProgress extends AgentVisitsState {
  const VisitsLoadInProgress();
}

class VisitsReady extends AgentVisitsState {
  const VisitsReady({
    this.visits = const [],
    this.filter = VisitFilter.today,
    this.mutatingId,
    this.lastActionFailed = false,
  });

  final List<AgentVisit> visits;
  final VisitFilter filter;
  final String? mutatingId;
  final bool lastActionFailed;

  /// Scheduled for today, whatever the hour — a visit at 08:00 is still today's
  /// work at 09:00, so this is a date comparison and not "still in the future".
  List<AgentVisit> get today =>
      (visits.where((v) => v.isToday()).toList())..sort(_byTime);

  /// Later than today, still to happen.
  List<AgentVisit> get upcoming => (visits
      .where((v) =>
          v.status == VisitStatus.scheduled && !v.isToday() && v.isUpcoming)
      .toList())
    ..sort(_byTime);

  /// Done, cancelled, or a scheduled visit whose slot has passed — the last of
  /// those is the one an agent needs to see, since it is the visit they may
  /// have missed.
  List<AgentVisit> get past => (visits
      .where((v) =>
          v.status == VisitStatus.completed ||
          v.status == VisitStatus.cancelled ||
          (v.status == VisitStatus.scheduled && !v.isToday() && !v.isUpcoming))
      .toList())
    ..sort((a, b) => _byTime(b, a));

  List<AgentVisit> get visible => switch (filter) {
        VisitFilter.today => today,
        VisitFilter.upcoming => upcoming,
        VisitFilter.past => past,
      };

  /// Badge on the Visites tab — what the agent has left to do today.
  int get todayCount => today.length;

  static int _byTime(AgentVisit a, AgentVisit b) {
    final left = a.scheduledAt;
    final right = b.scheduledAt;
    if (left == null || right == null) return 0;
    return left.compareTo(right);
  }

  VisitsReady copyWith({
    List<AgentVisit>? visits,
    VisitFilter? filter,
    String? mutatingId,
    bool clearMutating = false,
    bool lastActionFailed = false,
  }) =>
      VisitsReady(
        visits: visits ?? this.visits,
        filter: filter ?? this.filter,
        mutatingId: clearMutating ? null : (mutatingId ?? this.mutatingId),
        lastActionFailed: lastActionFailed,
      );

  @override
  List<Object?> get props => [visits, filter, mutatingId, lastActionFailed];
}

class VisitsFailure extends AgentVisitsState {
  const VisitsFailure();
}
