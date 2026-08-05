import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/mocks/mocks.dart';

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
  late SubscriptionRepository repository;

  setUpAll(() {
    registerFallbackValue(Pageable());
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

    when(() => dioClient.api).thenReturn(apiClient);
    when(apiClient.getSubscriptionsApi).thenReturn(api);
    repository = SubscriptionRepository(dioClient: dioClient);
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

  group('payment history', () {
    test('maps the server list, newest first', () async {
      when(() => api.listMyPayments(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => ok(
          PageResponsePaymentSummary((b) => b
            ..content = ListBuilder([
              PaymentSummary((s) => s
                ..paymentId = 'pay-2'
                ..tier = PaymentSummaryTierEnum.PRO
                ..amount = 10000
                ..method = PaymentSummaryMethodEnum.MTN_MOMO
                ..status = PaymentSummaryStatusEnum.CONFIRMED
                ..hasReceipt = true),
              PaymentSummary((s) => s
                ..paymentId = 'pay-1'
                ..tier = PaymentSummaryTierEnum.BASIC_PLUS
                ..status = PaymentSummaryStatusEnum.FAILED
                ..hasReceipt = false),
            ])
            ..totalElements = 2),
        ),
      );

      final payments = await repository.payments();

      expect(payments.map((p) => p.paymentId), ['pay-2', 'pay-1']);
      expect(payments.first.tier, SubscriptionTier.pro);
      expect(payments.first.status, PaymentStatus.confirmed);
      // hasReceipt drives whether a download affordance is shown at all.
      expect(payments.first.hasReceipt, isTrue);
      expect(payments.last.hasReceipt, isFalse);
    });

    test('reads one payment as the settlement source of truth', () async {
      when(() => api.getPayment(id: 'pay-1')).thenAnswer(
        (_) async => ok(
          PaymentSummary((s) => s
            ..paymentId = 'pay-1'
            ..tier = PaymentSummaryTierEnum.PRO
            ..status = PaymentSummaryStatusEnum.FAILED),
        ),
      );

      // The tier alone could never express this — it just stays unchanged.
      expect((await repository.payment('pay-1'))?.status, PaymentStatus.failed);
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
