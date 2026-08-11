part of 'agent_detail_bloc.dart';

sealed class AgentDetailEvent extends Equatable {
  const AgentDetailEvent();

  @override
  List<Object?> get props => [];
}

class AgentDetailRequested extends AgentDetailEvent {
  const AgentDetailRequested(this.accountId);

  final String accountId;

  @override
  List<Object?> get props => [accountId];
}
