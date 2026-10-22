import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/declare_payment_bloc.dart';
import 'package:mboa_user/features/my_home/bloc/home_invoices_bloc.dart';
import 'package:mboa_user/features/my_home/bloc/invoice_bloc.dart';
import 'package:mboa_user/features/my_home/models/declaration_form.dart';
import 'package:mboa_user/features/my_home/ui/declare_payment_page.dart';
import 'package:mboa_user/features/my_home/ui/invoice_page.dart';
import 'package:mboa_user/features/my_home/ui/widgets/home_invoices_section.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

class MockMediaUploader extends Mock implements MediaUploader {}

class MockInvoiceBloc extends MockBloc<InvoiceEvent, InvoiceState> implements InvoiceBloc {}

class MockDeclarePaymentBloc extends MockBloc<DeclarePaymentEvent, DeclarePaymentState> implements DeclarePaymentBloc {}

class MockHomeInvoicesBloc extends MockBloc<HomeInvoicesEvent, HomeInvoicesState> implements HomeInvoicesBloc {}

class _FakeDraft extends Fake implements DeclarationDraft {}

/// CDC M30 slice E — an invoice paid outside Mboa, declared by the tenant
/// (RM-M24-09).
void main() {
  final today = DateTime(2026, 10, 21, 15);

  HomeInvoice invoice({InvoiceStatus status = InvoiceStatus.toPay, int amount = 12000, DateTime? paidAt}) => HomeInvoice(
        id: 'i-1',
        contractId: 'c-1',
        annonceTitle: 'Studio Akwa',
        kind: InvoiceKind.electricity,
        label: 'Électricité — septembre',
        amount: amount,
        dueDate: DateTime(2026, 10, 30),
        status: status,
        paidAt: paidAt,
      );

  Declaration declared(String id, int amount, DeclarationStatus status) => Declaration(
        id: id,
        contractId: 'c-1',
        kind: DeclarationKind.invoice,
        invoiceId: 'i-1',
        amount: amount,
        paidOn: DateTime(2026, 10, 15),
        method: RentPaymentMethod.cash,
        status: status,
      );

  group('the form', () {
    test('an invoice names no échéance, and starts at what is left', () {
      final form = DeclarationForm.invoice(invoice(), left: 7000, today: today);

      expect(form.kind, DeclarationKind.invoice);
      expect(form.invoiceId, 'i-1');
      expect(form.amount, 7000);
      expect(form.due, 7000);
      expect(form.paidOn, DateTime(2026, 10, 21));
      expect(form.isComplete, isFalse);
      final ready = form.copyWith(method: RentPaymentMethod.cash);
      expect(ready.isComplete, isTrue);
      expect(ready.toDraft().dueIndexes, isEmpty);
    });

    test('never more than the invoice, never less than nothing', () {
      expect(DeclarationForm.invoice(invoice(), left: 50000, today: today).amount, 12000);
      expect(DeclarationForm.invoice(invoice(), left: -5, today: today).amount, 0);
    });
  });

  group('the blocs', () {
    late MockHomesRepository repository;

    setUpAll(() => registerFallbackValue(_FakeDraft()));

    setUp(() => repository = MockHomesRepository());

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'an invoice is declared on the invoice, never on the home',
      setUp: () => when(() => repository.declareInvoice('i-1', any()))
          .thenAnswer((_) async => declared('d-9', 7000, DeclarationStatus.declared)),
      build: () => DeclarePaymentBloc(repository: repository, uploader: MockMediaUploader()),
      seed: () => DeclarePaymentState(
        contractId: 'c-1',
        form: DeclarationForm.invoice(invoice(), left: 7000, today: today).copyWith(method: RentPaymentMethod.cash),
      ),
      act: (bloc) => bloc.add(const DeclarationSubmitted()),
      verify: (bloc) {
        expect(bloc.state.sent?.id, 'd-9');
        final draft = verify(() => repository.declareInvoice('i-1', captureAny())).captured.single as DeclarationDraft;
        expect(draft.amount, 7000);
        verifyNever(() => repository.declare(any(), any()));
      },
    );

    blocTest<HomeInvoicesBloc, HomeInvoicesState>(
      "the tenancy's invoices",
      setUp: () => when(() => repository.invoices(contractId: 'c-1')).thenAnswer((_) async => Cached([invoice()])),
      build: () => HomeInvoicesBloc(repository: repository),
      act: (bloc) => bloc.add(const HomeInvoicesRequested('c-1')),
      expect: () => [HomeInvoicesReady(items: [invoice()])],
    );

    blocTest<HomeInvoicesBloc, HomeInvoicesState>(
      'offline, the copy — marked',
      setUp: () => when(() => repository.invoices(contractId: 'c-1'))
          .thenAnswer((_) async => Cached([invoice()], fromCache: true)),
      build: () => HomeInvoicesBloc(repository: repository),
      act: (bloc) => bloc.add(const HomeInvoicesRequested('c-1')),
      expect: () => [HomeInvoicesReady(items: [invoice()], isOffline: true)],
    );

    blocTest<HomeInvoicesBloc, HomeInvoicesState>(
      'nothing to show is a failure; a failed refresh keeps the list',
      setUp: () => when(() => repository.invoices(contractId: 'c-1')).thenThrow(Exception('offline')),
      build: () => HomeInvoicesBloc(repository: repository),
      seed: () => HomeInvoicesReady(items: [invoice()]),
      act: (bloc) => bloc.add(const HomeInvoicesRequested('c-1')),
      expect: () => const <HomeInvoicesState>[],
    );

    blocTest<InvoiceBloc, InvoiceState>(
      'an invoice and what was declared on it; what is left is the confirmed part off',
      setUp: () {
        when(() => repository.invoice('i-1')).thenAnswer((_) async => Cached(invoice()));
        when(() => repository.invoiceDeclarations('i-1')).thenAnswer(
          (_) async => [
            declared('d-2', 2000, DeclarationStatus.declared),
            declared('d-1', 5000, DeclarationStatus.confirmed),
            declared('d-0', 1000, DeclarationStatus.contested),
          ],
        );
      },
      build: () => InvoiceBloc(repository: repository),
      act: (bloc) => bloc.add(const InvoiceRequested('i-1')),
      verify: (bloc) {
        final state = bloc.state as InvoiceReady;
        expect(state.declarations, hasLength(3));
        // Only the confirmed counts: waiting and contested are not paid.
        expect(state.confirmedTotal, 5000);
        expect(state.left, 7000);
        expect(state.canDeclare, isTrue);
      },
    );

    blocTest<InvoiceBloc, InvoiceState>(
      'offline: the copy, no declarations asked, nothing declared from it',
      setUp: () => when(() => repository.invoice('i-1')).thenAnswer((_) async => Cached(invoice(), fromCache: true)),
      build: () => InvoiceBloc(repository: repository),
      act: (bloc) => bloc.add(const InvoiceRequested('i-1')),
      verify: (bloc) {
        final state = bloc.state as InvoiceReady;
        expect(state.isOffline, isTrue);
        expect(state.canDeclare, isFalse);
        verifyNever(() => repository.invoiceDeclarations(any()));
      },
    );

    blocTest<InvoiceBloc, InvoiceState>(
      'declarations that do not come: shown as offline, not as a failure',
      setUp: () {
        when(() => repository.invoice('i-1')).thenAnswer((_) async => Cached(invoice()));
        when(() => repository.invoiceDeclarations('i-1')).thenThrow(Exception('offline'));
      },
      build: () => InvoiceBloc(repository: repository),
      act: (bloc) => bloc.add(const InvoiceRequested('i-1')),
      verify: (bloc) => expect((bloc.state as InvoiceReady).isOffline, isTrue),
    );

    blocTest<InvoiceBloc, InvoiceState>(
      'no invoice at all: retryable',
      setUp: () => when(() => repository.invoice('i-1')).thenThrow(Exception('offline')),
      build: () => InvoiceBloc(repository: repository),
      act: (bloc) => bloc.add(const InvoiceRequested('i-1')),
      expect: () => const [InvoiceLoading(), InvoiceFailure('i-1')],
    );

    test('a paid or cancelled invoice cannot be declared', () {
      expect(InvoiceReady(invoice(status: InvoiceStatus.paid)).canDeclare, isFalse);
      expect(InvoiceReady(invoice(status: InvoiceStatus.cancelled)).canDeclare, isFalse);
      expect(InvoiceReady(invoice(status: InvoiceStatus.overdue)).canDeclare, isTrue);
    });
  });

  group('the screens', () {
    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const InvoiceRequested('x'));
    });

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

    Widget view(MockInvoiceBloc bloc, {ValueChanged<InvoiceReady>? onDeclare}) => BlocProvider<InvoiceBloc>.value(
          value: bloc,
          child: InvoiceView(onDeclare: onDeclare ?? (_) {}, onOpenDeclaration: (_) {}),
        );

    testWidgets('open: "Déclarer payée" is the one main action; nothing pays from here', (tester) async {
      final bloc = MockInvoiceBloc();
      final ready = InvoiceReady(invoice());
      when(() => bloc.state).thenReturn(ready);
      InvoiceReady? asked;
      await pump(tester, view(bloc, onDeclare: (s) => asked = s));

      expect(find.text('Échéance : 30 octobre 2026'), findsOneWidget);
      expect(find.textContaining('Les factures se paient hors de Mboa'), findsOneWidget);
      await tester.tap(find.text('Déclarer payée'));
      expect(asked, ready);
      // RM-M30-06 — a record of a payment made elsewhere, never a payment.
      expect(find.textContaining(RegExp('payer maintenant|payer dans|recharge', caseSensitive: false)), findsNothing);
    });

    testWidgets('paid: said with its day, and no bar', (tester) async {
      final bloc = MockInvoiceBloc();
      when(() => bloc.state)
          .thenReturn(InvoiceReady(invoice(status: InvoiceStatus.paid, paidAt: DateTime(2026, 10, 20, 9))));
      await pump(tester, view(bloc));

      expect(find.text('Payée le 20 octobre 2026'), findsOneWidget);
      expect(find.text('Déclarer payée'), findsNothing);
    });

    testWidgets('offline: said, and nothing declared from the copy', (tester) async {
      final bloc = MockInvoiceBloc();
      when(() => bloc.state).thenReturn(InvoiceReady(invoice(), isOffline: true));
      await pump(tester, view(bloc));

      expect(find.textContaining('Hors ligne'), findsOneWidget);
      expect(find.text('Déclarer payée'), findsNothing);
    });

    testWidgets("the space's section: nothing when there are none; each invoice opens", (tester) async {
      HomeInvoice? opened;
      Widget section(HomeInvoicesState state) {
        final bloc = MockHomeInvoicesBloc();
        when(() => bloc.state).thenReturn(state);
        return BlocProvider<HomeInvoicesBloc>.value(
          value: bloc,
          child: Scaffold(body: HomeInvoicesSection(onOpen: (i) => opened = i)),
        );
      }

      await pump(tester, section(const HomeInvoicesReady()));
      expect(find.text('Factures'), findsNothing);
      await pump(tester, section(const HomeInvoicesFailure()));
      expect(find.text('Factures'), findsNothing);

      await pump(tester, section(HomeInvoicesReady(items: [invoice()])));
      expect(find.text('Factures'), findsOneWidget);
      await tester.tap(find.text('Électricité — septembre'));
      expect(opened, invoice());
    });

    testWidgets('the form on an invoice: its own title, no échéance to pick', (tester) async {
      final bloc = MockDeclarePaymentBloc();
      when(() => bloc.state).thenReturn(
        DeclarePaymentState(contractId: 'c-1', form: DeclarationForm.invoice(invoice(), left: 7000, today: today)),
      );
      await pump(tester, BlocProvider<DeclarePaymentBloc>.value(value: bloc, child: const DeclarePaymentView()));

      expect(find.text('Déclarer une facture payée'), findsOneWidget);
      expect(find.text('Pour quelles échéances ?'), findsNothing);
      expect(find.text('7000'), findsOneWidget);
    });

    testWidgets('the invoice, partly confirmed', (tester) async {
      final bloc = MockInvoiceBloc();
      when(() => bloc.state).thenReturn(
        InvoiceReady(
          invoice(),
          declarations: [
            declared('d-2', 2000, DeclarationStatus.declared),
            declared('d-1', 5000, DeclarationStatus.confirmed),
          ],
        ),
      );
      await pump(tester, view(bloc));

      // French amounts carry a narrow no-break space: matched on the words.
      expect(find.textContaining(RegExp(r'^Déjà confirmé : 5.000 FCFA · reste 7.000 FCFA$')), findsOneWidget);
      await expectLater(find.byType(InvoiceView), matchesGoldenFile('goldens/invoice.png'));
    });
  });
}
