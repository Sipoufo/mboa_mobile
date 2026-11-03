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

class MockKycRepository extends Mock implements KycRepository {}

class MockMediaUploader extends Mock implements MediaUploader {}

class MockKycApi extends Mock implements KYCApi {}

class MockKycCubit extends MockCubit<KycState> implements KycCubit {}

/// §40 F — the founder's owner had an approved KYC and still typed his
/// identity at every signature, into an empty form: approved before §39 B,
/// his KYC held no document. It can now be added, once, without a new review.
void main() {
  final today = DateTime.now();
  final document = DocumentIdentity(
    type: KycDocType.cni,
    number: 'CM1234567',
    issuedOn: DateTime(2022, 5, 2),
    expiresOn: DateTime(today.year + 5, 5, 1),
    issuedAt: 'Yaoundé',
  );
  const missing = KycStatusData(status: KycStatus.approved, documentMissing: true);
  final complete = KycStatusData(status: KycStatus.approved, identity: document);

  setUpAll(() async {
    await loadBrandFonts();
    registerFallbackValue(const DocumentIdentity());
    registerFallbackValue(
      KycDocumentRequest((b) => b
        ..idDocumentType = KycDocumentRequestIdDocumentTypeEnum.CNI
        ..idNumber = 'x'
        ..issuedOn = Date(2020, 1, 1)
        ..expiresOn = Date(2030, 1, 1)
        ..issuedAt = 'x'),
    );
  });

  test('only an approved KYC without its document can receive one', () {
    expect(missing.canAddDocument, isTrue);
    expect(complete.canAddDocument, isFalse);
    expect(const KycStatusData(status: KycStatus.pending, documentMissing: true).canAddDocument, isFalse);
  });

  group('the repository', () {
    test('sends the five details to PUT /kyc/me/document, and reads documentMissing back', () async {
      final api = MockKycApi();
      final dioClient = MockDioClient();
      final client = MockApiClient();
      when(() => dioClient.api).thenReturn(client);
      when(client.getKYCApi).thenReturn(api);
      when(() => api.addMyKycDocument(kycDocumentRequest: any(named: 'kycDocumentRequest'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          data: KycStatusResponse((b) => b
            ..status = 'APPROVED'
            ..documentMissing = false),
        ),
      );

      final status = await KycRepository(dioClient: dioClient).addDocument(document);

      final sent = verify(() => api.addMyKycDocument(kycDocumentRequest: captureAny(named: 'kycDocumentRequest')))
          .captured
          .single as KycDocumentRequest;
      expect(sent.idDocumentType, KycDocumentRequestIdDocumentTypeEnum.CNI);
      expect(sent.idNumber, 'CM1234567');
      expect(sent.issuedOn, Date(2022, 5, 2));
      expect(sent.issuedAt, 'Yaoundé');
      expect(status.canAddDocument, isFalse);
    });
  });

  test('the repository reads « documentMissing » from the status', () async {
    final api = MockKycApi();
    final dioClient = MockDioClient();
    final client = MockApiClient();
    when(() => dioClient.api).thenReturn(client);
    when(client.getKYCApi).thenReturn(api);
    when(api.getMyKycStatus).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        data: KycStatusResponse((b) => b
          ..status = 'APPROVED'
          ..documentMissing = true),
      ),
    );

    final status = await KycRepository(dioClient: dioClient).loadStatus();

    expect(status.canAddDocument, isTrue);
  });

  group('the cubit', () {
    late MockKycRepository repository;

    setUp(() => repository = MockKycRepository());

    KycCubit build() => KycCubit(repository: repository, uploader: MockMediaUploader());

    blocTest<KycCubit, KycState>(
      'adds it and says so, once',
      setUp: () => when(() => repository.addDocument(any())).thenAnswer((_) async => complete),
      build: build,
      seed: () => KycReady(missing, KycDraft.of(missing)),
      act: (cubit) => cubit.addDocument(document),
      expect: () => [
        KycReady(missing, KycDraft.of(missing), submitting: true),
        KycReady(complete, KycDraft.of(complete), addedDocument: true),
      ],
    );

    blocTest<KycCubit, KycState>(
      'an expired document is refused before it is sent, and by the server after',
      setUp: () => when(() => repository.addDocument(any())).thenAnswer(
        (_) async => throw DioException(
          requestOptions: RequestOptions(),
          response: Response(requestOptions: RequestOptions(), statusCode: 400, data: {'error': 'ID_DOCUMENT_EXPIRED'}),
        ),
      ),
      build: build,
      seed: () => KycReady(missing, KycDraft.of(missing)),
      act: (cubit) => cubit.addDocument(document),
      skip: 1,
      expect: () => [KycReady(missing, KycDraft.of(missing), error: KycError.documentExpired)],
    );

    blocTest<KycCubit, KycState>(
      'already there (added elsewhere): the status is read again',
      setUp: () {
        when(() => repository.addDocument(any())).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response: Response(requestOptions: RequestOptions(), statusCode: 409, data: {'error': 'KYC_DOCUMENT_PRESENT'}),
          ),
        );
        when(repository.loadStatus).thenAnswer((_) async => complete);
      },
      build: build,
      seed: () => KycReady(missing, KycDraft.of(missing)),
      act: (cubit) => cubit.addDocument(document),
      skip: 1,
      expect: () => [KycReady(complete, KycDraft.of(complete))],
    );
  });

  group('the screens', () {
    late MockKycCubit cubit;

    setUp(() {
      cubit = MockKycCubit();
      when(() => cubit.addDocument(any())).thenAnswer((_) async {});
    });

    Future<void> pump(WidgetTester tester, Widget child, {String? tab}) async {
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
          home: BlocProvider<KycCubit>.value(value: cubit, child: child),
        ),
      );
      await tester.pumpAndSettle();
      if (tab != null) {
        await tester.tap(find.text(tab));
        await tester.pumpAndSettle();
      }
    }

    testWidgets('Certifications: approved without its document — say so, and « À compléter »', (tester) async {
      when(() => cubit.state).thenReturn(KycReady(missing, KycDraft.of(missing)));
      await pump(tester, CertificationsView(onOpenIdDocument: () {}));

      expect(find.text("Complète ta pièce d'identité"), findsOneWidget);
      expect(find.text('À compléter'), findsOneWidget);
      await expectLater(find.byType(CertificationsView), matchesGoldenFile('goldens/kyc_document_missing.png'));
    });

    testWidgets('Certifications: « Compléter » opens the sheet, and what is saved is added', (tester) async {
      when(() => cubit.state).thenReturn(KycReady(missing, KycDraft.of(missing)));
      await pump(tester, CertificationsView(onOpenIdDocument: () {}));

      await tester.tap(find.text('Compléter'));
      await tester.pumpAndSettle();
      expect(find.byType(DocumentSheet), findsOneWidget);
      // Starts from nothing: nothing to save yet.
      final save = tester.widget<Button>(find.widgetWithText(Button, 'Enregistrer'));
      expect(save.onPressed, isNull);
    });

    testWidgets('the sheet: complete, it hands the document back', (tester) async {
      DocumentIdentity? saved;
      await pump(
        tester,
        Scaffold(
          body: Builder(
            builder: (context) => TextButton(
              onPressed: () async => saved = await showDocumentSheet(context, initial: document),
              child: const Text('open'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(Button, 'Enregistrer'));
      await tester.pumpAndSettle();

      expect(saved, document);
    });

    testWidgets('Certifications: approved with its document — nothing to complete', (tester) async {
      when(() => cubit.state).thenReturn(KycReady(complete, KycDraft.of(complete)));
      await pump(tester, CertificationsView(onOpenIdDocument: () {}));

      expect(find.text("Complète ta pièce d'identité"), findsNothing);
      expect(find.text('À compléter'), findsNothing);
    });

    testWidgets('the invitation banner: a fourth face, until it is added', (tester) async {
      when(() => cubit.state).thenReturn(KycReady(missing, KycDraft.of(missing)));
      var opened = 0;
      await pump(tester, Scaffold(body: KycInviteBanner(role: AccountRole.prestataire, onOpen: () => opened++)));

      expect(find.text("Complète ta pièce d'identité"), findsOneWidget);
      await tester.tap(find.text('Compléter'));
      expect(opened, 1);
    });

    testWidgets('signing: the form starts from what the KYC holds', (tester) async {
      await pump(
        tester,
        Scaffold(
          body: SignContractSheet(
            contract: const Contract(id: 'c-1', status: ContractStatus.accepted, canSign: true, identityRequired: true),
            identityPrefill: document,
          ),
        ),
      );

      expect(find.text('CM1234567'), findsOneWidget);
      expect(find.text('Yaoundé'), findsOneWidget);
    });

    testWidgets('signing without the document on an approved KYC: how to stop typing it', (tester) async {
      await pump(
        tester,
        const Scaffold(
          body: SignContractSheet(
            contract: Contract(id: 'c-1', status: ContractStatus.accepted, canSign: true, identityRequired: true),
            documentMissing: true,
          ),
        ),
      );

      expect(find.text('Ajoute ta pièce à tes certifications pour ne plus la retaper.'), findsOneWidget);
    });
  });
}
