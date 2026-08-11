import 'package:auto_route/auto_route.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'app_router.gr.dart';

/// Declarative route table for App Mboa Pro. Generated into `app_router.gr.dart`
/// by `build_runner` (run `make gen-code`).
///
/// Shape:
///  - guest routes (`/splash`, `/login`, `/register`) — `GuestGuard` bounces an
///    already-signed-in user off them;
///  - everything else lives under `/app`, behind `SessionGuard` and the
///    `AuthenticatedRouter` wrapper that owns the session-scoped blocs;
///  - the tab shell (`ProShellRoute`) holds Accueil / Gestionnaire / Finance.
///    The Menu slot pushes `ProMenuRoute` over the active tab instead of being
///    a fourth tab.
///
/// The guards make the table defensively correct for deep links and back
/// navigation; the *transition* on login/logout is still driven by the root
/// `AuthBloc` listener in `MboaProApp`, which also keeps [SessionSnapshot] warm.
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({SessionSnapshot? snapshot})
      : _snapshot = snapshot ?? getIt<SessionSnapshot>();

  final SessionSnapshot _snapshot;

  /// Sends a signed-out visitor back to login.
  late final _sessionGuard = SessionGuard(
    snapshot: _snapshot,
    onDenied: (router) => router.replaceAll([const LoginRoute()]),
  );

  /// Keeps a signed-in user out of the guest routes.
  late final _guestGuard = GuestGuard(
    snapshot: _snapshot,
    onAuthenticated: (router) => router.replaceAll([const AuthenticatedRouter()]),
  );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/splash', initial: true),
        AutoRoute(page: LoginRoute.page, path: '/login', guards: [_guestGuard]),
        AutoRoute(page: RegisterRoute.page, path: '/register', guards: [_guestGuard]),
        AutoRoute(
          page: AuthenticatedRouter.page,
          path: '/app',
          guards: [_sessionGuard],
          children: [
            // Tab shell.
            AutoRoute(
              page: ProShellRoute.page,
              path: '',
              initial: true,
              children: [
                AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
                AutoRoute(page: ManagerRoute.page, path: 'manager'),
                AutoRoute(page: FinanceRoute.page, path: 'finance'),
              ],
            ),

            // Agent shell (M15). A separate persona: a signed-in agent is
            // redirected here by the role listener in AuthenticatedWrapper,
            // because the prestataire tabs are about listings they do not have.
            AutoRoute(
              page: AgentShellRoute.page,
              path: 'agent',
              children: [
                AutoRoute(page: AgentVisitsRoute.page, path: 'visits', initial: true),
                AutoRoute(page: AgentMissionsRoute.page, path: 'missions'),
                AutoRoute(page: AgentProfileRoute.page, path: 'profile'),
              ],
            ),
            AutoRoute(page: AgentZonesRoute.page, path: 'agent/zones'),
            AutoRoute(page: AgentAvailabilityRoute.page, path: 'agent/availability'),

            // Agent assignment (M11).
            AutoRoute(page: MesAgentsRoute.page, path: 'agents'),
            AutoRoute(page: AgentAssignmentRoute.page, path: 'agents/assign'),

            // Slide menu — pushed over the shell, not a tab.
            CustomRoute(
              page: ProMenuRoute.page,
              path: 'menu',
              transitionsBuilder: TransitionsBuilders.slideLeft,
              opaque: false,
            ),

            // Profile & settings (M02).
            AutoRoute(page: EditProfileRoute.page, path: 'profile'),
            AutoRoute(page: SettingsRoute.page, path: 'settings/hub'),
            AutoRoute(page: SettingsMenuRoute.page, path: 'settings'),
            AutoRoute(page: ChangePhoneRoute.page, path: 'settings/phone'),
            AutoRoute(page: ChangePasswordRoute.page, path: 'settings/password'),
            AutoRoute(page: DeleteAccountRoute.page, path: 'settings/delete'),

            // KYC / Certifications (M01bis).
            AutoRoute(page: CertificationsRoute.page, path: 'kyc'),
            AutoRoute(page: IdDocumentRoute.page, path: 'kyc/id-document'),

            // Listings (M10).
            AutoRoute(page: MesBiensRoute.page, path: 'biens'),
            AutoRoute(page: AnnoncesListRoute.page, path: 'biens/uniques'),
            AutoRoute(page: ResidencesListRoute.page, path: 'biens/multiples'),
            AutoRoute(page: AnnonceFormRoute.page, path: 'biens/form'),
            AutoRoute(page: ResidenceDetailRoute.page, path: 'biens/residences/:id'),
            AutoRoute(page: AnnonceDetailRoute.page, path: 'biens/:id'),

            // Subscriptions (M13).
            AutoRoute(page: SubscriptionRoute.page, path: 'subscription'),
            AutoRoute(page: PlansRoute.page, path: 'subscription/plans'),

            // Gated-feature explainer.
            AutoRoute(page: AccessRestrictedRoute.page, path: 'access-restricted'),
          ],
        ),
      ];
}
