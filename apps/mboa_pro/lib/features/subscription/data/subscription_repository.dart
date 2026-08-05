import 'dart:math';

import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/subscription_models.dart';

/// Subscriptions and Mobile Money payment (CDC M13).
class SubscriptionRepository {
  SubscriptionRepository({required DioClient dioClient})
      : _dioClient = dioClient;

  final DioClient _dioClient;

  SubscriptionsApi get _api => _dioClient.api.getSubscriptionsApi();

  /// The current plan. Falls back to the free tier when the backend returns no
  /// body — an account without a subscription is on Gratuit, not in an error
  /// state.
  Future<SubscriptionPlan> myPlan() async {
    final response = await _api.mySubscription();
    final data = response.data;
    return data == null
        ? const SubscriptionPlan.free()
        : SubscriptionPlan.fromResponse(data);
  }

  /// The purchasable plans, cheapest first.
  Future<List<TierOption>> tiers() async {
    final response = await _api.tiers();
    final options = (response.data ?? const <TierInfo>[])
        .map(TierOption.fromResponse)
        .toList()
      ..sort((a, b) => (a.rank ?? a.tier.index).compareTo(b.rank ?? b.tier.index));
    return options;
  }

  /// Initiates a Mobile Money payment.
  ///
  /// [idempotencyKey] must stay stable across retries of the *same* purchase —
  /// the endpoint accepts an `Idempotency-Key` header precisely so a retried
  /// request cannot charge twice. Generate one per attempt with
  /// [newIdempotencyKey] and reuse it.
  Future<PaymentAttempt> subscribe({
    required SubscriptionTier tier,
    required PaymentMethod method,
    required String idempotencyKey,
  }) async {
    final response = await _api.subscribe(
      idempotencyKey: idempotencyKey,
      subscribeRequest: SubscribeRequest((b) => b
        ..tier = tier.asRequest
        ..method = method.asRequest),
    );

    final data = response.data;
    if (data == null) {
      throw StateError('subscribe returned no payment');
    }

    return PaymentAttempt.fromResponse(data, tier: tier);
  }

  /// A signed URL for the payment receipt (RM-M13-07).
  Future<String?> receiptUrl(String paymentId) async {
    final response = await _api.receipt(id: paymentId);
    return response.data?.downloadUrl;
  }

  /// The prestataire's payment history (RM-M13-07), newest first.
  ///
  /// Replaced a device-local Hive cache: `paymentId` used to come back only
  /// from the initiating call, so receipts vanished on reinstall.
  Future<List<PaymentAttempt>> payments() async {
    final response = await _api.listMyPayments(
      pageable: Pageable((b) => b
        ..page = 0
        ..size = 50),
    );
    return (response.data?.content ?? const <PaymentSummary>[])
        .map(PaymentAttempt.fromSummary)
        .toList();
  }

  /// One payment's current state — the source of truth while awaiting
  /// settlement. Unlike the tier, this distinguishes FAILED from "not yet".
  Future<PaymentAttempt?> payment(String paymentId) async {
    final response = await _api.getPayment(id: paymentId);
    final data = response.data;
    return data == null ? null : PaymentAttempt.fromSummary(data);
  }

  /// A fresh idempotency key for one purchase attempt.
  static String newIdempotencyKey() {
    final random = Random();
    final suffix = List.generate(8, (_) => random.nextInt(16).toRadixString(16)).join();
    return 'sub-${DateTime.now().microsecondsSinceEpoch}-$suffix';
  }
}
