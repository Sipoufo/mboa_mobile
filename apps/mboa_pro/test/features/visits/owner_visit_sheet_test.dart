import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_pro/app/notifications_bootstrap.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/annonces/data/location_capture.dart';
import 'package:mboa_pro/features/visits/bloc/prestataire_visits_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visit_detail_bloc.dart';
import 'package:mboa_pro/features/visits/bloc/visits_agenda_blocs.dart';
import 'package:mboa_pro/features/visits/data/agent_visit_repository.dart';
import 'package:mboa_pro/features/visits/data/prestataire_visit_repository.dart';
import 'package:mboa_pro/features/visits/data/visit_detail_source.dart';
import 'package:mboa_pro/features/visits/models/agent_visit.dart';
import 'package:mboa_pro/features/visits/ui/prestataire_visits_page.dart';
import 'package:mboa_pro/features/visits/ui/visit_detail_page.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../_helpers/mocks/mocks.dart';

class MockPrestataireVisitRepository extends Mock implements PrestataireVisitRepository {}

class MockAgentVisitRepository extends Mock implements AgentVisitRepository {}

class MockLocationCapture extends Mock implements LocationCapture {}

class MockPrestataireVisitesApi extends Mock implements PrestataireVisitesApi {}

class MockVisitDetailBloc extends MockBloc<VisitDetailEvent, VisitDetailState> implements VisitDetailBloc {}

class MockPrestataireAgendaBloc extends MockBloc<VisitsAgendaEvent, VisitsAgendaState>
    implements PrestataireAgendaBloc {}

