import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

part 'contract_detail_event.dart';
part 'contract_detail_state.dart';

/// One contract, and everything the prestataire may do to it (CDC M08).
///
/// Every action answers with the contract as the server now holds it, so
/// nothing is patched locally: `status`, `awaiting` and `canSign` are its
/// verdicts (RM-M08-09, RM-M08-02) and a second opinion here would be a bug
/// waiting to happen.
class ContractDetailBloc
    extends Bloc<ContractDetailEvent, ContractDetailState> {
  ContractDetailBloc({required ContractRepository repository})
      : _repository = repository,
        super(const ContractDetailInitial()) {
    on<ContractRequested>(_onRequested);
    on<ContractSent>(_onSent);
    on<ContractSigned>(_onSigned);
    on<ContractChangeAnswered>(_onChangeAnswered);
    on<ContractAmended>(_onAmended);
    on<ContractCancelled>(_onCancelled);
    on<ContractPdfRequested>(_onPdf);
  }

  final ContractRepository _repository;

  Future<void> _onRequested(
    ContractRequested event,
    Emitter<ContractDetailState> emit,
  ) async {
    emit(const ContractDetailLoadInProgress());
    try {
      emit(ContractDetailReady(await _repository.one(event.id)));
    } catch (_) {
      emit(const ContractDetailFailure());
    }
  }

  Future<void> _onSent(
    ContractSent event,
    Emitter<ContractDetailState> emit,
  ) =>
      _run(emit, (contract) => _repository.send(contract.id));

  /// RM-M08-03 — the second signature locks it for good. The confirmation is a
  /// local gesture (the request carries only a session), which is why the
  /// screen makes the reader type the word rather than tap once.
  Future<void> _onSigned(
    ContractSigned event,
    Emitter<ContractDetailState> emit,
  ) =>
      _run(emit, (contract) => _repository.sign(contract.id));

  /// CE-M08-03 — an answer per objection, whether or not the terms move.
  Future<void> _onChangeAnswered(
    ContractChangeAnswered event,
    Emitter<ContractDetailState> emit,
  ) {
    final body = event.body.trim();
    if (body.isEmpty) return Future.value();
    return _run(
      emit,
      (contract) => _repository.respondToChange(
        contract.id,
        changeId: event.changeId,
        body: body,
      ),
    );
  }

  /// RM-M08-08 — amending a contested contract counts as an answer and returns
  /// it to the tenant; no second send is required, so the screen does not offer
  /// one afterwards.
  Future<void> _onAmended(
    ContractAmended event,
    Emitter<ContractDetailState> emit,
  ) =>
      _run(emit, (contract) => _repository.amend(contract.id, event.terms));

  Future<void> _onCancelled(
    ContractCancelled event,
    Emitter<ContractDetailState> emit,
  ) async {
    final current = state;
    if (current is! ContractDetailReady) return;

    emit(current.copyWith(isBusy: true));
    try {
      await _repository.cancel(current.contract.id);
      emit(const ContractWasCancelled());
    } catch (_) {
      emit(current.copyWith(isBusy: false, lastActionFailed: true));
    }
  }

  /// CA-M08-01 — a short-lived URL, handed to the screen to open.
  Future<void> _onPdf(
    ContractPdfRequested event,
    Emitter<ContractDetailState> emit,
  ) async {
    final current = state;
    if (current is! ContractDetailReady) return;

    emit(current.copyWith(isBusy: true));
    try {
      final url = await _repository.pdfUrl(current.contract.id);
      emit(current.copyWith(isBusy: false, pdfUrl: url));
    } catch (_) {
      emit(current.copyWith(isBusy: false, lastActionFailed: true));
    }
  }

  Future<void> _run(
    Emitter<ContractDetailState> emit,
    Future<Contract> Function(Contract contract) action,
  ) async {
    final current = state;
    if (current is! ContractDetailReady) return;

    emit(current.copyWith(isBusy: true));
    try {
      emit(ContractDetailReady(await action(current.contract), justActed: true));
    } catch (_) {
      emit(current.copyWith(isBusy: false, lastActionFailed: true));
    }
  }
}
