import 'dart:math';

import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../models/subscription_models.dart';

/// Subscriptions and Mobile Money payment (CDC M13).
class SubscriptionRepository {
  SubscriptionRepository({
    required DioClient dioClient,
    required HiveCache cache,
  })  : _dioClient = dioClient,
        _cache = cache;

  final DioClient _dioClient;
  final HiveCache _cache;

  static const String _paymentsKey = 'payments';

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

    final attempt = PaymentAttempt.fromResponse(data, tier: tier);
    await rememberPayment(attempt);
    return attempt;
  }

  /// A signed URL for the payment receipt (RM-M13-07).
  Future<String?> receiptUrl(String paymentId) async {
    final response = await _api.receipt(id: paymentId);
    return response.data?.downloadUrl;
  }

  // --- Local payment history -------------------------------------------------
  //
  // There is no "list my payments" endpoint, and `paymentId` comes back only
  // from the initiating call, so receipts would be unreachable after the fact.
  // Persisting locally is a stopgap: it does not survive a reinstall and does
  // not follow the user across devices. Drop this once the backend exposes a
  // payments list.

  Future<void> rememberPayment(PaymentAttempt attempt) async {
    if (attempt.paymentId.isEmpty) return;

    final payments = knownPayments()
        .where((p) => p.paymentId != attempt.paymentId)
        .toList()
      ..insert(0, attempt);

    await _cache.put(StorageKeys.subscriptionBox, _paymentsKey, {
      // Keep the history short — receipts age out of usefulness.
      'items': payments.take(20).map((p) => p.toCache()).toList(),
    });
  }

  List<PaymentAttempt> knownPayments() {
    final json = _cache.get(StorageKeys.subscriptionBox, _paymentsKey);
    final items = (json?['items'] as List?) ?? const [];
    return items
        .map((e) => PaymentAttempt.fromCache(Map<String, dynamic>.from(e as Map)))
        .toList();
  }

  /// A fresh idempotency key for one purchase attempt.
  static String newIdempotencyKey() {
    final random = Random();
    final suffix = List.generate(8, (_) => random.nextInt(16).toRadixString(16)).join();
    return 'sub-${DateTime.now().microsecondsSinceEpoch}-$suffix';
  }
}
