import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The home's "N paiements déclarés attendent ta confirmation" (CDC M30) —
/// a count, nothing more: the server's total, not a page.
///
/// A failed read keeps the last count: the card is a nudge, and a blank one
/// would say there is nothing to answer.
class WaitingDeclarationsBloc extends Bloc<WaitingDeclarationsEvent, WaitingDeclarationsState> {
  WaitingDeclarationsBloc({required HomesRepository repository})
      : _repository = repository,
        super(const WaitingDeclarationsUnknown()) {
    on<WaitingDeclarationsRequested>(_onRequested);
  }

  final HomesRepository _repository;

  Future<void> _onRequested(WaitingDeclarationsRequested event, Emitter<WaitingDeclarationsState> emit) async {
    try {
      emit(WaitingDeclarationsCounted(await _repository.waitingCount()));
    } catch (_) {
      // Kept as it was.
    }
  }
}

sealed class WaitingDeclarationsEvent extends Equatable {
  const WaitingDeclarationsEvent();

  @override
  List<Object?> get props => [];
}

final class WaitingDeclarationsRequested extends WaitingDeclarationsEvent {
  const WaitingDeclarationsRequested();
}

sealed class WaitingDeclarationsState extends Equatable {
  const WaitingDeclarationsState();

  @override
  List<Object?> get props => [];
}

final class WaitingDeclarationsUnknown extends WaitingDeclarationsState {
  const WaitingDeclarationsUnknown();
}

final class WaitingDeclarationsCounted extends WaitingDeclarationsState {
  const WaitingDeclarationsCounted(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}
