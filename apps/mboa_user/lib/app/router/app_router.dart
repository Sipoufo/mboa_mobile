import 'package:auto_route/auto_route.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa. Routes are generated into
/// `app_router.gr.dart` by `build_runner` (run `make gen-code`).
///
/// Same shape as App Mboa Pro: guest routes up top behind `GuestGuard`,
/// everything authenticated under `/app` behind `SessionGuard` and the
/// `AuthenticatedRouter` wrapper. There is no tab shell here yet — when one
/// lands it slots in as `/app`'s initial child without moving the rest.
///
/// The login screens (`LoginRoute`, `OtpRoute`) come from the shared
/// `mboa_shared` package; auto_route resolves them across the package boundary.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({SessionSnapshot? snapshot})
      : _snapshot = snapshot ?? getIt<SessionSnapshot>();

  final SessionSnapshot _snapshot;

  late final _sessionGuard = SessionGuard(
    snapshot: _snapshot,
    onDenied: (router) => router.replaceAll([const WelcomeRoute()]),
  );

  late final _guestGuard = GuestGuard(
    snapshot: _snapshot,
    onAuthenticated: (router) => router.replaceAll([const AuthenticatedRouter()]),
  );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
        AutoRoute(page: WelcomeRoute.page, path: '/welcome', guards: [_guestGuard]),
        AutoRoute(page: LoginRoute.page, path: '/login', guards: [_guestGuard]),
        AutoRoute(page: OtpRoute.page, path: '/login/otp', guards: [_guestGuard]),
        AutoRoute(
          page: AuthenticatedRouter.page,
          path: '/app',
          guards: [_sessionGuard],
          children: [
            AutoRoute(page: HomeRoute.page, path: '', initial: true),

            // Profile & settings (M02).
            AutoRoute(page: EditProfileRoute.page, path: 'profile'),
            AutoRoute(page: SettingsRoute.page, path: 'settings/hub'),
            AutoRoute(page: SettingsMenuRoute.page, path: 'settings'),
            AutoRoute(page: ChangePhoneRoute.page, path: 'settings/phone'),
            AutoRoute(page: DeleteAccountRoute.page, path: 'settings/delete'),
          ],
        ),
      ];
}
