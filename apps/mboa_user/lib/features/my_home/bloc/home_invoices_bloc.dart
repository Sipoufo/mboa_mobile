import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// One tenancy's invoices (CDC M24, slice E), in its space — what can be
/// declared paid. Offline, the last list read, marked.
///
/// A section of the space rather than the space's own read: the landlord
/// reads the same space and cannot read these, so the shared bloc stays
/// without them.
class HomeInvoicesBloc extends Bloc<HomeInvoicesEvent, HomeInvoicesState> {
  HomeInvoicesBloc({required HomesRepository repository})
      : _repository = repository,
        super(const HomeInvoicesLoading()) {
    on<HomeInvoicesRequested>(_onRequested);
  }

  final HomesRepository _repository;

  Future<void> _onRequested(HomeInvoicesRequested event, Emitter<HomeInvoicesState> emit) async {
    try {
      final read = await _repository.invoices(contractId: event.contractId);
      emit(HomeInvoicesReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      // A refresh that fails keeps the list; with nothing to show, the
      // section is left out rather than the space spoilt.
      if (state is! HomeInvoicesReady) emit(const HomeInvoicesFailure());
    }
  }
}

sealed class HomeInvoicesEvent extends Equatable {
  const HomeInvoicesEvent();

  @override
  List<Object?> get props => [];
}

final class HomeInvoicesRequested extends HomeInvoicesEvent {
  const HomeInvoicesRequested(this.contractId);

  final String contractId;

  @override
  List<Object?> get props => [contractId];
}

sealed class HomeInvoicesState extends Equatable {
  const HomeInvoicesState();

  @override
  List<Object?> get props => [];
}

final class HomeInvoicesLoading extends HomeInvoicesState {
  const HomeInvoicesLoading();
}

final class HomeInvoicesFailure extends HomeInvoicesState {
  const HomeInvoicesFailure();
}

final class HomeInvoicesReady extends HomeInvoicesState {
  const HomeInvoicesReady({this.items = const [], this.isOffline = false});

  /// Latest due first — the server's order.
  final List<HomeInvoice> items;
  final bool isOffline;

  @override
  List<Object?> get props => [items, isOffline];
}
