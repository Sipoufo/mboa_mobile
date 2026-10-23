import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/notifications_bootstrap.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/finance/bloc/finance_addon_bloc.dart';
import 'package:mboa_pro/features/finance/data/finance_addon_repository.dart';
import 'package:mboa_pro/features/finance/models/finance_addon.dart';
import 'package:mboa_pro/features/finance/ui/finance_page.dart';
import 'package:mboa_pro/features/subscription/bloc/subscribe_bloc.dart';
import 'package:mboa_pro/features/subscription/data/subscription_repository.dart';
import 'package:mboa_pro/features/subscription/models/subscription_models.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';
import '../../_helpers/mocks/mocks.dart';

class MockFinanceAddOnApi extends Mock implements FinanceAddOnApi {}

class MockFinanceAddonRepository extends Mock implements FinanceAddonRepository {}

class MockSubscriptionRepository extends Mock implements SubscriptionRepository {}

class MockFinanceAddonBloc extends MockBloc<FinanceAddonEvent, FinanceAddonState> implements FinanceAddonBloc {}

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

class _FakeAddonRequest extends Fake implements SubscribeAddonRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

/// RM-M13-09 — « Gestion financière », the paid add-on of M24–M26.
void main() {
  final end = DateTime(2026, 11, 22);

  group('the add-on', () {
    test('running writes; held once, it still reads', () {
      expect(const FinanceAddon().canRead, isFalse);
      expect(const FinanceAddon(everSubscribed: true).canRead, isTrue);
      expect(const FinanceAddon(everSubscribed: true).canWrite, isFalse);
      expect(const FinanceAddon(active: true, everSubscribed: true).canWrite, isTrue);
    });

    test('kept for offline as read', () {
      final addon = FinanceAddon(active: true, periodEnd: end, everSubscribed: true, monthlyPrice: 5000);
      expect(FinanceAddon.fromCache(addon.toCache()), addon);
      expect(FinanceAddon.fromCache('junk'), isNull);
    });

    test('the repository reads the server, and the last read offline', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final api = MockFinanceAddOnApi();
      final cache = MockHiveCache();
      final stored = <String, Map<String, dynamic>>{};
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getFinanceAddOnApi).thenReturn(api);
      when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
        stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
      });
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
      when(api.getFinanceAddon).thenAnswer(
        (_) async => _ok(FinanceAddonResponse((b) => b
          ..active = true
          ..periodEnd = DateTime.utc(2026, 11, 22)
          ..everSubscribed = true
          ..monthlyPrice = 5000)),
      );
      final repository = FinanceAddonRepository(dioClient: dioClient, cache: cache);

      final online = await repository.addon();
      expect(online.value.active, isTrue);
      expect(online.value.monthlyPrice, 5000);
      expect(stored.keys, ['addon']);

      when(api.getFinanceAddon).thenThrow(DioException(requestOptions: RequestOptions(path: '/x')));
      final offline = await repository.addon();
      expect(offline.fromCache, isTrue);
      expect(offline.value.active, isTrue);
    });

    late MockFinanceAddonRepository repository;

    blocTest<FinanceAddonBloc, FinanceAddonState>(
      'the bloc reads it; nothing at all is a failure',
      setUp: () {
        repository = MockFinanceAddonRepository();
        when(repository.addon).thenThrow(Exception('offline'));
      },
      build: () => FinanceAddonBloc(repository: repository),
      act: (bloc) => bloc.add(const FinanceAddonRequested()),
      expect: () => const [FinanceAddonFailure()],
    );
  });

  group('buying it — the subscription checkout', () {
    test('goes to its own route, with the Mobile Money chosen', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final api = MockFinanceAddOnApi();
      registerFallbackValue(_FakeAddonRequest());
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getFinanceAddOnApi).thenReturn(api);
      when(
        () => api.subscribeFinanceAddon(
          subscribeAddonRequest: any(named: 'subscribeAddonRequest'),
          idempotencyKey: any(named: 'idempotencyKey'),
        ),
      ).thenAnswer(
        (_) async => _ok(PaymentInitiatedResponse((b) => b
          ..paymentId = 'pay-9'
          ..status = PaymentInitiatedResponseStatusEnum.PENDING)),
      );

      final attempt = await SubscriptionRepository(dioClient: dioClient).subscribe(
        purchase: const FinanceAddonPurchase(),
        method: PaymentMethod.orangeMoney,
        idempotencyKey: 'key-9',
      );

      expect(attempt.purchase, const FinanceAddonPurchase());
      final captured = verify(
        () => api.subscribeFinanceAddon(
          subscribeAddonRequest: captureAny(named: 'subscribeAddonRequest'),
          idempotencyKey: 'key-9',
        ),
      ).captured.single as SubscribeAddonRequest;
      expect(captured.method, SubscribeAddonRequestMethodEnum.ORANGE_MONEY);
    });

    late MockSubscriptionRepository subscriptions;

    blocTest<SubscribeBloc, SubscribeState>(
      'confirmed: no plan to read — the add-on changes no tier',
      setUp: () {
        subscriptions = MockSubscriptionRepository();
        registerFallbackValue(const FinanceAddonPurchase());
        registerFallbackValue(PaymentMethod.mtnMomo);
        when(
          () => subscriptions.subscribe(
            purchase: any(named: 'purchase'),
            method: any(named: 'method'),
            idempotencyKey: any(named: 'idempotencyKey'),
          ),
        ).thenAnswer(
          (_) async => const PaymentAttempt(
            paymentId: 'pay-9',
            purchase: FinanceAddonPurchase(),
            status: PaymentStatus.confirmed,
          ),
        );
      },
      build: () => SubscribeBloc(repository: subscriptions),
      act: (bloc) => bloc.add(const SubscribeRequested(purchase: FinanceAddonPurchase(), method: PaymentMethod.mtnMomo)),
      expect: () => const [
        SubscribeInitiating(purchase: FinanceAddonPurchase(), method: PaymentMethod.mtnMomo),
        SubscribeConfirmed(
          attempt: PaymentAttempt(paymentId: 'pay-9', purchase: FinanceAddonPurchase(), status: PaymentStatus.confirmed),
        ),
      ],
      verify: (_) => verifyNever(subscriptions.myPlan),
    );
  });

  group('N-26, the push', () {
    late MockAppRouter router;

    setUpAll(() => registerFallbackValue(_FakeRoute()));

    setUp(() {
      router = MockAppRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => router.navigate(any())).thenAnswer((_) async {});
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    });

    tearDown(getIt.reset);

    test('opens « Gestion financière »', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);
      routeNotificationTap(router, const PushMessage(type: PushType.financeAddon));
      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, FinanceRoute.name);
    });

    test('an agent has none: the shell', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.agent);
      routeNotificationTap(router, const PushMessage(type: PushType.financeAddon));
      verifyNever(() => router.push<Object?>(any()));
    });
  });

  group('the hub', () {
    late MockFinanceAddonBloc bloc;
    late int bought;
    late int opened;

    setUpAll(loadBrandFonts);

    setUp(() {
      bloc = MockFinanceAddonBloc();
      bought = 0;
      opened = 0;
    });

    Future<void> pump(WidgetTester tester, FinanceAddon addon, {bool offline = false}) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => bloc.state).thenReturn(FinanceAddonReady(addon, isOffline: offline));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<FinanceAddonBloc>.value(
            value: bloc,
            child: FinanceView(
              onBuy: () => bought++,
              onInvoices: (_) => opened++,
              onLedger: (_) => opened++,
              onProviders: (_) => opened++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('never held: what it is, its price, one way in — the parts are not open yet', (tester) async {
      await pump(tester, const FinanceAddon(monthlyPrice: 5000));

      expect(find.textContaining('Aucun argent ne transite par Mboa'), findsOneWidget);
      await tester.tap(find.text('Registre'));
      expect(opened, 0);
      await tester.tap(find.text('Activer pour 5 000 FCFA'));
      expect(bought, 1);
      await tester.pumpAndSettle();
      await expectLater(find.byType(FinanceView), matchesGoldenFile('goldens/finance_new.png'));
    });

    testWidgets('running: until when, the parts open, no bar — extending is possible, not expected', (tester) async {
      await pump(tester, FinanceAddon(active: true, everSubscribed: true, periodEnd: end, monthlyPrice: 5000));

      expect(find.text('Active jusqu\'au 22 novembre 2026'), findsOneWidget);
      expect(find.byType(Button), findsNothing);
      await tester.tap(find.text('Registre'));
      expect(opened, 1);
      await tester.tap(find.text('Prolonger de 30 jours'));
      expect(bought, 1);
      await tester.pumpAndSettle();
      await expectLater(find.byType(FinanceView), matchesGoldenFile('goldens/finance_active.png'));
    });

    testWidgets('expired: what was noted stays readable; reactivating is the one action', (tester) async {
      await pump(tester, FinanceAddon(everSubscribed: true, periodEnd: end, monthlyPrice: 5000));

      expect(find.text('Expirée le 22 novembre 2026'), findsOneWidget);
      expect(find.textContaining('reste consultable et exportable'), findsOneWidget);
      await tester.tap(find.text('Factures'));
      expect(opened, 1);
      expect(find.text('Réactiver pour 5 000 FCFA'), findsOneWidget);
    });

    testWidgets('offline: nothing to buy', (tester) async {
      await pump(tester, const FinanceAddon(monthlyPrice: 5000), offline: true);

      expect(find.byType(Button), findsNothing);
      expect(find.textContaining('Hors ligne'), findsOneWidget);
    });
  });
}
