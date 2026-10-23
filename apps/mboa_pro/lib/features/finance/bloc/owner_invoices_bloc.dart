import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/owner_invoices_repository.dart';

/// The landlord's invoices (CDC M24), by where they stand — the server's
/// word, lateness included (RM-M24-07). Readable offline.
class OwnerInvoicesBloc extends Bloc<OwnerInvoicesEvent, OwnerInvoicesState> {
  OwnerInvoicesBloc({required OwnerInvoicesRepository repository})
      : _repository = repository,
        super(const OwnerInvoicesLoading()) {
    on<OwnerInvoicesRequested>(_onRequested);
    on<OwnerInvoicesFilterChanged>((event, emit) {
      if (state case final OwnerInvoicesReady ready) emit(ready.copyWith(filter: event.filter));
    });
  }

  final OwnerInvoicesRepository _repository;

  Future<void> _onRequested(OwnerInvoicesRequested event, Emitter<OwnerInvoicesState> emit) async {
    final current = state;
    try {
      final read = await _repository.list();
      emit(
        OwnerInvoicesReady(
          items: read.value,
          isOffline: read.fromCache,
          filter: current is OwnerInvoicesReady ? current.filter : InvoiceStatus.toPay,
        ),
      );
    } catch (_) {
      if (current is! OwnerInvoicesReady) emit(const OwnerInvoicesFailure());
    }
  }
}

sealed class OwnerInvoicesEvent extends Equatable {
  const OwnerInvoicesEvent();

  @override
  List<Object?> get props => [];
}

final class OwnerInvoicesRequested extends OwnerInvoicesEvent {
  const OwnerInvoicesRequested();
}

final class OwnerInvoicesFilterChanged extends OwnerInvoicesEvent {
  const OwnerInvoicesFilterChanged(this.filter);

  final InvoiceStatus filter;

  @override
  List<Object?> get props => [filter];
}

sealed class OwnerInvoicesState extends Equatable {
  const OwnerInvoicesState();

  @override
  List<Object?> get props => [];
}

final class OwnerInvoicesLoading extends OwnerInvoicesState {
  const OwnerInvoicesLoading();
}

final class OwnerInvoicesFailure extends OwnerInvoicesState {
  const OwnerInvoicesFailure();
}

final class OwnerInvoicesReady extends OwnerInvoicesState {
  const OwnerInvoicesReady({required this.items, this.filter = InvoiceStatus.toPay, this.isOffline = false});

  /// Latest due first — the server's order.
  final List<HomeInvoice> items;

  /// Which of « À payer », « En retard », « Payée », « Annulée ».
  final InvoiceStatus filter;
  final bool isOffline;

  static const filters = [InvoiceStatus.toPay, InvoiceStatus.overdue, InvoiceStatus.paid, InvoiceStatus.cancelled];

  List<HomeInvoice> get shown => [for (final i in items) if (i.status == filter) i];

  int count(InvoiceStatus status) => items.where((i) => i.status == status).length;

  OwnerInvoicesReady copyWith({InvoiceStatus? filter}) =>
      OwnerInvoicesReady(items: items, filter: filter ?? this.filter, isOffline: isOffline);

  @override
  List<Object?> get props => [items, filter, isOffline];
}
