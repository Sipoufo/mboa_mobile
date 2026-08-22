part of 'contract_detail_bloc.dart';

sealed class ContractDetailState extends Equatable {
  const ContractDetailState();

  @override
  List<Object?> get props => [];
}

class ContractDetailInitial extends ContractDetailState {
  const ContractDetailInitial();
}

class ContractDetailLoadInProgress extends ContractDetailState {
  const ContractDetailLoadInProgress();
}

class ContractDetailReady extends ContractDetailState {
  const ContractDetailReady(
    this.contract, {
    this.isBusy = false,
    this.justActed = false,
    this.lastActionFailed = false,
    this.pdfUrl,
  });

  final Contract contract;
  final bool isBusy;

  /// An action went through — the screen confirms and the list reloads behind.
  final bool justActed;

  final bool lastActionFailed;

  /// CA-M08-01 — short-lived, so it is carried once and not stored.
  final String? pdfUrl;

  ContractDetailReady copyWith({
    Contract? contract,
    bool? isBusy,
    bool justActed = false,
    bool lastActionFailed = false,
    String? pdfUrl,
  }) =>
      ContractDetailReady(
        contract ?? this.contract,
        isBusy: isBusy ?? this.isBusy,
        justActed: justActed,
        lastActionFailed: lastActionFailed,
        pdfUrl: pdfUrl,
      );

  @override
  List<Object?> get props =>
      [contract, isBusy, justActed, lastActionFailed, pdfUrl];
}

/// Gone: the screen pops, and the list re-reads.
class ContractWasCancelled extends ContractDetailState {
  const ContractWasCancelled();
}

class ContractDetailFailure extends ContractDetailState {
  const ContractDetailFailure();
}
