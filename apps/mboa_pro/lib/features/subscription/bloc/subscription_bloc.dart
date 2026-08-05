import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/subscription_repository.dart';
import '../models/subscription_models.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

/// Owns the *current* plan (CDC M13).
///
/// Session-scoped and provided by `AuthenticatedWrapper`, because it is what
/// feeds `AccessContext.tier` — the whole app's tier gating reads this one
/// instance. The checkout flow lives in `SubscribeBloc`; this bloc only learns
/// the outcome, via [SubscriptionRefreshRequested].
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc({required SubscriptionRepository repository})
      : _repository = repository,
        super(const SubscriptionInitial()) {
    on<SubscriptionLoadRequested>(_onLoad);
    on<SubscriptionRefreshRequested>(_onRefresh);
  }

  final SubscriptionRepository _repository;

  Future<void> _onLoad(
    SubscriptionLoadRequested event,
    Emitter<SubscriptionState> emit,
  ) async {
    emit(const SubscriptionLoadInProgress());
    await _load(emit);
  }

  Future<void> _onRefresh(
    SubscriptionRefreshRequested event,
    Emitter<SubscriptionState> emit,
  ) =>
      _load(emit);

  Future<void> _load(Emitter<SubscriptionState> emit) async {
    try {
      emit(SubscriptionReady(await _repository.myPlan()));
    } catch (_) {
      // Never block the app on this: an unknown plan is treated as Gratuit, so
      // gated features stay locked rather than being wrongly opened up.
      emit(const SubscriptionReady(SubscriptionPlan.free(), fromFallback: true));
    }
  }
}
