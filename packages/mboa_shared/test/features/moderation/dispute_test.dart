import 'package:api_client/api_client.dart' as api;
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

class MockSignalementsApi extends Mock implements api.SignalementsApi {}

class MockReportRepository extends Mock implements ReportRepository {}

class MockReportCubit extends MockCubit<ReportState> implements ReportCubit {}

class MockDeclarationBloc extends MockBloc<DeclarationEvent, DeclarationState> implements DeclarationBloc {}

class _FakeRequest extends Fake implements api.CreateSignalementRequest {}

/// RM-M30-07 — a dispute over a home, a declaration or a sending of photo
/// proofs: either party, one reason, and both hear the ruling (N-40).
void main() {
  setUpAll(() {
    registerFallbackValue(const ReportTarget.contract('x'));
    registerFallbackValue(ReportReason.dispute);
    registerFallbackValue(_FakeRequest());
  });

  group('the target', () {
    test('three kinds, written out against the generated client, with one reason', () {
      expect(ReportTargetKind.contract.wire, api.CreateSignalementRequestTargetTypeEnum.CONTRACT);
      expect(ReportTargetKind.declaration.wire, api.CreateSignalementRequestTargetTypeEnum.DECLARATION);
      expect(ReportTargetKind.evidence.wire, api.CreateSignalementRequestTargetTypeEnum.EVIDENCE);
      expect(ReportReason.dispute.wire, api.CreateSignalementRequestReasonEnum.DISPUTE);
      for (final target in const [
        ReportTarget.contract('c-1'),
        ReportTarget.declaration('d-1'),
        ReportTarget.evidence('e-1'),
      ]) {
        expect(target.kind.isDispute, isTrue);
        expect(target.reasons, [ReportReason.dispute]);
      }
    });

    test('and « dispute » fits nothing else (REASON_NOT_APPLICABLE)', () {
      for (final kind in [ReportTargetKind.annonce, ReportTargetKind.message, ReportTargetKind.review]) {
        expect(kind.isDispute, isFalse);
        expect(ReportTarget(kind: kind, id: 'x').reasons, isNot(contains(ReportReason.dispute)));
      }
    });
  });

  group('sending', () {
    test('ALREADY_REPORTED is its own answer', () async {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      final signalements = MockSignalementsApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getSignalementsApi).thenReturn(signalements);
      when(() => signalements.createSignalement(createSignalementRequest: any(named: 'createSignalementRequest')))
          .thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/signalements'),
          response: Response(
            requestOptions: RequestOptions(path: '/signalements'),
            statusCode: 409,
            data: {'error': 'ALREADY_REPORTED'},
          ),
        ),
      );

      await expectLater(
        ReportRepository(dioClient: dioClient)
            .report(const ReportTarget.declaration('d-1'), reason: ReportReason.dispute),
        throwsA(isA<AlreadyReported>()),
      );
      final sent = verify(
        () => signalements.createSignalement(createSignalementRequest: captureAny(named: 'createSignalementRequest')),
      ).captured.single as api.CreateSignalementRequest;
      expect(sent.targetType, api.CreateSignalementRequestTargetTypeEnum.DECLARATION);
      expect(sent.reason, api.CreateSignalementRequestReasonEnum.DISPUTE);
    });

    late MockReportRepository repository;

    blocTest<ReportCubit, ReportState>(
      '…said as such, not as an error to retry',
      setUp: () {
        repository = MockReportRepository();
        when(() => repository.report(any(), reason: any(named: 'reason'), comment: any(named: 'comment')))
            .thenThrow(const AlreadyReported());
      },
      build: () => ReportCubit(repository: repository),
      act: (cubit) => cubit.send(const ReportTarget.contract('c-1'), reason: ReportReason.dispute),
      expect: () => const [ReportSending(), ReportFailed(alreadyReported: true)],
    );
  });

  group('the sheet', () {
    late MockReportCubit cubit;

    setUpAll(loadBrandFonts);

    setUp(() {
      cubit = MockReportCubit();
      when(() => cubit.state).thenReturn(const ReportIdle());
      when(() => cubit.send(any(), reason: any(named: 'reason'), comment: any(named: 'comment')))
          .thenAnswer((_) async {});
    });

    Future<void> open(WidgetTester tester, ReportTarget target) async {
      tester.view.physicalSize = const Size(390 * 3, 1000 * 3);
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
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showReportSheet(context, target: target, cubit: cubit),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    }

    testWidgets('one reason, so none asked; what Mboa does with it, said', (tester) async {
      await open(tester, const ReportTarget.declaration('d-1'));

      expect(find.text('Signaler un litige'), findsOneWidget);
      expect(find.textContaining('ne retire aucun point de Mboa Score'), findsOneWidget);
      expect(find.byType(RadioListTile<ReportReason>), findsNothing);
      await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/dispute_sheet.png'));

      await tester.enterText(find.byType(TextField), "J'ai payé en espèces le 3");
      await tester.tap(find.text('Envoyer le litige'));
      verify(
        () => cubit.send(
          const ReportTarget.declaration('d-1'),
          reason: ReportReason.dispute,
          comment: "J'ai payé en espèces le 3",
        ),
      ).called(1);
    });

    testWidgets('already reported: said, the sheet closed', (tester) async {
      whenListen(
        cubit,
        Stream.fromIterable(const [ReportSending(), ReportFailed(alreadyReported: true)]),
        initialState: const ReportIdle(),
      );
      await open(tester, const ReportTarget.evidence('e-1'));
      await tester.pumpAndSettle();

      expect(find.text('Envoyer le litige'), findsNothing);
      expect(find.textContaining('déjà signalé ce litige'), findsOneWidget);
    });
  });

  group('a contested declaration', () {
    const contested = Declaration(
      id: 'd-1',
      contractId: 'c-1',
      amount: 150000,
      status: DeclarationStatus.contested,
      contestReason: 'Rien reçu',
    );

    Future<void> pump(WidgetTester tester, Declaration d, {ValueChanged<Declaration>? onDispute}) async {
      final bloc = MockDeclarationBloc();
      when(() => bloc.state).thenReturn(DeclarationReady(d));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<DeclarationBloc>.value(value: bloc, child: DeclarationView(onDispute: onDispute)),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('offers the dispute outright, and behind « ⋯ »', (tester) async {
      final disputed = <String>[];
      await pump(tester, contested, onDispute: (d) => disputed.add(d.id));

      expect(find.textContaining('Un désaccord sur ce paiement'), findsOneWidget);
      // Alone on screen before the sheet opens.
      await tester.tap(find.text('Signaler un litige'));
      await tester.tap(find.byTooltip("Plus d'actions"));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ListTile, 'Signaler un litige'));
      await tester.pumpAndSettle();

      expect(disputed, ['d-1', 'd-1']);
    });

    testWidgets('not contested: only behind « ⋯ »; without the door, nothing', (tester) async {
      await pump(tester, const Declaration(id: 'd-2', contractId: 'c-1', amount: 1, status: DeclarationStatus.declared),
          onDispute: (_) {});
      expect(find.textContaining('Un désaccord sur ce paiement'), findsNothing);
      expect(find.byTooltip("Plus d'actions"), findsOneWidget);

      await pump(tester, contested);
      expect(find.textContaining('Un désaccord sur ce paiement'), findsNothing);
      expect(find.byTooltip("Plus d'actions"), findsNothing);
    });
  });
}
