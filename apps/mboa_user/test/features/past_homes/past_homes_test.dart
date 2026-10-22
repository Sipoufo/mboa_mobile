import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/my_homes_bloc.dart';
import 'package:mboa_user/features/my_home/ui/evidence_pages.dart';
import 'package:mboa_user/features/my_home/ui/home_requests_pages.dart';
import 'package:mboa_user/features/my_home/ui/my_homes_page.dart';
import 'package:mboa_user/features/past_homes/bloc/past_home_bloc.dart';
import 'package:mboa_user/features/past_homes/bloc/past_homes_bloc.dart';
import 'package:mboa_user/features/past_homes/ui/past_home_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockPastHomesRepository extends Mock implements PastHomesRepository {}

class MockPdfSharer extends Mock implements PdfSharer {}

class MockPastHomeBloc extends MockBloc<PastHomeEvent, PastHomeState> implements PastHomeBloc {}

class MockPastHomesBloc extends MockBloc<PastHomesEvent, PastHomesState> implements PastHomesBloc {}

class MockMyHomesBloc extends MockBloc<MyHomesEvent, MyHomesState> implements MyHomesBloc {}

class MockHomeRequestsBloc extends MockBloc<HomeRequestsEvent, HomeRequestsState> implements HomeRequestsBloc {}

class MockEvidenceBloc extends MockBloc<EvidenceEvent, EvidenceState> implements EvidenceBloc {}

