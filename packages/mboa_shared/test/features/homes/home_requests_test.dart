import 'package:api_client/api_client.dart' as api;
import 'package:bloc_test/bloc_test.dart';
import 'package:built_collection/built_collection.dart';
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

class MockHomeRequestsRepository extends Mock implements HomeRequestsRepository {}

class MockMessagingRepository extends Mock implements MessagingRepository {}

class MockHomeRequestBloc extends MockBloc<HomeRequestEvent, HomeRequestState> implements HomeRequestBloc {}

class MockHomeRequestsBloc extends MockBloc<HomeRequestsEvent, HomeRequestsState> implements HomeRequestsBloc {}

class _FakeCreate extends Fake implements api.CreateHomeRequest {}

class _FakeStatus extends Fake implements api.HomeRequestStatusRequest {}

Response<T> _ok<T>(T data) => Response<T>(data: data, requestOptions: RequestOptions(path: '/x'));

DioException _refused(String code) => DioException(
      requestOptions: RequestOptions(path: '/x'),
      response: Response(requestOptions: RequestOptions(path: '/x'), statusCode: 409, data: {'error': code}),
    );

/// CDC M30 lot 3 — requests to the landlord (RM-M30-09/10), N-38.
void main() {
  HomeRequest request({
    HomeRequestStatus status = HomeRequestStatus.sent,
    bool canStart = false,
    bool canResolve = false,
    bool canClose = false,
    bool canReopen = false,
  }) =>
      HomeRequest(
        id: 'hr-1',
        contractId: 'c-1',
        annonceTitle: 'Studio Akwa',
        tenant: const ContractParticipant(displayName: 'Awa Nkeng'),
        conversationId: 'conv-1',
        type: HomeRequestType.maintenance,
        title: 'Fuite sous l\'évier',
        description: 'Ça goutte depuis hier soir.',
        status: status,
        history: [
          HomeRequestStep(status: HomeRequestStatus.sent, at: DateTime(2026, 10, 22, 9)),
          if (status != HomeRequestStatus.sent)
            HomeRequestStep(status: HomeRequestStatus.seen, byLandlord: true, at: DateTime(2026, 10, 22, 10)),
          if (status == HomeRequestStatus.inProgress)
            HomeRequestStep(
              status: HomeRequestStatus.inProgress,
              byLandlord: true,
              note: 'Le plombier passe jeudi',
              at: DateTime(2026, 10, 22, 11),
            ),
        ],
        createdAt: DateTime(2026, 10, 22, 9),
        canStart: canStart,
        canResolve: canResolve,
        canClose: canClose,
        canReopen: canReopen,
      );

  group('the model', () {
    test('reads the server, history included, and keeps a row\'s worth offline', () {
      final r = HomeRequest.fromResponse(
        api.HomeRequestResponse(
          (b) => b
            ..id = 'hr-1'
            ..type = api.HomeRequestResponseTypeEnum.MAINTENANCE
            ..title = 'Fuite'
            ..status = api.HomeRequestResponseStatusEnum.IN_PROGRESS
            ..history = ListBuilder([
              api.HomeRequestEventResponse((e) => e
                ..status = api.HomeRequestEventResponseStatusEnum.IN_PROGRESS
                ..byLandlord = true
                ..note = '  Le plombier passe jeudi '),
            ])
            ..canResolve = true,
        ),
      );

      expect(r.type, HomeRequestType.maintenance);
      expect(r.status, HomeRequestStatus.inProgress);
      expect(r.status.isOpen, isTrue);
      expect(HomeRequestStatus.resolved.isOpen, isFalse);
      expect(r.history.single.note, 'Le plombier passe jeudi');
      expect(r.canResolve, isTrue);
      expect(HomeRequest.fromCache(r.toCache())?.status, HomeRequestStatus.inProgress);
    });

    test('N-38 pushes are known', () {
      expect(PushType.parse('HOME_REQUEST'), PushType.homeRequest);
    });
  });

  group('the repository', () {
    late MockMonLogementApi monLogement;
    late MockHiveCache cache;
    late HomeRequestsRepository repository;

    setUpAll(() {
      registerFallbackValue(api.Pageable());
      registerFallbackValue(_FakeCreate());
      registerFallbackValue(_FakeStatus());
    });

    setUp(() {
      final dioClient = MockDioClient();
      final apiClient = MockApiClient();
      monLogement = MockMonLogementApi();
      cache = MockHiveCache();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getMonLogementApi).thenReturn(monLogement);
      when(() => cache.put(any(), any(), any())).thenAnswer((_) async {});
      when(() => cache.get(any(), any(), ttl: any(named: 'ttl'))).thenReturn(null);
      repository = HomeRequestsRepository(dioClient: dioClient, cache: cache);
    });

    test('the inbox is what still waits: sent, seen, in progress', () async {
      when(
        () => monLogement.listMyReceivedRequests(pageable: any(named: 'pageable'), status: any(named: 'status')),
      ).thenAnswer((_) async => _ok(api.PageResponseHomeRequestResponse((b) => b..totalElements = 3)));

      expect(await repository.openCount(), 3);
      final status = verify(
        () => monLogement.listMyReceivedRequests(pageable: any(named: 'pageable'), status: captureAny(named: 'status')),
      ).captured.single as BuiltList<String>;
      expect(status, ['SENT', 'SEEN', 'IN_PROGRESS']);
    });

    test('a request is sent with its words trimmed and its photos', () async {
      when(() => monLogement.createHomeRequest(contractId: 'c-1', createHomeRequest: any(named: 'createHomeRequest')))
          .thenAnswer((_) async => _ok(api.HomeRequestResponse((b) => b..id = 'hr-9')));

      await repository.create(
        'c-1',
        const HomeRequestDraft(
          type: HomeRequestType.maintenance,
          title: ' Fuite ',
          description: ' Ça goutte. ',
          photoKeys: ['p/1.jpg'],
        ),
      );

      final body = verify(
        () => monLogement.createHomeRequest(contractId: 'c-1', createHomeRequest: captureAny(named: 'createHomeRequest')),
      ).captured.single as api.CreateHomeRequest;
      expect(body.type, api.CreateHomeRequestTypeEnum.MAINTENANCE);
      expect(body.title, 'Fuite');
      expect(body.description, 'Ça goutte.');
      expect(body.photoKeys, ['p/1.jpg']);
    });

    test('a step out of order is told as such', () async {
      when(
        () => monLogement.moveHomeRequest(requestId: 'hr-1', homeRequestStatusRequest: any(named: 'homeRequestStatusRequest')),
      ).thenThrow(_refused('HOME_REQUEST_TRANSITION_INVALID'));

      await expectLater(
        repository.move('hr-1', HomeRequestStatus.resolved),
        throwsA(isA<HomeRequestRefused>().having((e) => e.reason, 'reason', HomeRequestRefusal.transitionInvalid)),
      );
    });

    test('a step carries its word', () async {
      when(
        () => monLogement.moveHomeRequest(requestId: 'hr-1', homeRequestStatusRequest: any(named: 'homeRequestStatusRequest')),
      ).thenAnswer((_) async => _ok(api.HomeRequestResponse((b) => b..id = 'hr-1')));

      await repository.move('hr-1', HomeRequestStatus.inProgress, note: ' Jeudi ');

      final body = verify(
        () => monLogement.moveHomeRequest(
          requestId: 'hr-1',
          homeRequestStatusRequest: captureAny(named: 'homeRequestStatusRequest'),
        ),
      ).captured.single as api.HomeRequestStatusRequest;
      expect(body.status, api.HomeRequestStatusRequestStatusEnum.IN_PROGRESS);
      expect(body.note, 'Jeudi');
    });
  });

  group('the blocs', () {
    late MockHomeRequestsRepository repository;
    late MockMessagingRepository messaging;

    setUp(() {
      repository = MockHomeRequestsRepository();
      messaging = MockMessagingRepository();
    });

    HomeRequestBloc build() => HomeRequestBloc(repository: repository, messaging: messaging);

    const reply = Message(id: 'm-2', body: 'Merci', isMine: true);
    const step = Message(id: 'm-1', body: 'Demande « Fuite » : en cours', isSystem: true);

    blocTest<HomeRequestBloc, HomeRequestState>(
      'opened: the request, then its exchanges oldest first — best-effort',
      setUp: () {
        when(() => repository.get('hr-1')).thenAnswer((_) async => request());
        when(() => messaging.messages('conv-1', homeRequestId: 'hr-1')).thenAnswer((_) async => [reply, step]);
      },
      build: build,
      act: (bloc) => bloc.add(const HomeRequestOpened('hr-1')),
      expect: () => [const HomeRequestLoading(), HomeRequestReady(request(), messages: const [step, reply])],
    );

    blocTest<HomeRequestBloc, HomeRequestState>(
      'exchanges that do not come spoil nothing',
      setUp: () {
        when(() => repository.get('hr-1')).thenAnswer((_) async => request());
        when(() => messaging.messages('conv-1', homeRequestId: 'hr-1')).thenThrow(Exception('offline'));
      },
      build: build,
      act: (bloc) => bloc.add(const HomeRequestOpened('hr-1')),
      expect: () => [const HomeRequestLoading(), HomeRequestReady(request())],
    );

    blocTest<HomeRequestBloc, HomeRequestState>(
      'the landlord takes it in hand, with a word — where allowed',
      setUp: () {
        when(() => repository.move('hr-1', HomeRequestStatus.inProgress, note: 'Jeudi'))
            .thenAnswer((_) async => request(status: HomeRequestStatus.inProgress, canResolve: true));
        when(() => messaging.messages('conv-1', homeRequestId: 'hr-1')).thenAnswer((_) async => [step]);
      },
      build: build,
      seed: () => HomeRequestReady(request(canStart: true, canResolve: true)),
      act: (bloc) => bloc.add(const HomeRequestMoved(HomeRequestStatus.inProgress, note: 'Jeudi')),
      verify: (bloc) {
        final state = bloc.state as HomeRequestReady;
        expect(state.request.status, HomeRequestStatus.inProgress);
        expect(state.messages, [step]);
        expect(state.moved, isTrue);
      },
    );

    blocTest<HomeRequestBloc, HomeRequestState>(
      'not where the server does not allow it',
      build: build,
      seed: () => HomeRequestReady(request()),
      act: (bloc) => bloc
        ..add(const HomeRequestMoved(HomeRequestStatus.resolved))
        ..add(const HomeRequestClosed())
        ..add(const HomeRequestReopened()),
      expect: () => const <HomeRequestState>[],
    );

    blocTest<HomeRequestBloc, HomeRequestState>(
      'a refusal reads it again, as it now stands',
      setUp: () {
        when(() => repository.close('hr-1')).thenThrow(const HomeRequestRefused(HomeRequestRefusal.transitionInvalid));
        when(() => repository.get('hr-1')).thenAnswer((_) async => request(status: HomeRequestStatus.closed));
      },
      build: build,
      seed: () => HomeRequestReady(request(canClose: true)),
      act: (bloc) => bloc.add(const HomeRequestClosed()),
      verify: (bloc) {
        final state = bloc.state as HomeRequestReady;
        expect(state.refusal, HomeRequestRefusal.transitionInvalid);
        expect(state.request.status, HomeRequestStatus.closed);
      },
    );

    blocTest<HomeRequestBloc, HomeRequestState>(
      'a reply is attached to the request, and added under the others',
      setUp: () => when(() => messaging.send('conv-1', body: 'Merci', homeRequestId: 'hr-1')).thenAnswer((_) async => reply),
      build: build,
      seed: () => HomeRequestReady(request(), messages: const [step]),
      act: (bloc) => bloc
        ..add(const HomeRequestReplySent('   '))
        ..add(const HomeRequestReplySent(' Merci ')),
      verify: (bloc) {
        expect((bloc.state as HomeRequestReady).messages, [step, reply]);
        verify(() => messaging.send('conv-1', body: 'Merci', homeRequestId: 'hr-1')).called(1);
      },
    );

    blocTest<HomeRequestsBloc, HomeRequestsState>(
      "a home's requests, or — without a contract — the landlord's inbox",
      setUp: () {
        when(() => repository.ofHome('c-1')).thenAnswer((_) async => Cached([request()]));
        when(() => repository.received()).thenAnswer((_) async => Cached([request()], fromCache: true));
      },
      build: () => HomeRequestsBloc(repository: repository, contractId: 'c-1'),
      act: (bloc) => bloc.add(const HomeRequestsRequested()),
      expect: () => [const HomeRequestsLoading(), HomeRequestsReady(items: [request()])],
      verify: (_) => verifyNever(() => repository.received()),
    );

    blocTest<HomeRequestsBloc, HomeRequestsState>(
      'the inbox, offline: marked',
      setUp: () => when(() => repository.received()).thenAnswer((_) async => Cached([request()], fromCache: true)),
      build: () => HomeRequestsBloc(repository: repository),
      act: (bloc) => bloc.add(const HomeRequestsRequested()),
      expect: () => [const HomeRequestsLoading(), HomeRequestsReady(items: [request()], isOffline: true)],
    );
  });

  group('the screens', () {
    late MockHomeRequestBloc bloc;

    setUpAll(() async {
      await loadBrandFonts();
      registerFallbackValue(const HomeRequestOpened('x'));
    });

    setUp(() => bloc = MockHomeRequestBloc());

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

    Widget view() => BlocProvider<HomeRequestBloc>.value(value: bloc, child: const HomeRequestView());

    testWidgets('the landlord: take it in hand is the main step, resolve behind "⋯"; a word goes with it',
        (tester) async {
      when(() => bloc.state).thenReturn(HomeRequestReady(request(canStart: true, canResolve: true)));
      await pump(tester, view());

      expect(find.byType(Button), findsOneWidget);
      await tester.tap(find.text('Prendre en charge'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Le plombier passe jeudi');
      await tester.tap(find.text('Valider'));
      await tester.pumpAndSettle();

      verify(() => bloc.add(const HomeRequestMoved(HomeRequestStatus.inProgress, note: 'Le plombier passe jeudi')))
          .called(1);

      await tester.tap(find.byTooltip('Plus d\'actions'));
      await tester.pumpAndSettle();
      expect(find.text('Marquer résolue'), findsOneWidget);
    });

    testWidgets('a step called off sends nothing', (tester) async {
      when(() => bloc.state).thenReturn(HomeRequestReady(request(canStart: true)));
      await pump(tester, view());

      await tester.tap(find.text('Prendre en charge'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Annuler'));
      await tester.pumpAndSettle();

      verifyNever(() => bloc.add(any()));
    });

    testWidgets('the tenant: « le problème persiste » first, « clore » behind "⋯", in red', (tester) async {
      when(() => bloc.state)
          .thenReturn(HomeRequestReady(request(status: HomeRequestStatus.resolved, canReopen: true, canClose: true)));
      await pump(tester, view());

      expect(find.text('Le problème persiste'), findsOneWidget);
      await tester.tap(find.byTooltip('Plus d\'actions'));
      await tester.pumpAndSettle();
      expect(find.text('Clore la demande'), findsOneWidget);
    });

    testWidgets('nothing to do: no bar', (tester) async {
      when(() => bloc.state).thenReturn(HomeRequestReady(request(status: HomeRequestStatus.closed)));
      await pump(tester, view());

      expect(find.byType(Button), findsNothing);
      // Closed: no more replies either.
      expect(find.byTooltip('Envoyer'), findsNothing);
    });

    testWidgets('a reply is sent from the field', (tester) async {
      when(() => bloc.state).thenReturn(HomeRequestReady(request()));
      await pump(tester, view());

      await tester.scrollUntilVisible(find.byTooltip('Envoyer'), 200, scrollable: find.byType(Scrollable).first);
      await tester.enterText(find.byType(TextField), 'Merci');
      await tester.tap(find.byTooltip('Envoyer'));

      verify(() => bloc.add(const HomeRequestReplySent('Merci'))).called(1);
    });

    testWidgets('the tenant\'s list: « Nouvelle demande » is the main action; empty, said', (tester) async {
      final list = MockHomeRequestsBloc();
      when(() => list.state).thenReturn(const HomeRequestsReady());
      var asked = false;
      await pump(
        tester,
        BlocProvider<HomeRequestsBloc>.value(
          value: list,
          child: HomeRequestsView(onOpen: (_) {}, onNew: () => asked = true),
        ),
      );

      expect(find.textContaining('Aucune demande pour l\'instant'), findsOneWidget);
      await tester.tap(find.text('Nouvelle demande'));
      expect(asked, isTrue);
    });

    testWidgets('a request in hand', (tester) async {
      when(() => bloc.state).thenReturn(
        HomeRequestReady(
          request(status: HomeRequestStatus.inProgress, canResolve: true),
          messages: const [
            Message(id: 'm-1', body: 'Demande « Fuite sous l\'évier » : en cours — Le plombier passe jeudi', isSystem: true),
            Message(id: 'm-2', body: 'Merci, je serai là.', isMine: true),
            Message(id: 'm-3', body: 'Parfait.'),
          ],
        ),
      );
      await pump(tester, view());

      await expectLater(find.byType(HomeRequestView), matchesGoldenFile('goldens/home_request.png'));
    });
  });
}
