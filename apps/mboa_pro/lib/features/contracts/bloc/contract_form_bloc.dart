import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

part 'contract_form_event.dart';
part 'contract_form_state.dart';

/// Drawing up a Contrat Mboa, or amending one (CDC M08).
///
/// RM-M08-01 — only a prestataire may initiate, and always **from one of his
/// listings**: the contract copies the property it carries (RM-M08-05), so the
/// listing is where it starts rather than a field to fill.
class ContractFormBloc extends Bloc<ContractFormEvent, ContractFormState> {
  ContractFormBloc({required ContractRepository repository})
      : _repository = repository,
        super(const ContractFormState()) {
    on<ContractFormStarted>(_onStarted);
    on<ContractFormChanged>(_onChanged);
    on<ContractFormSubmitted>(_onSubmitted);
  }

  final ContractRepository _repository;

  void _onStarted(ContractFormStarted event, Emitter<ContractFormState> emit) {
    emit(
      ContractFormState(
        terms: event.terms,
        amendingId: event.amendingId,
      ),
    );
  }

  void _onChanged(ContractFormChanged event, Emitter<ContractFormState> emit) {
    emit(state.copyWith(terms: event.terms));
  }

  Future<void> _onSubmitted(
    ContractFormSubmitted event,
    Emitter<ContractFormState> emit,
  ) async {
    if (!state.terms.isComplete && state.amendingId == null) return;

    emit(state.copyWith(isSaving: true, clearOutcome: true));
    try {
      final contract = state.amendingId == null
          ? await _repository.create(state.terms)
          : await _repository.amend(state.amendingId!, state.terms);
      emit(state.copyWith(isSaving: false, saved: contract));
    } catch (error) {
      // CE-M08-01 — a tenant with no Mboa account is not an error the
      // prestataire caused: the server sends them an SMS invitation and
      // declines to create the contract, which the screen has to say. The code
      // is not documented yet (backend-requests §15), so the 404 stands in.
      final api = ApiError.from(error);
      emit(
        state.copyWith(
          isSaving: false,
          failure: api.statusCode == 404
              ? ContractFormFailure.tenantHasNoAccount
              : ContractFormFailure.refused,
        ),
      );
    }
  }
}
