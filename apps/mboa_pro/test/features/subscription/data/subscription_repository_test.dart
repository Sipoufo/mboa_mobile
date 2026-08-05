import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

class MockHiveCache extends Mock implements HiveCache {}

class MockSubscriptionsApi extends Mock implements SubscriptionsApi {}

Response<T> ok<T>(T data) => Response<T>(
      data: data,
      requestOptions: RequestOptions(path: '/api/v1/subscriptions'),
      statusCode: 200,
    );

/// A 200 with no body — the generated `Response<T>` keeps `data` nullable even
/// when `T` isn't.
Response<T> okEmpty<T>() => Response<T>(
      requestOptions: RequestOptions(path: '/api/v1/subscriptions'),
      statusCode: 200,
    );

void main() {
  late MockDioClient dioClient;
  late MockApiClient apiClient;
  late MockSubscriptionsApi api;
  late MockHiveCache cache;
  late SubscriptionRepository repository;

  setUpAll(() {
    registerFallbackValue(
      SubscribeRequest((b) => b
        ..tier = SubscribeRequestTierEnum.FREE
        ..method = SubscribeRequestMethodEnum.MTN_MOMO),
    );
  });

  setUp(() {
    dioClient = MockDioClient();
    apiClient = MockApiClient();
    api = MockSubscriptionsApi();
    cache = MockHiveCache();

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getSubscriptionsApi).thenReturn(api);
    when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
    when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);

    repository = SubscriptionRepository(dioClient: dioClient, cache: cache);
  });

  group('myPlan', () {
    test('maps the tier and period', () async {
      final end = DateTime.utc(2026, 9, 1);
      when(() => api.mySubscription()).thenAnswer(
        (_) async => ok(
          SubscriptionResponse((b) => b
            ..tier = SubscriptionResponseTierEnum.PRO
            ..periodEnd = end
            ..activeListingLimit = 10),
        ),
      );

      final plan = await repository.myPlan();

      expect(plan.tier, SubscriptionTier.pro);
      expect(plan.periodEnd, end);
      expect(plan.activeListingLimit, 10);
    });

    test('treats a missing body as the free tier, not an error', () async {
      when(() => api.mySubscription())
          .thenAnswer((_) async => okEmpty<SubscriptionResponse>());

      expect((await repository.myPlan()).tier, SubscriptionTier.gratuit);
    });

    test('maps an unrecognised tier down to Gratuit', () async {
      when(() => api.mySubscription()).thenAnswer(
        (_) async => ok(SubscriptionResponse((b) => b..tier = null)),
      );

      // Never guess upward — an unknown tier must not unlock paid features.
      expect((await repository.myPlan()).tier, SubscriptionTier.gratuit);
    });
  });

  group('tiers', () {
    test('sorts by rank, cheapest first', () async {
      when(() => api.tiers()).thenAnswer(
        (_) async => ok(
          BuiltList<TierInfo>([
            TierInfo((b) => b
              ..tier = TierInfoTierEnum.PRO_PLUS
              ..rank = 3
              ..monthlyPrice = 15000),
            TierInfo((b) => b
              ..tier = TierInfoTierEnum.FREE
              ..rank = 0
              ..monthlyPrice = 0),
            TierInfo((b) => b
              ..tier = TierInfoTierEnum.BASIC_PLUS
              ..rank = 1
              ..monthlyPrice = 5000),
          ]),
        ),
      );

      final options = await repository.tiers();

      expect(
        options.map((o) => o.tier),
        [
          SubscriptionTier.gratuit,
          SubscriptionTier.basicPlus,
          SubscriptionTier.proPlus,
        ],
      );
    });
  });

  group('subscribe', () {
    void stubSubscribe(PaymentInitiatedResponse response) {
      when(
        () => api.subscribe(
          subscribeRequest: any(named: 'subscribeRequest'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer((_) async => ok(response));
    }

    test('sends the tier, method and idempotency key', () async {
      stubSubscribe(
        PaymentInitiatedResponse((b) => b
          ..paymentId = 'pay-1'
          ..amount = 5000
          ..status = PaymentInitiatedResponseStatusEnum.PENDING),
      );

      await repository.subscribe(
        tier: SubscriptionTier.basicPlus,
        method: PaymentMethod.orangeMoney,
        idempotencyKey: 'key-1',
      );

      final captured = verify(
        () => api.subscribe(
          subscribeRequest: captureAny(named: 'subscribeRequest'),
          idempotencyKey: captureAny(named: 'idempotencyKey'),
        ),
      ).captured;

      final request = captured[0] as SubscribeRequest;
      expect(request.tier, SubscribeRequestTierEnum.BASIC_PLUS);
      expect(request.method, SubscribeRequestMethodEnum.ORANGE_MONEY);
      expect(captured[1], 'key-1');
    });

    test('persists the payment so the receipt stays reachable', () async {
      stubSubscribe(
        PaymentInitiatedResponse((b) => b
          ..paymentId = 'pay-42'
          ..amount = 5000),
      );

      await repository.subscribe(
        tier: SubscriptionTier.basicPlus,
        method: PaymentMethod.mtnMomo,
        idempotencyKey: 'key-1',
      );

      final stored = verify(
        () => cache.put(StorageKeys.subscriptionBox, 'payments', captureAny()),
      ).captured.single as Map<String, dynamic>;
      expect((stored['items'] as List).single['paymentId'], 'pay-42');
    });

    test('throws when the backend returns no payment', () async {
      when(
        () => api.subscribe(
          subscribeRequest: any(named: 'subscribeRequest'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer((_) async => okEmpty<PaymentInitiatedResponse>());

      expect(
        () => repository.subscribe(
          tier: SubscriptionTier.pro,
          method: PaymentMethod.mtnMomo,
          idempotencyKey: 'key-1',
        ),
        throwsA(isA<StateError>()),
      );
    });
  });

  group('local payment history', () {
    test('de-duplicates by paymentId, newest first', () async {
      const first = PaymentAttempt(
        paymentId: 'pay-1',
        tier: SubscriptionTier.basicPlus,
      );
      const second = PaymentAttempt(
        paymentId: 'pay-2',
        tier: SubscriptionTier.pro,
      );

      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn({
        'items': [first.toCache()],
      });

      await repository.rememberPayment(second);

      final stored = verify(
        () => cache.put(StorageKeys.subscriptionBox, 'payments', captureAny()),
      ).captured.single as Map<String, dynamic>;
      final ids =
          (stored['items'] as List).map((e) => e['paymentId']).toList();
      expect(ids, ['pay-2', 'pay-1']);
    });

    test('ignores a payment with no id — it has no receipt handle', () async {
      await repository.rememberPayment(
        const PaymentAttempt(paymentId: '', tier: SubscriptionTier.pro),
      );

      verifyNever(() => cache.put(any(), any(), any()));
    });

    test('reads back what it wrote', () {
      const attempt = PaymentAttempt(
        paymentId: 'pay-9',
        tier: SubscriptionTier.proPlus,
        amount: 15000,
      );
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn({
        'items': [attempt.toCache()],
      });

      final payments = repository.knownPayments();

      expect(payments.single.paymentId, 'pay-9');
      expect(payments.single.tier, SubscriptionTier.proPlus);
      expect(payments.single.amount, 15000);
    });
  });

  test('receiptUrl returns the signed download link', () async {
    when(() => api.receipt(id: 'pay-1')).thenAnswer(
      (_) async => ok(
        ReceiptResponse((b) => b..downloadUrl = 'https://r2/receipt.pdf'),
      ),
    );

    expect(await repository.receiptUrl('pay-1'), 'https://r2/receipt.pdf');
  });
}
