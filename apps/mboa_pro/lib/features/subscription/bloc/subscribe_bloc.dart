import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../data/subscription_repository.dart';
import '../models/subscription_models.dart';

part 'subscribe_event.dart';
part 'subscribe_state.dart';

/// The checkout flow (CDC M13): pick a tier, pick a Mobile Money provider, pay
/// on the handset, wait for confirmation.
///
/// Separate from `SubscriptionBloc` because it is a transient, multi-step flow —
/// the same split as `ProfileBloc` vs `ChangePasswordCubit`. Created per flow,
/// so its state dies with the screen instead of lingering all session.
///
/// Confirmation is webhook-driven, so the outcome is polled. It polls the
/// **payment** rather than the plan: unlike the tier, the payment distinguishes
/// `FAILED` from "not settled yet", so a rejection is reported instead of
/// silently timing out. A push also fires on settlement (M03), which is what
/// ends the wait when the app is backgrounded.
///
/// Polling still stops after [pollTimeout] and hands off to a "we'll notify
/// you" state, rather than spinning for the full 15 minutes RM-M13-05 allows.
class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  SubscribeBloc({
    required SubscriptionRepository repository,
    this.pollInterval = const Duration(seconds: 3),
    this.pollTimeout = const Duration(seconds: 90),
  })  : _repository = repository,
        super(const SubscribeIdle()) {
    on<SubscribeRequested>(_onRequested);
    on<SubscribeRetryRequested>(_onRetry);
  }

  final SubscriptionRepository _repository;

  /// How often to re-read the plan while awaiting the webhook.
  final Duration pollInterval;

  /// How long to wait before handing off to the notification path.
  final Duration pollTimeout;

  /// Stable across retries of one purchase, so a retry cannot double-charge.
  /// The server generates a random key when the header is absent, so sending
  /// one is what actually stops a double-tap becoming two payments.
  String? _idempotencyKey;

  /// Retained so a mid-poll rejection can be reported with its inputs.
  PaymentMethod _method = PaymentMethod.mtnMomo;

  Future<void> _onRetry(
    SubscribeRetryRequested event,
    Emitter<SubscribeState> emit,
  ) async {
    final current = state;
    if (current is! SubscribeFailure) return;
    await _run(current.tier, current.method, emit);
  }

  Future<void> _onRequested(
    SubscribeRequested event,
    Emitter<SubscribeState> emit,
  ) async {
    // A new purchase is a new charge; a retry of the same one is not.
    _idempotencyKey = SubscriptionRepository.newIdempotencyKey();
    await _run(event.tier, event.method, emit);
  }

  Future<void> _run(
    SubscriptionTier tier,
    PaymentMethod method,
    Emitter<SubscribeState> emit,
  ) async {
    _method = method;
    emit(SubscribeInitiating(tier: tier, method: method));

    final PaymentAttempt attempt;
    try {
      attempt = await _repository.subscribe(
        tier: tier,
        method: method,
        idempotencyKey: _idempotencyKey ??= SubscriptionRepository.newIdempotencyKey(),
      );
    } catch (_) {
      emit(SubscribeFailure(tier: tier, method: method));
      return;
    }

    // The provider can settle synchronously; don't poll if it already has.
    switch (attempt.status) {
      case PaymentStatus.confirmed:
        emit(SubscribeConfirmed(attempt: attempt, plan: await _safePlan()));
        return;
      case PaymentStatus.failed:
      case PaymentStatus.cancelled:
        emit(SubscribeFailure(tier: tier, method: method, attempt: attempt));
        return;
      case PaymentStatus.pending:
        break;
    }

    emit(SubscribeAwaitingConfirmation(attempt: attempt));
    await _awaitConfirmation(tier, attempt, emit);
  }

  /// Polls the payment until it settles, or [pollTimeout] elapses.
  Future<void> _awaitConfirmation(
    SubscriptionTier tier,
    PaymentAttempt attempt,
    Emitter<SubscribeState> emit,
  ) async {
    final deadline = DateTime.now().add(pollTimeout);

    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(pollInterval);
      if (isClosed || emit.isDone) return;

      final settled = await _safePayment(attempt.paymentId);
      switch (settled?.status) {
        case PaymentStatus.confirmed:
          emit(SubscribeConfirmed(attempt: settled!, plan: await _safePlan()));
          return;
        case PaymentStatus.failed:
        case PaymentStatus.cancelled:
          // Reported now rather than after the full timeout — watching the tier
          // could never tell a rejection from "not yet".
          emit(SubscribeFailure(tier: tier, method: _method, attempt: settled));
          return;
        case PaymentStatus.pending:
        case null:
          break;
      }
    }

    // Still pending. The webhook has up to 15 minutes (RM-M13-05), so this is
    // not a failure — the payment may yet succeed, and M03 notifications are
    // what close the loop.
    emit(SubscribePendingHandoff(attempt: attempt));
  }

  /// A poll failure must not abort the wait — the next tick may well succeed.
  Future<PaymentAttempt?> _safePayment(String paymentId) async {
    try {
      return await _repository.payment(paymentId);
    } catch (_) {
      return null;
    }
  }

  Future<SubscriptionPlan?> _safePlan() async {
    try {
      return await _repository.myPlan();
    } catch (_) {
      return null;
    }
  }
}
