part of 'contracts_bloc.dart';

/// What the list is showing. **"À vous de jouer" is a filter on `awaiting`**,
/// not on status: RM-M08-09 says the contract knows whose move it is, and that
/// is the first question a landlord has.
class ContractFilter extends Equatable {
  const ContractFilter.all() : status = null, mineToPlay = false;
  const ContractFilter.awaitingMe() : status = null, mineToPlay = true;
  const ContractFilter.status(this.status) : mineToPlay = false;

  final ContractStatus? status;
  final bool mineToPlay;

  bool matches(Contract contract) {
    if (mineToPlay) {
      return contract.awaiting == ContractParty.prestataire ||
          contract.awaiting == ContractParty.both;
    }
    return status == null || contract.status == status;
  }

  @override
  List<Object?> get props => [status, mineToPlay];
}

sealed class ContractsState extends Equatable {
  const ContractsState();

  @override
  List<Object?> get props => [];
}

class ContractsInitial extends ContractsState {
  const ContractsInitial();
}

class ContractsLoadInProgress extends ContractsState {
  const ContractsLoadInProgress();
}

class ContractsReady extends ContractsState {
  const ContractsReady({
    this.items = const [],
    this.filter = const ContractFilter.all(),
  });

  final List<Contract> items;
  final ContractFilter filter;

  List<Contract> get visible => items.where(filter.matches).toList();

  /// The badge the list leads with: how many are waiting on him.
  int get awaitingMeCount =>
      items.where(const ContractFilter.awaitingMe().matches).length;

  ContractsReady copyWith({List<Contract>? items, ContractFilter? filter}) =>
      ContractsReady(items: items ?? this.items, filter: filter ?? this.filter);

  @override
  List<Object?> get props => [items, filter];
}

class ContractsFailure extends ContractsState {
  const ContractsFailure();
}
