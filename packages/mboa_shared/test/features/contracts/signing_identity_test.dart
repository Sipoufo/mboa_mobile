import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';
import '../score/load_brand_fonts.dart';

class MockContractDetailBloc extends MockBloc<ContractDetailEvent, ContractDetailState> implements ContractDetailBloc {}

class MockContractRepository extends Mock implements ContractRepository {}

class MockContratsApi extends Mock implements ContratsApi {}

class _FakeSign extends Fake implements SignContractRequest {}

/// §39 D — each party signs with their identity: verified, or typed.
void main() {
  final today = DateTime(2026, 10, 28);
  final typed = DocumentIdentity(
    type: KycDocType.cni,
    number: 'CM1234567',
    issuedOn: DateTime(2020, 3, 1),
    expiresOn: DateTime(2035, 3, 1),
    issuedAt: 'Douala',
  );

  Contract contract({bool identityRequired = false, List<ContractSignature> signatures = const []}) => Contract(
        id: 'c-1',
        status: ContractStatus.accepted,
        annonceTitle: 'Studio Bonapriso',
        prestataire: const ContractParticipant(accountId: 'p-1', displayName: 'Agence Deido'),
        tenant: const ContractParticipant(accountId: 't-1', displayName: 'Awa Nkeng'),
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2026, 11),
        durationUnits: 12,
        canSign: true,
        identityRequired: identityRequired,
        signatures: signatures,
      );

  setUpAll(() async {
    registerFallbackValue(_FakeSign());
    registerFallbackValue(const DocumentIdentity());
    await loadBrandFonts();
  });

  group('the sheet', () {
    Future<List<SignConfirmation?>> open(WidgetTester tester, Contract contract) async {
      tester.view.physicalSize = const Size(390 * 3, 1100 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final out = <SignConfirmation?>[];
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () async => out.add(await showModalBottomSheet<SignConfirmation>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => SignContractSheet(contract: contract, today: today),
                  )),
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return out;
    }

    Button sign(WidgetTester tester) => tester.widget<Button>(find.widgetWithText(Button, 'Signer'));

    testWidgets('a verified identity: nothing to type, the word is enough', (tester) async {
      final out = await open(tester, contract());

      expect(find.text('Ton identité'), findsNothing);
      await tester.enterText(find.byType(TextField).last, 'SIGNER');
      await tester.pump();
      await tester.tap(find.widgetWithText(Button, 'Signer'));
      await tester.pumpAndSettle();

      expect(out.single?.identity, isNull);
    });

    testWidgets('no verified identity: « Signer » waits for the document as well as the word', (tester) async {
      await open(tester, contract(identityRequired: true));

      expect(find.text('Ton identité'), findsOneWidget);
      // The word's field is the last one, below the document's.
      await tester.enterText(find.byType(TextField).last, 'SIGNER');
      await tester.pump();

      expect(sign(tester).onPressed, isNull);
    });

    testWidgets('the sheet, with the identity to type', (tester) async {
      await open(tester, contract(identityRequired: true));

      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/sign_with_identity.png'));
    });
  });

  testWidgets('from the screen: the identity typed goes to the bloc with the signature', (tester) async {
    final bloc = MockContractDetailBloc();
    when(() => bloc.state).thenReturn(ContractDetailReady(contract(identityRequired: true)));
    tester.view.physicalSize = const Size(390 * 3, 1100 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: BlocProvider<ContractDetailBloc>.value(
          value: bloc,
          child: ContractDetailView(id: 'c-1', viewer: ContractParty.tenant, identityPrefill: typed),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(Button, 'Signer').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'SIGNER');
    await tester.pump();
    await tester.tap(find.widgetWithText(Button, 'Signer').last);
    await tester.pumpAndSettle();

    verify(() => bloc.add(ContractSigned(identity: typed))).called(1);
  });

  group('the signatures card', () {
    testWidgets('each signature says its document, and who vouches for it', (tester) async {
      final bloc = MockContractDetailBloc();
      when(() => bloc.state).thenReturn(ContractDetailReady(contract(signatures: [
        ContractSignature(
          signerAccountId: 'p-1',
          signedAt: DateTime(2026, 10, 27, 10),
          identity: SignatureIdentity(document: typed.copyWith(number: '*****3456'), verified: true),
        ),
        ContractSignature(
          signerAccountId: 't-1',
          signedAt: DateTime(2026, 10, 28, 9),
          identity: SignatureIdentity(document: typed.copyWith(type: KycDocType.passport, number: 'AA0123456')),
        ),
      ])));
      tester.view.physicalSize = const Size(390 * 3, 1600 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<ContractDetailBloc>.value(
            value: bloc,
            child: const ContractDetailView(id: 'c-1', viewer: ContractParty.tenant),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Carte d’identité · *****3456 · Vérifiée par Mboa'), findsOneWidget);
      expect(find.text('Passeport · AA0123456 · Déclarée, non vérifiée'), findsOneWidget);
    });
  });

  group('the bloc and the wire', () {
    blocTest<ContractDetailBloc, ContractDetailState>(
      'the typed identity goes with the signature',
      build: () {
        final repository = MockContractRepository();
        when(() => repository.sign(any(), identity: any(named: 'identity'))).thenAnswer((_) async => contract());
        return ContractDetailBloc(repository: repository);
      },
      seed: () => ContractDetailReady(contract(identityRequired: true)),
      act: (bloc) => bloc.add(ContractSigned(identity: typed)),
      verify: (bloc) => expect((bloc.state as ContractDetailReady).justActed, isTrue),
    );

    test('…and reaches the repository as typed', () async {
      final repository = MockContractRepository();
      when(() => repository.sign(any(), identity: any(named: 'identity'))).thenAnswer((_) async => contract());
      final bloc = ContractDetailBloc(repository: repository)..emit(ContractDetailReady(contract(identityRequired: true)));

      bloc.add(ContractSigned(identity: typed));
      await bloc.stream.firstWhere((s) => s is ContractDetailReady && s.justActed);

      verify(() => repository.sign('c-1', identity: typed)).called(1);
      await bloc.close();
    });

    test('on the wire: the five fields, and nothing when the KYC vouches', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final api = MockContratsApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getContratsApi).thenReturn(api);
      when(() => api.signContract(id: 'c-1', signContractRequest: any(named: 'signContractRequest'))).thenAnswer(
        (_) async => Response(
          data: ContractResponse((b) => b..id = 'c-1'),
          requestOptions: RequestOptions(path: '/contracts/c-1/sign'),
          statusCode: 200,
        ),
      );
      final repository = ContractRepository(dioClient: dioClient);

      await repository.sign('c-1', identity: typed);
      await repository.sign('c-1');

      final sent = verify(() => api.signContract(id: 'c-1', signContractRequest: captureAny(named: 'signContractRequest')))
          .captured
          .cast<SignContractRequest>();
      final identity = sent.first.identity!;
      expect(
        (identity.idDocumentType, identity.idNumber, identity.issuedOn, identity.expiresOn, identity.issuedAt),
        (SigningIdentityRequestIdDocumentTypeEnum.CNI, 'CM1234567', Date(2020, 3, 1), Date(2035, 3, 1), 'Douala'),
      );
      expect(sent.last.identity, isNull);
    });
  });
}
