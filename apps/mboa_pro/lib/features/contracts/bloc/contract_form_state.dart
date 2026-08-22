part of 'contract_form_bloc.dart';

/// Why a submission did not go through — the two cases need different words.
enum ContractFormFailure {
  /// CE-M08-01 — the tenant has no Mboa account; an invitation went out and the
  /// contract was deliberately not created.
  tenantHasNoAccount,

  refused,
}

class ContractFormState extends Equatable {
  const ContractFormState({
    this.terms = const ContractTerms(),
    this.amendingId,
    this.isSaving = false,
    this.saved,
    this.failure,
  });

  final ContractTerms terms;

  /// Null when drawing up a new contract.
  final String? amendingId;

  final bool isSaving;

  /// The contract as the server created or amended it.
  final Contract? saved;

  final ContractFormFailure? failure;

  bool get isAmending => amendingId != null;

  bool get canSubmit => !isSaving && (isAmending || terms.isComplete);

  ContractFormState copyWith({
    ContractTerms? terms,
    bool? isSaving,
    Contract? saved,
    ContractFormFailure? failure,
    bool clearOutcome = false,
  }) =>
      ContractFormState(
        terms: terms ?? this.terms,
        amendingId: amendingId,
        isSaving: isSaving ?? this.isSaving,
        saved: clearOutcome ? null : (saved ?? this.saved),
        failure: clearOutcome ? null : (failure ?? this.failure),
      );

  @override
  List<Object?> get props => [terms, amendingId, isSaving, saved, failure];
}
