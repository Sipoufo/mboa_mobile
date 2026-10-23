import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/providers_repository.dart';
import '../models/finance_refusal.dart';
import '../models/service_provider.dart';

enum ProviderDone { archived, restored, deleted }

/// One intervenant (CDC M26): who, what he was paid and when; archived —
/// hidden from the pickers, history kept — or deleted when he has no
/// payment.
class ProviderBloc extends Bloc<ProviderEvent, ProviderState> {
  ProviderBloc({required ProvidersRepository repository})
      : _repository = repository,
        super(const ProviderLoading()) {
    on<ProviderOpened>(_onOpened);
    on<ProviderArchived>((event, emit) => _act(emit, ProviderDone.archived, () => _repository.archive(_id)));
    on<ProviderRestored>((event, emit) => _act(emit, ProviderDone.restored, () => _repository.restore(_id)));
    on<ProviderDeleted>((event, emit) => _act(emit, ProviderDone.deleted, () async {
          await _repository.delete(_id);
          return null;
        }));
  }

  final ProvidersRepository _repository;

  String get _id => (state as ProviderReady).provider.id;

  Future<void> _onOpened(ProviderOpened event, Emitter<ProviderState> emit) async {
    if (state is! ProviderReady) emit(const ProviderLoading());
    try {
      final read = await _repository.provider(event.id);
      emit(ProviderReady(provider: read.value.$1, payments: read.value.$2, isOffline: read.fromCache));
    } catch (_) {
      if (state is! ProviderReady) emit(ProviderFailure(event.id));
    }
  }

  Future<void> _act(
    Emitter<ProviderState> emit,
    ProviderDone done,
    Future<ServiceProvider?> Function() call,
  ) async {
    final current = state;
    if (current is! ProviderReady || current.isBusy) return;
    emit(current.copyWith(isBusy: true));
    try {
      final provider = await call();
      emit(ProviderReady(provider: provider ?? current.provider, payments: current.payments, done: done));
    } on FinanceRefused catch (refused) {
      emit(current.copyWith(refusal: refused.reason));
    } catch (_) {
      emit(current.copyWith(failed: true));
    }
  }
}

sealed class ProviderEvent extends Equatable {
  const ProviderEvent();

  @override
  List<Object?> get props => [];
}

final class ProviderOpened extends ProviderEvent {
  const ProviderOpened(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ProviderArchived extends ProviderEvent {
  const ProviderArchived();
}

final class ProviderRestored extends ProviderEvent {
  const ProviderRestored();
}

final class ProviderDeleted extends ProviderEvent {
  const ProviderDeleted();
}

sealed class ProviderState extends Equatable {
  const ProviderState();

  @override
  List<Object?> get props => [];
}

final class ProviderLoading extends ProviderState {
  const ProviderLoading();
}

final class ProviderFailure extends ProviderState {
  const ProviderFailure(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}

final class ProviderReady extends ProviderState {
  const ProviderReady({
    required this.provider,
    this.payments = const [],
    this.isOffline = false,
    this.isBusy = false,
    this.done,
    this.refusal,
    this.failed = false,
  });

  final ServiceProvider provider;

  /// Latest first.
  final List<ProviderPayment> payments;
  final bool isOffline;
  final bool isBusy;
  final ProviderDone? done;
  final FinanceRefusal? refusal;
  final bool failed;

  /// Outcomes are not carried over.
  ProviderReady copyWith({bool isBusy = false, FinanceRefusal? refusal, bool failed = false}) => ProviderReady(
        provider: provider,
        payments: payments,
        isOffline: isOffline,
        isBusy: isBusy,
        refusal: refusal,
        failed: failed,
      );

  @override
  List<Object?> get props => [provider, payments, isOffline, isBusy, done, refusal, failed];
}
