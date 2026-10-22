import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// The useful contacts the landlord shares on the tenant's home (CDC M30
/// lot 3, RM-M30-13, CA-M30-05): a name, a role, a number — nothing else.
/// Offline, the last list read, marked.
class HomeContactsBloc extends Bloc<HomeContactsEvent, HomeContactsState> {
  HomeContactsBloc({required ContactsRepository repository, required this.contractId})
      : _repository = repository,
        super(const HomeContactsLoading()) {
    on<HomeContactsRequested>(_onRequested);
  }

  final ContactsRepository _repository;
  final String contractId;

  Future<void> _onRequested(HomeContactsRequested event, Emitter<HomeContactsState> emit) async {
    if (state is! HomeContactsReady) emit(const HomeContactsLoading());
    try {
      final read = await _repository.ofHome(contractId);
      emit(HomeContactsReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! HomeContactsReady) emit(const HomeContactsFailure());
    }
  }
}

sealed class HomeContactsEvent extends Equatable {
  const HomeContactsEvent();

  @override
  List<Object?> get props => [];
}

final class HomeContactsRequested extends HomeContactsEvent {
  const HomeContactsRequested();
}

sealed class HomeContactsState extends Equatable {
  const HomeContactsState();

  @override
  List<Object?> get props => [];
}

final class HomeContactsLoading extends HomeContactsState {
  const HomeContactsLoading();
}

final class HomeContactsFailure extends HomeContactsState {
  const HomeContactsFailure();
}

final class HomeContactsReady extends HomeContactsState {
  const HomeContactsReady({this.items = const [], this.isOffline = false});

  final List<UsefulContact> items;
  final bool isOffline;

  @override
  List<Object?> get props => [items, isOffline];
}
