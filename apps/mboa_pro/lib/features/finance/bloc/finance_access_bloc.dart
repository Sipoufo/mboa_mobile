import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/finance_access_repository.dart';
import '../models/finance_access.dart';

/// « Gestion financière » — where the landlord stands with the finance tools
/// (RM-M13-09). Read again on return from the plans: a new plan is what opens
/// writing.
class FinanceAccessBloc extends Bloc<FinanceAccessEvent, FinanceAccessState> {
  FinanceAccessBloc({required FinanceAccessRepository repository})
      : _repository = repository,
        super(const FinanceAccessLoading()) {
    on<FinanceAccessRequested>(_onRequested);
  }

  final FinanceAccessRepository _repository;

  Future<void> _onRequested(FinanceAccessRequested event, Emitter<FinanceAccessState> emit) async {
    try {
      final read = await _repository.access();
      emit(FinanceAccessReady(read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! FinanceAccessReady) emit(const FinanceAccessFailure());
    }
  }
}

sealed class FinanceAccessEvent extends Equatable {
  const FinanceAccessEvent();

  @override
  List<Object?> get props => [];
}

final class FinanceAccessRequested extends FinanceAccessEvent {
  const FinanceAccessRequested();
}

sealed class FinanceAccessState extends Equatable {
  const FinanceAccessState();

  @override
  List<Object?> get props => [];
}

final class FinanceAccessLoading extends FinanceAccessState {
  const FinanceAccessLoading();
}

final class FinanceAccessFailure extends FinanceAccessState {
  const FinanceAccessFailure();
}

final class FinanceAccessReady extends FinanceAccessState {
  const FinanceAccessReady(this.access, {this.isOffline = false});

  final FinanceAccess access;
  final bool isOffline;

  @override
  List<Object?> get props => [access, isOffline];
}
