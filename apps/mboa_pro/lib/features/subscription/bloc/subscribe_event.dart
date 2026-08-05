part of 'subscribe_bloc.dart';

sealed class SubscribeEvent extends Equatable {
  const SubscribeEvent();

  @override
  List<Object?> get props => [];
}

/// Starts a new purchase — a new charge, so a new idempotency key.
final class SubscribeRequested extends SubscribeEvent {
  const SubscribeRequested({required this.tier, required this.method});

  final SubscriptionTier tier;
  final PaymentMethod method;

  @override
  List<Object?> get props => [tier, method];
}

/// Retries the *same* purchase after a failure, reusing the idempotency key so
/// a request that actually landed cannot charge twice.
final class SubscribeRetryRequested extends SubscribeEvent {
  const SubscribeRetryRequested();
}
