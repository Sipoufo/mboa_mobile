part of 'contract_detail_bloc.dart';

sealed class ContractDetailEvent extends Equatable {
  const ContractDetailEvent();

  @override
  List<Object?> get props => [];
}

class ContractRequested extends ContractDetailEvent {
  const ContractRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

/// N-07 — the draft goes to the tenant.
class ContractSent extends ContractDetailEvent {
  const ContractSent();
}

/// RM-M08-03.
class ContractSigned extends ContractDetailEvent {
  const ContractSigned();
}

/// CE-M08-03 — answering one objection.
class ContractChangeAnswered extends ContractDetailEvent {
  const ContractChangeAnswered({required this.changeId, required this.body});

  final String changeId;
  final String body;

  @override
  List<Object?> get props => [changeId, body];
}

/// RM-M08-08 — new terms, while nobody has accepted them.
class ContractAmended extends ContractDetailEvent {
  const ContractAmended(this.terms);

  final ContractTerms terms;

  @override
  List<Object?> get props => [terms];
}

/// Either party, up to the second signature.
class ContractCancelled extends ContractDetailEvent {
  const ContractCancelled();
}

/// CA-M08-01.
class ContractPdfRequested extends ContractDetailEvent {
  const ContractPdfRequested();
}
