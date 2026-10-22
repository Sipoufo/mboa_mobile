import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../score/load_brand_fonts.dart';

class MockHomesRepository extends Mock implements HomesRepository {}

class MockPdfSharer extends Mock implements PdfSharer {}

class MockDeclarationBloc extends MockBloc<DeclarationEvent, DeclarationState> implements DeclarationBloc {}

/// CDC M30 — one declared payment, read by either party, answered by the
/// landlord where the server allows it (RM-M30-04, RM-M30-07).
void main() {
  Declaration declaration({
    DeclarationStatus status = DeclarationStatus.declared,
    bool hasProof = true,
    bool canConfirm = false,
    bool canContest = false,
    String? contestReason,
    String? receiptId,
    bool receiptReady = false,
    DateTime? answeredAt,
  }) =>
      Declaration(
        id: 'd-1',
        contractId: 'c-1',
        annonceTitle: 'Studio Akwa',
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        dueIndexes: const [1, 2],
        amount: 300000,
        paidOn: DateTime(2026, 10, 18),
        method: RentPaymentMethod.orangeMoney,
        reference: 'OM2610181234',
        note: 'Octobre et novembre',
        hasProof: hasProof,
        status: status,
        contestReason: contestReason,
        declaredAt: DateTime(2026, 10, 19),
        canConfirm: canConfirm,
        canContest: canContest,
        receiptId: receiptId,
        receiptReady: receiptReady,
        answeredAt: answeredAt,
      );

  group('the bloc', () {
    late MockHomesRepository repository;

    setUp(() => repository = MockHomesRepository());

    DeclarationBloc build() => DeclarationBloc(repository: repository);

    blocTest<DeclarationBloc, DeclarationState>(
      "the tenant's read goes through the space, its proofs along",
      setUp: () {
        when(() => repository.declaration('c-1', 'd-1')).thenAnswer((_) async => declaration());
        when(() => repository.proofUrls('c-1', 'd-1')).thenAnswer((_) async => ['https://r2/p1']);
      },
      build: build,
      act: (bloc) => bloc.add(const DeclarationRequested(id: 'd-1', contractId: 'c-1')),
      expect: () => [
        const DeclarationLoading(),
        DeclarationReady(declaration(), proofUrls: const ['https://r2/p1']),
      ],
      verify: (_) => verifyNever(() => repository.receivedDeclaration(any())),
    );

    blocTest<DeclarationBloc, DeclarationState>(
      "the landlord's read goes through his inbox (what N-35 opens)",
      setUp: () {
        when(() => repository.receivedDeclaration('d-1')).thenAnswer((_) async => declaration(hasProof: false));
      },
      build: build,
      act: (bloc) => bloc.add(const DeclarationRequested(id: 'd-1')),
      expect: () => [const DeclarationLoading(), DeclarationReady(declaration(hasProof: false))],
      // No proof: none asked for.
      verify: (_) => verifyNever(() => repository.proofUrls(any(), any())),
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'proofs are best-effort: the declaration stands without them',
      setUp: () {
        when(() => repository.declaration('c-1', 'd-1')).thenAnswer((_) async => declaration());
        when(() => repository.proofUrls('c-1', 'd-1')).thenThrow(Exception('offline'));
      },
      build: build,
      act: (bloc) => bloc.add(const DeclarationRequested(id: 'd-1', contractId: 'c-1')),
      expect: () => [const DeclarationLoading(), DeclarationReady(declaration())],
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'a read that fails can be retried',
      setUp: () => when(() => repository.receivedDeclaration('d-1')).thenThrow(Exception('offline')),
      build: build,
      act: (bloc) => bloc.add(const DeclarationRequested(id: 'd-1')),
      expect: () => [const DeclarationLoading(), const DeclarationFailure(id: 'd-1')],
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'confirming, where allowed',
      setUp: () => when(() => repository.confirm('d-1'))
          .thenAnswer((_) async => declaration(status: DeclarationStatus.confirmed)),
      build: build,
      seed: () => DeclarationReady(declaration(canConfirm: true)),
      act: (bloc) => bloc.add(const DeclarationConfirmed()),
      expect: () => [
        DeclarationReady(declaration(canConfirm: true), isBusy: true),
        DeclarationReady(declaration(status: DeclarationStatus.confirmed), done: DeclarationAnswer.confirmed),
      ],
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'not where the server does not allow it',
      build: build,
      seed: () => DeclarationReady(declaration()),
      act: (bloc) => bloc
        ..add(const DeclarationConfirmed())
        ..add(const DeclarationContested('Rien reçu')),
      expect: () => const <DeclarationState>[],
      verify: (_) {
        verifyNever(() => repository.confirm(any()));
        verifyNever(() => repository.contest(any(), reason: any(named: 'reason')));
      },
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'RM-M30-07 — contesting needs a reason, sent trimmed',
      setUp: () => when(() => repository.contest('d-1', reason: 'Rien reçu'))
          .thenAnswer((_) async => declaration(status: DeclarationStatus.contested, contestReason: 'Rien reçu')),
      build: build,
      seed: () => DeclarationReady(declaration(canContest: true)),
      act: (bloc) => bloc
        ..add(const DeclarationContested('   '))
        ..add(const DeclarationContested('  Rien reçu ')),
      verify: (bloc) {
        verifyNever(() => repository.contest(any(), reason: any(named: 'reason', that: isNot('Rien reçu'))));
        verify(() => repository.contest('d-1', reason: 'Rien reçu')).called(1);
        expect((bloc.state as DeclarationReady).done, DeclarationAnswer.contested);
      },
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'a refusal (answered already) is told, on the declaration as it now stands',
      setUp: () {
        when(() => repository.confirm('d-1')).thenThrow(const DeclarationRefused(DeclarationRefusal.answered));
        when(() => repository.receivedDeclaration('d-1'))
            .thenAnswer((_) async => declaration(status: DeclarationStatus.confirmed));
      },
      build: build,
      seed: () => DeclarationReady(declaration(canConfirm: true)),
      act: (bloc) => bloc.add(const DeclarationConfirmed()),
      verify: (bloc) {
        final state = bloc.state as DeclarationReady;
        expect(state.refusal, DeclarationRefusal.answered);
        expect(state.declaration.status, DeclarationStatus.confirmed);
        expect(state.done, isNull);
      },
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'an answer that fails is said, the declaration kept',
      setUp: () => when(() => repository.confirm('d-1')).thenThrow(Exception('offline')),
      build: build,
      seed: () => DeclarationReady(declaration(canConfirm: true)),
      act: (bloc) => bloc.add(const DeclarationConfirmed()),
      expect: () => [
        DeclarationReady(declaration(canConfirm: true), isBusy: true),
        DeclarationReady(declaration(canConfirm: true), failed: true),
      ],
    );
  });

  group('the receipt (slice D)', () {
    late MockHomesRepository repository;
    late MockPdfSharer sharer;

    setUp(() {
      repository = MockHomesRepository();
      sharer = MockPdfSharer();
    });

    DeclarationBloc build({int tries = 3}) => DeclarationBloc(
          repository: repository,
          sharer: sharer,
          receiptPoll: const Duration(milliseconds: 5),
          receiptPollTries: tries,
        );

    final pending = declaration(status: DeclarationStatus.confirmed, receiptId: 'r-1');
    final ready = declaration(status: DeclarationStatus.confirmed, receiptId: 'r-1', receiptReady: true);

    blocTest<DeclarationBloc, DeclarationState>(
      'CA-M30-02 — named but not made: read again until it is, then no more',
      setUp: () {
        var reads = 0;
        when(() => repository.declaration('c-1', 'd-1')).thenAnswer((_) async => ++reads < 3 ? pending : ready);
        when(() => repository.proofUrls('c-1', 'd-1')).thenAnswer((_) async => const []);
      },
      build: build,
      act: (bloc) => bloc.add(const DeclarationRequested(id: 'd-1', contractId: 'c-1')),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        final state = bloc.state as DeclarationReady;
        expect(state.declaration.receiptReady, isTrue);
        expect(state.receiptPending, isFalse);
        // The first read, then two more: ready at the third, and it stops.
        verify(() => repository.declaration('c-1', 'd-1')).called(3);
      },
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'a confirmation names the receipt: the landlord\'s screen waits for it too',
      setUp: () {
        when(() => repository.confirm('d-1')).thenAnswer((_) async => pending);
        when(() => repository.receivedDeclaration('d-1')).thenAnswer((_) async => ready);
      },
      build: build,
      seed: () => DeclarationReady(declaration(canConfirm: true)),
      act: (bloc) => bloc.add(const DeclarationConfirmed()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) => expect((bloc.state as DeclarationReady).declaration.receiptReady, isTrue),
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'still not made after the tries: the wait is over, said; by hand, read again',
      setUp: () {
        var reads = 0;
        when(() => repository.declaration('c-1', 'd-1')).thenAnswer((_) async => ++reads < 5 ? pending : ready);
        when(() => repository.proofUrls('c-1', 'd-1')).thenAnswer((_) async => const []);
      },
      build: () => build(tries: 2),
      act: (bloc) async {
        bloc.add(const DeclarationRequested(id: 'd-1', contractId: 'c-1'));
        await Future<void>.delayed(const Duration(milliseconds: 80));
        expect((bloc.state as DeclarationReady).receiptWaitOver, isTrue);
        // No more automatic reads once it is over.
        verify(() => repository.declaration('c-1', 'd-1')).called(3);
        bloc.add(const DeclarationReceiptRefreshed(byHand: true));
      },
      wait: const Duration(milliseconds: 80),
      verify: (bloc) {
        final state = bloc.state as DeclarationReady;
        expect(state.declaration.receiptReady, isTrue);
        expect(state.receiptWaitOver, isFalse);
      },
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'ready: fetched and offered under the name the screen gives',
      setUp: () {
        when(() => repository.receiptPdfUrl('r-1')).thenAnswer((_) async => 'https://r2/r-1.pdf');
        when(() => sharer.shareLink(any(), name: any(named: 'name'))).thenAnswer((_) async {});
      },
      build: build,
      seed: () => DeclarationReady(ready),
      act: (bloc) => bloc.add(const DeclarationReceiptRequested(name: 'Reçu de paiement — Studio Akwa')),
      expect: () => [DeclarationReady(ready, receiptBusy: true), DeclarationReady(ready)],
      verify: (_) =>
          verify(() => sharer.shareLink('https://r2/r-1.pdf', name: 'Reçu de paiement — Studio Akwa')).called(1),
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'the server still making it is said as such, not as a failure',
      setUp: () => when(() => repository.receiptPdfUrl('r-1')).thenThrow(const ReceiptNotReady()),
      build: build,
      seed: () => DeclarationReady(ready),
      act: (bloc) => bloc.add(const DeclarationReceiptRequested(name: 'x')),
      expect: () => [DeclarationReady(ready, receiptBusy: true), DeclarationReady(ready, receiptNotReady: true)],
      verify: (_) => verifyNever(() => sharer.shareLink(any(), name: any(named: 'name'))),
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'a download that fails is said',
      setUp: () {
        when(() => repository.receiptPdfUrl('r-1')).thenAnswer((_) async => 'https://r2/r-1.pdf');
        when(() => sharer.shareLink(any(), name: any(named: 'name'))).thenThrow(Exception('offline'));
      },
      build: build,
      seed: () => DeclarationReady(ready),
      act: (bloc) => bloc.add(const DeclarationReceiptRequested(name: 'x')),
      expect: () => [DeclarationReady(ready, receiptBusy: true), DeclarationReady(ready, receiptFailed: true)],
    );

    blocTest<DeclarationBloc, DeclarationState>(
      'no receipt, nothing asked',
      build: build,
      seed: () => DeclarationReady(declaration()),
      act: (bloc) => bloc.add(const DeclarationReceiptRequested(name: 'x')),
      expect: () => const <DeclarationState>[],
      verify: (_) => verifyNever(() => repository.receiptPdfUrl(any())),
    );
  });

  group('the screen', () {
    late MockDeclarationBloc bloc;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const DeclarationConfirmed());
    });

    setUp(() => bloc = MockDeclarationBloc());

    Future<void> pump(WidgetTester tester, DeclarationState state) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
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
          home: BlocProvider<DeclarationBloc>.value(value: bloc, child: const DeclarationView()),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('the tenant has nothing to answer: no bar at all', (tester) async {
      await pump(tester, DeclarationReady(declaration()));

      // CA-M30-03 — said: the money moved outside Mboa.
      expect(find.textContaining('Payé hors de Mboa'), findsOneWidget);
      expect(find.text('Confirmer le paiement'), findsNothing);
      expect(find.byTooltip("Plus d'actions"), findsNothing);
      // Not even an empty strip: the page runs to the bottom.
      expect(tester.getBottomLeft(find.byType(ListView)).dy, 844);
      // What is awaited — not "ta réponse", which is the landlord's.
      expect(find.text('En attente de la réponse du propriétaire.'), findsOneWidget);
    });

    testWidgets('the landlord: confirm is the main action, asked once more', (tester) async {
      await pump(tester, DeclarationReady(declaration(canConfirm: true, canContest: true)));

      await tester.tap(find.text('Confirmer le paiement'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Confirmer le paiement')));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const DeclarationConfirmed())).called(1);
    });

    testWidgets('the landlord: a confirmation called off sends nothing', (tester) async {
      await pump(tester, DeclarationReady(declaration(canConfirm: true)));

      await tester.tap(find.text('Confirmer le paiement'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();

      verifyNever(() => bloc.add(any()));
    });

    testWidgets('the landlord: contesting is behind "⋯", with a reason', (tester) async {
      await pump(tester, DeclarationReady(declaration(canConfirm: true, canContest: true)));

      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Contester'));
      await tester.pumpAndSettle();
      expect(find.byType(ContestSheet), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Rien reçu sur mon compte');
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(ContestSheet), matching: find.text('Contester')));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const DeclarationContested('Rien reçu sur mon compte'))).called(1);
    });

    testWidgets('a contested one shows why', (tester) async {
      await pump(tester, DeclarationReady(declaration(status: DeclarationStatus.contested, contestReason: 'Rien reçu')));

      expect(find.text('« Rien reçu »'), findsOneWidget);
    });

    testWidgets('confirmed: the receipt is the main action, for either party, under a readable name', (tester) async {
      await pump(
        tester,
        DeclarationReady(declaration(status: DeclarationStatus.confirmed, receiptId: 'r-1', receiptReady: true)),
      );

      expect(find.text('Reçu de paiement'), findsOneWidget);
      await tester.tap(find.text('Télécharger le reçu'));
      verify(
        () => bloc.add(const DeclarationReceiptRequested(name: 'Reçu de paiement — Studio Akwa — 18 oct. 2026')),
      ).called(1);
    });

    testWidgets('being made: said on the card, and no button to press yet', (tester) async {
      when(() => bloc.state).thenReturn(
        DeclarationReady(declaration(status: DeclarationStatus.confirmed, receiptId: 'r-1')),
      );
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
          home: BlocProvider<DeclarationBloc>.value(value: bloc, child: const DeclarationView()),
        ),
      );
      // The spinner turns forever: pumped, not settled.
      await tester.pump();

      expect(find.text('Quittance en préparation…'), findsOneWidget);
      expect(find.text('Télécharger le reçu'), findsNothing);
    });

    testWidgets('late in coming: said, and tried again by hand', (tester) async {
      await pump(
        tester,
        DeclarationReady(
          declaration(status: DeclarationStatus.confirmed, receiptId: 'r-1'),
          receiptWaitOver: true,
        ),
      );

      expect(find.textContaining('tarde à arriver'), findsOneWidget);
      await tester.tap(find.text('Réessayer'));
      verify(() => bloc.add(const DeclarationReceiptRefreshed(byHand: true))).called(1);
    });

    testWidgets('the receipt, as the tenant sees it', (tester) async {
      await pump(
        tester,
        DeclarationReady(
          declaration(
            status: DeclarationStatus.confirmed,
            receiptId: 'r-1',
            receiptReady: true,
            answeredAt: DateTime(2026, 10, 20, 8),
          ),
        ),
      );

      // Who did what, and when — not the chip's word again.
      expect(find.text('Le propriétaire a confirmé l\'avoir reçu le 20 octobre 2026.'), findsOneWidget);

      await expectLater(find.byType(DeclarationView), matchesGoldenFile('goldens/declaration_receipt.png'));
    });

    testWidgets('the declaration, as the landlord sees it', (tester) async {
      await pump(tester, DeclarationReady(declaration(canConfirm: true, canContest: true, hasProof: false)));

      await expectLater(find.byType(DeclarationView), matchesGoldenFile('goldens/declaration.png'));
    });
  });
}
