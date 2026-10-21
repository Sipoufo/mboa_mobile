import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mboa_user/features/my_home/bloc/declare_payment_bloc.dart';
import 'package:mboa_user/features/my_home/models/declaration_form.dart';
import 'package:mboa_user/features/my_home/ui/declare_payment_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/load_brand_fonts.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

class MockMediaUploader extends Mock implements MediaUploader {}

class MockDeclarePaymentBloc extends MockBloc<DeclarePaymentEvent, DeclarePaymentState> implements DeclarePaymentBloc {}

class _FakeDraft extends Fake implements DeclarationDraft {}

/// CDC M30 — declaring a payment made outside Mboa (RM-M30-03).
void main() {
  final today = DateTime(2026, 10, 20, 15);

  RentDue due(int index, DueStatus status, {int confirmed = 0, bool late = false}) => RentDue(
        index: index,
        dueDate: DateTime(2026, 9 + index, 18),
        amount: 150000,
        confirmedTotal: confirmed,
        status: status,
        late: late,
      );

  final schedule = [
    due(0, DueStatus.confirmed, confirmed: 150000),
    due(1, DueStatus.late, confirmed: 50000, late: true),
    due(2, DueStatus.due),
    due(3, DueStatus.upcoming),
    due(4, DueStatus.declared),
    due(5, DueStatus.upcoming),
  ];

  group('the form', () {
    test('offers the open échéances only, and starts on the oldest', () {
      final form = DeclarationForm.rent(schedule, today: today);

      expect(form.options.map((d) => d.index), [1, 2, 3, 5]);
      expect(form.selected.map((d) => d.index), [1]);
      // What is left on it, not its full amount.
      expect(form.amount, 100000);
      expect(form.paidOn, DateTime(2026, 10, 20));
    });

    test('a tapped row is the starting point', () {
      final form = DeclarationForm.rent(schedule, preselected: due(3, DueStatus.upcoming), today: today);

      expect(form.selected.map((d) => d.index), [3]);
      expect(form.amount, 150000);
    });

    test('§29.1 — consecutive: neighbours grow the range, its ends shrink it, elsewhere starts over', () {
      var form = DeclarationForm.rent(schedule, today: today);

      form = form.toggle(due(2, DueStatus.due));
      expect(form.selected.map((d) => d.index), [1, 2]);
      expect(form.amount, 250000);

      form = form.toggle(due(3, DueStatus.upcoming));
      expect(form.selected.map((d) => d.index), [1, 2, 3]);

      form = form.toggle(due(1, DueStatus.late));
      expect(form.selected.map((d) => d.index), [2, 3]);

      // 4 is declared already: 5 does not follow 3, so it starts over.
      form = form.toggle(due(5, DueStatus.upcoming));
      expect(form.selected.map((d) => d.index), [5]);
    });

    test('the deposit: no échéance, what is left of it', () {
      final form = DeclarationForm.deposit(const RentDeposit(amount: 300000, confirmedTotal: 100000), today: today);

      expect(form.kind, DeclarationKind.deposit);
      expect(form.amount, 200000);
      expect(form.copyWith(method: RentPaymentMethod.cash).toDraft().dueIndexes, isEmpty);
    });

    test('CE-M30-02 — zero, or more than ten times what is due, is unusual', () {
      final form = DeclarationForm.rent(schedule, preselected: due(2, DueStatus.due), today: today);

      expect(form.copyWith(amount: 150000).looksUnusual, isFalse);
      expect(form.copyWith(amount: 0).looksUnusual, isTrue);
      expect(form.copyWith(amount: 1500001).looksUnusual, isTrue);
    });

    test('ready once there is an amount, a date and a method', () {
      final form = DeclarationForm.rent(schedule, today: today);

      expect(form.isComplete, isFalse);
      expect(form.copyWith(method: RentPaymentMethod.cash).isComplete, isTrue);
      expect(form.copyWith(method: RentPaymentMethod.cash, clearAmount: true).isComplete, isFalse);
    });

    test('rent with no échéance chosen is never ready, whatever the amount', () {
      final form = DeclarationForm.rent([due(0, DueStatus.confirmed, confirmed: 150000)], today: today)
          .copyWith(amount: 150000, method: RentPaymentMethod.cash);

      expect(form.options, isEmpty);
      expect(form.isComplete, isFalse);
    });

    test('at most three proofs', () {
      final form = DeclarationForm.rent(schedule, today: today);

      expect(form.copyWith(proofKeys: const ['a', 'b']).hasProofRoom, isTrue);
      expect(form.copyWith(proofKeys: const ['a', 'b', 'c']).hasProofRoom, isFalse);
    });
  });

  group('the bloc', () {
    late MockHomesRepository repository;
    late MockMediaUploader uploader;

    setUpAll(() {
      registerFallbackValue(_FakeDraft());
      registerFallbackValue(ImageSource.camera);
      registerFallbackValue(CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT);
    });

    setUp(() {
      repository = MockHomesRepository();
      uploader = MockMediaUploader();
    });

    final ready = DeclarationForm.rent(schedule, today: today).copyWith(method: RentPaymentMethod.orangeMoney);
    const sent = Declaration(id: 'd-1', status: DeclarationStatus.declared);

    DeclarePaymentBloc build() => DeclarePaymentBloc(repository: repository, uploader: uploader);

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'sends what the form says',
      setUp: () => when(() => repository.declare('c-1', any())).thenAnswer((_) async => sent),
      build: build,
      seed: () => DeclarePaymentState(contractId: 'c-1', form: ready),
      act: (bloc) => bloc.add(const DeclarationSubmitted()),
      expect: () => [
        DeclarePaymentState(contractId: 'c-1', form: ready, isSending: true),
        DeclarePaymentState(contractId: 'c-1', form: ready, sent: sent),
      ],
      verify: (_) {
        final draft = verify(() => repository.declare('c-1', captureAny())).captured.single as DeclarationDraft;
        expect(draft.dueIndexes, [1]);
        expect(draft.amount, 100000);
        expect(draft.method, RentPaymentMethod.orangeMoney);
      },
    );

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'an incomplete form is not sent',
      build: build,
      seed: () => DeclarePaymentState(contractId: 'c-1', form: DeclarationForm.rent(schedule, today: today)),
      act: (bloc) => bloc.add(const DeclarationSubmitted()),
      expect: () => const <DeclarePaymentState>[],
      verify: (_) => verifyNever(() => repository.declare(any(), any())),
    );

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'a refusal is told, and the form kept',
      setUp: () => when(() => repository.declare('c-1', any()))
          .thenThrow(const DeclarationRefused(DeclarationRefusal.dueAlreadyConfirmed)),
      build: build,
      seed: () => DeclarePaymentState(contractId: 'c-1', form: ready),
      act: (bloc) => bloc.add(const DeclarationSubmitted()),
      verify: (bloc) {
        expect(bloc.state.refusal, DeclarationRefusal.dueAlreadyConfirmed);
        expect(bloc.state.form, ready);
      },
    );

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'a proof is compressed and uploaded as it is added, its key kept',
      setUp: () => when(() => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')))
          .thenAnswer((_) async => 'proof/1.jpg'),
      build: build,
      seed: () => DeclarePaymentState(contractId: 'c-1', form: ready),
      act: (bloc) => bloc.add(const DeclarationProofAdded(ImageSource.gallery)),
      verify: (bloc) {
        expect(bloc.state.form?.proofKeys, ['proof/1.jpg']);
        verify(
          () => uploader.captureAndUpload(
            source: ImageSource.gallery,
            category: CreateUploadRequestCategoryEnum.FINANCE_ATTACHMENT,
          ),
        ).called(1);
      },
    );

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'CE-M30-01 — an upload that fails is said, the form kept',
      setUp: () => when(() => uploader.captureAndUpload(source: any(named: 'source'), category: any(named: 'category')))
          .thenThrow(Exception('offline')),
      build: build,
      seed: () => DeclarePaymentState(contractId: 'c-1', form: ready),
      act: (bloc) => bloc.add(const DeclarationProofAdded(ImageSource.camera)),
      verify: (bloc) {
        expect(bloc.state.uploadFailed, isTrue);
        expect(bloc.state.form, ready);
      },
    );

    blocTest<DeclarePaymentBloc, DeclarePaymentState>(
      'a fourth proof is not asked for',
      build: build,
      seed: () => DeclarePaymentState(contractId: 'c-1', form: ready.copyWith(proofKeys: const ['a', 'b', 'c'])),
      act: (bloc) => bloc.add(const DeclarationProofAdded(ImageSource.camera)),
      expect: () => const <DeclarePaymentState>[],
    );
  });

  group('the screen', () {
    late MockDeclarePaymentBloc bloc;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const DeclarationSubmitted());
    });

    setUp(() => bloc = MockDeclarePaymentBloc());

    Future<void> pump(WidgetTester tester, DeclarationForm form) async {
      tester.view.physicalSize = const Size(390 * 3, 1100 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      when(() => bloc.state).thenReturn(DeclarePaymentState(contractId: 'c-1', form: form));

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<DeclarePaymentBloc>.value(value: bloc, child: const DeclarePaymentView()),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('the amount starts at what is due; Mobile Money first; nothing to pay here', (tester) async {
      await pump(tester, DeclarationForm.rent(schedule, today: today));

      expect(find.text('100000'), findsOneWidget);
      expect(find.text('MTN Mobile Money'), findsOneWidget);
      expect(find.text('Orange Money'), findsOneWidget);
      expect(find.text('Espèces'), findsNothing);
      await tester.tap(find.text('Autres'));
      await tester.pumpAndSettle();
      expect(find.text('Espèces'), findsOneWidget);
      // CA-M30-03 — nothing on this screen pays through Mboa.
      expect(find.textContaining(RegExp('payer maintenant|recharge', caseSensitive: false)), findsNothing);
    });

    testWidgets('CE-M30-02 — an unusual amount asks once more before sending', (tester) async {
      await pump(
        tester,
        DeclarationForm.rent(schedule, today: today).copyWith(method: RentPaymentMethod.cash, amount: 5000000),
      );

      await tester.tap(find.text('Déclarer le paiement'));
      await tester.pumpAndSettle();
      expect(find.text('Montant inhabituel'), findsOneWidget);
      await tester.tap(find.text('Envoyer quand même'));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const DeclarationSubmitted())).called(1);
    });

    testWidgets('the form', (tester) async {
      await pump(
        tester,
        DeclarationForm.rent(schedule, today: today).toggle(due(2, DueStatus.due)).copyWith(
              method: RentPaymentMethod.orangeMoney,
              proofKeys: const ['proof/1.jpg'],
            ),
      );

      await expectLater(find.byType(DeclarePaymentView), matchesGoldenFile('goldens/declare_payment.png'));
    });
  });
}
