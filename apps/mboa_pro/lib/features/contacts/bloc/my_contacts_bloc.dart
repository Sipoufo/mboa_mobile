import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The landlord's useful contacts (CDC M30 lot 3, RM-M30-13): his notes
/// about third parties, fifteen at most, each shared with his tenants or
/// not. Offline, the last list read, marked.
class MyContactsBloc extends Bloc<MyContactsEvent, MyContactsState> {
  MyContactsBloc({required ContactsRepository repository})
      : _repository = repository,
        super(const MyContactsLoading()) {
    on<MyContactsRequested>(_onRequested);
    on<MyContactDeleted>(_onDeleted);
  }

  final ContactsRepository _repository;

  Future<void> _onRequested(MyContactsRequested event, Emitter<MyContactsState> emit) async {
    if (state is! MyContactsReady) emit(const MyContactsLoading());
    try {
      final read = await _repository.mine();
      emit(MyContactsReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! MyContactsReady) emit(const MyContactsFailure());
    }
  }

  Future<void> _onDeleted(MyContactDeleted event, Emitter<MyContactsState> emit) async {
    final current = state;
    if (current is! MyContactsReady || current.isOffline) return;
    try {
      await _repository.delete(event.id);
      emit(MyContactsReady(items: [for (final c in current.items) if (c.id != event.id) c]));
    } catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(MyContactsReady(items: current.items, failed: true));
    }
  }
}

sealed class MyContactsEvent extends Equatable {
  const MyContactsEvent();

  @override
  List<Object?> get props => [];
}

final class MyContactsRequested extends MyContactsEvent {
  const MyContactsRequested();
}

final class MyContactDeleted extends MyContactsEvent {
  const MyContactDeleted(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

sealed class MyContactsState extends Equatable {
  const MyContactsState();

  @override
  List<Object?> get props => [];
}

final class MyContactsLoading extends MyContactsState {
  const MyContactsLoading();
}

final class MyContactsFailure extends MyContactsState {
  const MyContactsFailure();
}

final class MyContactsReady extends MyContactsState {
  const MyContactsReady({this.items = const [], this.isOffline = false, this.failed = false});

  final List<UsefulContact> items;
  final bool isOffline;

  /// A deletion that did not go through — said once.
  final bool failed;

  bool get isFull => items.length >= ContactsRepository.max;

  @override
  List<Object?> get props => [items, isOffline, failed];
}
