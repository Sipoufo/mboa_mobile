import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_pro/app/router/app_router.dart';
import 'package:mboa_pro/app/router/app_router.gr.dart';
import 'package:mboa_shared/mboa_shared.dart';

void main() {
  late AppRouter router;

  setUp(() => router = AppRouter(snapshot: SessionSnapshot()));

  AutoRoute routeNamed(String name, {List<AutoRoute>? within}) =>
      (within ?? router.routes).firstWhere((r) => r.name == name);

  /// Declared children, minus the `RedirectRoute` auto_route synthesises for a
  /// nested collection whose initial route doesn't sit at the empty path.
  List<AutoRoute> childrenOf(String name, {List<AutoRoute>? within}) =>
      routeNamed(name, within: within)
          .children!
          .routes
          .whereType<AutoRoute>()
          .where((r) => r is! RedirectRoute)
          .toList();

  /// Everything nested under `/app`.
  List<AutoRoute> appChildren() => childrenOf(AuthenticatedRouter.name);

  group('guest routes', () {
    test('login and register are behind GuestGuard', () {
      for (final name in [LoginRoute.name, RegisterRoute.name]) {
        expect(
          routeNamed(name).guards.whereType<GuestGuard>(),
          isNotEmpty,
          reason: name,
        );
      }
    });

    test('splash is reachable unguarded — it is what seeds the snapshot', () {
      final splash = routeNamed(SplashRoute.name);

      expect(splash.guards, isEmpty);
      expect(splash.initial, isTrue);
    });
  });

  group('authenticated subtree', () {
    test('/app is behind SessionGuard', () {
      final app = routeNamed(AuthenticatedRouter.name);

      expect(app.path, '/app');
      expect(app.guards.whereType<SessionGuard>(), isNotEmpty);
    });

    test('every authenticated screen is nested under /app', () {
      final childNames = appChildren().map((r) => r.name).toSet();

      expect(
        childNames,
        containsAll([
          ProShellRoute.name,
          ProMenuRoute.name,
          EditProfileRoute.name,
          SettingsMenuRoute.name,
          ChangePhoneRoute.name,
          ChangePasswordRoute.name,
          DeleteAccountRoute.name,
          CertificationsRoute.name,
          IdDocumentRoute.name,
          AccessRestrictedRoute.name,
        ]),
      );

      // Nothing authenticated may sit at the root, where no guard protects it.
      final rootNames = router.routes.map((r) => r.name).toSet();
      expect(rootNames.intersection(childNames), isEmpty);
    });
  });

  group('tab shell', () {
    test('holds exactly the three tabs, Accueil first', () {
      final tabs = childrenOf(ProShellRoute.name, within: appChildren());

      expect(
        tabs.map((r) => r.name),
        [HomeRoute.name, PrestataireVisitsRoute.name, ContractsListRoute.name],
      );
      expect(tabs.first.initial, isTrue);
    });

    test('the menu is a sibling of the shell, not a fourth tab', () {
      final tabNames = childrenOf(ProShellRoute.name, within: appChildren())
          .map((r) => r.name);
      expect(tabNames, isNot(contains(ProMenuRoute.name)));

      final menu = routeNamed(
        ProMenuRoute.name,
        within: appChildren(),
      );
      expect(menu.path, 'menu');
    });

    test('the role gate is the landing route of /app, not a shell', () {
      final gate = routeNamed(RoleGateRoute.name, within: appChildren());

      // App Mboa Pro serves two personas and the login response carries no
      // role, so `/app` cannot open on either shell: an agent would see the
      // prestataire dashboard until the profile arrived.
      expect(gate.initial, isTrue);
      expect(gate.path, '');
    });

    test('neither shell is the landing route', () {
      for (final name in [ProShellRoute.name, AgentShellRoute.name]) {
        expect(
          routeNamed(name, within: appChildren()).initial,
          isFalse,
          reason: '$name must be reached through the gate',
        );
      }
    });
  });
}
