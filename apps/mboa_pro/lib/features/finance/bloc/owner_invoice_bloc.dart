import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/owner_invoices_repository.dart';
import '../models/finance_refusal.dart';

enum OwnerInvoiceDone { paid, cancelled, reopened }

/// One of the landlord's invoices (CDC M24): marked paid when the tenant
/// paid him outside Mboa (RM-M24-05), cancelled — never deleted —, or
/// reopened when that « paid » was a mistake.
class OwnerInvoiceBloc extends Bloc<OwnerInvoiceEvent, OwnerInvoiceState> {
  OwnerInvoiceBloc({required OwnerInvoicesRepository repository})
      : _repository = repository,
        super(const OwnerInvoiceLoading()) {
    on<OwnerInvoiceOpened>(_onOpened);
    on<OwnerInvoiceMarkedPaid>((event, emit) => _act(emit, OwnerInvoiceDone.paid, (id) => _repository.markPaid(id, paidOn: event.paidOn)));
    on<OwnerInvoiceCancelled>((event, emit) => _act(emit, OwnerInvoiceDone.cancelled, _repository.cancel));
    on<OwnerInvoiceReopened>((event, emit) => _act(emit, OwnerInvoiceDone.reopened, _repository.reopen));
  }

  final OwnerInvoicesRepository _repository;

  Future<void> _onOpened(OwnerInvoiceOpened event, Emitter<OwnerInvoiceState> emit) async {
    if (state is! OwnerInvoiceReady) emit(const OwnerInvoiceLoading());
    try {
      final read = await _repository.invoice(event.id);
      emit(OwnerInvoiceReady(read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! OwnerInvoiceReady) emit(OwnerInvoiceFailure(event.id));
    }
  }

  Future<void> _act(
    Emitter<OwnerInvoiceState> emit,
    OwnerInvoiceDone done,
    Future<HomeInvoice> Function(String id) call,
  ) async {
    final current = state;
    if (current is! OwnerInvoiceReady || current.isBusy) return;
    emit(current.copyWith(isBusy: true));
    try {
      emit(OwnerInvoiceReady(await call(current.invoice.id), done: done));
    } on FinanceRefused catch (refused) {
      emit(current.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(current.copyWith(failed: true));
    }
  }
}

sealed class OwnerInvoiceEvent extends Equatable {
  const OwnerInvoiceEvent();

  @override
  List<Object?> get props => [];
}

final class OwnerInvoiceOpened extends OwnerInvoiceEvent {
  const OwnerInvoiceOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class OwnerInvoiceMarkedPaid extends OwnerInvoiceEvent {
  const OwnerInvoiceMarkedPaid(this.paidOn);

  final DateTime paidOn;

  @override
  List<Object?> get props => [paidOn];
}

final class OwnerInvoiceCancelled extends OwnerInvoiceEvent {
  const OwnerInvoiceCancelled();
}

final class OwnerInvoiceReopened extends OwnerInvoiceEvent {
  const OwnerInvoiceReopened();
}

sealed class OwnerInvoiceState extends Equatable {
  const OwnerInvoiceState();

  @override
  List<Object?> get props => [];
}

final class OwnerInvoiceLoading extends OwnerInvoiceState {
  const OwnerInvoiceLoading();
}

final class OwnerInvoiceFailure extends OwnerInvoiceState {
  const OwnerInvoiceFailure(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class OwnerInvoiceReady extends OwnerInvoiceState {
  const OwnerInvoiceReady(
    this.invoice, {
    this.isOffline = false,
    this.isBusy = false,
    this.done,
    this.refusal,
    this.failed = false,
  });

  final HomeInvoice invoice;
  final bool isOffline;
  final bool isBusy;

  /// Once: what was just done — said, and the list read again.
  final OwnerInvoiceDone? done;
  final FinanceRefusal? refusal;
  final bool failed;

  /// Open: it can be marked paid, corrected, cancelled.
  bool get isOpen => invoice.status.isOpen && !isOffline;

  /// Paid by the landlord's own word — the one payment he may withdraw.
  bool get canReopen => invoice.status == InvoiceStatus.paid && invoice.paidManually && !isOffline;

  /// Outcomes are not carried over.
  OwnerInvoiceReady copyWith({bool isBusy = false, FinanceRefusal? refusal, bool failed = false}) =>
      OwnerInvoiceReady(invoice, isOffline: isOffline, isBusy: isBusy, refusal: refusal, failed: failed);

  @override
  List<Object?> get props => [invoice, isOffline, isBusy, done, refusal, failed];
}
