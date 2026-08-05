part of 'subscription_bloc.dart';

sealed class SubscriptionState extends Equatable {
  const SubscriptionState();

  /// The tier to gate on right now. Anything other than a loaded plan reads as
  /// Gratuit, so a slow or failed load never unlocks a paid feature.
  SubscriptionTier get tier => switch (this) {
        SubscriptionReady(:final plan) => plan.effectiveTier,
        _ => SubscriptionTier.gratuit,
      };

  @override
  List<Object?> get props => [];
}

final class SubscriptionInitial extends SubscriptionState {
  const SubscriptionInitial();
}

final class SubscriptionLoadInProgress extends SubscriptionState {
  const SubscriptionLoadInProgress();
}

final class SubscriptionReady extends SubscriptionState {
  const SubscriptionReady(this.plan, {this.fromFallback = false});

  final SubscriptionPlan plan;

  /// True when the load failed and this is the safe Gratuit default rather than
  /// a plan the backend confirmed. The UI says so instead of asserting the
  /// account is free.
  final bool fromFallback;

  @override
  List<Object?> get props => [plan, fromFallback];
}
