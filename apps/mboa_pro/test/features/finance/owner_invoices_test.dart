import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/finance/bloc/invoice_form_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/owner_invoice_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/owner_invoices_bloc.dart';
import 'package:mboa_pro/features/finance/data/owner_invoices_repository.dart';
import 'package:mboa_pro/features/finance/models/finance_refusal.dart';
import 'package:mboa_pro/features/finance/ui/invoice_form_page.dart';
import 'package:mboa_pro/features/finance/ui/owner_invoices_pages.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';
import '../../_helpers/mocks/mocks.dart';

class MockOwnerInvoicesApi extends Mock implements FinanceInvoicesOwnerApi {}

class MockOwnerInvoicesRepository extends Mock implements OwnerInvoicesRepository {}

class MockHomesRepository extends Mock implements HomesRepository {}

class MockOwnerInvoicesBloc extends MockBloc<OwnerInvoicesEvent, OwnerInvoicesState> implements OwnerInvoicesBloc {}

class MockOwnerInvoiceBloc extends MockBloc<OwnerInvoiceEvent, OwnerInvoiceState> implements OwnerInvoiceBloc {}

class MockInvoiceFormBloc extends MockBloc<InvoiceFormEvent, InvoiceFormState> implements InvoiceFormBloc {}

class _FakeCreate extends Fake implements CreateInvoiceRequest {}

class _FakeDraft extends Fake implements InvoiceDraft {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 409, data: {'error': code}),
    );

