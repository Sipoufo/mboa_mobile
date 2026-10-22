import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/app/notifications_bootstrap.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_pro/features/tenant_requests/bloc/open_requests_bloc.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRequestsRepository extends Mock implements HomeRequestsRepository {}

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// CDC M30 lot 3 — the landlord's side of the tenants' requests.
void main() {
  group('the counter', () {
    late MockHomeRequestsRepository repository;

    setUp(() => repository = MockHomeRequestsRepository());

    blocTest<OpenRequestsBloc, OpenRequestsState>(
      "is the server's total of what still waits",
      setUp: () => when(() => repository.openCount()).thenAnswer((_) async => 3),
      build: () => OpenRequestsBloc(repository: repository),
      act: (bloc) => bloc.add(const OpenRequestsRequested()),
      expect: () => const [OpenRequestsCounted(3)],
    );

    blocTest<OpenRequestsBloc, OpenRequestsState>(
      'a failed read keeps the last count',
      setUp: () => when(() => repository.openCount()).thenThrow(Exception('offline')),
      build: () => OpenRequestsBloc(repository: repository),
      seed: () => const OpenRequestsCounted(2),
      act: (bloc) => bloc.add(const OpenRequestsRequested()),
      expect: () => const <OpenRequestsState>[],
    );
  });

  group('N-38, the push', () {
    late MockAppRouter router;

    setUpAll(() => registerFallbackValue(_FakeRoute()));

    setUp(() {
      router = MockAppRouter();
      when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
      when(() => router.navigate(any())).thenAnswer((_) async {});
      getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
    });

    tearDown(getIt.reset);

    test('a tenant\'s request opens the request', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.homeRequest, entityId: 'hr-1'));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, TenantRequestRoute.name);
      expect((route.args! as TenantRequestRouteArgs).requestId, 'hr-1');
    });

    test('several merged (no id): the inbox', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.prestataire);

      routeNotificationTap(router, const PushMessage(type: PushType.homeRequest));

      final route = verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;
      expect(route.routeName, ReceivedRequestsRoute.name);
    });

    test('an agent has no tenants: the shell', () {
      getIt<SessionSnapshot>().markAuthenticated(role: AccountRole.agent);

      routeNotificationTap(router, const PushMessage(type: PushType.homeRequest, entityId: 'hr-1'));

      verifyNever(() => router.push<Object?>(any()));
    });
  });
}
