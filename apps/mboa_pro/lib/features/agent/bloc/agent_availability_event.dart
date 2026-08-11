part of 'agent_availability_bloc.dart';

sealed class AgentAvailabilityEvent extends Equatable {
  const AgentAvailabilityEvent();

  @override
  List<Object?> get props => [];
}

class AvailabilityLoadRequested extends AgentAvailabilityEvent {
  const AvailabilityLoadRequested();
}

class AvailabilityRuleAdded extends AgentAvailabilityEvent {
  const AvailabilityRuleAdded(this.rule);

  final AvailabilityRule rule;

  @override
  List<Object?> get props => [rule];
}

class AvailabilityRuleRemoved extends AgentAvailabilityEvent {
  const AvailabilityRuleRemoved(this.rule);

  final AvailabilityRule rule;

  @override
  List<Object?> get props => [rule];
}

class AvailabilityRuleChanged extends AgentAvailabilityEvent {
  const AvailabilityRuleChanged({required this.before, required this.after});

  final AvailabilityRule before;
  final AvailabilityRule after;

  @override
  List<Object?> get props => [before, after];
}

class VisitDurationChanged extends AgentAvailabilityEvent {
  const VisitDurationChanged(this.minutes);

  final int minutes;

  @override
  List<Object?> get props => [minutes];
}

class AvailabilitySaveRequested extends AgentAvailabilityEvent {
  const AvailabilitySaveRequested();
}

/// RM-M15-03 — immediate, because it cancels visits already booked that day.
class DayOffBlocked extends AgentAvailabilityEvent {
  const DayOffBlocked(this.day);

  final DateTime day;

  @override
  List<Object?> get props => [day];
}

class DayOffUnblocked extends AgentAvailabilityEvent {
  const DayOffUnblocked(this.day);

  final DateTime day;

  @override
  List<Object?> get props => [day];
}
