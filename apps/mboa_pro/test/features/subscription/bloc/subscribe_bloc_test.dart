import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/subscription/bloc/subscribe_bloc.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

/// Comfortably longer than the bloc's poll timeout under test.
const _pollWait = Duration(milliseconds: 300);

void main() {
  late MockSubscriptionRepository repository;

  const tier = SubscriptionTier.basicPlus;
  const method = PaymentMethod.mtnMomo;

  const pending = PaymentAttempt(paymentId: 'pay-1', tier: tier);
  const confirmed = PaymentAttempt(
    paymentId: 'pay-1',
    tier: tier,
    status: PaymentStatus.confirmed,
  );

  const paidPlan = SubscriptionPlan(tier: tier);

  setUpAll(() {
    registerFallbackValue(SubscriptionTier.gratuit);
    registerFallbackValue(PaymentMethod.mtnMomo);
  });

  setUp(() {
    repository = MockSubscriptionRepository();
    when(() => repository.myPlan()).thenAnswer((_) async => paidPlan);
    // Default: still settling.
    when(() => repository.payment(any())).thenAnswer((_) async => pending);
  });

  void stubSubscribe(PaymentAttempt attempt) {
    when(
      () => repository.subscribe(
        tier: any(named: 'tier'),
        method: any(named: 'method'),
        idempotencyKey: any(named: 'idempotencyKey'),
      ),
    ).thenAnswer((_) async => attempt);
  }

  SubscribeBloc build() => SubscribeBloc(
        repository: repository,
        pollInterval: const Duration(milliseconds: 5),
        pollTimeout: const Duration(milliseconds: 40),
      );

  group('happy paths', () {
    blocTest<SubscribeBloc, SubscribeState>(
      'skips polling when the provider settles synchronously',
      setUp: () {
        stubSubscribe(confirmed);
        when(() => repository.myPlan()).thenAnswer((_) async => paidPlan);
      },
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      expect: () => const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeConfirmed(attempt: confirmed, plan: paidPlan),
      ],
    );

    blocTest<SubscribeBloc, SubscribeState>(
      'polls the payment and confirms once it settles',
      setUp: () {
        stubSubscribe(pending);
        // Pending on the first poll, confirmed on the next — the webhook.
        var calls = 0;
        when(() => repository.payment(any())).thenAnswer((_) async {
          calls++;
          return calls > 1 ? confirmed : pending;
        });
      },
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      wait: _pollWait,
      expect: () => const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeAwaitingConfirmation(attempt: pending),
        SubscribeConfirmed(attempt: confirmed, plan: paidPlan),
      ],
    );

    blocTest<SubscribeBloc, SubscribeState>(
      'reports a rejection immediately instead of timing out',
      setUp: () {
        stubSubscribe(pending);
        // Watching the tier could never distinguish this from "not yet".
        when(() => repository.payment(any())).thenAnswer(
          (_) async => const PaymentAttempt(
            paymentId: 'pay-1',
            tier: tier,
            status: PaymentStatus.failed,
          ),
        );
      },
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      wait: _pollWait,
      skip: 2,
      expect: () => [isA<SubscribeFailure>()],
    );
  });

  group('the webhook does not land in time', () {
    blocTest<SubscribeBloc, SubscribeState>(
      'hands off to the notification path rather than failing',
      setUp: () => stubSubscribe(pending),
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      wait: _pollWait,
      // RM-M13-05 allows 15 minutes; the payment may still succeed, so this is
      // explicitly not a failure state.
      expect: () => const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeAwaitingConfirmation(attempt: pending),
        SubscribePendingHandoff(attempt: pending),
      ],
    );

    blocTest<SubscribeBloc, SubscribeState>(
      'keeps polling through a failed read',
      setUp: () {
        stubSubscribe(pending);
        var calls = 0;
        when(() => repository.payment(any())).thenAnswer((_) async {
          calls++;
          if (calls == 1) throw Exception('flaky network');
          return confirmed;
        });
      },
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      wait: _pollWait,
      expect: () => const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeAwaitingConfirmation(attempt: pending),
        SubscribeConfirmed(attempt: confirmed, plan: paidPlan),
      ],
    );
  });

  group('failures', () {
    blocTest<SubscribeBloc, SubscribeState>(
      'reports a failed initiation with the inputs needed to retry',
      setUp: () {
        when(
          () => repository.subscribe(
            tier: any(named: 'tier'),
            method: any(named: 'method'),
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenThrow(Exception('boom'));
      },
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      expect: () => const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeFailure(tier: tier, method: method),
      ],
    );

    blocTest<SubscribeBloc, SubscribeState>(
      'does not poll when the provider rejects the payment outright',
      setUp: () => stubSubscribe(
        const PaymentAttempt(
          paymentId: 'pay-1',
          tier: tier,
          status: PaymentStatus.failed,
        ),
      ),
      build: build,
      act: (bloc) =>
          bloc.add(const SubscribeRequested(tier: tier, method: method)),
      verify: (_) => verifyNever(() => repository.payment(any())),
    );
  });

  group('idempotency — a retry must not double-charge', () {
    test('reuses the key when retrying the same purchase', () async {
      when(
        () => repository.subscribe(
          tier: any(named: 'tier'),
          method: any(named: 'method'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenThrow(Exception('boom'));

      final bloc = build()
        ..add(const SubscribeRequested(tier: tier, method: method));
      await expectLater(
        bloc.stream.firstWhere((s) => s is SubscribeFailure),
        completes,
      );

      bloc.add(const SubscribeRetryRequested());
      await expectLater(
        bloc.stream.firstWhere((s) => s is SubscribeFailure),
        completes,
      );

      final keys = verify(
        () => repository.subscribe(
          tier: any(named: 'tier'),
          method: any(named: 'method'),
          idempotencyKey: captureAny(named: 'idempotencyKey'),
        ),
      ).captured;

      expect(keys, hasLength(2));
      expect(keys.first, keys.last, reason: 'a retry is the same charge');
      await bloc.close();
    });

    test('uses a fresh key for a genuinely new purchase', () async {
      stubSubscribe(confirmed);
      when(() => repository.myPlan()).thenAnswer((_) async => paidPlan);

      final bloc = build()
        ..add(const SubscribeRequested(tier: tier, method: method));
      await expectLater(
        bloc.stream.firstWhere((s) => s is SubscribeConfirmed),
        completes,
      );

      bloc.add(
        const SubscribeRequested(
          tier: SubscriptionTier.pro,
          method: PaymentMethod.orangeMoney,
        ),
      );
      await expectLater(
        bloc.stream.firstWhere((s) => s is SubscribeConfirmed),
        completes,
      );

      final keys = verify(
        () => repository.subscribe(
          tier: any(named: 'tier'),
          method: any(named: 'method'),
          idempotencyKey: captureAny(named: 'idempotencyKey'),
        ),
      ).captured;

      expect(keys.first, isNot(keys.last));
      await bloc.close();
    });

    test('newIdempotencyKey is unique per call', () {
      final keys = List.generate(
        50,
        (_) => SubscriptionRepository.newIdempotencyKey(),
      );
      expect(keys.toSet(), hasLength(50));
    });
  });
}
