import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/features/subscription/bloc/subscription_bloc.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockSubscriptionRepository extends Mock
    implements SubscriptionRepository {}

void main() {
  late MockSubscriptionRepository repository;

  final paid = SubscriptionPlan(
    tier: SubscriptionTier.pro,
    periodEnd: DateTime.now().add(const Duration(days: 20)),
    activeListingLimit: 10,
  );

  setUp(() => repository = MockSubscriptionRepository());

  SubscriptionBloc build() => SubscriptionBloc(repository: repository);

  blocTest<SubscriptionBloc, SubscriptionState>(
    'emits [loading, ready] with the plan',
    setUp: () => when(repository.myPlan).thenAnswer((_) async => paid),
    build: build,
    act: (bloc) => bloc.add(const SubscriptionLoadRequested()),
    expect: () => [const SubscriptionLoadInProgress(), SubscriptionReady(paid)],
  );

  blocTest<SubscriptionBloc, SubscriptionState>(
    'falls back to Gratuit when the load fails, and flags it',
    setUp: () => when(repository.myPlan).thenThrow(Exception('offline')),
    build: build,
    act: (bloc) => bloc.add(const SubscriptionLoadRequested()),
    expect: () => const [
      SubscriptionLoadInProgress(),
      SubscriptionReady(SubscriptionPlan.free(), fromFallback: true),
    ],
  );

  blocTest<SubscriptionBloc, SubscriptionState>(
    'refresh re-reads without a loading flash',
    setUp: () => when(repository.myPlan).thenAnswer((_) async => paid),
    build: build,
    seed: () => const SubscriptionReady(SubscriptionPlan.free()),
    act: (bloc) => bloc.add(const SubscriptionRefreshRequested()),
    expect: () => [SubscriptionReady(paid)],
  );

  group('the tier the app gates on', () {
    test('is Gratuit until a plan is actually loaded', () {
      // A slow or failed load must never unlock a paid feature.
      expect(const SubscriptionInitial().tier, SubscriptionTier.gratuit);
      expect(const SubscriptionLoadInProgress().tier, SubscriptionTier.gratuit);
    });

    test('is the loaded tier once ready', () {
      expect(SubscriptionReady(paid).tier, SubscriptionTier.pro);
    });

    test('drops to Gratuit when the period has lapsed (RM-M13-02)', () {
      final expired = SubscriptionPlan(
        tier: SubscriptionTier.proPlus,
        periodEnd: DateTime.now().subtract(const Duration(days: 1)),
      );

      expect(expired.hasLapsed, isTrue);
      expect(SubscriptionReady(expired).tier, SubscriptionTier.gratuit);
    });

    test('a free plan without an end date has not lapsed', () {
      expect(const SubscriptionPlan.free().hasLapsed, isFalse);
    });
  });
}
