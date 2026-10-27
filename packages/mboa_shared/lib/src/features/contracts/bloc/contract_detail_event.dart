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

/// RM-M08-02 — the tenant takes the terms as they stand, which opens signing
/// for both parties. The landlord never sends this: the server refuses it.
class ContractAccepted extends ContractDetailEvent {
  const ContractAccepted();
}

/// CE-M08-03 / RM-M08-07 — the tenant contests, naming the terms and saying
/// why. An empty comment is not an objection, so the bloc drops it rather than
/// letting the server answer 400.
class ContractChangesRequested extends ContractDetailEvent {
  const ContractChangesRequested({required this.comment, this.terms = const []});

  final String comment;
  final List<ContestedTerm> terms;

  @override
  List<Object?> get props => [comment, terms];
}

/// Either party, up to the second signature.
class ContractCancelled extends ContractDetailEvent {
  const ContractCancelled();
}

/// CA-M08-01 — fetched and offered as `[name].pdf`.
class ContractPdfRequested extends ContractDetailEvent {
  const ContractPdfRequested({this.name = 'Contrat Mboa'});

  /// The file name the user sees.
  final String name;

  @override
  List<Object?> get props => [name];
}

/// RM-M08-11 — ask to end a signed contract: proposed to the other party
/// ([mutual]) or notified alone, binding at once.
class ContractTerminationRequested extends ContractDetailEvent {
  const ContractTerminationRequested({required this.lastDay, required this.reason, required this.mutual});

  final DateTime lastDay;
  final String reason;
  final bool mutual;

  @override
  List<Object?> get props => [lastDay, reason, mutual];
}

/// The other party's answer to a proposed termination.
class ContractTerminationAnswered extends ContractDetailEvent {
  const ContractTerminationAnswered({required this.confirm});

  final bool confirm;

  @override
  List<Object?> get props => [confirm];
}

/// Its author takes back a proposal not yet answered.
class ContractTerminationWithdrawn extends ContractDetailEvent {
  const ContractTerminationWithdrawn();
}

/// §37 A — the landlord's stars for the tenant, and an optional word for Mboa.
class ContractTenantRated extends ContractDetailEvent {
  const ContractTenantRated({required this.stars, this.comment});

  final int stars;
  final String? comment;

  @override
  List<Object?> get props => [stars, comment];
}
