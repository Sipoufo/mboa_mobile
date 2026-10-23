import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/finance/bloc/invoice_form_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/owner_invoice_bloc.dart';
import 'package:mboa_pro/features/finance/bloc/owner_invoices_bloc.dart';
import 'package:mboa_pro/features/finance/data/owner_invoices_repository.dart';
import 'package:mboa_pro/features/finance/models/finance_refusal.dart';
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
      'offers the running tenancies only (RM-M24-02) — one, already chosen',
      setUp: () => when(() => homes.tenantHomes()).thenAnswer((_) async => const Cached([running, ended])),
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      act: (bloc) => bloc.add(const InvoiceFormStarted()),
      expect: () => const [
        InvoiceFormState(isLoadingTenancies: true),
        InvoiceFormState(tenancies: [running], contractId: 'c-1'),
      ],
    );

    test('an « Autre » charge says what it is', () {
      final ready = InvoiceFormState(contractId: 'c-1', amount: 5000, dueDate: DateTime(2026, 11));
      expect(ready.canSubmit, isTrue);
      expect(ready.copyWith(kind: InvoiceKind.other).canSubmit, isFalse);
      expect(ready.copyWith(kind: InvoiceKind.other, label: 'Gardiennage').canSubmit, isTrue);
      expect(ready.copyWith(amount: 0).canSubmit, isFalse);
    });

    blocTest<InvoiceFormBloc, InvoiceFormState>(
      'correcting: the words, the amount and the date go — the server\'s answer closes the form',
      setUp: () => when(() => invoices.update('a', label: any(named: 'label'), amount: 20000, dueDate: any(named: 'dueDate')))
          .thenAnswer((_) async => invoice('a')),
      build: () => InvoiceFormBloc(invoices: invoices, homes: homes),
      act: (bloc) => bloc
        ..add(InvoiceFormStarted(editing: invoice('a')))
        ..add(const InvoiceFormChanged(amount: 20000))
        ..add(const InvoiceFormSubmitted()),
      verify: (bloc) {
        expect(bloc.state.saved, invoice('a'));
        verifyNever(() => homes.tenantHomes());
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

    testWidgets('the form', (tester) async {
      final bloc = MockInvoiceFormBloc();
      when(() => bloc.state).thenReturn(
        InvoiceFormState(
          tenancies: const [
            Home(
              contractId: 'c-1',
              annonceTitle: 'Studio Akwa',
              state: HomeStage.active,
              tenant: ContractParticipant(displayName: 'Awa Nkeng'),
            ),
            Home(
              contractId: 'c-2',
              annonceTitle: 'Chambre 3',
              residenceName: 'Résidence Deido',
              state: HomeStage.active,
              tenant: ContractParticipant(displayName: 'Paul Etoga'),
            ),
          ],
          contractId: 'c-1',
          kind: InvoiceKind.electricity,
          dueDate: DateTime(2026, 10, 30),
        ),
      );
      await pump(tester, BlocProvider<InvoiceFormBloc>.value(value: bloc, child: const InvoiceFormView()));

      await expectLater(find.byType(InvoiceFormView), matchesGoldenFile('goldens/invoice_form.png'));
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
