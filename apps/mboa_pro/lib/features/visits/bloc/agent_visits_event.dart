part of 'agent_visits_bloc.dart';

sealed class AgentVisitsEvent extends Equatable {
  const AgentVisitsEvent();

  @override
  List<Object?> get props => [];
}

class VisitsLoadRequested extends AgentVisitsEvent {
  const VisitsLoadRequested();
}

class VisitsRefreshRequested extends AgentVisitsEvent {
  const VisitsRefreshRequested();
}

class VisitsFilterChanged extends AgentVisitsEvent {
  const VisitsFilterChanged(this.filter);

  final VisitFilter filter;

  @override
  List<Object?> get props => [filter];
}

/// RM-M16-04 — allowed up to an hour before; the server is the judge.
class VisitCancelled extends AgentVisitsEvent {
  const VisitCancelled(this.visit);

  final AgentVisit visit;

  @override
  List<Object?> get props => [visit];
}
