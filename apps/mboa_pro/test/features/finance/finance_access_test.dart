import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/notifications_bootstrap.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/finance/bloc/finance_access_bloc.dart';
import 'package:mboa_pro/features/finance/data/finance_access_repository.dart';
import 'package:mboa_pro/features/finance/models/finance_access.dart';
import 'package:mboa_pro/features/finance/ui/finance_page.dart';
import 'package:mboa_pro/features/finance/ui/widgets/finance_bits.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';
import '../../_helpers/mocks/mocks.dart';

class MockSubscriptionRepository extends Mock implements SubscriptionRepository {}

class MockFinanceAccessRepository extends Mock implements FinanceAccessRepository {}

class MockFinanceAccessBloc extends MockBloc<FinanceAccessEvent, FinanceAccessState> implements FinanceAccessBloc {}

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// RM-M13-09 — one subscription: the finance tools (M24–M26) come with the
/// plans that include them, Pro and Pro+ today, and are sold nowhere else.
void main() {
  final end = DateTime(2026, 11, 22);

  // The server's plans, cheapest first — prices and inclusion are the admin's.
  const tiers = [
    TierOption(tier: SubscriptionTier.gratuit, rank: 0, monthlyPrice: 0),
    TierOption(tier: SubscriptionTier.basicPlus, rank: 1, monthlyPrice: 3000),
    TierOption(tier: SubscriptionTier.pro, rank: 2, monthlyPrice: 7500, includesFinance: true),
    TierOption(tier: SubscriptionTier.proPlus, rank: 3, monthlyPrice: 10000, includesFinance: true),
  ];

  group('where the landlord stands', () {
    late MockSubscriptionRepository subscriptions;
    late MockHiveCache cache;
    late FinanceAccessRepository repository;
    final stored = <String, Map<String, dynamic>>{};

    setUp(() {
      subscriptions = MockSubscriptionRepository();
      cache = MockHiveCache();
      stored.clear();
      when(() => subscriptions.tiers()).thenAnswer((_) async => tiers);
      when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
        stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
      });
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
      repository = FinanceAccessRepository(subscriptions: subscriptions, cache: cache);
    });

    test('Basic+ reads what it held, writes nothing — and is pointed at Pro, at its price', () async {
      when(() => subscriptions.myPlan())
          .thenAnswer((_) async => SubscriptionPlan(tier: SubscriptionTier.basicPlus, periodEnd: DateTime(2099)));

      final access = (await repository.access()).value;

      expect(access.canWrite, isFalse);
      expect(access.includedFromTier, SubscriptionTier.pro);
      expect(access.includedFromPrice, 7500);
    });

    test('Pro writes, until its period ends; lapsed, it is Gratuit and writes no more', () async {
      when(() => subscriptions.myPlan())
          .thenAnswer((_) async => SubscriptionPlan(tier: SubscriptionTier.pro, periodEnd: DateTime(2099)));
      expect((await repository.access()).value.canWrite, isTrue);

      when(() => subscriptions.myPlan())
          .thenAnswer((_) async => SubscriptionPlan(tier: SubscriptionTier.pro, periodEnd: DateTime(2020)));
      final lapsed = (await repository.access()).value;
      expect(lapsed.canWrite, isFalse);
      expect(lapsed.tier, SubscriptionTier.gratuit);
    });

    test('offline: the last read', () async {
      when(() => subscriptions.myPlan())
          .thenAnswer((_) async => SubscriptionPlan(tier: SubscriptionTier.proPlus, periodEnd: DateTime(2099)));
      final online = (await repository.access()).value;

      when(() => subscriptions.myPlan()).thenThrow(Exception('offline'));
      final offline = await repository.access();
      expect(offline.fromCache, isTrue);
      expect(offline.value, online);
    });

    blocTest<FinanceAccessBloc, FinanceAccessState>(
      'the bloc says it as read',
      setUp: () {
        when(() => subscriptions.myPlan())
            .thenAnswer((_) async => SubscriptionPlan(tier: SubscriptionTier.pro, periodEnd: DateTime(2099)));
      },
      build: () => FinanceAccessBloc(repository: repository),
      act: (bloc) => bloc.add(const FinanceAccessRequested()),
      expect: () => [
        isA<FinanceAccessReady>().having((s) => s.access.canWrite, 'canWrite', isTrue),
      ],
    );
  });

  test('the add-on is sold no more: buying it never reaches the server', () async {
    final dioClient = MockDioClient();
    final repository = SubscriptionRepository(dioClient: dioClient);
    await expectLater(
      repository.subscribe(purchase: const FinanceAddonPurchase(), method: PaymentMethod.mtnMomo, idempotencyKey: 'k'),
      throwsUnsupportedError,
    );
    verifyNever(() => dioClient.api);
  });

  group('N-26, an old push', () {
    late MockAppRouter router;

    setUpAll(() => registerFallbackValue(_FakeRoute()));

    setUp(() {
      router = MockAppRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => router.navigate(any())).thenAnswer((_) async {});
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    });

    tearDown(getIt.reset);

    test('still opens « Gestion financière »', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);
      routeNotificationTap(router, const PushMessage(type: PushType.financeAddon));
      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, FinanceRoute.name);
    });
  });

  group('the hub', () {
    late MockFinanceAccessBloc bloc;
    late int plans;
    late int opened;

    setUpAll(loadBrandFonts);

    setUp(() {
      bloc = MockFinanceAccessBloc();
      plans = 0;
      opened = 0;
    });

    Future<void> pump(WidgetTester tester, FinanceAccess access, {bool offline = false}) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => bloc.state).thenReturn(FinanceAccessReady(access, isOffline: offline));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<FinanceAccessBloc>.value(
            value: bloc,
            child: FinanceView(
              onPlans: () => plans++,
              onInvoices: (_) => opened++,
              onLedger: (_) => opened++,
              onProviders: (_) => opened++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    const basic = FinanceAccess(
      tier: SubscriptionTier.basicPlus,
      includedFromTier: SubscriptionTier.pro,
      includedFromPrice: 7500,
    );

    testWidgets('not in the plan: where it is, at what price, one way there — what was noted still opens',
        (tester) async {
      await pump(tester, basic);

      expect(find.textContaining('inclus dès la formule Pro'), findsOneWidget);
      expect(find.textContaining(RegExp(r'Formule Pro : 7.500 FCFA par mois')), findsOneWidget);
      await tester.tap(find.text('Registre'));
      expect(opened, 1);
      await tester.tap(find.text('Voir les formules'));
      expect(plans, 1);
      await tester.pumpAndSettle();
      await expectLater(find.byType(FinanceView), matchesGoldenFile('goldens/finance_not_included.png'));
    });

    testWidgets('in the plan: until when, the parts open, no bar', (tester) async {
      await pump(
        tester,
        FinanceAccess(tier: SubscriptionTier.pro, periodEnd: end, includesFinance: true),
      );

      expect(find.text('Formule Pro · jusqu\'au 22 nov. 2026'), findsOneWidget);
      expect(find.byType(Button), findsNothing);
      await tester.tap(find.text('Factures'));
      expect(opened, 1);
      await expectLater(find.byType(FinanceView), matchesGoldenFile('goldens/finance_included.png'));
    });

    testWidgets('offline: no plans to go to', (tester) async {
      await pump(tester, basic, offline: true);

      expect(find.byType(Button), findsNothing);
      expect(find.textContaining('Hors ligne'), findsOneWidget);
    });

    testWidgets('a list never held: the plans, never « Réessayer »', (tester) async {
      var retried = 0;
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Scaffold(body: FinanceLoadFailure(planRequired: true, onRetry: () => retried++)),
        ),
      );

      expect(find.text('Le suivi financier est inclus dès la formule Pro.'), findsOneWidget);
      expect(find.text('Voir les formules'), findsOneWidget);
      expect(find.text('Réessayer'), findsNothing);
      expect(retried, 0);
    });
  });
}
