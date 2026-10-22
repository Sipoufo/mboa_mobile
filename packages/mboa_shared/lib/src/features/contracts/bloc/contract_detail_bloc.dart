import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../media/pdf_sharer.dart';
import '../data/contract_repository.dart';
import '../models/contract.dart';

part 'contract_detail_event.dart';
part 'contract_detail_state.dart';

/// One contract, and everything either party may do to it (CDC M08).
///
/// Shared between the two apps for the same reason [ContractRepository] is:
/// the landlord and the tenant call the **same** endpoints, and the server
/// says who may do what. Every action answers with the contract as the server
/// now holds it, so nothing is patched locally: `status`, `awaiting` and
/// `canSign` are its verdicts (RM-M08-09, RM-M08-02) and a second opinion here
/// would be a bug waiting to happen.
class ContractDetailBloc
    extends Bloc<ContractDetailEvent, ContractDetailState> {
  ContractDetailBloc({required ContractRepository repository, PdfSharer? sharer})
      : _repository = repository,
        _sharer = sharer ?? PdfSharer(),
        super(const ContractDetailInitial()) {
    on<ContractRequested>(_onRequested);
    on<ContractSent>(_onSent);
    on<ContractAccepted>(_onAccepted);
    on<ContractChangesRequested>(_onChangesRequested);
    on<ContractSigned>(_onSigned);
    on<ContractChangeAnswered>(_onChangeAnswered);
    on<ContractAmended>(_onAmended);
    on<ContractCancelled>(_onCancelled);
    on<ContractPdfRequested>(_onPdf);
    on<ContractTerminationRequested>(_onTerminationRequested);
    on<ContractTerminationAnswered>(_onTerminationAnswered);
    on<ContractTerminationWithdrawn>(_onTerminationWithdrawn);
  }

  final ContractRepository _repository;
  final PdfSharer _sharer;

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

  /// RM-M08-02 — accepting opens signing for both parties. There is no
  /// `canAccept` verdict to lean on the way [Contract.canSign] exists, so the
  /// screen offers it from `status` and `awaiting`; see docs/backend-requests.md.
  Future<void> _onAccepted(
    ContractAccepted event,
    Emitter<ContractDetailState> emit,
  ) =>
      _run(emit, (contract) => _repository.accept(contract.id));

  /// CE-M08-03 — contesting sends it back to the landlord with the objection
  /// attached; the terms themselves do not move until he amends them.
  Future<void> _onChangesRequested(
    ContractChangesRequested event,
    Emitter<ContractDetailState> emit,
  ) {
    final comment = event.comment.trim();
    if (comment.isEmpty) return Future.value();
    return _run(
      emit,
      (contract) => _repository.requestChanges(
        contract.id,
        comment: comment,
        terms: event.terms,
      ),
    );
  }

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

  /// CA-M08-01 — a short-lived link, fetched and offered on the share sheet
  /// (save, print, send). It used to be copied to the clipboard: nothing in
  /// the app opened one.
  Future<void> _onPdf(
    ContractPdfRequested event,
    Emitter<ContractDetailState> emit,
  ) async {
    final current = state;
    if (current is! ContractDetailReady) return;

    emit(current.copyWith(isBusy: true));
    try {
      final url = await _repository.pdfUrl(current.contract.id);
      await _sharer.shareLink(url, name: event.name);
      emit(current.copyWith(isBusy: false));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(current.copyWith(isBusy: false, lastActionFailed: true));
    }
  }

  /// RM-M08-11 — only where the server offers it (`tenancy.canTerminate`),
  /// and never without a reason.
  Future<void> _onTerminationRequested(
    ContractTerminationRequested event,
    Emitter<ContractDetailState> emit,
  ) {
    final current = state;
    final reason = event.reason.trim();
    if (current is! ContractDetailReady || !(current.contract.tenancy?.canTerminate ?? false) || reason.isEmpty) {
      return Future.value();
    }
    return _terminating(
      emit,
      (contract) => _repository.terminate(contract.id, lastDay: event.lastDay, reason: reason, mutual: event.mutual),
    );
  }

  Future<void> _onTerminationAnswered(
    ContractTerminationAnswered event,
    Emitter<ContractDetailState> emit,
  ) {
    final current = state;
    if (current is! ContractDetailReady || !(current.contract.tenancy?.termination?.canAnswer ?? false)) {
      return Future.value();
    }
    return _terminating(
      emit,
      (contract) =>
          event.confirm ? _repository.confirmTermination(contract.id) : _repository.declineTermination(contract.id),
    );
  }

  Future<void> _onTerminationWithdrawn(
    ContractTerminationWithdrawn event,
    Emitter<ContractDetailState> emit,
  ) {
    final current = state;
    if (current is! ContractDetailReady || !(current.contract.tenancy?.termination?.canWithdraw ?? false)) {
      return Future.value();
    }
    return _terminating(emit, (contract) => _repository.withdrawTermination(contract.id));
  }

  /// [_run], with the server's refusals said in words — and the contract read
  /// again, since a refusal usually means it moved on.
  Future<void> _terminating(
    Emitter<ContractDetailState> emit,
    Future<Contract> Function(Contract contract) action,
  ) async {
    final current = state;
    if (current is! ContractDetailReady || current.isBusy) return;

    emit(current.copyWith(isBusy: true));
    try {
      emit(ContractDetailReady(await action(current.contract), justActed: true));
    } on ContractTerminationRefused catch (refused) {
      Contract fresh;
      try {
        fresh = await _repository.one(current.contract.id);
      } catch (_) {
        fresh = current.contract;
      }
      emit(ContractDetailReady(fresh, terminationRefusal: refused.reason));
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
