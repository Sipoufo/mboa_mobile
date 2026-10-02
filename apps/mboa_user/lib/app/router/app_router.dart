import 'package:auto_route/auto_route.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa. Routes are generated into
/// `app_router.gr.dart` by `build_runner` (run `make gen-code`).
///
/// **The tab shell is public** (`/`), unlike App Mboa Pro's: CA-M04-04 and
/// RM-M04-05 let a visitor search and read fiches without an account, and the
/// wall goes up on the actions — contacting, booking — not at the door. Sign-in
/// screens stay behind `GuestGuard`, and everything that genuinely needs a
/// session stays under `/app` behind `SessionGuard`.
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

        // Public: searching and reading a fiche need no account (CA-M04-04,
        // CA-M05-04). The fiches are pushed over the shell rather than living
        // in a tab — they are a destination, not a section.
        AutoRoute(page: ListingDetailRoute.page, path: '/listings/:id'),
        // M12 — a thread is opened from the list or straight after a first
        // contact; it needs a session, which the tab already checked.
        AutoRoute(page: ThreadRoute.page, path: '/messages/:id'),
        AutoRoute(page: ResidenceDetailRoute.page, path: '/residences/:id'),

        // Public: searching needs no account (CA-M04-04).
        AutoRoute(
          page: UserShellRoute.page,
          path: '/',
          children: [
            AutoRoute(page: SearchRoute.page, path: '', initial: true),
            AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
            AutoRoute(page: MessagesRoute.page, path: 'messages'),
            AutoRoute(page: AccountRoute.page, path: 'account'),
          ],
        ),
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
            // M07 — a visit belongs to an account, so it lives behind the
            // session guard with the rest of `/app`.
            AutoRoute(page: MyVisitsRoute.page, path: 'visits'),
            AutoRoute(page: VisitDetailRoute.page, path: 'visits/:visitId'),

            AutoRoute(page: SettingsMenuRoute.page, path: 'settings'),
            AutoRoute(page: ChangePhoneRoute.page, path: 'settings/phone'),
            AutoRoute(page: DeleteAccountRoute.page, path: 'settings/delete'),
          ],
        ),
      ];
}
