import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

part 'contracts_event.dart';
part 'contracts_state.dart';

/// The prestataire's contracts (CDC M08), newest first.
///
/// Filtering happens **here, over one read**, not per tab: a portfolio's
/// contracts are few, and `awaiting` — the thing the list is really sorted by
/// in the reader's head — cannot be queried server-side anyway.
class ContractsBloc extends Bloc<ContractsEvent, ContractsState> {
  ContractsBloc({required ContractRepository repository})
      : _repository = repository,
        super(const ContractsInitial()) {
    on<ContractsLoadRequested>(_onLoad);
    on<ContractsRefreshRequested>(_onRefresh);
    on<ContractsFilterChanged>(_onFilter);
  }

  final ContractRepository _repository;

  Future<void> _onLoad(
    ContractsLoadRequested event,
    Emitter<ContractsState> emit,
  ) async {
    emit(const ContractsLoadInProgress());
    await _read(emit, const ContractFilter.all());
  }

  Future<void> _onRefresh(
    ContractsRefreshRequested event,
    Emitter<ContractsState> emit,
  ) async {
    final current = state;
    await _read(emit, current is ContractsReady ? current.filter : const ContractFilter.all());
  }

  void _onFilter(ContractsFilterChanged event, Emitter<ContractsState> emit) {
    final current = state;
    if (current is! ContractsReady) return;
    emit(current.copyWith(filter: event.filter));
  }

  Future<void> _read(Emitter<ContractsState> emit, ContractFilter filter) async {
    try {
      emit(ContractsReady(items: await _repository.list(), filter: filter));
    } catch (_) {
      // A failed refresh keeps whatever is on screen.
      if (state is! ContractsReady) emit(const ContractsFailure());
    }
  }
}