/// CDC M24 — the landlord's invoices.
void main() {
  HomeInvoice invoice(
    String id, {
    InvoiceStatus status = InvoiceStatus.toPay,
    InvoiceKind kind = InvoiceKind.electricity,
    bool manual = false,
    bool pastDue = false,
  }) =>
      HomeInvoice(
        id: id,
        contractId: 'c-1',
        annonceTitle: 'Studio Akwa',
        kind: kind,
        label: kind == InvoiceKind.electricity ? 'Électricité — septembre' : null,
        amount: 18500,
        dueDate: DateTime(2026, 10, 30),
        status: status,
        paidAt: status == InvoiceStatus.paid ? DateTime(2026, 10, 12) : null,
        paidManually: manual,
        pastDue: pastDue,
      );

  // Two standalone listings let, three units in two residences.
  const tenancies = [
    Home(
      contractId: 'c-1',
      annonceTitle: 'Studio Akwa',
      state: HomeStage.active,
      tenant: ContractParticipant(displayName: 'Awa Nkeng'),
    ),
    Home(
      contractId: 'c-2',
      annonceTitle: 'Chambre 3',
      residenceId: 'res-1',
      residenceName: 'Résidence Deido',
      state: HomeStage.active,
      tenant: ContractParticipant(displayName: 'Paul Etoga'),
    ),
    Home(
      contractId: 'c-3',
      annonceTitle: 'Chambre 1',
      residenceId: 'res-1',
      residenceName: 'Résidence Deido',
      state: HomeStage.active,
      tenant: ContractParticipant(displayName: 'Éloïse Mbarga'),
    ),
    Home(
      contractId: 'c-4',
      annonceTitle: 'Studio B2',
      residenceId: 'res-2',
      residenceName: 'Résidence Bonapriso',
      state: HomeStage.active,
      tenant: ContractParticipant(displayName: 'Jean Fotso'),
    ),
    Home(
      contractId: 'c-5',
      annonceTitle: 'Appartement Bonamoussadi',
      state: HomeStage.active,
      tenant: ContractParticipant(displayName: 'Brice Kamga'),
    ),
  ];

  setUpAll(() {
    registerFallbackValue(_FakeCreate());
    registerFallbackValue(_FakeDraft());
    registerFallbackValue(Pageable());
    registerFallbackValue(DateTime(2026));
  });

  group('the repository', () {
    late MockOwnerInvoicesApi api;
    late MockHiveCache cache;
    late OwnerInvoicesRepository repository;

    InvoiceResponse response({String status = 'TO_PAY', String? paidVia}) => InvoiceResponse((b) => b
      ..id = 'i-1'
      ..contractId = 'c-1'
      ..kind = InvoiceResponseKindEnum.ELECTRICITY
      ..amount = 18500
      ..status = InvoiceResponseStatusEnum.valueOf(status)
      ..paidVia = paidVia == null ? null : InvoiceResponsePaidViaEnum.valueOf(paidVia)
      ..pastDue = true);

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      api = MockOwnerInvoicesApi();
      cache = MockHiveCache();
      final stored = <String, Map<String, dynamic>>{};
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getFinanceInvoicesOwnerApi).thenReturn(api);
      when(() => cache.put(any(), any(), any())).thenAnswer((call) async {
        stored[call.positionalArguments[1] as String] = call.positionalArguments[2] as Map<String, dynamic>;
      });
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl')))
          .thenAnswer((call) => stored[call.positionalArguments[1] as String]);
      repository = OwnerInvoicesRepository(dioClient: dioClient, cache: cache);
    });

    test('lists them, and keeps them for offline', () async {
      when(() => api.listOwnerInvoices(pageable: any(named: 'pageable'))).thenAnswer(
        (_) async => _ok(PageResponseInvoiceResponse((b) => b..content = ListBuilder([response()]))),
      );
      final online = await repository.list();
      expect(online.value.single.pastDue, isTrue);

      when(() => api.listOwnerInvoices(pageable: any(named: 'pageable')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/x')));
      final offline = await repository.list();
      expect(offline.fromCache, isTrue);
      expect(offline.value.single.amount, 18500);
    });

    test('bills by hand — paying in the app is shut (DL-04); no words, none sent', () async {
      when(() => api.createInvoice(createInvoiceRequest: any(named: 'createInvoiceRequest')))
          .thenAnswer((_) async => _ok(response()));

      await repository.create(
        InvoiceDraft(contractId: 'c-1', kind: InvoiceKind.water, amount: 9000, dueDate: DateTime(2026, 11, 5), label: '  '),
      );

      final sent = verify(() => api.createInvoice(createInvoiceRequest: captureAny(named: 'createInvoiceRequest')))
          .captured
          .single as CreateInvoiceRequest;
      expect(sent.kind, CreateInvoiceRequestKindEnum.WATER);
      expect(sent.settlement, CreateInvoiceRequestSettlementEnum.MANUAL);
      expect(sent.label, isNull);
      expect(sent.amount, 9000);
      expect(sent.dueDate, Date(2026, 11, 5));
    });

    test('paid by the landlord\'s word is « MANUAL »; the refusals are named', () async {
      when(() => api.markInvoicePaid(id: 'i-1', markInvoicePaidRequest: any(named: 'markInvoicePaidRequest')))
          .thenAnswer((_) async => _ok(response(status: 'PAID', paidVia: 'MANUAL')));
      expect((await repository.markPaid('i-1', paidOn: DateTime(2026, 10, 12))).paidManually, isTrue);

      when(() => api.cancelInvoice(id: 'i-1')).thenThrow(_refused('INVOICE_SETTLED'));
      await expectLater(
        repository.cancel('i-1'),
        throwsA(isA<FinanceRefused>().having((r) => r.reason, 'reason', FinanceRefusal.settled)),
      );
      when(() => api.reopenInvoice(id: 'i-1')).thenThrow(_refused('FINANCE_ADDON_REQUIRED'));
      await expectLater(
        repository.reopen('i-1'),
        throwsA(isA<FinanceRefused>().having((r) => r.reason, 'reason', FinanceRefusal.addonRequired)),
      );
    });
  });

  group('the list', () {
    late MockOwnerInvoicesRepository repository;

    setUp(() => repository = MockOwnerInvoicesRepository());

    test('by where they stand, each counted', () {
      final ready = OwnerInvoicesReady(
        items: [invoice('a'), invoice('b', status: InvoiceStatus.overdue), invoice('c', status: InvoiceStatus.paid)],
      );
      expect(ready.shown.map((i) => i.id), ['a']);
      expect(ready.count(InvoiceStatus.overdue), 1);
      expect(ready.copyWith(filter: InvoiceStatus.paid).shown.map((i) => i.id), ['c']);
    });

    blocTest<OwnerInvoicesBloc, OwnerInvoicesState>(
      'a refresh keeps the filter chosen',
      setUp: () => when(repository.list).thenAnswer((_) async => Cached([invoice('a')])),
      build: () => OwnerInvoicesBloc(repository: repository),
      seed: () => const OwnerInvoicesReady(items: [], filter: InvoiceStatus.overdue),
      act: (bloc) => bloc.add(const OwnerInvoicesRequested()),
      expect: () => [OwnerInvoicesReady(items: [invoice('a')], filter: InvoiceStatus.overdue)],
    );
  });

  group('one invoice', () {
    late MockOwnerInvoicesRepository repository;

    setUp(() => repository = MockOwnerInvoicesRepository());

    blocTest<OwnerInvoiceBloc, OwnerInvoiceState>(
      'marked paid on the day the landlord says',
      setUp: () => when(() => repository.markPaid('a', paidOn: DateTime(2026, 10, 12)))
          .thenAnswer((_) async => invoice('a', status: InvoiceStatus.paid, manual: true)),
      build: () => OwnerInvoiceBloc(repository: repository),
      seed: () => OwnerInvoiceReady(invoice('a')),
      act: (bloc) => bloc.add(OwnerInvoiceMarkedPaid(DateTime(2026, 10, 12))),
      expect: () => [
        OwnerInvoiceReady(invoice('a'), isBusy: true),
        OwnerInvoiceReady(invoice('a', status: InvoiceStatus.paid, manual: true), done: OwnerInvoiceDone.paid),
      ],
    );

    blocTest<OwnerInvoiceBloc, OwnerInvoiceState>(
      'refused: said, the invoice as it was',
      setUp: () => when(() => repository.cancel('a')).thenThrow(const FinanceRefused(FinanceRefusal.addonRequired)),
      build: () => OwnerInvoiceBloc(repository: repository),
      seed: () => OwnerInvoiceReady(invoice('a')),
      act: (bloc) => bloc.add(const OwnerInvoiceCancelled()),
      expect: () => [
        OwnerInvoiceReady(invoice('a'), isBusy: true),
        OwnerInvoiceReady(invoice('a'), refusal: FinanceRefusal.addonRequired),
      ],
    );

    test('only a payment declared by hand can be withdrawn; offline, nothing is done', () {
      expect(OwnerInvoiceReady(invoice('a', status: InvoiceStatus.paid, manual: true)).canReopen, isTrue);
      expect(OwnerInvoiceReady(invoice('a', status: InvoiceStatus.paid)).canReopen, isFalse);
      expect(OwnerInvoiceReady(invoice('a')).isOpen, isTrue);
      expect(OwnerInvoiceReady(invoice('a'), isOffline: true).isOpen, isFalse);
    });
  });

  group('the form', () {
    late MockOwnerInvoicesRepository invoices;
    late MockHomesRepository homes;
    const running = Home(
      contractId: 'c-1',
      annonceTitle: 'Studio Akwa',
      state: HomeStage.active,
      tenant: ContractParticipant(displayName: 'Awa Nkeng'),
    );
    const ended = Home(contractId: 'c-0', state: HomeStage.readOnly);

    setUp(() {
      invoices = MockOwnerInvoicesRepository();
      homes = MockHomesRepository();
    });

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'offers the running tenancies only (RM-M24-02) — one, already chosen: straight to the charge',
      setUp: () => when(() => homes.activeTenantHomes()).thenAnswer((_) async => const Cached([running, ended])),
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      act: (bloc) => bloc.add(const InvoiceFormStarted()),
      expect: () => const [
        InvoiceFormState(isLoadingTenancies: true),
        InvoiceFormState(tenancies: [running], contractId: 'c-1', step: InvoiceFormStep.charge),
      ],
      verify: (bloc) => expect(bloc.state.steps, [InvoiceFormStep.charge, InvoiceFormStep.amount]),
    );

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'several: the tenant first — on the residences\' tab when no standalone listing is let',
      setUp: () => when(() => homes.activeTenantHomes()).thenAnswer((_) async => Cached([tenancies[1], tenancies[3]])),
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      act: (bloc) => bloc.add(const InvoiceFormStarted()),
      verify: (bloc) {
        expect(bloc.state.step, InvoiceFormStep.tenant);
        expect(bloc.state.group, TenancyGroup.multiple);
        expect(bloc.state.contractId, isNull);
        expect(bloc.state.steps, InvoiceFormStep.values);
      },
    );

    group('the tenant step', () {
      const state = InvoiceFormState(tenancies: tenancies);
      List<String> ids(List<Home> homes) => [for (final h in homes) h.contractId];

      test('standalone listings apart from residences, by name; residences by name, their tenants too', () {
        expect(ids(state.singles), ['c-1', 'c-5']);
        expect([for (final r in state.residences) r.name], ['Résidence Bonapriso', 'Résidence Deido']);
        expect(ids(state.residences.last.homes), ['c-3', 'c-2']);
        expect(state.residencesCount, 3);
      });

      test('the search finds a person, a unit or a residence — accents and case aside, in both tabs', () {
        expect(ids(state.copyWith(query: 'ELOISE').residences.single.homes), ['c-3']);
        expect(state.copyWith(query: 'eloise').singles, isEmpty);
        expect(ids(state.copyWith(query: 'akwa').singles), ['c-1']);
        expect(state.copyWith(query: 'deido').residencesCount, 2);
        // Every word, anywhere: a person in a residence.
        expect(ids(state.copyWith(query: 'paul deido').residences.single.homes), ['c-2']);
        expect(state.copyWith(query: 'paul bonapriso').residencesCount, 0);
      });
    });

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'a row chosen: on to the charge',
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      seed: () => const InvoiceFormState(tenancies: tenancies),
      act: (bloc) => bloc.add(const InvoiceFormTenantChosen('c-2')),
      expect: () => const [InvoiceFormState(tenancies: tenancies, contractId: 'c-2', step: InvoiceFormStep.charge)],
      verify: (bloc) => expect(bloc.state.tenancy?.placeTitle, 'Chambre 3 · Résidence Deido'),
    );

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'forward only past a step done; back always',
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      seed: () => const InvoiceFormState(tenancies: tenancies),
      act: (bloc) => bloc
        // No tenant yet: not past the first step.
        ..add(const InvoiceFormStepRequested(InvoiceFormStep.charge))
        ..add(const InvoiceFormTenantChosen('c-1'))
        ..add(const InvoiceFormChanged(kind: InvoiceKind.other))
        // « Autre » without its words: not past the charge.
        ..add(const InvoiceFormStepRequested(InvoiceFormStep.amount))
        ..add(const InvoiceFormChanged(label: 'Gardiennage'))
        ..add(const InvoiceFormStepRequested(InvoiceFormStep.amount))
        ..add(const InvoiceFormStepRequested(InvoiceFormStep.tenant)),
      expect: () => [
        isA<InvoiceFormState>().having((s) => s.step, 'step', InvoiceFormStep.charge),
        isA<InvoiceFormState>().having((s) => s.kind, 'kind', InvoiceKind.other),
        isA<InvoiceFormState>().having((s) => s.label, 'label', 'Gardiennage'),
        isA<InvoiceFormState>().having((s) => s.step, 'step', InvoiceFormStep.amount),
        isA<InvoiceFormState>().having((s) => s.step, 'step', InvoiceFormStep.tenant),
      ],
      verify: (bloc) {
        expect(bloc.state.contractId, 'c-1');
        expect(bloc.state.label, 'Gardiennage');
      },
    );

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'not two steps at once',
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      seed: () => const InvoiceFormState(tenancies: tenancies, contractId: 'c-1'),
      act: (bloc) => bloc.add(const InvoiceFormStepRequested(InvoiceFormStep.amount)),
      expect: () => const <InvoiceFormState>[],
    );

    test('an « Autre » charge says what it is', () {
      final ready = InvoiceFormState(contractId: 'c-1', amount: 5000, dueDate: DateTime(2026, 11));
      expect(ready.canSubmit, isTrue);
      expect(ready.copyWith(kind: InvoiceKind.other).canSubmit, isFalse);
      expect(ready.copyWith(kind: InvoiceKind.other, label: 'Gardiennage').canSubmit, isTrue);
      expect(ready.copyWith(amount: 0).canSubmit, isFalse);
    });

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'correcting: no tenant to pick — the words, the amount and the date go, the server\'s answer closes the form',
      setUp: () => when(() => invoices.update('a', label: any(named: 'label'), amount: 20000, dueDate: any(named: 'dueDate')))
          .thenAnswer((_) async => invoice('a')),
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      act: (bloc) => bloc
        ..add(InvoiceFormStarted(editing: invoice('a')))
        ..add(const InvoiceFormTenantChosen('c-9'))
        ..add(const InvoiceFormStepRequested(InvoiceFormStep.tenant))
        ..add(const InvoiceFormChanged(amount: 20000))
        ..add(const InvoiceFormSubmitted()),
      verify: (bloc) {
        expect(bloc.state.steps, [InvoiceFormStep.charge, InvoiceFormStep.amount]);
        expect(bloc.state.contractId, 'c-1');
        expect(bloc.state.saved, invoice('a'));
        verifyNever(() => homes.activeTenantHomes());
      },
    );
  });

  group('the screens', () {
    setUpAll(loadBrandFonts);

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
          home: child,
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('the list: by where they stand, « Nouvelle facture » the one action', (tester) async {
      final bloc = MockOwnerInvoicesBloc();
      when(() => bloc.state).thenReturn(
        OwnerInvoicesReady(
          items: [
            invoice('a', pastDue: true),
            invoice('b', kind: InvoiceKind.water),
            invoice('c', status: InvoiceStatus.overdue),
          ],
        ),
      );
      var created = 0;
      await pump(
        tester,
        BlocProvider<OwnerInvoicesBloc>.value(
          value: bloc,
          child: OwnerInvoicesView(onOpen: (_) {}, onNew: () => created++),
        ),
      );

      expect(find.text('En retard (1)'), findsOneWidget);
      expect(find.text('Échéance dépassée'), findsOneWidget);
      await tester.tap(find.text('Nouvelle facture'));
      expect(created, 1);
      await tester.pumpAndSettle();
      await expectLater(find.byType(OwnerInvoicesView), matchesGoldenFile('goldens/owner_invoices.png'));
    });

    testWidgets('one open: « Marquer payée », the rest behind « ⋯ » — cancelling in red, asked once more',
        (tester) async {
      final bloc = MockOwnerInvoiceBloc();
      when(() => bloc.state).thenReturn(OwnerInvoiceReady(invoice('a')));
      await pump(tester, BlocProvider<OwnerInvoiceBloc>.value(value: bloc, child: OwnerInvoiceView(onEdit: (_) {})));

      await expectLater(find.byType(OwnerInvoiceView), matchesGoldenFile('goldens/owner_invoice.png'));
      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      expect(find.text('Modifier'), findsOneWidget);
      await tester.tap(find.text('Annuler la facture'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Oui'));
      await tester.pumpAndSettle();
      verify(() => bloc.add(const OwnerInvoiceCancelled())).called(1);
    });

    testWidgets('paid by hand: no bar; withdrawing it is up top, behind « ⋯ »', (tester) async {
      final bloc = MockOwnerInvoiceBloc();
      when(() => bloc.state).thenReturn(OwnerInvoiceReady(invoice('a', status: InvoiceStatus.paid, manual: true)));
      await pump(tester, BlocProvider<OwnerInvoiceBloc>.value(value: bloc, child: OwnerInvoiceView(onEdit: (_) {})));

      expect(find.byType(Button), findsNothing);
      expect(find.textContaining('Mboa ne vérifie pas ce paiement'), findsOneWidget);
      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      expect(find.text('Retirer le paiement déclaré'), findsOneWidget);
    });

    group('the form, step by step', () {
      late MockInvoiceFormBloc bloc;

      setUp(() => bloc = MockInvoiceFormBloc());

      Future<void> form(WidgetTester tester, InvoiceFormState state) async {
        when(() => bloc.state).thenReturn(state);
        await pump(tester, BlocProvider<InvoiceFormBloc>.value(value: bloc, child: const InvoiceFormView()));
      }

      testWidgets('1 — the tenant: one search, two tabs that count; the row is the choice, no bar', (tester) async {
        await form(tester, const InvoiceFormState(tenancies: tenancies));

        expect(find.text('Étape 1 sur 3'), findsOneWidget);
        expect(find.text('Biens uniques (2)'), findsOneWidget);
        expect(find.text('Biens multiples (3)'), findsOneWidget);
        expect(find.byType(Button), findsNothing);
        await expectLater(find.byType(InvoiceFormView), matchesGoldenFile('goldens/invoice_form_tenant.png'));

        await tester.tap(find.text('Brice Kamga'));
        verify(() => bloc.add(const InvoiceFormTenantChosen('c-5'))).called(1);
        await tester.enterText(find.byType(TextField), 'deido');
        verify(() => bloc.add(const InvoiceFormSearchChanged('deido'))).called(1);
        await tester.tap(find.text('Biens multiples (3)'));
        verify(() => bloc.add(const InvoiceFormGroupChanged(TenancyGroup.multiple))).called(1);
      });

      testWidgets('1 — the residences: each under its name, its tenants with their unit', (tester) async {
        await form(tester, const InvoiceFormState(tenancies: tenancies, group: TenancyGroup.multiple, contractId: 'c-2'));

        expect(find.text('Résidence Deido'), findsOneWidget);
        expect(find.text('Chambre 3'), findsOneWidget);
        await expectLater(find.byType(InvoiceFormView), matchesGoldenFile('goldens/invoice_form_residences.png'));
      });

      testWidgets('1 — nothing here for the search: said, and the other tab still counts its matches', (tester) async {
        await form(tester, const InvoiceFormState(tenancies: tenancies, query: 'deido'));

        expect(find.text('Aucun locataire ne correspond à « deido » ici.'), findsOneWidget);
        expect(find.text('Biens multiples (2)'), findsOneWidget);
      });

      testWidgets('2 — the charge: whom on top, the kinds as cards, « Continuer »; back is the step before',
          (tester) async {
        await form(
          tester,
          const InvoiceFormState(
            tenancies: tenancies,
            contractId: 'c-2',
            step: InvoiceFormStep.charge,
            kind: InvoiceKind.electricity,
            label: 'Électricité — octobre',
          ),
        );

        expect(find.text('Étape 2 sur 3'), findsOneWidget);
        expect(find.text('Chambre 3 · Résidence Deido'), findsOneWidget);
        await expectLater(find.byType(InvoiceFormView), matchesGoldenFile('goldens/invoice_form_charge.png'));

        await tester.tap(find.text('Eau'));
        verify(() => bloc.add(const InvoiceFormChanged(kind: InvoiceKind.water))).called(1);
        await tester.tap(find.text('Continuer'));
        verify(() => bloc.add(const InvoiceFormStepRequested(InvoiceFormStep.amount))).called(1);
        await tester.tap(find.byIcon(LucideIcons.arrowLeft));
        verify(() => bloc.add(const InvoiceFormStepRequested(InvoiceFormStep.tenant))).called(1);
        await tester.tap(find.text('Changer'));
        verify(() => bloc.add(const InvoiceFormStepRequested(InvoiceFormStep.tenant))).called(1);
      });

      testWidgets('3 — the amount and the date, under whom and what; « Créer la facture »', (tester) async {
        await form(
          tester,
          InvoiceFormState(
            tenancies: tenancies,
            contractId: 'c-2',
            step: InvoiceFormStep.amount,
            kind: InvoiceKind.electricity,
            label: 'Électricité — octobre',
            amount: 18500,
            dueDate: DateTime(2026, 11, 5),
          ),
        );

        expect(find.text('Étape 3 sur 3'), findsOneWidget);
        expect(find.text('Électricité — octobre'), findsOneWidget);
        await expectLater(find.byType(InvoiceFormView), matchesGoldenFile('goldens/invoice_form_amount.png'));

        await tester.tap(find.text('Créer la facture'));
        verify(() => bloc.add(const InvoiceFormSubmitted())).called(1);
      });

      testWidgets('correcting: two steps, the tenant and the kind fixed', (tester) async {
        await form(
          tester,
          InvoiceFormState(editing: invoice('a'), contractId: 'c-1', step: InvoiceFormStep.charge, kind: InvoiceKind.electricity),
        );

        expect(find.text('Étape 1 sur 2'), findsOneWidget);
        expect(find.text('Changer'), findsNothing);
        await tester.tap(find.text('Eau'));
        verifyNever(() => bloc.add(const InvoiceFormChanged(kind: InvoiceKind.water)));
      });
    });

    testWidgets('no tenancy running: said, nothing to fill', (tester) async {
      final bloc = MockInvoiceFormBloc();
      when(() => bloc.state).thenReturn(const InvoiceFormState());
      await pump(tester, BlocProvider<InvoiceFormBloc>.value(value: bloc, child: const InvoiceFormView()));

      expect(find.textContaining('Contrat Mboa actif'), findsOneWidget);
      expect(find.byType(Button), findsNothing);
    });
  });
}
