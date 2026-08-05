part of 'subscription_bloc.dart';

sealed class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();

  @override
  List<Object?> get props => [];
}

final class SubscriptionLoadRequested extends SubscriptionEvent {
  const SubscriptionLoadRequested();
}

/// Silent re-read — used after a confirmed payment, and by pull-to-refresh.
final class SubscriptionRefreshRequested extends SubscriptionEvent {
  const SubscriptionRefreshRequested();
}