class MockPrestataireVisitsBloc extends MockBloc<PrestataireVisitsEvent, PrestataireVisitsState>
    implements PrestataireVisitsBloc {}

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// §14 — an owner showing his own property has the agent's sheet: the
/// client's name, phone and score, and what he may do — answer a proposed
/// time, confirm presence, cancel a scheduled visit up to an hour before.
void main() {
  AgentVisitDetail sheet({VisitStatus status = VisitStatus.scheduled, String? client = 'u-1'}) => AgentVisitDetail(
    id: 'v-1',
    status: status,
    annonceTitle: 'Studio Bonapriso',
    exactAddress: 'Rue 1.234, Bonapriso',
    scheduledAt: DateTime(2026, 11, 3, 10),
    userName: 'Awa Nkeng',
    userPhone: '+237690000000',
    // On his own visit, these are himself.
    prestataireName: 'Jean Mbarga',
    prestatairePhone: '+237691111111',
    userAccountId: client,
  );

  group('the owner\'s source', () {
    late MockPrestataireVisitRepository repository;
    late MockLocationCapture location;

    setUp(() {
      repository = MockPrestataireVisitRepository();
      location = MockLocationCapture();
    });

    VisitDetailBloc build() => VisitDetailBloc(repository: repository, location: location, persona: VisitPersona.owner);

    blocTest<VisitDetailBloc, VisitDetailState>(
      'reads the sheet from the owner\'s route, and says who reads it',
      setUp: () => when(() => repository.detail('v-1')).thenAnswer((_) async => sheet()),
      build: build,
      act: (bloc) => bloc.add(const VisitDetailRequested('v-1')),
      expect: () => [
        const VisitDetailLoadInProgress(),
        VisitDetailReady(sheet(), persona: VisitPersona.owner),
      ],
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'RM-M15-06 — confirming a proposed time re-reads the now scheduled visit',
      setUp: () {
        when(() => repository.confirm('v-1')).thenAnswer((_) async {});
        when(() => repository.detail('v-1')).thenAnswer((_) async => sheet());
      },
      build: build,
      seed: () => VisitDetailReady(sheet(status: VisitStatus.requested), persona: VisitPersona.owner),
      act: (bloc) => bloc.add(const VisitRequestAnswered(accept: true)),
      expect: () => [
        VisitDetailReady(sheet(status: VisitStatus.requested), persona: VisitPersona.owner, isAnswering: true),
        VisitDetailReady(sheet(), persona: VisitPersona.owner),
      ],
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'declining ends the request, and the sheet with it',
      setUp: () => when(() => repository.decline('v-1')).thenAnswer((_) async {}),
      build: build,
      seed: () => VisitDetailReady(sheet(status: VisitStatus.requested), persona: VisitPersona.owner),
      act: (bloc) => bloc.add(const VisitRequestAnswered(accept: false)),
      skip: 1,
      expect: () => [const VisitWasCancelled()],
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'CANCELLATION_TOO_LATE is the server\'s, and the sheet stays to say so',
      setUp: () => when(() => repository.cancel('v-1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/cancel'),
          response: Response(
            requestOptions: RequestOptions(path: '/cancel'),
            statusCode: 409,
            data: {'error': 'CANCELLATION_TOO_LATE'},
          ),
        ),
      ),
      build: build,
      seed: () => VisitDetailReady(sheet(), persona: VisitPersona.owner),
      act: (bloc) => bloc.add(const VisitCancelRequested()),
      skip: 1,
      expect: () => [VisitDetailReady(sheet(), persona: VisitPersona.owner, lastActionFailed: true)],
    );

    blocTest<VisitDetailBloc, VisitDetailState>(
      'an agent\'s source has no proposed times to answer',
      build: () => VisitDetailBloc(repository: MockAgentVisitRepository(), location: location),
      seed: () => VisitDetailReady(sheet(status: VisitStatus.requested)),
      act: (bloc) => bloc.add(const VisitRequestAnswered(accept: true)),
      expect: () => const <VisitDetailState>[],
    );
  });

  group('PrestataireVisitRepository', () {
    late MockDioClient dioClient;
    late MockApiClient apiClient;
    late MockPrestataireVisitesApi api;
    late PrestataireVisitRepository repository;

    setUp(() {
      dioClient = MockDioClient();
      apiClient = MockApiClient();
      api = MockPrestataireVisitesApi();
      when(() => dioClient.api).thenReturn(apiClient);
      when(apiClient.getPrestataireVisitesApi).thenReturn(api);
      repository = PrestataireVisitRepository(dioClient: dioClient);
    });

    test('§14 / §26 — the sheet carries the client, and the id their score takes', () async {
      when(() => api.getMyOwnerVisite(id: 'v-1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/v-1'),
          data: AgentVisiteDetail(
            (b) => b
              ..id = 'v-1'
              ..status = AgentVisiteDetailStatusEnum.SCHEDULED
              ..userName = 'Awa Nkeng'
              ..userPhone = '+237690000000'
              ..userAccountId = 'u-1',
          ),
        ),
      );

      final detail = await repository.detail('v-1');

      expect(detail.userName, 'Awa Nkeng');
      expect(detail.userAccountId, 'u-1');
    });

    test('cancels through the owner\'s route', () async {
      when(() => api.cancelMyOwnerVisite(id: 'v-1')).thenAnswer(
        (_) async => Response<void>(requestOptions: RequestOptions(path: '/cancel'), statusCode: 204),
      );

      await repository.cancel('v-1');

      verify(() => api.cancelMyOwnerVisite(id: 'v-1')).called(1);
    });
  });

  group('the sheet, read by the owner', () {
    late MockVisitDetailBloc bloc;

    setUp(() => bloc = MockVisitDetailBloc());

    Future<void> pump(WidgetTester tester, AgentVisitDetail visit) async {
      when(() => bloc.state).thenReturn(VisitDetailReady(visit, persona: VisitPersona.owner));
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('fr'),
          theme: MboaTheme.light(),
          localizationsDelegates: MboaLocalizations.delegates,
          supportedLocales: MboaLocalizations.supportedLocales,
          home: BlocProvider<VisitDetailBloc>.value(
            value: bloc,
            child: const VisitDetailPage(id: 'v-1'),
          ),
        ),
      );
      await tester.pump();
      await tester.scrollUntilVisible(find.text('Awa Nkeng'), 200);
    }

    testWidgets('one person to reach — the client — and their score', (tester) async {
      await pump(tester, sheet());

      expect(find.textContaining('+237690000000'), findsOneWidget);
      // His own name and number are not a contact.
      expect(find.text('Jean Mbarga'), findsNothing);
      expect(find.textContaining('+237691111111'), findsNothing);
      expect(find.text('Voir son Mboa Score'), findsOneWidget);
    });

    testWidgets('without the client\'s id, no score to offer', (tester) async {
      await pump(tester, sheet(client: null));

      expect(find.text('Voir son Mboa Score'), findsNothing);
    });

    testWidgets('a proposed time is answered, not cancelled', (tester) async {
      await pump(tester, sheet(status: VisitStatus.requested));

      expect(find.text('Confirmer le créneau'), findsOneWidget);
      expect(find.text('Annuler la visite'), findsNothing);

      await tester.tap(find.text('Confirmer le créneau'));
      verify(() => bloc.add(const VisitRequestAnswered(accept: true))).called(1);
    });

    testWidgets('a scheduled visit can be cancelled', (tester) async {
      await pump(tester, sheet());

      expect(find.text('Annuler la visite'), findsOneWidget);
      expect(find.text('Confirmer le créneau'), findsNothing);
    });
  });

  testWidgets('§26 — a request to answer offers the client\'s score', (tester) async {
    final agenda = MockPrestataireAgendaBloc();
    final actions = MockPrestataireVisitsBloc();
    final day = DateTime(2026, 8, 19);
    when(() => actions.state).thenReturn(const PrestataireVisitsIdle());
    when(() => agenda.state).thenReturn(
      VisitsAgendaReady(
        weekStart: DateTime(2026, 8, 17),
        selectedDay: day,
        today: day,
        visits: [
          Visit(
            id: 'v-1',
            status: VisitStatus.requested,
            annonceTitle: 'Studio Bonapriso',
            scheduledAt: day.add(const Duration(hours: 10)),
            visitorKind: VisitorKind.owner,
            clientAccountId: 'u-1',
          ),
        ],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('fr'),
        theme: MboaTheme.light(),
        localizationsDelegates: MboaLocalizations.delegates,
        supportedLocales: MboaLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider<PrestataireAgendaBloc>.value(value: agenda),
            BlocProvider<PrestataireVisitsBloc>.value(value: actions),
          ],
          child: const PrestataireVisitsPage(),
        ),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Voir son Mboa Score'), findsOneWidget);
  });

  group('a visit notification', () {
    late MockAppRouter router;

    setUpAll(() => registerFallbackValue(_FakeRoute()));

    setUp(() {
      router = MockAppRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => router.navigate(any())).thenAnswer((_) async {});
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    });

    tearDown(getIt.reset);

    test('takes an agent to that visit\'s sheet', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.agent);

      routeNotificationTap(router, const PushMessage(type: PushType.visit, entityId: 'v-1'));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, VisitDetailRoute.name);
    });

    test('takes an owner to the agenda — the visit may be an agent\'s on his property', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.visit, entityId: 'v-1'));

      // N-03 / N-05 also reach him for an agent's visit, whose sheet he cannot
      // read; the payload does not say which.
      verifyNever(() => router.push<Object?>(any()));
      final route = verify(() => router.navigate(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, ProShellRoute.name);
    });
  });
}
