import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

class MockContractDetailBloc extends MockBloc<ContractDetailEvent, ContractDetailState>
    implements ContractDetailBloc {}

/// RM-M08-03 — two signatures, one per party.
///
/// Regression (seen on device, 2026-10-20): the server's `current` says a
/// signature covers the terms as they stand, not that it is the reader's. Read
/// as "mine", the tenant's signature made the landlord's screen say "Tu as
/// signé" and he could not sign.
void main() {
  late MockContractDetailBloc bloc;

  Contract accepted({required bool canSign, List<ContractSignature> signatures = const []}) => Contract(
        id: 'c-1',
        status: ContractStatus.accepted,
        annonceTitle: 'Studio Bonapriso',
        prestataire: const ContractParticipant(accountId: 'p-1', displayName: 'Agence Deido'),
        tenant: const ContractParticipant(accountId: 't-1', displayName: 'Awa Nkeng'),
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2026, 11),
        durationUnits: 12,
        awaiting: ContractParty.prestataire,
        canSign: canSign,
        signatures: signatures,
      );

  final tenantSigned = ContractSignature(signerAccountId: 't-1', signedAt: DateTime(2026, 10, 20, 9));

  setUp(() => bloc = MockContractDetailBloc());

  Future<void> pump(WidgetTester tester, Contract contract, ContractParty viewer) async {
    tester.view.physicalSize = const Size(390 * 3, 1400 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    when(() => bloc.state).thenReturn(ContractDetailReady(contract));

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<ContractDetailBloc>.value(
          value: bloc,
          child: ContractDetailView(id: 'c-1', viewer: viewer),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('the tenant has signed: the landlord can still sign', (tester) async {
    await pump(tester, accepted(canSign: true, signatures: [tenantSigned]), ContractParty.prestataire);

    final sign = tester.widget<Button>(find.widgetWithText(Button, 'Signer'));
    expect(sign.onPressed, isNotNull);
    expect(find.text('Tu as signé'), findsNothing);
    // And the signature is called the tenant's, not his.
    expect(find.text('Signature du locataire'), findsOneWidget);
    expect(find.text('Ta signature'), findsNothing);
  });

  testWidgets('the tenant reads it as their own', (tester) async {
    await pump(tester, accepted(canSign: false, signatures: [tenantSigned]), ContractParty.tenant);

    expect(find.text('Ta signature'), findsOneWidget);
    // Signed already: the server says so (canSign false), and no button offers it again.
    expect(find.widgetWithText(Button, 'Signer'), findsNothing);
  });

  testWidgets('the landlord\'s signature, read by the tenant', (tester) async {
    await pump(
      tester,
      accepted(canSign: true, signatures: [ContractSignature(signerAccountId: 'p-1', signedAt: DateTime(2026, 10, 20))]),
      ContractParty.tenant,
    );

    expect(find.text('Signature du prestataire'), findsOneWidget);
  });

  testWidgets('a signature on terms amended since says it no longer counts', (tester) async {
    await pump(
      tester,
      accepted(
        canSign: true,
        signatures: [
          ContractSignature(signerAccountId: 't-1', signedAt: DateTime(2026, 10, 19), coversCurrentTerms: false),
        ],
      ),
      ContractParty.prestataire,
    );

    expect(find.textContaining('Sur des termes modifiés depuis'), findsOneWidget);
  });

  test('a signature is matched to its party by account', () {
    final contract = accepted(canSign: true);

    expect(contract.signerOf(tenantSigned), ContractParty.tenant);
    expect(contract.signerOf(const ContractSignature(signerAccountId: 'p-1')), ContractParty.prestataire);
    expect(contract.signerOf(const ContractSignature(signerAccountId: 'x')), ContractParty.unknown);
  });
}
