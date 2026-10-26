import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/providers_repository.dart';
import '../models/finance_refusal.dart';
import '../models/service_provider.dart';

/// The landlord's intervenants (CDC M26), by name, with what each was paid —
/// the archived ones on demand. Readable offline.
class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  ProvidersBloc({required ProvidersRepository repository})
      : _repository = repository,
        super(const ProvidersLoading()) {
    on<ProvidersRequested>((event, emit) => _load(emit, event.includeArchived ?? _archived));
  }

  final ProvidersRepository _repository;

  bool get _archived => state is ProvidersReady && (state as ProvidersReady).includeArchived;

  Future<void> _load(Emitter<ProvidersState> emit, bool includeArchived) async {
    try {
      final read = await _repository.list(includeArchived: includeArchived);
      emit(ProvidersReady(items: read.value, includeArchived: includeArchived, isOffline: read.fromCache));
    } on FinanceRefused catch (refused) {
      if (state is! ProvidersReady) emit(ProvidersFailure(planRequired: refused.reason == FinanceRefusal.planRequired));
    } catch (_) {
      if (state is! ProvidersReady) emit(const ProvidersFailure());
    }
  }
}

sealed class ProvidersEvent extends Equatable {
  const ProvidersEvent();

  @override
  List<Object?> get props => [];
}

/// [includeArchived]: switch; null keeps what was shown.
final class ProvidersRequested extends ProvidersEvent {
  const ProvidersRequested({this.includeArchived});

  final bool? includeArchived;

  @override
  List<Object?> get props => [includeArchived];
}

sealed class ProvidersState extends Equatable {
  const ProvidersState();

  @override
  List<Object?> get props => [];
}

final class ProvidersLoading extends ProvidersState {
  const ProvidersLoading();
}

final class ProvidersFailure extends ProvidersState {
  const ProvidersFailure({this.planRequired = false});

  /// Never held the finance tools: the server refuses even reading
  /// (`FINANCE_PLAN_REQUIRED`) — the page points at the plans, not at retry.
  final bool planRequired;

  @override
  List<Object?> get props => [planRequired];
}

final class ProvidersReady extends ProvidersState {
  const ProvidersReady({required this.items, this.includeArchived = false, this.isOffline = false});

  final List<ServiceProvider> items;
  final bool includeArchived;
  final bool isOffline;

  @override
  List<Object?> get props => [items, includeArchived, isOffline];
}
