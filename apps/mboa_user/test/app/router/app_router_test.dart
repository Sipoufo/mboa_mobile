import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/app/router/app_router.dart';
import 'package:mboa_user/app/router/app_router.gr.dart';

/// **The tenant app has a public zone, and that is load-bearing.**
///
/// CA-M04-04 and RM-M04-05 let a visitor search and read fiches without an
/// account; the wall belongs on contacting and booking. Putting the shell
/// behind `SessionGuard` would send every first-time user to a login screen
/// before they ever saw a property — the app's whole entry point.
void main() {
  late AppRouter router;

  setUp(() => router = AppRouter(snapshot: SessionSnapshot()));

  AutoRoute routeNamed(String name, {List<AutoRoute>? within}) =>
      (within ?? router.routes).firstWhere((r) => r.name == name);

  List<AutoRoute> childrenOf(String name) => routeNamed(name)
      .children!
      .routes
      .whereType<AutoRoute>()
      .where((r) => r is! RedirectRoute)
      .toList();

  test('a cold start opens on the splash — the only place the session is restored', () {
    // The platform hands over `/` at launch. When the shell owned `/`, it was
    // opened directly and the splash's session check never ran: every restart
    // looked signed out with the tokens still in the Keychain.
    final match = router.matcher.match('/');
    expect(match, isNotNull);
    expect(match!.last.name, SplashRoute.name);
  });

  test('the shell is reachable without a session', () {
    expect(routeNamed(UserShellRoute.name).guards, isEmpty);
  });

  test('the search is the shell\'s landing tab', () {
    final tabs = childrenOf(UserShellRoute.name);
    expect(tabs.first.name, SearchRoute.name);
    expect(
      tabs.map((t) => t.name),
      [
        SearchRoute.name,
        FavoritesRoute.name,
        MessagesRoute.name,
        AccountRoute.name,
      ],
    );
  });

  test('the search tab itself carries no guard', () {
    final search = routeNamed(
      SearchRoute.name,
      within: childrenOf(UserShellRoute.name),
    );
    expect(search.guards, isEmpty);
  });

  test('what genuinely needs a session stays behind SessionGuard', () {
    expect(
      routeNamed(AuthenticatedRouter.name).guards.whereType<SessionGuard>(),
      isNotEmpty,
    );
  });

  test('M12 — a thread is a destination, not a tab', () {
    // Pushed over the shell from the list *and* straight after a first
    // contact, so it lives at the root rather than inside a tab.
    expect(routeNamed(ThreadRoute.name).guards, isEmpty);
  });

  test('sign-in screens stay behind GuestGuard', () {
    for (final name in [LoginRoute.name, WelcomeRoute.name]) {
      expect(
        routeNamed(name).guards.whereType<GuestGuard>(),
        isNotEmpty,
        reason: name,
      );
    }
  });
}
