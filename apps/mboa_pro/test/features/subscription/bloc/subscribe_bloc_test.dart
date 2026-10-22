import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/subscription/bloc/subscribe_bloc.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

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

  // Production timings: nothing below runs on the wall clock, so there is no
  // reason to shrink them.
  SubscribeBloc build() => SubscribeBloc(repository: repository);

  /// Runs one purchase to the end of the poll window on fake time and returns
  /// every state it emitted.
  ///
  /// The poll's delays and its deadline (`clock.now()`) both run on fake time,
  /// so how many reads fit before the deadline no longer depends on how loaded
  /// the machine is. On real timers a starved 5 ms delay could overrun a 40 ms
  /// deadline and hand off before the second read.
  List<SubscribeState> purchaseOnFakeTime() => fakeAsync((async) {
        final bloc = build();
        final states = <SubscribeState>[];
        bloc.stream.listen(states.add);
        bloc.add(const SubscribeRequested(tier: tier, method: method));
        async.elapse(bloc.pollTimeout + bloc.pollInterval);
        unawaited(bloc.close());
        async.flushMicrotasks();
        return states;
      });

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

    test('polls the payment and confirms once it settles', () {
      stubSubscribe(pending);
      // Pending on the first poll, confirmed on the next — the webhook.
      var calls = 0;
      when(() => repository.payment(any())).thenAnswer((_) async {
        calls++;
        return calls > 1 ? confirmed : pending;
      });

      expect(purchaseOnFakeTime(), const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeAwaitingConfirmation(attempt: pending),
        SubscribeConfirmed(attempt: confirmed, plan: paidPlan),
      ]);
      verify(() => repository.payment('pay-1')).called(2);
    });

    test('reports a rejection immediately instead of timing out', () {
      stubSubscribe(pending);
      // Watching the tier could never distinguish this from "not yet".
      when(() => repository.payment(any())).thenAnswer(
        (_) async => const PaymentAttempt(
          paymentId: 'pay-1',
          tier: tier,
          status: PaymentStatus.failed,
        ),
      );

      expect(purchaseOnFakeTime().skip(2), [isA<SubscribeFailure>()]);
      verify(() => repository.payment('pay-1')).called(1);
    });

    test(
      'a refund settles the payment; it is not something still to wait for',
      () {
        stubSubscribe(pending);
        // REFUNDED arrived with the 2026-10 spec. Before it was mapped, the
        // catch-all read it as `pending`: the bloc polled it to the deadline
        // and then promised a notification for a plan that was never going to
        // activate.
        when(() => repository.payment(any())).thenAnswer(
          (_) async => const PaymentAttempt(
            paymentId: 'pay-1',
            tier: tier,
            status: PaymentStatus.refunded,
          ),
        );

        expect(purchaseOnFakeTime().skip(2), [isA<SubscribeFailure>()]);
        verify(() => repository.payment('pay-1')).called(1);
      },
    );
  });

  group('the webhook does not land in time', () {
    test('hands off to the notification path rather than failing', () {
      stubSubscribe(pending);

      // RM-M13-05 allows 15 minutes; the payment may still succeed, so this is
      // explicitly not a failure state.
      expect(purchaseOnFakeTime(), const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeAwaitingConfirmation(attempt: pending),
        SubscribePendingHandoff(attempt: pending),
      ]);
      // One read every 3 s for 90 s, then it stops — it does not spin.
      verify(() => repository.payment('pay-1')).called(30);
    });

    test('keeps polling through a failed read', () {
      stubSubscribe(pending);
      var calls = 0;
      when(() => repository.payment(any())).thenAnswer((_) async {
        calls++;
        if (calls == 1) throw Exception('flaky network');
        return confirmed;
      });

      expect(purchaseOnFakeTime(), const [
        SubscribeInitiating(tier: tier, method: method),
        SubscribeAwaitingConfirmation(attempt: pending),
        SubscribeConfirmed(attempt: confirmed, plan: paidPlan),
      ]);
      verify(() => repository.payment('pay-1')).called(2);
    });
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
