import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/owner_invoices_repository.dart';
import '../models/finance_refusal.dart';

/// Billing a tenant (CDC M24), or correcting a bill not paid yet. Only the
/// tenant of a running Mboa contract can be billed (RM-M24-02): the form
/// offers those tenancies and no others.
class InvoiceFormBloc extends Bloc<InvoiceFormEvent, InvoiceFormState> {
  InvoiceFormBloc({required OwnerInvoicesRepository invoices, required HomesRepository homes})
      : _invoices = invoices,
        _homes = homes,
        super(const InvoiceFormState()) {
    on<InvoiceFormStarted>(_onStarted);
    on<InvoiceFormChanged>((event, emit) {
      if (state.isSubmitting) return;
      emit(state.copyWith(
        contractId: event.contractId,
        kind: event.kind,
        label: event.label,
        amount: event.amount,
        dueDate: event.dueDate,
      ));
    });
    on<InvoiceFormSubmitted>(_onSubmitted);
  }

  final OwnerInvoicesRepository _invoices;
  final HomesRepository _homes;

  Future<void> _onStarted(InvoiceFormStarted event, Emitter<InvoiceFormState> emit) async {
    final editing = event.editing;
    if (editing != null) {
      // The tenancy and the kind stay what they were: only the words, the
      // amount and the date are corrected.
      emit(InvoiceFormState(
        editing: editing,
        contractId: editing.contractId,
        kind: editing.kind,
        label: editing.label,
        amount: editing.amount,
        dueDate: editing.dueDate,
      ));
      return;
    }
    emit(const InvoiceFormState(isLoadingTenancies: true));
    try {
      final read = await _homes.tenantHomes();
      final running = [for (final home in read.value) if (home.state == HomeStage.active) home];
      emit(state.copyWith(
        tenancies: running,
        // One tenancy: nothing to choose.
        contractId: running.length == 1 ? running.single.contractId : null,
      ));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }

  Future<void> _onSubmitted(InvoiceFormSubmitted event, Emitter<InvoiceFormState> emit) async {
    if (!state.canSubmit) return;
    emit(state.copyWith(isSubmitting: true));
    try {
      final editing = state.editing;
      final saved = editing == null
          ? await _invoices.create(InvoiceDraft(
              contractId: state.contractId!,
              kind: state.kind,
              label: state.label,
              amount: state.amount!,
              dueDate: state.dueDate!,
            ))
          : await _invoices.update(editing.id, label: state.label, amount: state.amount, dueDate: state.dueDate);
      emit(state.copyWith(saved: saved));
    } on FinanceRefused catch (refused) {
      emit(state.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(state.copyWith(failed: true));
    }
  }
}

sealed class InvoiceFormEvent extends Equatable {
  const InvoiceFormEvent();

  @override
  List<Object?> get props => [];
}

/// [editing]: correcting that invoice; null, a new one.
final class InvoiceFormStarted extends InvoiceFormEvent {
  const InvoiceFormStarted({this.editing});

  final HomeInvoice? editing;

  @override
  List<Object?> get props => [editing];
}

/// What changed — the rest stays.
final class InvoiceFormChanged extends InvoiceFormEvent {
  const InvoiceFormChanged({this.contractId, this.kind, this.label, this.amount, this.dueDate});

  final String? contractId;
  final InvoiceKind? kind;
  final String? label;
  final int? amount;
  final DateTime? dueDate;

  @override
  List<Object?> get props => [contractId, kind, label, amount, dueDate];
}

final class InvoiceFormSubmitted extends InvoiceFormEvent {
  const InvoiceFormSubmitted();
}

class InvoiceFormState extends Equatable {
  const InvoiceFormState({
    this.editing,
    this.tenancies = const [],
    this.isLoadingTenancies = false,
    this.contractId,
    this.kind = InvoiceKind.water,
    this.label,
    this.amount,
    this.dueDate,
    this.isSubmitting = false,
    this.saved,
    this.refusal,
    this.failed = false,
  });

  final HomeInvoice? editing;

  /// The running tenancies — the only ones that can be billed.
  final List<Home> tenancies;
  final bool isLoadingTenancies;
  final String? contractId;
  final InvoiceKind kind;
  final String? label;
  final int? amount;
  final DateTime? dueDate;
  final bool isSubmitting;

  /// Once: the invoice as the server recorded it — the screen closes on it.
  final HomeInvoice? saved;
  final FinanceRefusal? refusal;
  final bool failed;

  bool get isEditing => editing != null;

  /// An « Autre » charge says what it is.
  bool get needsLabel => kind == InvoiceKind.other && (label?.trim().isEmpty ?? true);

  bool get canSubmit =>
      contractId != null && (amount ?? 0) > 0 && dueDate != null && !needsLabel && !isSubmitting;

  /// Outcomes are not carried over.
  InvoiceFormState copyWith({
    List<Home>? tenancies,
    String? contractId,
    InvoiceKind? kind,
    String? label,
    int? amount,
    DateTime? dueDate,
    bool isSubmitting = false,
    HomeInvoice? saved,
    FinanceRefusal? refusal,
    bool failed = false,
  }) =>
      InvoiceFormState(
        editing: editing,
        tenancies: tenancies ?? this.tenancies,
        contractId: contractId ?? this.contractId,
        kind: kind ?? this.kind,
        label: label ?? this.label,
        amount: amount ?? this.amount,
        dueDate: dueDate ?? this.dueDate,
        isSubmitting: isSubmitting,
        saved: saved,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props => [
        editing,
        tenancies,
        isLoadingTenancies,
        contractId,
        kind,
        label,
        amount,
        dueDate,
        isSubmitting,
        saved,
        refusal,
        failed,
      ];
}
