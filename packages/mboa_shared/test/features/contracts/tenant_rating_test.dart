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

class _FakeRateTenantRequest extends Fake implements RateTenantRequest {}

/// §37 A — the landlord rates the tenant once the tenancy has ended.
void main() {
  Contract ended({bool canRateTenant = true, int? tenantRating}) => Contract(
        id: 'c-1',
        status: ContractStatus.signed,
        annonceTitle: 'Studio Bonapriso',
        city: 'Douala',
        prestataire: const ContractParticipant(displayName: 'Agence Deido'),
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2025, 9),
        durationUnits: 12,
        canRateTenant: canRateTenant,
        tenantRating: tenantRating,
      );

  setUpAll(() async {
    registerFallbackValue(_FakeRateTenantRequest());
    await loadBrandFonts();
  });

  group('the screen', () {
    late MockContractDetailBloc bloc;

    setUp(() {
      bloc = MockContractDetailBloc();
      when(() => bloc.state).thenReturn(ContractDetailReady(ended()));
    });

    Future<void> pump(WidgetTester tester) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<ContractDetailBloc>.value(
            value: bloc,
            child: const ContractDetailView(id: 'c-1', viewer: ContractParty.prestataire),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('while it may be rated, rating is the main action; the PDF moves behind « ⋯ »', (tester) async {
      await pump(tester);

      expect(find.widgetWithText(Button, 'Noter le locataire'), findsOneWidget);
      expect(find.widgetWithText(Button, 'Télécharger le PDF'), findsNothing);

      await tester.tap(find.byTooltip('Plus d\'actions'));
      await tester.pumpAndSettle();
      expect(find.text('Télécharger le PDF'), findsOneWidget);
    });

    testWidgets('the stars and a word for Mboa go to the bloc; no stars, nothing to send', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Noter le locataire'));
      await tester.pumpAndSettle();

      final send = find.widgetWithText(Button, 'Envoyer la note');
      expect(tester.widget<Button>(send).onPressed, isNull);
      expect(find.text('Seul Mboa lit ce commentaire.'), findsOneWidget);

      await tester.tap(find.byTooltip('4 étoiles sur 5'));
      await tester.enterText(find.byType(TextField), 'Locataire soigneux, toujours à l\'heure.');
      await tester.pump();
      await tester.tap(send);
      await tester.pumpAndSettle();

      verify(() => bloc.add(const ContractTenantRated(stars: 4, comment: 'Locataire soigneux, toujours à l\'heure.')))
          .called(1);
    });

    testWidgets('once rated: the stars on the contract, and the PDF back in front', (tester) async {
      when(() => bloc.state).thenReturn(ContractDetailReady(ended(canRateTenant: false, tenantRating: 4)));
      await pump(tester);

      expect(find.text('Ta note du locataire'), findsOneWidget);
      expect(find.byWidgetPredicate((w) => w is TenantStars && w.stars == 4 && w.onChanged == null), findsOneWidget);
      expect(find.widgetWithText(Button, 'Télécharger le PDF'), findsOneWidget);
    });

    testWidgets('the sheet', (tester) async {
      await pump(tester);
      await tester.tap(find.text('Noter le locataire'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('4 étoiles sur 5'));
      await tester.pump();

      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/tenant_rating_sheet.png'));
    });
  });

  group('the bloc', () {
    late MockContractRepository repository;

    setUp(() {
      repository = MockContractRepository();
      when(() => repository.rateTenant(any(), stars: any(named: 'stars'), comment: any(named: 'comment')))
          .thenAnswer((_) async => ended(canRateTenant: false, tenantRating: 5));
    });

    blocTest<ContractDetailBloc, ContractDetailState>(
      'rated: the contract read again says so',
      build: () => ContractDetailBloc(repository: repository),
      seed: () => ContractDetailReady(ended()),
      act: (bloc) => bloc.add(const ContractTenantRated(stars: 5)),
      expect: () => [
        ContractDetailReady(ended(), isBusy: true),
        ContractDetailReady(ended(canRateTenant: false, tenantRating: 5), justActed: true),
      ],
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'outside 1–5 nothing is sent',
      build: () => ContractDetailBloc(repository: repository),
      seed: () => ContractDetailReady(ended()),
      act: (bloc) => bloc
        ..add(const ContractTenantRated(stars: 0))
        ..add(const ContractTenantRated(stars: 6)),
      expect: () => const <ContractDetailState>[],
    );
  });

  group('the wire', () {
    test('an empty comment is no comment; the contract is read again', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final api = MockContratsApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getContratsApi).thenReturn(api);
      when(() => api.rateTenant(id: 'c-1', rateTenantRequest: any(named: 'rateTenantRequest'))).thenAnswer(
        (_) async => Response(
          data: TenantRatingResponse((b) => b
            ..contractId = 'c-1'
            ..stars = 3),
          requestOptions: RequestOptions(path: '/contracts/c-1/tenant-rating'),
          statusCode: 201,
        ),
      );
      when(() => api.getContract(id: 'c-1')).thenAnswer(
        (_) async => Response(
          data: ContractResponse((b) => b
            ..id = 'c-1'
            ..canRateTenant = false
            ..tenantRating = 3),
          requestOptions: RequestOptions(path: '/contracts/c-1'),
          statusCode: 200,
        ),
      );

      final contract = await ContractRepository(dioClient: dioClient).rateTenant('c-1', stars: 3, comment: '   ');

      final sent = verify(() => api.rateTenant(id: 'c-1', rateTenantRequest: captureAny(named: 'rateTenantRequest')))
          .captured
          .single as RateTenantRequest;
      expect((sent.stars, sent.comment), (3, null));
      expect(contract.tenantRating, 3);
    });
  });
}
