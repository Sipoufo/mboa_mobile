part of 'contract_form_bloc.dart';

sealed class ContractFormEvent extends Equatable {
  const ContractFormEvent();

  @override
  List<Object?> get props => [];
}

/// Opens the form: on a listing's terms for a new contract, or on an existing
/// contract's for an amendment (RM-M08-08).
class ContractFormStarted extends ContractFormEvent {
  const ContractFormStarted(this.terms, {this.amendingId});

  final ContractTerms terms;
  final String? amendingId;

  @override
  List<Object?> get props => [terms, amendingId];
}

class ContractFormChanged extends ContractFormEvent {
  const ContractFormChanged(this.terms);

  final ContractTerms terms;

  @override
  List<Object?> get props => [terms];
}

class ContractFormSubmitted extends ContractFormEvent {
  const ContractFormSubmitted();
}
