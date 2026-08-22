import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/features/contracts/bloc/contract_detail_bloc.dart';
import 'package:mboa_pro/features/contracts/bloc/contracts_bloc.dart';
import 'package:mboa_pro/features/contracts/ui/contract_detail_page.dart';
import 'package:mboa_pro/features/contracts/ui/contracts_list_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../_helpers/load_brand_fonts.dart';

class MockContractsBloc extends MockBloc<ContractsEvent, ContractsState>
    implements ContractsBloc {}

class MockContractDetailBloc
    extends MockBloc<ContractDetailEvent, ContractDetailState>
    implements ContractDetailBloc {}

/// The M08 screens, each pumped with only the bloc its own route provides.
void main() {
  late MockContractsBloc contracts;
  late MockContractDetailBloc detail;

  Contract contract({
    ContractStatus status = ContractStatus.sent,
    ContractParty awaiting = ContractParty.tenant,
    bool canSign = false,
    bool signed = false,
    List<ChangeRequest> changes = const [],
  }) =>
      Contract(
        id: 'c-1',
        status: status,
        annonceTitle: 'Studio Bonapriso',
        city: 'Douala',
        district: 'Bonapriso',
        exactAddress: signed ? 'Rue 1.234, Bonapriso' : null,
        prestataire: const ContractParticipant(displayName: 'Agence Deido'),
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        price: 110000,
        depositAmount: 220000,
        chargesIncluded: false,
        startDate: DateTime(2026, 9),
        durationUnits: 12,
        tacitRenewal: true,
        awaiting: awaiting,
        canSign: canSign,
        changeRequests: changes,
        lockedAt: signed ? DateTime(2026, 8, 25) : null,
      );

  setUpAll(loadBrandFonts);

  setUp(() {
    contracts = MockContractsBloc();
    detail = MockContractDetailBloc();
    when(() => contracts.state).thenReturn(
      ContractsReady(items: [contract(awaiting: ContractParty.prestataire)]),
    );
    when(() => detail.state).thenReturn(ContractDetailReady(contract()));
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

  Widget withList(Widget child) =>
      BlocProvider<ContractsBloc>.value(value: contracts, child: child);

  Widget withDetail(Widget child) =>
      BlocProvider<ContractDetailBloc>.value(value: detail, child: child);

  group('the list', () {
    testWidgets('leads with what is waiting on him', (tester) async {
      await pump(tester, withList(const ContractsListPage()));

      expect(tester.takeException(), isNull);
      expect(find.text('À vous de jouer (1)'), findsOneWidget);
      expect(find.text('En attente de votre action'), findsOneWidget);
    });

    testWidgets('RM-M08-01 — an empty list points at the biens', (tester) async {
      when(() => contracts.state).thenReturn(const ContractsReady());
      await pump(tester, withList(const ContractsListPage()));

      // A contract always starts from a property, so there is no "+" here.
      expect(find.text('Aucun contrat'), findsOneWidget);
      expect(find.textContaining('part toujours d\'un bien'), findsOneWidget);
    });
  });

  group('the detail', () {
    testWidgets('a draft offers to send, and nothing else', (tester) async {
      when(() => detail.state).thenReturn(
        ContractDetailReady(
          contract(
            status: ContractStatus.draft,
            awaiting: ContractParty.prestataire,
          ),
        ),
      );
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));

      expect(find.text('Envoyer au locataire'), findsOneWidget);
      expect(find.text('Signer'), findsNothing);
    });

    testWidgets('CA-M08-02 — an unsigned contract withholds the address',
        (tester) async {
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));

      // The server withholds it until both signatures are in; the header shows
      // the quartier, as the listing does.
      expect(find.textContaining('Rue 1.234'), findsNothing);
      expect(find.textContaining('Bonapriso'), findsWidgets);
    });

    testWidgets('CA-M08-02 — once signed, it is there', (tester) async {
      when(() => detail.state).thenReturn(
        ContractDetailReady(
          contract(
            status: ContractStatus.signed,
            awaiting: ContractParty.nobody,
            signed: true,
          ),
        ),
      );
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));

      expect(find.textContaining('Rue 1.234'), findsOneWidget);
    });

    testWidgets('RM-M08-03 — a signed contract says it is locked and offers '
        'the PDF', (tester) async {
      when(() => detail.state).thenReturn(
        ContractDetailReady(
          contract(
            status: ContractStatus.signed,
            awaiting: ContractParty.nobody,
            signed: true,
          ),
        ),
      );
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));

      expect(find.textContaining('verrouillé'), findsOneWidget);
      expect(find.text('Télécharger le PDF'), findsOneWidget);
      // Nothing to amend, nothing to cancel.
      expect(find.text('Modifier les termes'), findsNothing);
      expect(find.text('Annuler le contrat'), findsNothing);
    });

    testWidgets('CE-M08-03 — a pending objection asks for an answer',
        (tester) async {
      when(() => detail.state).thenReturn(
        ContractDetailReady(
          contract(
            status: ContractStatus.changesRequested,
            awaiting: ContractParty.prestataire,
            changes: [
              ChangeRequest(
                id: 'ch-1',
                comment: 'La caution de 2 mois est trop élevée.',
                contestedTerms: const [ContestedTerm.depositAmount],
                createdAt: DateTime(2026, 8, 20),
                pending: true,
              ),
            ],
          ),
        ),
      );
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));
      // The negotiation sits below the terms and the parties.
      await tester.scrollUntilVisible(find.text('Répondre'), 200);

      expect(find.text('Objection en attente de votre réponse'), findsOneWidget);
      expect(find.text('Caution'), findsWidgets);
      expect(find.text('Répondre'), findsOneWidget);
    });

    testWidgets('RM-M08-03 — signing needs the word typed, not a tap',
        (tester) async {
      when(() => detail.state)
          .thenReturn(ContractDetailReady(contract(canSign: true)));
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));

      await tester.tap(find.text('Signer'));
      await tester.pumpAndSettle();

      // The sheet's own button is inert until the word matches — a bail is not
      // signed by a distracted tap.
      final button = tester.widget<Button>(find.byType(Button).last);
      expect(button.onPressed, isNull);

      await tester.enterText(find.byType(TextField).last, 'signer');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Button).last);
      await tester.pumpAndSettle();

      verify(() => detail.add(const ContractSigned())).called(1);
    });

    testWidgets('the detail', (tester) async {
      when(() => detail.state).thenReturn(
        ContractDetailReady(
          contract(
            status: ContractStatus.changesRequested,
            awaiting: ContractParty.prestataire,
            changes: [
              ChangeRequest(
                id: 'ch-1',
                comment: 'La caution de 2 mois est trop élevée.',
                contestedTerms: const [ContestedTerm.depositAmount],
                createdAt: DateTime(2026, 8, 20),
                pending: true,
              ),
            ],
          ),
        ),
      );
      await pump(tester, withDetail(const ContractDetailPage(id: 'c-1')));

      await expectLater(
        find.byType(ContractDetailPage),
        matchesGoldenFile('goldens/contract_detail.png'),
      );
    });
  });
}