/// CDC M31 — « Mes anciens logements ».
void main() {
  final home = Home(
    contractId: 'c-1',
    annonceId: 'a-1',
    annonceTitle: 'Studio meublé à Bastos',
    district: 'Bastos',
    city: 'Yaoundé',
    state: HomeStage.readOnly,
    rent: 80000,
    deposit: const RentDeposit(amount: 160000),
    startDate: DateTime(2025, 1, 1),
    endDate: DateTime(2026, 9, 30),
  );

  final past = PastHome(
    home: home,
    listingOnline: true,
    verificationCode: 'MB-7K2P',
    confirmedTotal: 1360000,
    byYear: const [(2026, 720000), (2025, 640000)],
    confirmed: [
      PastExpense(
        declarationId: 'd-1',
        label: 'Loyer du 1 sept. 2026 au 30 sept. 2026',
        amount: 80000,
        paidOn: DateTime(2026, 9, 2),
        status: DeclarationStatus.confirmed,
        receiptId: 'r-1',
        receiptReady: true,
      ),
      PastExpense(
        declarationId: 'd-2',
        kind: DeclarationKind.invoice,
        label: "La facture d'eau",
        amount: 12500,
        paidOn: DateTime(2026, 8, 20),
        status: DeclarationStatus.confirmed,
      ),
    ],
    notConfirmed: const [
      PastExpense(
        declarationId: 'd-3',
        label: 'Loyer du 1 août 2026 au 31 août 2026',
        amount: 80000,
        status: DeclarationStatus.contested,
      ),
    ],
    requestCount: 4,
    openRequestCount: 1,
    rating: const PropertyRatingSummary(average: 4.2, reviewCount: 7),
    myReview: MyPastReview(reviewId: 'rv-1', rating: 4, canEdit: true, editableUntil: DateTime(2026, 11, 15)),
  );

  group('PastHomesBloc', () {
    late MockPastHomesRepository repository;

    setUp(() => repository = MockPastHomesRepository());

    blocTest<PastHomesBloc, PastHomesState>(
      'reads the ended tenancies, offline from the last read',
      setUp: () => when(repository.list).thenAnswer((_) async => Cached([home], fromCache: true)),
      build: () => PastHomesBloc(repository: repository),
      act: (bloc) => bloc.add(const PastHomesRequested()),
      expect: () => [const PastHomesLoading(), PastHomesReady(items: [home], isOffline: true)],
    );

    blocTest<PastHomesBloc, PastHomesState>(
      'nothing at all is a failure',
      setUp: () => when(repository.list).thenThrow(Exception('offline')),
      build: () => PastHomesBloc(repository: repository),
      act: (bloc) => bloc.add(const PastHomesRequested()),
      expect: () => const [PastHomesLoading(), PastHomesFailure()],
    );

    blocTest<PastHomesBloc, PastHomesState>(
      'a failed refresh keeps the list',
      setUp: () => when(repository.list).thenThrow(Exception('offline')),
      build: () => PastHomesBloc(repository: repository),
      seed: () => PastHomesReady(items: [home]),
      act: (bloc) => bloc.add(const PastHomesRequested()),
      expect: () => const <PastHomesState>[],
    );
  });

  group('PastHomeBloc', () {
    late MockPastHomesRepository repository;
    late MockPdfSharer sharer;
    final pdf = Uint8List.fromList([37, 80, 68, 70]);

    setUpAll(() => registerFallbackValue(Uint8List(0)));

    setUp(() {
      repository = MockPastHomesRepository();
      sharer = MockPdfSharer();
    });

    blocTest<PastHomeBloc, PastHomeState>(
      'reads the sheet',
      setUp: () => when(() => repository.get('c-1')).thenAnswer((_) async => Cached(past)),
      build: () => PastHomeBloc(repository: repository, sharer: sharer),
      act: (bloc) => bloc.add(const PastHomeRequested('c-1')),
      expect: () => [const PastHomeLoading(), PastHomeReady(past: past)],
    );

    blocTest<PastHomeBloc, PastHomeState>(
      'unreadable and never read: a failure, to try again',
      setUp: () => when(() => repository.get('c-1')).thenThrow(Exception('404')),
      build: () => PastHomeBloc(repository: repository, sharer: sharer),
      act: (bloc) => bloc.add(const PastHomeRequested('c-1')),
      expect: () => const [PastHomeLoading(), PastHomeFailure('c-1')],
    );

    blocTest<PastHomeBloc, PastHomeState>(
      'the statement: fetched as bytes, offered on the share sheet under its name',
      setUp: () {
        when(() => repository.expensesPdf('c-1')).thenAnswer((_) async => pdf);
        when(() => sharer.shareBytes(any(), name: any(named: 'name'))).thenAnswer((_) async {});
      },
      build: () => PastHomeBloc(repository: repository, sharer: sharer),
      seed: () => PastHomeReady(past: past),
      act: (bloc) => bloc.add(const PastHomeStatementRequested(name: 'Relevé des dépenses — Studio')),
      expect: () => [PastHomeReady(past: past, statementBusy: true), PastHomeReady(past: past)],
      verify: (_) => verify(() => sharer.shareBytes(pdf, name: 'Relevé des dépenses — Studio')).called(1),
    );

    blocTest<PastHomeBloc, PastHomeState>(
      'a statement that fails is said — and reported',
      setUp: () => when(() => repository.expensesPdf('c-1')).thenThrow(Exception('offline')),
      build: () => PastHomeBloc(repository: repository, sharer: sharer),
      seed: () => PastHomeReady(past: past),
      act: (bloc) => bloc.add(const PastHomeStatementRequested(name: 'x')),
      expect: () => [
        PastHomeReady(past: past, statementBusy: true),
        PastHomeReady(past: past, statementFailed: true),
      ],
      errors: () => [isA<Exception>()],
    );

    blocTest<PastHomeBloc, PastHomeState>(
      'one statement at a time',
      build: () => PastHomeBloc(repository: repository, sharer: sharer),
      seed: () => PastHomeReady(past: past, statementBusy: true),
      act: (bloc) => bloc.add(const PastHomeStatementRequested(name: 'x')),
      expect: () => const <PastHomeState>[],
      verify: (_) => verifyNever(() => repository.expensesPdf(any())),
    );
  });

  group('the sheet', () {
    late MockPastHomeBloc bloc;
    late List<String> opened;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const PastHomeRequested('c-1'));
    });

    setUp(() {
      bloc = MockPastHomeBloc();
      opened = [];
    });

    Future<void> pump(WidgetTester tester, PastHomeState state, {double height = 844}) async {
      tester.view.physicalSize = Size(390 * 3, height * 3);
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
          home: BlocProvider<PastHomeBloc>.value(
            value: bloc,
            child: PastHomeView(
              onListing: (id) => opened.add('listing:$id'),
              onContract: () => opened.add('contract'),
              onReview: () => opened.add('review'),
              onExpense: (e) => opened.add('declaration:${e.declarationId}'),
              onRequests: () => opened.add('requests'),
              onEvidence: ({required canAdd}) => opened.add('evidence:$canAdd'),
              onSpace: () => opened.add('space'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    // Brought to the middle: at the edge, a tap lands on the bar.
    Future<void> tapScrolled(WidgetTester tester, Finder finder) async {
      await tester.scrollUntilVisible(finder, 200, scrollable: find.byType(Scrollable).first);
      await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
      await tester.pumpAndSettle();
      await tester.tap(finder);
    }

    // French groups thousands with a narrow no-break space.
    String n(String spaced) => spaced.replaceAll(' ', '\u202f');

    testWidgets('the lease as signed, the confirmed total, the other payments apart (RM-M31-02/03)', (tester) async {
      await pump(tester, PastHomeReady(past: past), height: 2400);

      expect(find.text('Studio meublé à Bastos'), findsOneWidget);
      expect(find.text('Location terminée'), findsOneWidget);
      expect(find.text('Du 1 janv. 2025 au 30 sept. 2026'), findsOneWidget);
      expect(find.text(n('1 360 000')), findsOneWidget);
      expect(find.textContaining('2026 · ${n('720 000')}'), findsOneWidget);
      expect(find.text('Non confirmés · hors total'), findsOneWidget);
      expect(find.text('Contesté'), findsOneWidget);
      expect(find.text('Code de vérification : MB-7K2P'), findsOneWidget);
      expect(find.text('4,2 · 7 avis'), findsOneWidget);
      expect(find.text('4 demandes, dont 1 ouverte'), findsOneWidget);
      expect(find.text('Télécharger le relevé des dépenses'), findsOneWidget);
    });

    testWidgets('each row opens where it lives', (tester) async {
      await pump(tester, PastHomeReady(past: past));

      await tester.tap(find.text("Voir l'annonce"));
      await tapScrolled(tester, find.text("La facture d'eau"));
      await tapScrolled(tester, find.text('Loyer du 1 août 2026 au 31 août 2026'));
      await tapScrolled(tester, find.text('Voir le contrat signé'));
      await tapScrolled(tester, find.text('Modifier mon avis'));
      await tapScrolled(tester, find.text('Demandes'));
      await tapScrolled(tester, find.text('État des lieux'));
      await tapScrolled(tester, find.text('Échéancier et déclarations'));

      expect(opened, [
        'listing:a-1',
        'declaration:d-2',
        'declaration:d-3',
        'contract',
        'review',
        'requests',
        // Ended 30 Sept.: past its 7 days, the photos are only read.
        'evidence:false',
        'space',
      ]);
    });

    testWidgets('the statement is the bar\'s one action', (tester) async {
      await pump(tester, PastHomeReady(past: past));

      await tester.tap(find.text('Télécharger le relevé des dépenses'));
      verify(
        () => bloc.add(const PastHomeStatementRequested(name: 'Relevé des dépenses — Studio meublé à Bastos')),
      ).called(1);
    });

    testWidgets('nothing paid, nothing to state: no bar; no review, no rating block (RM-M31-04)', (tester) async {
      await pump(
        tester,
        PastHomeReady(
          past: PastHome(home: home, myReview: const MyPastReview(canWrite: true)),
        ),
        height: 2000,
      );

      expect(find.text('Aucun paiement confirmé.'), findsOneWidget);
      expect(find.text('Télécharger le relevé des dépenses'), findsNothing);
      expect(find.text("Note du bien aujourd'hui"), findsNothing);
      expect(find.text("Voir l'annonce"), findsNothing);
      expect(find.text('Donner mon avis'), findsOneWidget);
      expect(find.text('Aucune demande'), findsOneWidget);
    });

    testWidgets('a review past its 30 days: read, not changed', (tester) async {
      await pump(
        tester,
        PastHomeReady(past: PastHome(home: home, myReview: const MyPastReview(reviewId: 'rv-1', rating: 5))),
        height: 2000,
      );

      expect(find.text('Mon avis · 5/5'), findsOneWidget);
      expect(find.text("Il n'est plus modifiable."), findsOneWidget);
      expect(find.text('Modifier mon avis'), findsNothing);
    });

    testWidgets('within its 7 days, exit photos may still be added (RM-M31-08)', (tester) async {
      final now = DateTime.now();
      final justEnded = PastHome(
        home: Home(contractId: 'c-1', state: HomeStage.readOnly, endDate: DateTime(now.year, now.month, now.day - 2)),
      );
      await pump(tester, PastHomeReady(past: justEnded));

      expect(find.textContaining('Photos de sortie possibles'), findsOneWidget);
      await tapScrolled(tester, find.text('État des lieux'));
      expect(opened, ['evidence:true']);
    });

    testWidgets('offline: said, with what needs a connection — and no photos added', (tester) async {
      final now = DateTime.now();
      final justEnded = PastHome(
        home: Home(contractId: 'c-1', state: HomeStage.readOnly, endDate: DateTime(now.year, now.month, now.day - 2)),
      );
      await pump(tester, PastHomeReady(past: justEnded, isOffline: true));

      expect(find.textContaining('Le relevé et les photos demandent une connexion'), findsOneWidget);
      expect(find.textContaining('Photos de sortie possibles'), findsNothing);
      await tapScrolled(tester, find.text('État des lieux'));
      expect(opened, ['evidence:false']);
    });

    testWidgets('the sheet', (tester) async {
      await pump(tester, PastHomeReady(past: past), height: 1900);

      await expectLater(find.byType(PastHomeView), matchesGoldenFile('goldens/past_home.png'));
    });
  });

  group('« Anciens »', () {
    setUpAll(loadBrandFonts);

    testWidgets('the tab', (tester) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final homes = MockMyHomesBloc();
      final pastHomes = MockPastHomesBloc();
      when(() => homes.state).thenReturn(const MyHomesReady(items: []));
      when(() => pastHomes.state).thenReturn(
        PastHomesReady(
          items: [
            home,
            const Home(
              contractId: 'c-0',
              annonceTitle: 'Chambre 3',
              residenceName: 'Résidence Deido',
              district: 'Deido',
              city: 'Douala',
              state: HomeStage.readOnly,
              rent: 45000,
            ),
          ],
        ),
      );
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: MultiBlocProvider(
            providers: [
              BlocProvider<MyHomesBloc>.value(value: homes),
              BlocProvider<PastHomesBloc>.value(value: pastHomes),
            ],
            child: MyHomesView(onOpen: (_) {}, onOpenPast: (_) {}),
          ),
        ),
      );
      await tester.tap(find.text('Anciens'));
      await tester.pumpAndSettle();

      await expectLater(find.byType(MyHomesView), matchesGoldenFile('goldens/past_homes_tab.png'));
    });
  });

  group('from an ended tenancy, read only (RM-M31-06)', () {
    late MockHomeRequestsBloc requests;
    late MockEvidenceBloc evidence;

    setUp(() {
      requests = MockHomeRequestsBloc();
      evidence = MockEvidenceBloc();
      when(() => requests.state).thenReturn(const HomeRequestsReady(items: []));
      when(() => evidence.state).thenReturn(const EvidenceReady(items: []));
      getIt
        ..registerFactoryParam<HomeRequestsBloc, String?, void>((_, _) => requests)
        ..registerFactoryParam<EvidenceBloc, String, void>((_, _) => evidence);
    });

    tearDown(getIt.reset);

    Future<void> pump(WidgetTester tester, AutoRouteWrapper page) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Builder(builder: page.wrappedRoute),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('requests: read, no new one', (tester) async {
      await pump(tester, const HomeRequestsPage(contractId: 'c-1'));
      expect(find.text('Nouvelle demande'), findsOneWidget);

      await pump(tester, const HomeRequestsPage(contractId: 'c-1', readOnly: true));
      expect(find.text('Nouvelle demande'), findsNothing);
    });

    testWidgets('photos: read, none added', (tester) async {
      await pump(tester, const HomeEvidencePage(contractId: 'c-1'));
      expect(find.text('Envoyer des photos'), findsOneWidget);

      await pump(tester, const HomeEvidencePage(contractId: 'c-1', readOnly: true));
      expect(find.text('Envoyer des photos'), findsNothing);
    });
  });
}
