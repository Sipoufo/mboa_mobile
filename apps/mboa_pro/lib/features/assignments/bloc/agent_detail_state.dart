part of 'agent_detail_bloc.dart';

sealed class AgentDetailState extends Equatable {
  const AgentDetailState();

  @override
  List<Object?> get props => [];
}

class AgentDetailInitial extends AgentDetailState {
  const AgentDetailInitial();
}

class AgentDetailLoadInProgress extends AgentDetailState {
  const AgentDetailLoadInProgress();
}

class AgentDetailReady extends AgentDetailState {
  const AgentDetailReady(this.profile);

  final AgentPublicProfileView profile;

  @override
  List<Object?> get props => [profile];
}

class AgentDetailFailure extends AgentDetailState {
  const AgentDetailFailure();
}
