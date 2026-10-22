import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/home_requests_repository.dart';
import '../data/homes_repository.dart';
import '../models/home_request.dart';

/// A list of requests to the landlord (CDC M30, RM-M30-09): one home's, read
/// by either party ([contractId]), or the landlord's inbox across his homes
/// (null — what still waits on him). Offline, the last list read, marked.
class HomeRequestsBloc extends Bloc<HomeRequestsEvent, HomeRequestsState> {
  HomeRequestsBloc({required HomeRequestsRepository repository, this.contractId})
      : _repository = repository,
        super(const HomeRequestsLoading()) {
    on<HomeRequestsRequested>(_onRequested);
  }

  final HomeRequestsRepository _repository;
  final String? contractId;

  Future<void> _onRequested(HomeRequestsRequested event, Emitter<HomeRequestsState> emit) async {
    // A refresh keeps the list on screen rather than blanking it.
    if (state is! HomeRequestsReady) emit(const HomeRequestsLoading());
    try {
      final Cached<List<HomeRequest>> read =
          contractId == null ? await _repository.received() : await _repository.ofHome(contractId!);
      emit(HomeRequestsReady(items: read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! HomeRequestsReady) emit(const HomeRequestsFailure());
    }
  }
}

sealed class HomeRequestsEvent extends Equatable {
  const HomeRequestsEvent();

  @override
  List<Object?> get props => [];
}

final class HomeRequestsRequested extends HomeRequestsEvent {
  const HomeRequestsRequested();
}

sealed class HomeRequestsState extends Equatable {
  const HomeRequestsState();

  @override
  List<Object?> get props => [];
}

final class HomeRequestsLoading extends HomeRequestsState {
  const HomeRequestsLoading();
}

final class HomeRequestsFailure extends HomeRequestsState {
  const HomeRequestsFailure();
}

final class HomeRequestsReady extends HomeRequestsState {
  const HomeRequestsReady({this.items = const [], this.isOffline = false});

  /// Newest first — the server's order.
  final List<HomeRequest> items;
  final bool isOffline;

  @override
  List<Object?> get props => [items, isOffline];
}
