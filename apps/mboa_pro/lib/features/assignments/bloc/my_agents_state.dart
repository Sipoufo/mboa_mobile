part of 'my_agents_bloc.dart';

/// One agent and everything they hold for this prestataire.
class AgentRow extends Equatable {
  const AgentRow({
    required this.agentAccountId,
    required this.assignments,
    this.agentName,
  });

  final String agentAccountId;
  final String? agentName;
  final List<Assignment> assignments;

  /// Live assignments only — an offer still awaiting an answer is not yet a
  /// property this agent works.
  List<Assignment> get live =>
      assignments.where((a) => a.status.isLive).toList();

  bool get isAwaitingResponse => assignments.any((a) => a.status.isPending);

  /// The single property when there is one, so the row can name it instead of
  /// counting to one.
  String? get soleProperty =>
      live.length == 1 ? live.single.propertyTitle : null;

  int get propertyCount => live.length;

  @override
  List<Object?> get props => [agentAccountId, agentName, assignments];
}

sealed class MyAgentsState extends Equatable {
  const MyAgentsState();

  @override
  List<Object?> get props => [];
}

class MyAgentsInitial extends MyAgentsState {
  const MyAgentsInitial();
}

class MyAgentsLoadInProgress extends MyAgentsState {
  const MyAgentsLoadInProgress();
}

class MyAgentsReady extends MyAgentsState {
  const MyAgentsReady({this.rows = const []});

  final List<AgentRow> rows;

  @override
  List<Object?> get props => [rows];
}

class MyAgentsFailure extends MyAgentsState {
  const MyAgentsFailure();
}
