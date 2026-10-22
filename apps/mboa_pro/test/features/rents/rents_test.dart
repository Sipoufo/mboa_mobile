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
import 'package:mboa_pro/features/rents/bloc/rents_bloc.dart';
import 'package:mboa_pro/features/rents/bloc/waiting_declarations_bloc.dart';
import 'package:mboa_pro/features/rents/ui/received_declaration_page.dart';
import 'package:mboa_pro/features/rents/ui/rents_page.dart';
import 'package:mboa_pro/features/rents/ui/tenant_home_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

class MockRentsBloc extends MockBloc<RentsEvent, RentsState> implements RentsBloc {}

class MockDeclarationBloc extends MockBloc<DeclarationEvent, DeclarationState> implements DeclarationBloc {}

class MockWaitingDeclarationsBloc extends MockBloc<WaitingDeclarationsEvent, WaitingDeclarationsState>
    implements WaitingDeclarationsBloc {}

class MockHomeSpaceBloc extends MockBloc<HomeSpaceEvent, HomeSpaceState> implements HomeSpaceBloc {}

class MockStackRouter extends Mock implements StackRouter {}

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// CDC M30 — "Loyers", the landlord's side: what his tenants declared, and
/// their spaces. No add-on (RM-M30-15), no money through Mboa (RM-M30-06).
void main() {
  Declaration declared(String id, {String annonceId = 'a-1', DateTime? at, bool hasProof = true}) => Declaration(
        id: id,
        contractId: 'c-$annonceId',
        annonceId: annonceId,
        annonceTitle: annonceId == 'a-1' ? 'Studio Akwa' : 'Chambre 3',
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        dueIndexes: const [1, 2],
        amount: 300000,
        paidOn: DateTime(2026, 10, 18),
        method: RentPaymentMethod.orangeMoney,
        hasProof: hasProof,
        status: DeclarationStatus.declared,
        declaredAt: at ?? DateTime(2026, 10, 19, 9, 10),
        canConfirm: true,
        canContest: true,
      );

  Home home(String annonceId, {String tenant = 'Awa Nkeng', int overdue = 0, String? residence, String? title}) => Home(
        contractId: 'c-$annonceId',
        annonceId: annonceId,
        annonceTitle: title ?? (annonceId == 'a-1' ? 'Studio Akwa' : 'Chambre 3'),
        residenceId: residence == null ? null : 'res-$residence',
        residenceName: residence == null ? null : 'Résidence $residence',
        district: 'Akwa',
        city: 'Douala',
        tenant: ContractParticipant(displayName: tenant),
        state: HomeStage.active,
        rent: 150000,
        overdueCount: overdue,
        overdueAmount: overdue * 150000,
      );

  group('the blocs', () {
    late MockHomesRepository repository;

    setUp(() => repository = MockHomesRepository());

    blocTest<RentsBloc, RentsState>(
      'everything: the inbox and every space',
      setUp: () {
        when(() => repository.waitingDeclarations())
            .thenAnswer((_) async => Cached([declared('d-1'), declared('d-2', annonceId: 'a-2')]));
        when(() => repository.tenantHomes()).thenAnswer((_) async => Cached([home('a-1'), home('a-2')]));
      },
      build: () => RentsBloc(repository: repository),
      act: (bloc) => bloc.add(const RentsRequested()),
      expect: () => [
        const RentsLoading(),
        RentsReady(
          waiting: [declared('d-1'), declared('d-2', annonceId: 'a-2')],
          homes: [home('a-1'), home('a-2')],
          byResidence: true,
        ),
      ],
    );

    blocTest<RentsBloc, RentsState>(
      "one listing's: the server narrows the spaces, the inbox is narrowed here",
      setUp: () {
        when(() => repository.waitingDeclarations())
            .thenAnswer((_) async => Cached([declared('d-1'), declared('d-2', annonceId: 'a-2')]));
        when(() => repository.tenantHomes(annonceId: 'a-1')).thenAnswer((_) async => Cached([home('a-1')]));
      },
      build: () => RentsBloc(repository: repository, annonceId: 'a-1'),
      act: (bloc) => bloc.add(const RentsRequested()),
      verify: (bloc) {
        final state = bloc.state as RentsReady;
        expect(state.waiting.map((d) => d.id), ['d-1']);
        expect(state.homes.map((h) => h.annonceId), ['a-1']);
        expect(state.byResidence, isFalse);
        verify(() => repository.tenantHomes(annonceId: 'a-1')).called(1);
      },
    );

    blocTest<RentsBloc, RentsState>(
      "§32 — a residence's units: both narrowed by the server, and listed as units",
      setUp: () {
        when(() => repository.waitingDeclarations(residenceId: 'res-1')).thenAnswer(
          (_) async => Cached([declared('d-2', annonceId: 'a-2'), declared('d-3', annonceId: 'a-3')]),
        );
        when(() => repository.tenantHomes(residenceId: 'res-1'))
            .thenAnswer((_) async => Cached([home('a-2', residence: '1'), home('a-3', residence: '1')]));
      },
      build: () => RentsBloc(repository: repository, residenceId: 'res-1'),
      act: (bloc) => bloc.add(const RentsRequested()),
      verify: (bloc) {
        final state = bloc.state as RentsReady;
        expect(state.waiting.map((d) => d.id), ['d-2', 'd-3']);
        // Its own screen: the units, not the residence again.
        expect(state.tenants, [SingleHome(home('a-2', residence: '1')), SingleHome(home('a-3', residence: '1'))]);
      },
    );

    test('§32 — the whole list reads residence first, standalone spaces as they are, in the server\'s order', () {
      final state = RentsReady(
        homes: [
          home('a-1'),
          home('a-2', residence: 'Deido', overdue: 1),
          home('a-5', title: 'Villa Bonapriso'),
          home('a-3', residence: 'Deido'),
          home('a-4', residence: 'Akwa'),
        ],
        byResidence: true,
      );

      final tenants = state.tenants;
      expect(tenants.map((e) => e.runtimeType), [SingleHome, ResidenceHomes, SingleHome, ResidenceHomes]);
      final deido = tenants[1] as ResidenceHomes;
      expect(deido.name, 'Résidence Deido');
      expect(deido.homes.map((h) => h.annonceId), ['a-2', 'a-3']);
      expect(deido.lateCount, 1);
      expect((tenants[3] as ResidenceHomes).homes.single.annonceId, 'a-4');
    });

    blocTest<RentsBloc, RentsState>(
      'offline: the last lists read, marked',
      setUp: () {
        when(() => repository.waitingDeclarations()).thenAnswer((_) async => Cached([declared('d-1')], fromCache: true));
        when(() => repository.tenantHomes()).thenAnswer((_) async => Cached([home('a-1')]));
      },
      build: () => RentsBloc(repository: repository),
      act: (bloc) => bloc.add(const RentsRequested()),
      verify: (bloc) => expect((bloc.state as RentsReady).isOffline, isTrue),
    );

    blocTest<RentsBloc, RentsState>(
      'nothing to show: said, retryable',
      setUp: () {
        when(() => repository.waitingDeclarations()).thenThrow(Exception('offline'));
        when(() => repository.tenantHomes()).thenAnswer((_) async => Cached([home('a-1')]));
      },
      build: () => RentsBloc(repository: repository),
      act: (bloc) => bloc.add(const RentsRequested()),
      expect: () => [const RentsLoading(), const RentsFailure()],
    );

    blocTest<RentsBloc, RentsState>(
      'a refresh that fails keeps the lists on screen',
      setUp: () => when(() => repository.waitingDeclarations()).thenThrow(Exception('offline')),
      build: () => RentsBloc(repository: repository),
      seed: () => RentsReady(waiting: [declared('d-1')]),
      act: (bloc) => bloc.add(const RentsRequested()),
      expect: () => const <RentsState>[],
    );

    blocTest<WaitingDeclarationsBloc, WaitingDeclarationsState>(
      "the home's counter is the server's total",
      setUp: () => when(() => repository.waitingCount()).thenAnswer((_) async => 4),
      build: () => WaitingDeclarationsBloc(repository: repository),
      act: (bloc) => bloc.add(const WaitingDeclarationsRequested()),
      expect: () => const [WaitingDeclarationsCounted(4)],
    );

    blocTest<WaitingDeclarationsBloc, WaitingDeclarationsState>(
      'a failed read keeps the last count',
      setUp: () => when(() => repository.waitingCount()).thenThrow(Exception('offline')),
      build: () => WaitingDeclarationsBloc(repository: repository),
      seed: () => const WaitingDeclarationsCounted(2),
      act: (bloc) => bloc.add(const WaitingDeclarationsRequested()),
      expect: () => const <WaitingDeclarationsState>[],
    );
  });

  group('the screens', () {
    late MockRentsBloc bloc;
    late MockStackRouter router;
    late MockWaitingDeclarationsBloc counter;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(_FakeRoute());
      registerFallbackValue(const RentsRequested());
      registerFallbackValue(const WaitingDeclarationsRequested());
      registerFallbackValue(const HomeSpaceRequested('c'));
    });

    setUp(() {
      bloc = MockRentsBloc();
      router = MockStackRouter();
      counter = MockWaitingDeclarationsBloc();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      getIt.registerSingleton<WaitingDeclarationsBloc>(counter);
    });

    tearDown(() => getIt.reset());

    Future<void> pump(WidgetTester tester, Widget child) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: StackRouterScope(controller: router, stateHash: 0, child: child),
        ),
      );
      await tester.pumpAndSettle();
    }

    Widget view({String? title}) => BlocProvider<RentsBloc>.value(value: bloc, child: RentsView(annonceTitle: title));

    testWidgets('what waits first, as a timeline; the tenants under their tab', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(
          waiting: [declared('d-1'), declared('d-2', annonceId: 'a-2', at: DateTime(2026, 10, 17, 18), hasProof: false)],
          homes: [home('a-1'), home('a-2', tenant: 'Paul Ebodé', overdue: 2)],
        ),
      );
      await pump(tester, view());

      expect(find.text('À confirmer (2)'), findsOneWidget);
      expect(find.text('Awa Nkeng · Studio Akwa'), findsOneWidget);
      expect(find.text('Loyer · 2 échéances · Orange Money'), findsNWidgets(2));
      // One day each: the timeline's dates.
      expect(find.text('19'), findsOneWidget);
      expect(find.text('17'), findsOneWidget);
      expect(find.text('Sans justificatif'), findsOneWidget);
      // RM-M30-06 — a record of payments, never a way to pay.
      expect(find.textContaining(RegExp('payer maintenant|recharge|solde', caseSensitive: false)), findsNothing);

      await tester.tap(find.text('Locataires (2)'));
      await tester.pumpAndSettle();
      // Whose space before where: the landlord has several tenants.
      expect(find.text('Paul Ebodé · Akwa · Douala'), findsOneWidget);
      expect(find.text('2 échéances en retard'), findsOneWidget);
    });

    testWidgets('a declaration opens where it is answered; back, the lists and the counter are read again', (tester) async {
      when(() => bloc.state).thenReturn(RentsReady(waiting: [declared('d-1')]));
      await pump(tester, view());

      await tester.tap(find.text('Awa Nkeng · Studio Akwa'));
      await tester.pumpAndSettle();

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, ReceivedDeclarationRoute.name);
      expect((route.args! as ReceivedDeclarationRouteArgs).declarationId, 'd-1');
      verify(() => bloc.add(const RentsRequested())).called(1);
      verify(() => counter.add(const WaitingDeclarationsRequested())).called(1);
    });

    testWidgets("a tenant's space opens from its card", (tester) async {
      when(() => bloc.state).thenReturn(RentsReady(homes: [home('a-1')]));
      await pump(tester, view());
      await tester.tap(find.text('Locataires (1)'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Studio Akwa'));
      await tester.pumpAndSettle();

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, TenantHomeRoute.name);
      expect((route.args! as TenantHomeRouteArgs).contractId, 'c-a-1');
    });

    testWidgets("empty: said, per tab; one listing's says which", (tester) async {
      when(() => bloc.state).thenReturn(const RentsReady());
      await pump(tester, view(title: 'Studio Akwa'));

      expect(find.text('Studio Akwa'), findsOneWidget);
      expect(find.textContaining('Aucun paiement à confirmer'), findsOneWidget);
      await tester.tap(find.text('Locataires (0)'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Aucun locataire'), findsOneWidget);
    });

    testWidgets('slice E — an invoice declared paid reads as one, and is answered in the same inbox', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(
          waiting: [
            Declaration(
              id: 'd-7',
              annonceTitle: 'Studio Akwa',
              tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
              kind: DeclarationKind.invoice,
              invoiceId: 'i-1',
              amount: 12000,
              method: RentPaymentMethod.cash,
              status: DeclarationStatus.declared,
              declaredAt: DateTime(2026, 10, 21, 10),
              canConfirm: true,
            ),
          ],
        ),
      );
      await pump(tester, view());

      expect(find.text('Facture · Espèces'), findsOneWidget);
      // Not an échéance count: an invoice names none.
      expect(find.textContaining('échéance'), findsNothing);
    });

    testWidgets('offline, it says so', (tester) async {
      when(() => bloc.state).thenReturn(RentsReady(waiting: [declared('d-1')], isOffline: true));
      await pump(tester, view());

      expect(find.textContaining('Hors ligne'), findsOneWidget);
    });

    testWidgets('a failure can be retried', (tester) async {
      when(() => bloc.state).thenReturn(const RentsFailure());
      await pump(tester, view());

      await tester.tap(find.text('Réessayer'));
      verify(() => bloc.add(const RentsRequested())).called(1);
    });

    testWidgets("an answer given on the declaration tells the home's counter", (tester) async {
      final declaration = MockDeclarationBloc();
      final ready = DeclarationReady(declared('d-1'));
      whenListen(
        declaration,
        Stream.fromIterable([ready, ready.copyWith(done: DeclarationAnswer.confirmed)]),
        initialState: ready,
      );
      await pump(
        tester,
        BlocProvider<DeclarationBloc>.value(
          value: declaration,
          child: const ReceivedDeclarationPage(declarationId: 'd-1'),
        ),
      );

      verify(() => counter.add(const WaitingDeclarationsRequested())).called(1);
    });

    testWidgets("a tenant's space: nothing to declare there; a declaration opens where it is answered", (tester) async {
      final space = MockHomeSpaceBloc();
      when(() => space.state).thenReturn(
        HomeSpaceReady(home: home('a-1'), schedule: const RentSchedule(), declarations: [declared('d-1')]),
      );
      await pump(
        tester,
        BlocProvider<HomeSpaceBloc>.value(value: space, child: const TenantHomePage(contractId: 'c-a-1')),
      );

      // Declaring is the tenant's.
      expect(find.text('Déclarer'), findsNothing);
      await tester.tap(find.text('Déclarations'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DeclarationRow));
      await tester.pumpAndSettle();

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, ReceivedDeclarationRoute.name);
      expect((route.args! as ReceivedDeclarationRouteArgs).declarationId, 'd-1');
      // Back: statuses and totals read again.
      verify(() => space.add(const HomeSpaceRequested('c-a-1'))).called(1);
    });

    testWidgets('the inbox', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(
          waiting: [
            declared('d-1'),
            declared('d-3', at: DateTime(2026, 10, 19, 7, 45)),
            declared('d-2', annonceId: 'a-2', at: DateTime(2026, 10, 17, 18), hasProof: false),
          ],
          homes: [home('a-1'), home('a-2')],
        ),
      );
      await pump(tester, view());

      await expectLater(find.byType(RentsView), matchesGoldenFile('goldens/rents_inbox.png'));
    });

    testWidgets('§32 — a residence first: its units counted, the late ones said; opened as its own "Loyers"', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(
          homes: [
            home('a-1'),
            home('a-2', residence: 'Deido', overdue: 1, tenant: 'Paul Ebodé'),
            home('a-3', residence: 'Deido', title: 'Chambre 5'),
          ],
          byResidence: true,
        ),
      );
      await pump(tester, view());
      await tester.tap(find.text('Locataires (3)'));
      await tester.pumpAndSettle();

      expect(find.text('Résidence Deido'), findsOneWidget);
      expect(find.text('2 unités louées'), findsOneWidget);
      expect(find.text('1 unité en retard'), findsOneWidget);
      // Its units are on its own screen, not here.
      expect(find.text('Paul Ebodé · Akwa · Douala'), findsNothing);

      await tester.tap(find.text('Résidence Deido'));
      await tester.pumpAndSettle();
      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, RentsRoute.name);
      final args = route.args! as RentsRouteArgs;
      expect(args.residenceId, 'res-Deido');
      expect(args.annonceTitle, 'Résidence Deido');
    });

    testWidgets('§32 — a unit names its residence, in the inbox and on its card', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(
          waiting: [
            Declaration(
              id: 'd-1',
              annonceTitle: 'Chambre 3',
              residenceName: 'Résidence Deido',
              tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
              amount: 50000,
              status: DeclarationStatus.declared,
              declaredAt: DateTime(2026, 10, 22, 8),
            ),
          ],
          homes: [home('a-2', residence: 'Deido')],
        ),
      );
      await pump(tester, view());

      expect(find.text('Awa Nkeng · Chambre 3 · Résidence Deido'), findsOneWidget);
      await tester.tap(find.text('Locataires (1)'));
      await tester.pumpAndSettle();
      expect(find.text('Chambre 3 · Résidence Deido'), findsOneWidget);
    });

    testWidgets('the tenants, by residence', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(
          homes: [
            home('a-1'),
            home('a-2', residence: 'Deido', overdue: 1, tenant: 'Paul Ebodé'),
            home('a-3', residence: 'Deido', title: 'Chambre 5'),
            home('a-4', residence: 'Akwa', title: 'Studio 2'),
          ],
          byResidence: true,
        ),
      );
      await pump(tester, view());
      await tester.tap(find.text('Locataires (4)'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(RentsView), matchesGoldenFile('goldens/rents_by_residence.png'));
    });

    testWidgets('the tenants', (tester) async {
      when(() => bloc.state).thenReturn(
        RentsReady(homes: [home('a-1'), home('a-2', tenant: 'Paul Ebodé', overdue: 2)]),
      );
      await pump(tester, view());
      await tester.tap(find.text('Locataires (2)'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(RentsView), matchesGoldenFile('goldens/rents_tenants.png'));
    });
  });

  group('N-35, the push', () {
    late MockAppRouter router;

    setUpAll(() => registerFallbackValue(_FakeRoute()));

    setUp(() {
      router = MockAppRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => router.navigate(any())).thenAnswer((_) async {});
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    });

    tearDown(getIt.reset);

    test('a payment declared opens the declaration, where it is answered', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.home, entityId: 'd-1'));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, ReceivedDeclarationRoute.name);
      expect((route.args! as ReceivedDeclarationRouteArgs).declarationId, 'd-1');
    });

    test('several merged (no id): the inbox', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.home));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, RentsRoute.name);
    });

    test('§31.3 — N-39, photo proofs added: the tenant\'s space, not a declaration', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.homeEvidence, entityId: 'c-1'));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, TenantHomeRoute.name);
      expect((route.args! as TenantHomeRouteArgs).contractId, 'c-1');
    });

    test('N-39 merged (no id): "Loyers"', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.homeEvidence));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, RentsRoute.name);
    });

    test('an agent has no rents: the shell', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.agent);

      routeNotificationTap(router, const PushMessage(type: PushType.home, entityId: 'd-1'));

      verifyNever(() => router.push<Object?>(any()));
      verify(() => router.navigate(const AuthenticatedRouter())).called(1);
    });
  });
}
