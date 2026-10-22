import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The home's "N demandes de locataires attendent ta réponse" (CDC M30,
/// RM-M30-09) — a count, the server's total of what still waits on him.
///
/// A failed read keeps the last count: the card is a nudge, and a blank one
/// would say there is nothing to answer.
class OpenRequestsBloc extends Bloc<OpenRequestsEvent, OpenRequestsState> {
  OpenRequestsBloc({required HomeRequestsRepository repository})
      : _repository = repository,
        super(const OpenRequestsUnknown()) {
    on<OpenRequestsRequested>(_onRequested);
  }

  final HomeRequestsRepository _repository;

  Future<void> _onRequested(OpenRequestsRequested event, Emitter<OpenRequestsState> emit) async {
    try {
      emit(OpenRequestsCounted(await _repository.openCount()));
    } catch (_) {
      // Kept as it was.
    }
  }
}

sealed class OpenRequestsEvent extends Equatable {
  const OpenRequestsEvent();

  @override
  List<Object?> get props => [];
}

final class OpenRequestsRequested extends OpenRequestsEvent {
  const OpenRequestsRequested();
}

sealed class OpenRequestsState extends Equatable {
  const OpenRequestsState();

  @override
  List<Object?> get props => [];
}

final class OpenRequestsUnknown extends OpenRequestsState {
  const OpenRequestsUnknown();
}

final class OpenRequestsCounted extends OpenRequestsState {
  const OpenRequestsCounted(this.count);

  final int count;

  @override
  List<Object?> get props => [count];
}
