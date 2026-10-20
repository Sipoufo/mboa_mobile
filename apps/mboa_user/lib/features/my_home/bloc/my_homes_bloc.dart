import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The tenant's spaces of "Mon Logement" (CDC M30) — one per signed
/// contract, active first (the server's order).
///
/// A session singleton: the Compte list and the search tab's "Prochain
/// loyer" read the same instance, loaded at sign-in and dropped at sign-out.
class MyHomesBloc extends Bloc<MyHomesEvent, MyHomesState> {
  MyHomesBloc({required HomesRepository repository})
      : _repository = repository,
        super(const MyHomesLoading()) {
    on<MyHomesRequested>(_onRequested);
  }

  final HomesRepository _repository;

  Future<void> _onRequested(MyHomesRequested event, Emitter<MyHomesState> emit) async {
    if (state is! MyHomesReady) emit(const MyHomesLoading());
    try {
      final read = await _repository.myHomes();
      emit(MyHomesReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! MyHomesReady) emit(const MyHomesFailure());
    }
  }
}

sealed class MyHomesEvent extends Equatable {
  const MyHomesEvent();

  @override
  List<Object?> get props => [];
}

final class MyHomesRequested extends MyHomesEvent {
  const MyHomesRequested();
}

sealed class MyHomesState extends Equatable {
  const MyHomesState();

  @override
  List<Object?> get props => [];
}

final class MyHomesLoading extends MyHomesState {
  const MyHomesLoading();
}

final class MyHomesFailure extends MyHomesState {
  const MyHomesFailure();
}

final class MyHomesReady extends MyHomesState {
  const MyHomesReady({required this.items, this.isOffline = false});

  final List<Home> items;
  final bool isOffline;

  /// The space the search tab speaks of: the first active one with
  /// something due (the server orders active first).
  Home? get current => items.where((h) => h.state == HomeStage.active && h.nextDue != null).firstOrNull;

  @override
  List<Object?> get props => [items, isOffline];
}
