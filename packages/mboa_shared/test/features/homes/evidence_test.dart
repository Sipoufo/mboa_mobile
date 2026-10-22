import 'dart:convert';
import 'dart:typed_data';

import 'package:api_client/api_client.dart' as api;
import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
import 'package:crypto/crypto.dart';
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

class MockMonLogementApi extends Mock implements api.MonLogementApi {}

class MockHiveCache extends Mock implements HiveCache {}

class MockDio extends Mock implements Dio {}

class MockEvidenceRepository extends Mock implements EvidenceRepository {}

class MockEvidenceBatchBloc extends MockBloc<EvidenceBatchEvent, EvidenceBatchState> implements EvidenceBatchBloc {}

class MockEvidenceBloc extends MockBloc<EvidenceEvent, EvidenceState> implements EvidenceBloc {}

class _FakeUploads extends Fake implements api.EvidenceUploadsRequest {}

class _FakeRecord extends Fake implements api.RecordEvidenceRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 409, data: {'error': code}),
    );

/// CDC M30 lot 3 — photo proofs of the home's condition (RM-M30-11/12).
void main() {
  final bytes = Uint8List.fromList([1, 2, 3, 4]);
  final photo = PhotoPreparer.prepare(bytes);

  group('the fingerprint', () {
    test('base64 of the SHA-256 of the very bytes that travel (§27.6)', () {
      expect(photo.sha256, base64.encode(sha256.convert(bytes).bytes));
      expect(photo.bytes, bytes);
    });
  });

  group('sending', () {
    late MockMonLogementApi monLogement;
    late MockDio storage;
    late EvidenceRepository repository;

    setUpAll(() {
      registerFallbackValue(_FakeUploads());
      registerFallbackValue(_FakeRecord());
      registerFallbackValue(Uri());
    });

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      monLogement = MockMonLogementApi();
      storage = MockDio();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMonLogementApi).thenReturn(monLogement);
      repository = EvidenceRepository(dioClient: dioClient, cache: MockHiveCache(), uploadClient: storage);
      when(
        () => monLogement.createEvidenceUploads(
          contractId: 'c-1',
          evidenceUploadsRequest: any(named: 'evidenceUploadsRequest'),
        ),
      ).thenAnswer(
        (_) async => _ok(
          BuiltList<api.EvidenceUpload>([
            api.EvidenceUpload((b) => b
              ..uploadUrl = 'https://r2/evidence/1.jpg?sig=x'
              ..method = 'PUT'
              ..objectKey = 'evidence/1.jpg'
              ..headers = MapBuilder({'Content-Type': 'image/jpeg', 'x-amz-checksum-sha256': photo.sha256})),
          ]),
        ),
      );
      when(
        () => monLogement.recordEvidence(contractId: 'c-1', recordEvidenceRequest: any(named: 'recordEvidenceRequest')),
      ).thenAnswer((_) async => _ok(api.EvidenceBatchResponse((b) => b..id = 'eb-1')));
    });

    final shot = EvidenceShot(photo: photo, room: EvidenceRoom.bathroom, roomLabel: ' ', comment: ' Fissure ');

    test('asks with the fingerprint, puts with exactly the headers given, then records', () async {
      when(() => storage.requestUri<void>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => Response(requestOptions: RequestOptions(path: '/r2'), statusCode: 200));
      final progress = <int>[];

      final batch = await repository.send('c-1', EvidencePhase.entry, [shot], onUploaded: (done, _) => progress.add(done));

      expect(batch.id, 'eb-1');
      expect(progress, [1]);
      final ask = verify(
        () => monLogement.createEvidenceUploads(
          contractId: 'c-1',
          evidenceUploadsRequest: captureAny(named: 'evidenceUploadsRequest'),
        ),
      ).captured.single as api.EvidenceUploadsRequest;
      expect(ask.files.single.sha256, photo.sha256);
      expect(ask.files.single.size, 4);
      expect(ask.files.single.contentType, 'image/jpeg');

      final options = verify(
        () => storage.requestUri<void>(
          Uri.parse('https://r2/evidence/1.jpg?sig=x'),
          data: any(named: 'data'),
          options: captureAny(named: 'options'),
        ),
      ).captured.single as Options;
      expect(options.method, 'PUT');
      expect(options.headers?['x-amz-checksum-sha256'], photo.sha256);
      expect(options.headers?['Content-Type'], 'image/jpeg');

      final record = verify(
        () => monLogement.recordEvidence(contractId: 'c-1', recordEvidenceRequest: captureAny(named: 'recordEvidenceRequest')),
      ).captured.single as api.RecordEvidenceRequest;
      final recorded = record.photos.single;
      expect(recorded.objectKey, 'evidence/1.jpg');
      expect(recorded.sha256, photo.sha256);
      expect(recorded.room, api.EvidencePhotoRequestRoomEnum.BATHROOM);
      expect(recorded.phase, api.EvidencePhotoRequestPhaseEnum.ENTRY);
      expect(recorded.roomLabel, isNull);
      expect(recorded.comment, 'Fissure');
    });

    test('CE-M30-01 — three tries, then said; nothing recorded', () async {
      when(() => storage.requestUri<void>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '/r2'), type: DioExceptionType.connectionError));

      await expectLater(repository.send('c-1', EvidencePhase.entry, [shot]), throwsA(isA<EvidenceUploadFailed>()));

      verify(() => storage.requestUri<void>(any(), data: any(named: 'data'), options: any(named: 'options'))).called(3);
      verifyNever(
        () => monLogement.recordEvidence(contractId: any(named: 'contractId'), recordEvidenceRequest: any(named: 'recordEvidenceRequest')),
      );
    });

    test('a photo missing in storage is told as such', () async {
      when(() => storage.requestUri<void>(any(), data: any(named: 'data'), options: any(named: 'options')))
          .thenAnswer((_) async => Response(requestOptions: RequestOptions(path: '/r2'), statusCode: 200));
      when(
        () => monLogement.recordEvidence(contractId: 'c-1', recordEvidenceRequest: any(named: 'recordEvidenceRequest')),
      ).thenThrow(_refused('EVIDENCE_NOT_STORED'));

      await expectLater(
        repository.send('c-1', EvidencePhase.entry, [shot]),
        throwsA(isA<EvidenceRefused>().having((e) => e.reason, 'reason', EvidenceRefusal.notStored)),
      );
    });
  });

  group('the blocs', () {
    late MockEvidenceRepository repository;

    setUp(() => repository = MockEvidenceRepository());

    const withLinks = EvidenceBatch(
      id: 'eb-1',
      contractId: 'c-1',
      photos: [EvidencePhoto(id: 'p-1', downloadUrl: 'https://r2/p-1')],
      canAcknowledge: true,
    );

    blocTest<EvidenceBatchBloc, EvidenceBatchState>(
      'acknowledged once, with a word — the links kept',
      setUp: () => when(() => repository.acknowledge('c-1', 'eb-1', comment: 'Bien reçu')).thenAnswer(
        (_) async => EvidenceBatch(
          id: 'eb-1',
          contractId: 'c-1',
          acknowledgedAt: DateTime(2026, 10, 23, 9),
          ownerComment: 'Bien reçu',
        ),
      ),
      build: () => EvidenceBatchBloc(repository: repository),
      seed: () => const EvidenceBatchReady(withLinks),
      act: (bloc) => bloc.add(const EvidenceAcknowledged(comment: 'Bien reçu')),
      verify: (bloc) {
        final state = bloc.state as EvidenceBatchReady;
        expect(state.acknowledged, isTrue);
        expect(state.batch.isAcknowledged, isTrue);
        expect(state.batch.ownerComment, 'Bien reçu');
        expect(state.batch.photos.single.downloadUrl, 'https://r2/p-1');
        expect(state.batch.canAcknowledge, isFalse);
      },
    );

    blocTest<EvidenceBatchBloc, EvidenceBatchState>(
      'not where the server does not allow it',
      build: () => EvidenceBatchBloc(repository: repository),
      seed: () => const EvidenceBatchReady(EvidenceBatch(id: 'eb-1', contractId: 'c-1')),
      act: (bloc) => bloc.add(const EvidenceAcknowledged()),
      expect: () => const <EvidenceBatchState>[],
    );

    blocTest<EvidenceBloc, EvidenceState>(
      "a home's sendings; offline, marked",
      setUp: () => when(() => repository.batches('c-1'))
          .thenAnswer((_) async => const Cached([EvidenceBatch(id: 'eb-1')], fromCache: true)),
      build: () => EvidenceBloc(repository: repository, contractId: 'c-1'),
      act: (bloc) => bloc.add(const EvidenceRequested()),
      expect: () => const [EvidenceLoading(), EvidenceReady(items: [EvidenceBatch(id: 'eb-1')], isOffline: true)],
    );
  });

  group('the screens', () {
    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const EvidenceRequested());
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

    final sending = EvidenceBatch(
      id: 'eb-1',
      contractId: 'c-1',
      recordedAt: DateTime(2026, 10, 22, 9, 30),
      photos: const [
        EvidencePhoto(id: 'p-1', room: EvidenceRoom.livingRoom, phase: EvidencePhase.entry),
        EvidencePhoto(id: 'p-2', room: EvidenceRoom.bathroom, phase: EvidencePhase.entry, comment: 'Fissure au plafond'),
        EvidencePhoto(id: 'p-3', room: EvidenceRoom.bedroom, roomLabel: 'Chambre 2', phase: EvidencePhase.entry),
      ],
      canAcknowledge: true,
    );

    testWidgets('the landlord acknowledges, once, with a word', (tester) async {
      final bloc = MockEvidenceBatchBloc();
      when(() => bloc.state).thenReturn(EvidenceBatchReady(sending));
      await pump(tester, BlocProvider<EvidenceBatchBloc>.value(value: bloc, child: const EvidenceBatchView()));

      expect(find.text('Chambre 2'), findsOneWidget);
      await tester.tap(find.widgetWithText(Button, 'Accuser réception'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Bien reçu');
      await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Accuser réception')));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const EvidenceAcknowledged(comment: 'Bien reçu'))).called(1);
    });

    testWidgets('seen already, or the tenant\'s: no bar', (tester) async {
      final bloc = MockEvidenceBatchBloc();
      when(() => bloc.state).thenReturn(const EvidenceBatchReady(EvidenceBatch(id: 'eb-1')));
      await pump(tester, BlocProvider<EvidenceBatchBloc>.value(value: bloc, child: const EvidenceBatchView()));

      expect(find.byType(Button), findsNothing);
      expect(find.text('Pas encore vu par le propriétaire'), findsOneWidget);
    });

    testWidgets('the tenant\'s list: « Envoyer des photos » as the main action, Mboa\'s guarantee said', (tester) async {
      final bloc = MockEvidenceBloc();
      when(() => bloc.state).thenReturn(EvidenceReady(items: [sending]));
      var asked = false;
      await pump(
        tester,
        BlocProvider<EvidenceBloc>.value(value: bloc, child: EvidenceView(onOpen: (_) {}, onAdd: () => asked = true)),
      );

      expect(find.textContaining('non modifiables'), findsOneWidget);
      expect(find.text('Entrée · 3 photos'), findsOneWidget);
      await tester.tap(find.text('Envoyer des photos'));
      expect(asked, isTrue);
    });

    testWidgets('a sending, by room', (tester) async {
      final bloc = MockEvidenceBatchBloc();
      when(() => bloc.state).thenReturn(EvidenceBatchReady(sending));
      await pump(tester, BlocProvider<EvidenceBatchBloc>.value(value: bloc, child: const EvidenceBatchView()));

      await expectLater(find.byType(EvidenceBatchView), matchesGoldenFile('goldens/evidence_batch.png'));
    });
  });
}
