import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/app/notifications_bootstrap.dart';
import 'package:mboa_user/app/router/app_router.dart';
import 'package:mboa_user/app/router/app_router.gr.dart';
import 'package:mocktail/mocktail.dart';

class MockAppRouter extends Mock implements AppRouter {}

class _FakeRoute extends Fake implements PageRouteInfo<dynamic> {}

/// CA-M03-02 — a tap opens the screen the notification is about.
void main() {
  late MockAppRouter router;

  setUpAll(() => registerFallbackValue(_FakeRoute()));

  setUp(() {
    router = MockAppRouter();
    when(() => router.push<Object?>(any())).thenAnswer((_) async => null);
    when(() => router.navigate(any())).thenAnswer((_) async {});
  });

  PageRouteInfo<dynamic> pushed() => verify(() => router.push<Object?>(captureAny())).captured.single as PageRouteInfo;

  test('N-01 opens what the saved search found', () {
    routeNotificationTap(router, const PushMessage(type: PushType.savedSearch, entityId: 's-1'));

    final route = pushed();
    expect(route.routeName, AuthenticatedRouter.name);
    final child = route.initialChildren!.single;
    expect(child.routeName, SavedSearchResultsRoute.name);
    expect((child.args! as SavedSearchResultsRouteArgs).id, 's-1');
  });

  test('N-01 without an id opens the saved searches', () {
    routeNotificationTap(router, const PushMessage(type: PushType.savedSearch));

    final route = pushed();
    expect(route.routeName, AuthenticatedRouter.name);
    expect(route.initialChildren!.single.routeName, SavedSearchesRoute.name);
  });

  test('a visit opens that visit', () {
    routeNotificationTap(router, const PushMessage(type: PushType.visit, entityId: 'v-1'));

    final child = pushed().initialChildren!.single;
    expect(child.routeName, VisitDetailRoute.name);
    expect((child.args! as VisitDetailRouteArgs).visitId, 'v-1');
  });

  test('N-33 / N-34 open the reservation request', () {
    routeNotificationTap(router, const PushMessage(type: PushType.reservation, entityId: 'r-1'));

    final child = pushed().initialChildren!.single;
    expect(child.routeName, ReservationDetailRoute.name);
    expect((child.args! as ReservationDetailRouteArgs).id, 'r-1');
  });

  test('a reservation push without an id opens the list', () {
    routeNotificationTap(router, const PushMessage(type: PushType.reservation));

    expect(pushed().initialChildren!.single.routeName, MyReservationsRoute.name);
  });

  test('N-36 — a payment confirmed or contested opens its space', () {
    routeNotificationTap(router, const PushMessage(type: PushType.home, entityId: 'c-1'));

    final child = pushed().initialChildren!.single;
    expect(child.routeName, MyHomeRoute.name);
    expect((child.args! as MyHomeRouteArgs).contractId, 'c-1');
  });

  test('N-36 merged (no id) opens "Mes logements"', () {
    routeNotificationTap(router, const PushMessage(type: PushType.home));

    expect(pushed().initialChildren!.single.routeName, MyHomesRoute.name);
  });

  test('N-36 for an invoice opens the invoice', () {
    routeNotificationTap(router, const PushMessage(type: PushType.invoice, entityId: 'i-1'));

    final child = pushed().initialChildren!.single;
    expect(child.routeName, InvoiceRoute.name);
    expect((child.args! as InvoiceRouteArgs).invoiceId, 'i-1');
  });

  test('an invoice push merged (no id) opens "Mes logements"', () {
    routeNotificationTap(router, const PushMessage(type: PushType.invoice));

    expect(pushed().initialChildren!.single.routeName, MyHomesRoute.name);
  });

  test('N-38 opens the request', () {
    routeNotificationTap(router, const PushMessage(type: PushType.homeRequest, entityId: 'hr-1'));

    final child = pushed().initialChildren!.single;
    expect(child.routeName, HomeRequestRoute.name);
    expect((child.args! as HomeRequestRouteArgs).requestId, 'hr-1');
  });

  test('a type this build does not know lands on the shell', () {
    routeNotificationTap(router, const PushMessage(type: PushType.unknown));

    verify(() => router.navigate(const AuthenticatedRouter())).called(1);
    verifyNever(() => router.push<Object?>(any()));
  });
}
