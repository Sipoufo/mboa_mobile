import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

class MockHomeSpaceBloc extends MockBloc<HomeSpaceEvent, HomeSpaceState> implements HomeSpaceBloc {}

/// CDC M30 — one space, read by either party.
void main() {
  RentDue due(int index, DueStatus status, {int confirmed = 0, bool late = false, List<String> ids = const []}) => RentDue(
        index: index,
        periodStart: DateTime(2026, 10 + index, 18),
        periodEnd: DateTime(2026, 11 + index, 17),
        dueDate: DateTime(2026, 10 + index, 18),
        amount: 150000,
        confirmedTotal: confirmed,
        status: status,
        late: late,
        declarationIds: ids,
      );

  Home home({
    HomeStage state = HomeStage.active,
    RentDue? next,
    int overdueCount = 0,
    int overdueAmount = 0,
    int deposit = 300000,
  }) =>
      Home(
        contractId: 'c-1',
        annonceTitle: 'Studio Akwa',
        city: 'Douala',
        district: 'Akwa',
        state: state,
        rent: 150000,
        rentalPeriod: RentalPeriod.month,
        deposit: RentDeposit(amount: deposit),
        startDate: DateTime(2026, 10, 18),
        nextDue: next,
        overdueCount: overdueCount,
        overdueAmount: overdueAmount,
      );

  final declaration = Declaration(
    id: 'd-1',
    contractId: 'c-1',
    dueIndexes: const [0],
    amount: 150000,
    paidOn: DateTime(2026, 10, 18),
    method: RentPaymentMethod.orangeMoney,
    status: DeclarationStatus.declared,
  );

  group('the bloc', () {
    late MockHomesRepository repository;

    setUp(() => repository = MockHomesRepository());

    final bundle = HomeBundle(
      home: home(next: due(1, DueStatus.due)),
      schedule: RentSchedule(dues: [due(1, DueStatus.due), due(2, DueStatus.upcoming)], moreBefore: true),
      declarations: [declaration],
      totals: const HomeTotals(confirmedTotal: 150000),
    );

    blocTest<HomeSpaceBloc, HomeSpaceState>(
      'reads the space whole',
      setUp: () => when(() => repository.bundle('c-1')).thenAnswer((_) async => Cached(bundle)),
      build: () => HomeSpaceBloc(repository: repository),
      act: (bloc) => bloc.add(const HomeSpaceRequested('c-1')),
      expect: () => [
        const HomeSpaceLoading(),
        HomeSpaceReady(
          home: bundle.home,
          schedule: bundle.schedule,
          declarations: bundle.declarations,
          totals: bundle.totals,
        ),
      ],
    );

    blocTest<HomeSpaceBloc, HomeSpaceState>(
      'offline, the copy — marked',
      setUp: () => when(() => repository.bundle('c-1')).thenAnswer((_) async => Cached(bundle, fromCache: true)),
      build: () => HomeSpaceBloc(repository: repository),
      act: (bloc) => bloc.add(const HomeSpaceRequested('c-1')),
      verify: (bloc) => expect((bloc.state as HomeSpaceReady).isOffline, isTrue),
    );

    blocTest<HomeSpaceBloc, HomeSpaceState>(
      'nothing at all is a failure that can be retried',
      setUp: () => when(() => repository.bundle('c-1')).thenThrow(Exception('offline')),
      build: () => HomeSpaceBloc(repository: repository),
      act: (bloc) => bloc.add(const HomeSpaceRequested('c-1')),
      expect: () => const [HomeSpaceLoading(), HomeSpaceFailure('c-1')],
    );

    blocTest<HomeSpaceBloc, HomeSpaceState>(
      'paging back asks before the first échéance, and puts the older ones first',
      setUp: () => when(() => repository.scheduleBefore('c-1', DateTime(2026, 11, 18)))
          .thenAnswer((_) async => RentSchedule(dues: [due(0, DueStatus.confirmed)])),
      build: () => HomeSpaceBloc(repository: repository),
      seed: () => HomeSpaceReady(home: bundle.home, schedule: bundle.schedule),
      act: (bloc) => bloc.add(const HomeSpaceOlderRequested()),
      verify: (bloc) {
        final ready = bloc.state as HomeSpaceReady;
        expect(ready.schedule.dues.map((d) => d.index), [0, 1, 2]);
        expect(ready.schedule.moreBefore, isFalse);
      },
    );

    blocTest<HomeSpaceBloc, HomeSpaceState>(
      'nothing older, or offline: nothing asked',
      build: () => HomeSpaceBloc(repository: repository),
      seed: () => HomeSpaceReady(home: bundle.home, schedule: bundle.schedule, isOffline: true),
      act: (bloc) => bloc.add(const HomeSpaceOlderRequested()),
      expect: () => const <HomeSpaceState>[],
      verify: (_) => verifyNever(() => repository.scheduleBefore(any(), any())),
    );
  });

  group('the view', () {
    late MockHomeSpaceBloc bloc;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const HomeSpaceOlderRequested());
    });

    setUp(() => bloc = MockHomeSpaceBloc());

    Future<void> pump(
      WidgetTester tester,
      HomeSpaceReady state, {
      void Function(HomeSpaceReady, RentDue?)? onDeclare,
      void Function(Declaration)? onOpen,
    }) async {
      tester.view.physicalSize = const Size(390 * 3, 900 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => bloc.state).thenReturn(state);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<HomeSpaceBloc>.value(
            value: bloc,
            child: HomeSpaceView(onDeclare: onDeclare, onDeclareDeposit: (_) {}, onOpenDeclaration: onOpen),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    HomeSpaceReady ready(Home h, {List<RentDue>? dues, bool moreBefore = false, bool offline = false}) => HomeSpaceReady(
          home: h,
          schedule: RentSchedule(dues: dues ?? [due(0, DueStatus.due)], moreBefore: moreBefore),
          declarations: [declaration],
          totals: const HomeTotals(confirmedTotal: 300000, declaredTotal: 150000),
          isOffline: offline,
        );

    testWidgets('the next rent, big, and when', (tester) async {
      await pump(tester, ready(home(next: due(1, DueStatus.due, confirmed: 50000))), onDeclare: (_, _) {});

      expect(find.text('Prochain loyer'), findsOneWidget);
      // What is left to pay, not the échéance's full amount.
      expect(find.textContaining(RegExp(r'^100.000$')), findsOneWidget);
      expect(find.textContaining('À payer le'), findsOneWidget);
    });

    testWidgets('late: the overdue total and how many', (tester) async {
      await pump(tester, ready(home(overdueCount: 2, overdueAmount: 300000, next: due(0, DueStatus.late, late: true))));

      expect(find.text('En retard'), findsWidgets);
      expect(find.text('2 échéances en retard'), findsOneWidget);
    });

    testWidgets('ended: said, and nothing to declare', (tester) async {
      await pump(tester, ready(home(state: HomeStage.readOnly)), onDeclare: (_, _) {});

      expect(find.text('Location terminée'), findsOneWidget);
      expect(find.text('Déclarer'), findsNothing);
    });

    testWidgets('the landlord\'s side has no round buttons and no "hors de Mboa" line', (tester) async {
      await pump(tester, ready(home(next: due(0, DueStatus.due))));

      expect(find.text('Déclarer'), findsNothing);
      expect(find.textContaining('hors de Mboa'), findsNothing);
    });

    testWidgets('the tenant\'s side: declare and deposit, and the reminder that Mboa holds nothing', (tester) async {
      await pump(tester, ready(home(next: due(0, DueStatus.due))), onDeclare: (_, _) {});

      expect(find.text('Déclarer'), findsOneWidget);
      expect(find.text('Caution'), findsOneWidget);
      expect(find.textContaining('hors de Mboa'), findsOneWidget);
    });

    testWidgets('offline: marked, and nothing declared from the copy', (tester) async {
      await pump(tester, ready(home(next: due(0, DueStatus.due)), offline: true), onDeclare: (_, _) {});

      expect(find.textContaining('Hors ligne'), findsOneWidget);
      expect(find.text('Déclarer'), findsNothing);
    });

    testWidgets('an open échéance tapped is declared for; a declared one opens its declaration', (tester) async {
      RentDue? declaredFor;
      Declaration? opened;
      await pump(
        tester,
        ready(
          home(next: due(1, DueStatus.due)),
          dues: [due(0, DueStatus.declared, ids: ['d-1']), due(1, DueStatus.due)],
        ),
        onDeclare: (_, d) => declaredFor = d,
        onOpen: (d) => opened = d,
      );

      await tester.tap(find.text('À payer'));
      expect(declaredFor?.index, 1);
      await tester.tap(find.text('Déclaré, en attente'));
      expect(opened?.id, 'd-1');
    });

    testWidgets('before Mboa\'s tracking: greyed, never late', (tester) async {
      await pump(tester, ready(home(next: due(1, DueStatus.due)), dues: [due(0, DueStatus.untracked), due(1, DueStatus.due)]));

      expect(find.text('Avant le suivi Mboa'), findsOneWidget);
    });

    testWidgets('older échéances on request', (tester) async {
      await pump(tester, ready(home(next: due(1, DueStatus.due)), moreBefore: true));

      await tester.tap(find.text('Échéances plus anciennes'));
      verify(() => bloc.add(const HomeSpaceOlderRequested())).called(1);
    });

    testWidgets('slice D — the receipts, titled as their PDFs; each opens its declaration', (tester) async {
      Declaration? opened;
      final state = ready(home(next: due(1, DueStatus.due)));
      await pump(
        tester,
        HomeSpaceReady(
          home: state.home,
          schedule: state.schedule,
          declarations: state.declarations,
          receipts: [
            HomeReceipt(
              id: 'r-2',
              declarationId: 'd-9',
              kind: ReceiptKind.rentPartial,
              periodStart: DateTime(2026, 11, 18),
              periodEnd: DateTime(2026, 12, 17),
              amount: 50000,
            ),
            HomeReceipt(
              id: 'r-1',
              declarationId: 'd-1',
              kind: ReceiptKind.rent,
              periodStart: DateTime(2026, 9, 23),
              periodEnd: DateTime(2026, 11, 22),
              amount: 300000,
              ready: true,
            ),
            HomeReceipt(
              id: 'r-0',
              declarationId: 'd-0',
              kind: ReceiptKind.deposit,
              amount: 300000,
              issuedAt: DateTime(2026, 9, 20, 10),
              ready: true,
            ),
          ],
        ),
        onOpen: (d) => opened = d,
      );

      await tester.scrollUntilVisible(find.text('Reçu de dépôt de garantie'), 200);
      expect(find.text('Quittances et reçus'), findsOneWidget);
      expect(find.text('Quittance de loyer'), findsOneWidget);
      expect(find.text('Reçu de paiement partiel'), findsOneWidget);
      // Being made, said; with no period, the day it was issued.
      expect(find.text('En préparation…'), findsOneWidget);
      expect(find.text('23 sept. – 22 nov. 2026'), findsOneWidget);
      expect(find.text('Émis le 20 sept. 2026'), findsOneWidget);

      await tester.tap(find.text('Quittance de loyer'));
      // The declaration it belongs to, where its PDF is downloaded.
      expect(opened?.id, 'd-1');
      await tester.tap(find.text('Reçu de dépôt de garantie'));
      expect(opened?.id, 'd-0');
      await tester.pumpAndSettle();
      await expectLater(find.byType(HomeSpaceView), matchesGoldenFile('goldens/home_space_receipts.png'));
    });

    testWidgets('the space, the tenant\'s side', (tester) async {
      await pump(
        tester,
        ready(
          home(next: due(2, DueStatus.due)),
          dues: [
            due(0, DueStatus.confirmed, confirmed: 150000),
            due(1, DueStatus.declared, ids: ['d-1']),
            due(2, DueStatus.due),
            due(3, DueStatus.upcoming),
          ],
        ),
        onDeclare: (_, _) {},
      );

      expect(find.byIcon(LucideIcons.send), findsOneWidget);
      await expectLater(find.byType(HomeSpaceView), matchesGoldenFile('goldens/home_space_tenant.png'));
    });
  });
}
