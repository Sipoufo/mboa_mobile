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
        AutoRoute(page: ForgotPasswordRoute.page, path: '/login/forgot-password', guards: [_guestGuard]),
        AutoRoute(
          page: AuthenticatedRouter.page,
          path: '/app',
          guards: [_sessionGuard],
          children: [
            // `/app` opens on a neutral gate, not on a persona's shell: the
            // role is not in the login response, so it is genuinely unknown
            // for a moment after signing in. Landing on the prestataire
            // dashboard and replacing it a beat later showed an agent someone
            // else's app.
            AutoRoute(page: RoleGateRoute.page, path: '', initial: true),
            AutoRoute(
              page: ProShellRoute.page,
              path: 'home',
              children: [
                AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
                AutoRoute(page: PrestataireVisitsRoute.page, path: 'visits'),
                AutoRoute(page: ContractsListRoute.page, path: 'contracts'),
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
            // M16 — the visit and its report are pushed over the agent shell.
            AutoRoute(page: VisitDetailRoute.page, path: 'agent/visits/:id'),
            // M07bis — one review screen for both personas; the agent opens it
            // from his visit detail, the prestataire from his own agenda.
            AutoRoute(page: VisitReviewRoute.page, path: 'visits/:id/review'),

            // Messagerie (M12) — reached from the slide menu; a prestataire
            // cannot start a thread, only answer one.
            AutoRoute(page: MessagesRoute.page, path: 'messages'),
            AutoRoute(page: ThreadRoute.page, path: 'messages/:id'),

            // Contrat Mboa (M08). The list is a shell tab — the menu entry
            // points at that tab rather than pushing a second copy of it.
            AutoRoute(page: ContractFormRoute.page, path: 'contracts/form'),
            // M29 — the requests on the prestataire's listings.
            AutoRoute(page: IncomingReservationsRoute.page, path: 'reservations'),
            AutoRoute(page: IncomingReservationRoute.page, path: 'reservations/:id'),
            // M30 — "Loyers": the declared payments and the tenants' spaces.
            AutoRoute(page: RentsRoute.page, path: 'rents'),
            // M24–M26 — « Gestion financière », the paid add-on.
            AutoRoute(page: FinanceRoute.page, path: 'finance'),
            AutoRoute(page: OwnerInvoicesRoute.page, path: 'finance/invoices'),
            // The form carries the invoice it corrects: no deep link.
            AutoRoute(page: InvoiceFormRoute.page, path: 'finance/invoices/new'),
            AutoRoute(page: OwnerInvoiceRoute.page, path: 'finance/invoices/:invoiceId'),
            AutoRoute(page: LedgerRoute.page, path: 'finance/ledger'),
            // The form carries the line it corrects: no deep link.
            AutoRoute(page: LedgerEntryFormRoute.page, path: 'finance/ledger/entry'),
            AutoRoute(page: ReceivedDeclarationRoute.page, path: 'rents/declarations/:declarationId'),
            AutoRoute(page: TenantHomeRoute.page, path: 'rents/homes/:contractId'),
            // M30 lot 3 — tenants' requests: the inbox, one home's, one
            // request (what N-38 opens).
            AutoRoute(page: ReceivedRequestsRoute.page, path: 'requests'),
            AutoRoute(page: TenantHomeRequestsRoute.page, path: 'rents/homes/:contractId/requests'),
            AutoRoute(page: TenantRequestRoute.page, path: 'home-requests/:requestId'),
            // M30 lot 3 — useful contacts.
            AutoRoute(page: ContactsRoute.page, path: 'contacts'),
            AutoRoute(page: ContactFormRoute.page, path: 'contacts/form'),
            // M30 lot 3 — a tenancy's photo proofs (N-39).
            AutoRoute(page: TenantEvidenceRoute.page, path: 'rents/homes/:contractId/evidence'),
            // M31 — before / after; ahead of a sending, whose id it would match.
            AutoRoute(page: TenantEvidenceCompareRoute.page, path: 'rents/homes/:contractId/evidence/compare'),
            AutoRoute(page: TenantEvidenceBatchRoute.page, path: 'rents/homes/:contractId/evidence/:batchId'),
            AutoRoute(page: ContractDetailRoute.page, path: 'contracts/:id'),
            // M27 — the review hangs off the contract, so its route does too.
            AutoRoute(
              page: ResidentReplyRoute.page,
              path: 'contracts/:contractId/review',
            ),
            AutoRoute(page: AgentAvailabilityRoute.page, path: 'agent/availability'),

            // Agent assignment (M11).
            AutoRoute(page: MesAgentsRoute.page, path: 'agents'),
            AutoRoute(page: AgentAssignmentRoute.page, path: 'agents/assign'),
            AutoRoute(page: AgentDetailRoute.page, path: 'agents/:id'),

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
            AutoRoute(page: NotificationPreferencesRoute.page, path: 'settings/notifications'),
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
