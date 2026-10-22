import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One invoice (CDC M24, slice E) — what N-36 opens for an invoice: its
/// status, what was declared on it, and what is left to declare.
class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc({required HomesRepository repository})
      : _repository = repository,
        super(const InvoiceLoading()) {
    on<InvoiceRequested>(_onRequested);
  }

  final HomesRepository _repository;

  Future<void> _onRequested(InvoiceRequested event, Emitter<InvoiceState> emit) async {
    if (state is! InvoiceReady) emit(const InvoiceLoading());
    final Cached<HomeInvoice> invoice;
    try {
      invoice = await _repository.invoice(event.id);
    } catch (_) {
      if (state is! InvoiceReady) emit(InvoiceFailure(event.id));
      return;
    }
    // Offline, the invoice from the list's copy and no declarations: said
    // as offline, and nothing declared from it.
    var declarations = const <Declaration>[];
    var offline = invoice.fromCache;
    if (!offline) {
      try {
        declarations = await _repository.invoiceDeclarations(event.id);
      } catch (_) {
        offline = true;
      }
    }
    emit(InvoiceReady(invoice.value, declarations: declarations, isOffline: offline));
  }
}

sealed class InvoiceEvent extends Equatable {
  const InvoiceEvent();

  @override
  List<Object?> get props => [];
}

final class InvoiceRequested extends InvoiceEvent {
  const InvoiceRequested(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

sealed class InvoiceState extends Equatable {
  const InvoiceState();

  @override
  List<Object?> get props => [];
}

final class InvoiceLoading extends InvoiceState {
  const InvoiceLoading();
}

final class InvoiceFailure extends InvoiceState {
  const InvoiceFailure(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class InvoiceReady extends InvoiceState {
  const InvoiceReady(this.invoice, {this.declarations = const [], this.isOffline = false});

  final HomeInvoice invoice;

  /// Newest first.
  final List<Declaration> declarations;
  final bool isOffline;

  /// What the landlord already confirmed on it. A suggestion for the form
  /// only — the server alone says when the invoice is paid (§31.2 asks for
  /// this figure on the invoice itself).
  int get confirmedTotal => declarations
      .where((d) => d.status == DeclarationStatus.confirmed)
      .fold(0, (sum, d) => sum + d.amount);

  int get left => (invoice.amount - confirmedTotal).clamp(0, invoice.amount);

  /// Open, online: it can be declared paid — even once the tenancy is over.
  bool get canDeclare => invoice.status.isOpen && !isOffline;

  @override
  List<Object?> get props => [invoice, declarations, isOffline];
}
