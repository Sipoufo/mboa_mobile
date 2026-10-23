import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/finance_addon_repository.dart';
import '../models/finance_addon.dart';

/// « Gestion financière » — where the landlord stands with the add-on
/// (RM-M13-09). Read again after a checkout: the payment's webhook is what
/// opens the period.
class FinanceAddonBloc extends Bloc<FinanceAddonEvent, FinanceAddonState> {
  FinanceAddonBloc({required FinanceAddonRepository repository})
      : _repository = repository,
        super(const FinanceAddonLoading()) {
    on<FinanceAddonRequested>(_onRequested);
  }

  final FinanceAddonRepository _repository;

  Future<void> _onRequested(FinanceAddonRequested event, Emitter<FinanceAddonState> emit) async {
    try {
      final read = await _repository.addon();
      emit(FinanceAddonReady(read.value, isOffline: read.fromCache));
    } catch (_) {
      if (state is! FinanceAddonReady) emit(const FinanceAddonFailure());
    }
  }
}

sealed class FinanceAddonEvent extends Equatable {
  const FinanceAddonEvent();

  @override
  List<Object?> get props => [];
}

final class FinanceAddonRequested extends FinanceAddonEvent {
  const FinanceAddonRequested();
}

sealed class FinanceAddonState extends Equatable {
  const FinanceAddonState();

  @override
  List<Object?> get props => [];
}

final class FinanceAddonLoading extends FinanceAddonState {
  const FinanceAddonLoading();
}

final class FinanceAddonFailure extends FinanceAddonState {
  const FinanceAddonFailure();
}

final class FinanceAddonReady extends FinanceAddonState {
  const FinanceAddonReady(this.addon, {this.isOffline = false});

  final FinanceAddon addon;
  final bool isOffline;

  @override
  List<Object?> get props => [addon, isOffline];
}
