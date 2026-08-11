part of 'my_agents_bloc.dart';

sealed class MyAgentsEvent extends Equatable {
  const MyAgentsEvent();

  @override
  List<Object?> get props => [];
}

class MyAgentsLoadRequested extends MyAgentsEvent {
  const MyAgentsLoadRequested();
}

class MyAgentsRefreshRequested extends MyAgentsEvent {
  const MyAgentsRefreshRequested();
}
