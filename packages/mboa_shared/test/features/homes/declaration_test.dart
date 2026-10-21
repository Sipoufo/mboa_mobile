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

    testWidgets('the declaration, as the landlord sees it', (tester) async {
      await pump(tester, DeclarationReady(declaration(canConfirm: true, canContest: true, hasProof: false)));

      await expectLater(find.byType(DeclarationView), matchesGoldenFile('goldens/declaration.png'));
    });
  });
}
