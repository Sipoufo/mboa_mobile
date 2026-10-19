import 'package:api_client/api_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';
import '../score/load_brand_fonts.dart';

class MockContratsApi extends Mock implements ContratsApi {}

class MockContractRepository extends Mock implements ContractRepository {}

class MockContractDetailBloc extends MockBloc<ContractDetailEvent, ContractDetailState>
    implements ContractDetailBloc {}

class _FakeTerminate extends Fake implements TerminateContractRequest {}

/// RM-M08-11 / RM-M08-12 — ending a signed contract, from both sides.
void main() {
  Contract signed({Tenancy? tenancy, DateTime? endDate}) => Contract(
        id: 'c-1',
        status: ContractStatus.signed,
        annonceTitle: 'Studio Bonapriso',
        city: 'Douala',
        prestataire: const ContractParticipant(displayName: 'Agence Deido'),
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        price: 110000,
        depositAmount: 220000,
        startDate: DateTime(2026, 9),
        endDate: endDate ?? DateTime(2027, 8, 31),
        durationUnits: 12,
        awaiting: ContractParty.nobody,
        tenancy: tenancy ??
            Tenancy(
              state: TenancyState.running,
              endsOn: DateTime(2027, 8, 31),
              canTerminate: true,
              earliestNoticeDate: DateTime(2026, 11, 19),
            ),
      );

  final proposedToMe = Tenancy(
    state: TenancyState.running,
    endsOn: DateTime(2027, 8, 31),
    termination: Termination(
      status: TerminationStatus.proposed,
      requestedBy: ContractParty.prestataire,
      mutual: true,
      reason: 'Je reprends le logement pour ma famille.',
      effectiveDate: DateTime(2026, 12, 31),
      canAnswer: true,
    ),
  );

  group('the model', () {
    test('reads the tenancy and its latest termination as the server sends them', () {
      final contract = Contract.fromResponse(
        ContractResponse(
          (b) => b
            ..id = 'c-1'
            ..status = ContractResponseStatusEnum.SIGNED
            ..reservationRequestId = 'r-1'
            ..tenancy.state = ContractTenancyResponseStateEnum.RUNNING
            ..tenancy.endsOn = Date(2026, 12, 31)
            ..tenancy.canTerminate = false
            ..tenancy.termination.status = TerminationResponseStatusEnum.NOTIFIED
            ..tenancy.termination.requestedBy = TerminationResponseRequestedByEnum.TENANT
            ..tenancy.termination.mutual = false
            ..tenancy.termination.effectiveDate = Date(2026, 12, 31),
        ),
      );

      expect(contract.reservationRequestId, 'r-1');
      expect(contract.tenancy?.state, TenancyState.running);
      expect(contract.tenancy?.endsOn, DateTime(2026, 12, 31));
      final termination = contract.tenancy!.termination!;
      expect(termination.status.isBinding, isTrue);
      expect(termination.requestedBy, ContractParty.tenant);
      expect(termination.mutual, isFalse);
    });

    test('no tenancy before the signatures', () {
      final contract = Contract.fromResponse(ContractResponse((b) => b..id = 'c-1'));
      expect(contract.tenancy, isNull);
    });
  });

  group('the repository', () {
    late MockContratsApi api;
    late ContractRepository repository;

    setUpAll(() => registerFallbackValue(_FakeTerminate()));

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      api = MockContratsApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getContratsApi).thenReturn(api);
      repository = ContractRepository(dioClient: dioClient);
    });

    Response<ContractResponse> ok() => Response(
          data: ContractResponse((b) => b..id = 'c-1'),
          requestOptions: RequestOptions(path: '/contracts/c-1/termination'),
        );

    test('sends the last day, the trimmed reason and the mode', () async {
      when(() => api.terminateContract(id: 'c-1', terminateContractRequest: any(named: 'terminateContractRequest')))
          .thenAnswer((_) async => ok());

      await repository.terminate('c-1', lastDay: DateTime(2026, 12, 31), reason: '  Mutation  ', mutual: false);

      final body = verify(
        () => api.terminateContract(id: 'c-1', terminateContractRequest: captureAny(named: 'terminateContractRequest')),
      ).captured.single as TerminateContractRequest;
      expect(body.effectiveDate, Date(2026, 12, 31));
      expect(body.reason, 'Mutation');
      expect(body.mutual, isFalse);
    });

    for (final (code, reason) in const [
      ('NOTICE_TOO_SHORT', TerminationRefusal.noticeTooShort),
      ('TERMINATION_DATE_PAST', TerminationRefusal.datePast),
      ('TERMINATION_AFTER_TERM', TerminationRefusal.afterTerm),
      ('TERMINATION_PENDING', TerminationRefusal.pending),
      ('CONTRACT_ALREADY_TERMINATED', TerminationRefusal.alreadyTerminated),
      ('CONTRACT_ENDED', TerminationRefusal.ended),
      ('TERMINATION_FINAL', TerminationRefusal.closed),
      ('CANNOT_ANSWER_OWN_TERMINATION', TerminationRefusal.closed),
    ]) {
      test('$code is told as ${reason.name}', () async {
        when(() => api.withdrawContractTermination(id: 'c-1')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/contracts'),
            response: Response(requestOptions: RequestOptions(path: '/contracts'), statusCode: 409, data: {'error': code}),
          ),
        );

        await expectLater(
          repository.withdrawTermination('c-1'),
          throwsA(isA<ContractTerminationRefused>().having((e) => e.reason, 'reason', reason)),
        );
      });
    }
  });

  group('the bloc', () {
    late MockContractRepository repository;

    setUp(() => repository = MockContractRepository());

    blocTest<ContractDetailBloc, ContractDetailState>(
      'asks to end it, and shows the contract as the server now holds it',
      setUp: () => when(() => repository.terminate('c-1', lastDay: DateTime(2026, 12, 31), reason: 'Mutation', mutual: true))
          .thenAnswer((_) async => signed(tenancy: proposedToMe)),
      build: () => ContractDetailBloc(repository: repository),
      seed: () => ContractDetailReady(signed()),
      act: (bloc) => bloc.add(ContractTerminationRequested(lastDay: DateTime(2026, 12, 31), reason: ' Mutation ', mutual: true)),
      expect: () => [
        ContractDetailReady(signed(), isBusy: true),
        ContractDetailReady(signed(tenancy: proposedToMe), justActed: true),
      ],
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'never without a reason, nor where the server does not offer it',
      build: () => ContractDetailBloc(repository: repository),
      seed: () => ContractDetailReady(signed(tenancy: proposedToMe)),
      act: (bloc) => bloc
        ..add(ContractTerminationRequested(lastDay: DateTime(2026, 12, 31), reason: 'Mutation', mutual: true))
        ..add(const ContractTerminationWithdrawn()),
      expect: () => const <ContractDetailState>[],
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'the other party answers a proposal',
      setUp: () => when(() => repository.declineTermination('c-1')).thenAnswer((_) async => signed()),
      build: () => ContractDetailBloc(repository: repository),
      seed: () => ContractDetailReady(signed(tenancy: proposedToMe)),
      act: (bloc) => bloc.add(const ContractTerminationAnswered(confirm: false)),
      expect: () => [
        ContractDetailReady(signed(tenancy: proposedToMe), isBusy: true),
        ContractDetailReady(signed(), justActed: true),
      ],
      verify: (_) => verifyNever(() => repository.confirmTermination(any())),
    );

    blocTest<ContractDetailBloc, ContractDetailState>(
      'a refusal is said once, and the contract read again',
      setUp: () {
        when(() => repository.confirmTermination('c-1'))
            .thenThrow(const ContractTerminationRefused(TerminationRefusal.closed));
        when(() => repository.one('c-1')).thenAnswer((_) async => signed());
      },
      build: () => ContractDetailBloc(repository: repository),
      seed: () => ContractDetailReady(signed(tenancy: proposedToMe)),
      act: (bloc) => bloc.add(const ContractTerminationAnswered(confirm: true)),
      expect: () => [
        ContractDetailReady(signed(tenancy: proposedToMe), isBusy: true),
        ContractDetailReady(signed(), terminationRefusal: TerminationRefusal.closed),
      ],
    );
  });

  group('the screen', () {
    late MockContractDetailBloc bloc;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const ContractTerminationWithdrawn());
    });

    setUp(() => bloc = MockContractDetailBloc());

    Future<void> pump(WidgetTester tester, Contract contract, {ContractParty viewer = ContractParty.tenant}) async {
      tester.view.physicalSize = const Size(390 * 3, 844 * 3);
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

    testWidgets('signed: the tenancy, the PDF as the one button, and "⋯" to end it', (tester) async {
      await pump(tester, signed());

      expect(find.text('En cours'), findsOneWidget);
      expect(find.textContaining('Dernier jour'), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);

      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      expect(find.text('Résilier le contrat'), findsOneWidget);
    });

    testWidgets('nothing to end: no "⋯" at all', (tester) async {
      await pump(tester, signed(tenancy: Tenancy(state: TenancyState.running, endsOn: DateTime(2027))));

      expect(find.byTooltip("Plus d'actions"), findsNothing);
    });

    testWidgets('a proposal to answer: the reason, then accept — asked first', (tester) async {
      await pump(tester, signed(tenancy: proposedToMe));

      expect(find.textContaining("L'autre partie propose de terminer la location"), findsOneWidget);
      expect(find.text('Motif : « Je reprends le logement pour ma famille. »'), findsOneWidget);

      await tester.ensureVisible(find.text('Accepter'));
      await tester.tap(find.text('Accepter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Accepter').last);
      await tester.pumpAndSettle();

      verify(() => bloc.add(const ContractTerminationAnswered(confirm: true))).called(1);
    });

    testWidgets('my own proposal: withdrawn, not answered', (tester) async {
      await pump(
        tester,
        signed(
          tenancy: Tenancy(
            state: TenancyState.running,
            termination: Termination(
              status: TerminationStatus.proposed,
              requestedBy: ContractParty.tenant,
              mutual: true,
              effectiveDate: DateTime(2026, 12, 31),
              canWithdraw: true,
            ),
          ),
        ),
      );

      expect(find.textContaining('Tu as proposé'), findsOneWidget);
      expect(find.text('Accepter'), findsNothing);
      await tester.ensureVisible(find.text('Retirer ma proposition'));
      await tester.tap(find.text('Retirer ma proposition'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Retirer ma proposition').last);
      await tester.pumpAndSettle();

      verify(() => bloc.add(const ContractTerminationWithdrawn())).called(1);
    });

    testWidgets('the landlord reads "L\'autre partie" for the tenant\'s notice', (tester) async {
      await pump(
        tester,
        signed(
          tenancy: Tenancy(
            state: TenancyState.running,
            endsOn: DateTime(2026, 12, 31),
            termination: Termination(
              status: TerminationStatus.notified,
              requestedBy: ContractParty.tenant,
              effectiveDate: DateTime(2026, 12, 31),
            ),
          ),
        ),
        viewer: ContractParty.prestataire,
      );

      expect(find.textContaining("L'autre partie a résilié le contrat"), findsOneWidget);
    });

    testWidgets('a proposal to answer', (tester) async {
      await pump(tester, signed(tenancy: proposedToMe));

      await expectLater(find.byType(ContractDetailView), matchesGoldenFile('goldens/contract_termination_proposed.png'));
    });
  });

  group('the sheet', () {
    setUpAll(loadBrandFonts);

    Future<void> pumpSheet(WidgetTester tester) async {
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
          home: Scaffold(body: TerminationSheet(contract: signed(), today: DateTime(2026, 10, 19))),
        ),
      );
      await tester.pumpAndSettle();
    }

    Button send(WidgetTester tester, String label) => tester.widget<Button>(find.widgetWithText(Button, label));

    testWidgets('nothing goes without a day and a reason', (tester) async {
      await pumpSheet(tester);

      expect(send(tester, 'Proposer la résiliation').onPressed, isNull);
      await tester.enterText(find.byType(TextField), 'Mutation à Yaoundé');
      await tester.pumpAndSettle();
      expect(send(tester, 'Proposer la résiliation').onPressed, isNull);
    });

    testWidgets('alone, the notice sets the earliest day, and it is said', (tester) async {
      await pumpSheet(tester);

      await tester.tap(find.text('Avec préavis'));
      await tester.pumpAndSettle();

      expect(find.textContaining('au plus tôt le 19 nov. 2026'), findsOneWidget);
      expect(find.text('Notifier la résiliation'), findsOneWidget);

      // The calendar opens on the notice's first day, not on today.
      await tester.tap(find.text('Choisir'));
      await tester.pumpAndSettle();
      expect(find.textContaining('novembre 2026'), findsOneWidget);
      expect(find.textContaining('octobre 2026'), findsNothing);
    });

    testWidgets('the sheet', (tester) async {
      await pumpSheet(tester);

      await expectLater(find.byType(TerminationSheet), matchesGoldenFile('goldens/contract_termination_sheet.png'));
    });
  });
}
