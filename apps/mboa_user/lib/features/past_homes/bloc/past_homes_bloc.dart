import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// « Mes anciens logements » (CDC M31): the tenancies that are over, the
/// latest first (the server's order). Readable offline from the last read.
class PastHomesBloc extends Bloc<PastHomesEvent, PastHomesState> {
  PastHomesBloc({required PastHomesRepository repository})
      : _repository = repository,
        super(const PastHomesLoading()) {
    on<PastHomesRequested>(_onRequested);
  }

  final PastHomesRepository _repository;

  Future<void> _onRequested(PastHomesRequested event, Emitter<PastHomesState> emit) async {
    if (state is! PastHomesReady) emit(const PastHomesLoading());
    try {
      final read = await _repository.list();
      emit(PastHomesReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! PastHomesReady) emit(const PastHomesFailure());
    }
  }
}

sealed class PastHomesEvent extends Equatable {
  const PastHomesEvent();

  @override
  List<Object?> get props => [];
}

final class PastHomesRequested extends PastHomesEvent {
  const PastHomesRequested();
}

sealed class PastHomesState extends Equatable {
  const PastHomesState();

  @override
  List<Object?> get props => [];
}

final class PastHomesLoading extends PastHomesState {
  const PastHomesLoading();
}

final class PastHomesFailure extends PastHomesState {
  const PastHomesFailure();
}

final class PastHomesReady extends PastHomesState {
  const PastHomesReady({required this.items, this.isOffline = false});

  final List<Home> items;
  final bool isOffline;

  @override
  List<Object?> get props => [items, isOffline];
}
