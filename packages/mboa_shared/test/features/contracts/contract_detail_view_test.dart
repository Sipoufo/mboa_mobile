import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockContractDetailBloc
    extends MockBloc<ContractDetailEvent, ContractDetailState>
    implements ContractDetailBloc {}

/// The shared M08 detail, from each side of the document (CDC M08, M27's
/// entry point).
///
/// The screen is one screen; what differs is which actions it offers, and that
/// comes from the server's `status` and `awaiting` plus which app is running.
/// These check that the wrong half is **absent** rather than present and
/// refused — a button that exists and then fails is worse than no button.
void main() {
  late MockContractDetailBloc detail;

  Contract contract({
    ContractStatus status = ContractStatus.sent,
    ContractParty awaiting = ContractParty.tenant,
    bool canSign = false,
  }) =>
      Contract(
        id: 'c-1',
        status: status,
        annonceTitle: 'Studio Bonapriso',
        city: 'Douala',
        prestataire: const ContractParticipant(displayName: 'Agence Deido'),
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2026, 9),
        durationUnits: 12,
        awaiting: awaiting,
        canSign: canSign,
      );

  setUp(() {
    detail = MockContractDetailBloc();
    when(() => detail.state).thenReturn(ContractDetailReady(contract()));
  });

  Future<void> pump(WidgetTester tester, Widget child) async {
    tester.view.physicalSize = const Size(390 * 3, 1400 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<ContractDetailBloc>.value(value: detail, child: child),
      ),
    );
    await tester.pumpAndSettle();
  }

  group("the tenant's side", () {
    testWidgets(
      'RM-M08-02 — the terms can be taken or contested while the ball is theirs',
      (tester) async {
        await pump(
          tester,
          const ContractDetailView(id: 'c-1', viewer: ContractParty.tenant),
        );

        expect(find.text('Accepter les termes'), findsOneWidget);
        expect(find.text('Demander une modification'), findsOneWidget);
        // RM-M08-01/08 — redrafting is the landlord's, and `onAmend` is null
        // here, so the button is not drawn at all.
        expect(find.text('Modifier les termes'), findsNothing);
      },
    );

    testWidgets(
      'nothing to decide while the landlord still owes an answer',
      (tester) async {
        when(() => detail.state).thenReturn(
          ContractDetailReady(
            contract(
              status: ContractStatus.changesRequested,
              awaiting: ContractParty.prestataire,
            ),
          ),
        );

        await pump(
          tester,
          const ContractDetailView(id: 'c-1', viewer: ContractParty.tenant),
        );

        expect(find.text('Accepter les termes'), findsNothing);
        expect(find.text('Demander une modification'), findsNothing);
      },
    );

    testWidgets('accepting asks the server, and does not guess the outcome',
        (tester) async {
      await pump(
        tester,
        const ContractDetailView(id: 'c-1', viewer: ContractParty.tenant),
      );
      await tester.tap(find.text('Accepter les termes'));
      await tester.pump();

      verify(() => detail.add(const ContractAccepted())).called(1);
    });

    testWidgets('CE-M08-03 — an objection with no words cannot be sent',
        (tester) async {
      await pump(
        tester,
        const ContractDetailView(id: 'c-1', viewer: ContractParty.tenant),
      );
      await tester.tap(find.text('Demander une modification'));
      await tester.pumpAndSettle();

      final send = tester.widget<Button>(
        find.widgetWithText(Button, "Envoyer l'objection"),
      );
      expect(send.onPressed, isNull);
    });

    testWidgets('RM-M08-07 — the contested terms travel with the objection',
        (tester) async {
      await pump(
        tester,
        const ContractDetailView(id: 'c-1', viewer: ContractParty.tenant),
      );
      await tester.tap(find.text('Demander une modification'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(FilterChip, 'Caution'));
      await tester.enterText(find.byType(TextField), '  Trop élevée.  ');
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(Button, "Envoyer l'objection"));
      await tester.pumpAndSettle();

      verify(
        () => detail.add(
          const ContractChangesRequested(
            comment: 'Trop élevée.',
            terms: [ContestedTerm.depositAmount],
          ),
        ),
      ).called(1);
    });
  });

  group("the landlord's side", () {
    testWidgets('redrafting is offered, accepting is not', (tester) async {
      await pump(
        tester,
        ContractDetailView(
          id: 'c-1',
          viewer: ContractParty.prestataire,
          onAmend: (_) {},
        ),
      );

      expect(find.text('Modifier les termes'), findsOneWidget);
      // Taking the terms is the tenant's move; the landlord wrote them.
      expect(find.text('Accepter les termes'), findsNothing);
      expect(find.text('Demander une modification'), findsNothing);
    });
  });
}
