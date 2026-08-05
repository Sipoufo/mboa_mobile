part of 'subscribe_bloc.dart';

sealed class SubscribeState extends Equatable {
  const SubscribeState();

  @override
  List<Object?> get props => [];
}

final class SubscribeIdle extends SubscribeState {
  const SubscribeIdle();
}

/// Calling `POST /subscriptions`.
final class SubscribeInitiating extends SubscribeState {
  const SubscribeInitiating({required this.tier, required this.method});

  final SubscriptionTier tier;
  final PaymentMethod method;

  @override
  List<Object?> get props => [tier, method];
}

/// Payment initiated; the prestataire is finishing it on their handset (USSD or
/// the MoMo app) while we poll for the webhook to land.
final class SubscribeAwaitingConfirmation extends SubscribeState {
  const SubscribeAwaitingConfirmation({required this.attempt});

  final PaymentAttempt attempt;

  @override
  List<Object?> get props => [attempt];
}

/// The tier is active.
final class SubscribeConfirmed extends SubscribeState {
  const SubscribeConfirmed({required this.attempt, this.plan});

  final PaymentAttempt attempt;

  /// Null when the confirming read failed — the payment is good either way.
  final SubscriptionPlan? plan;

  @override
  List<Object?> get props => [attempt, plan];
}

/// We stopped waiting, but the payment has not failed — the webhook still has
/// time (RM-M13-05). The user is told they'll be notified.
final class SubscribePendingHandoff extends SubscribeState {
  const SubscribePendingHandoff({required this.attempt});

  final PaymentAttempt attempt;

  @override
  List<Object?> get props => [attempt];
}

/// Initiation failed, or the provider rejected/cancelled the payment.
/// Carries the inputs so [SubscribeRetryRequested] can replay them.
final class SubscribeFailure extends SubscribeState {
  const SubscribeFailure({
    required this.tier,
    required this.method,
    this.attempt,
  });

  final SubscriptionTier tier;
  final PaymentMethod method;
  final PaymentAttempt? attempt;

  @override
  List<Object?> get props => [tier, method, attempt];
}
