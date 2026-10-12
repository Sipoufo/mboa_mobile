part of 'contracts_bloc.dart';

sealed class ContractsEvent extends Equatable {
  const ContractsEvent();

  @override
  List<Object?> get props => [];
}

class ContractsLoadRequested extends ContractsEvent {
  const ContractsLoadRequested();
}

class ContractsRefreshRequested extends ContractsEvent {
  const ContractsRefreshRequested();
}

class ContractsFilterChanged extends ContractsEvent {
  const ContractsFilterChanged(this.filter);

  final ContractFilter filter;

  @override
  List<Object?> get props => [filter];
}
