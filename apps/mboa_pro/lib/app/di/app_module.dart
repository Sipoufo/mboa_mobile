import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/password_reset/bloc/password_reset_bloc.dart';
import '../../features/password_reset/data/password_reset_repository.dart';
import '../../features/agent/bloc/agent_availability_bloc.dart';
import '../../features/assignments/bloc/agent_detail_bloc.dart';
import '../../features/assignments/bloc/agent_missions_bloc.dart';
import '../../features/assignments/bloc/my_agents_bloc.dart';
import '../../features/assignments/bloc/property_agent_bloc.dart';
import '../../features/assignments/data/agent_mission_repository.dart';
import '../../features/assignments/data/assignment_repository.dart';
import '../../features/annonces/data/location_capture.dart';
import '../../features/contracts/bloc/contract_form_bloc.dart';
import '../../features/visits/bloc/prestataire_visits_bloc.dart';
import '../../features/visits/bloc/visit_review_bloc.dart';
import '../../features/visits/bloc/visits_agenda_blocs.dart';
import '../../features/visits/data/prestataire_visit_repository.dart';
import '../../features/visits/data/visit_detail_source.dart';
import '../../features/visits/bloc/visit_detail_bloc.dart';
import '../../features/visits/data/agent_visit_repository.dart';
import '../../features/agent/bloc/agent_profile_bloc.dart';
import '../../features/agent/data/agent_repository.dart';
import '../../features/annonces/bloc/annonce_form_bloc.dart';
import '../../features/annonces/bloc/annonces_bloc.dart';
import '../../features/annonces/bloc/residences_bloc.dart';
import '../../features/annonces/data/annonce_repository.dart';
import '../../features/annonces/data/residence_repository.dart';
import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/login/bloc/credential_login_bloc.dart';
import '../../features/login/data/credential_auth_repository.dart';
import '../../features/home/bloc/home_bloc.dart';
import '../../features/home/data/pro_dashboard_repository.dart';
import '../../features/kyc/data/kyc_repository.dart';
import '../../features/kyc/logic/kyc_cubit.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../features/profile/profile_types.dart';
import '../../features/register/bloc/register_bloc.dart';
import '../../features/reservations/bloc/incoming_reservation_bloc.dart';
import '../../features/reservations/bloc/incoming_reservations_bloc.dart';
import '../../features/reservations/bloc/pending_reservations_bloc.dart';
import '../../features/reservations/data/incoming_reservations_repository.dart';
import '../../features/register/data/register_repository.dart';
import '../../features/rents/bloc/rents_bloc.dart';
import '../../features/tenant_requests/bloc/open_requests_bloc.dart';
import '../../features/rents/bloc/waiting_declarations_bloc.dart';
import '../../features/splash/logic/splash_cubit.dart';
import '../../features/subscription/bloc/subscribe_bloc.dart';
import '../../features/subscription/bloc/subscription_bloc.dart';
import '../../features/subscription/data/subscription_repository.dart';

/// Registers App-Mboa-Pro dependencies on top of the shared core module.
void registerAppModule() {
  // Routing — the snapshot the guards read, and the feature-access policy.
  getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
  getIt.registerLazySingleton<AccessPolicy>(AccessPolicy.new);

  // Push notifications (M03). Registered before AuthRepository because logout
  // has to revoke the device *before* the tokens are cleared.
  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(dioClient: getIt<DioClient>()),
  );

  // Session gate.
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      dioClient: getIt<DioClient>(),
      tokenStorage: getIt<SecureTokenStorage>(),
      cache: getIt<HiveCache>(),
      notifications: getIt<NotificationsRepository>(),
    ),
  );
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(repository: getIt<AuthRepository>()),
  );

  // Shared session check + startup splash controller.
  registerSessionModule(getIt);
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(sessionRepository: getIt<SessionRepository>()),
  );

  // Credential login (email + password + email OTP) — Pro-specific.
  getIt.registerLazySingleton<CredentialAuthRepository>(
    () => CredentialAuthRepository(
      dioClient: getIt<DioClient>(),
      tokenStorage: getIt<SecureTokenStorage>(),
    ),
  );
  getIt.registerFactory<CredentialLoginBloc>(
    () => CredentialLoginBloc(repository: getIt<CredentialAuthRepository>()),
  );

  // Professional registration (role + email + password + phone + phone OTP).
  getIt.registerLazySingleton<RegisterRepository>(
    () => RegisterRepository(
      dioClient: getIt<DioClient>(),
      tokenStorage: getIt<SecureTokenStorage>(),
    ),
  );
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(repository: getIt<RegisterRepository>()),
  );

  // Profile / Settings (M02) — shared base + prestataire business profile.
  // Singleton bloc so the hub and edit screen share one instance.
  getIt.registerLazySingleton<BaseProfileRepository>(
    () => BaseProfileRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<ProProfileRepository>(
    () => ProProfileRepository(
      dioClient: getIt<DioClient>(),
      base: getIt<BaseProfileRepository>(),
    ),
  );
  getIt.registerLazySingleton<ProProfileBloc>(
    () => ProProfileBloc(
      repository: getIt<ProProfileRepository>(),
      uploader: getIt<MediaUploader>(),
    ),
  );

  // KYC / Certifications (M01bis). Singleton cubit so the certifications and
  // ID-document screens share one capture draft.
  getIt.registerLazySingleton<KycRepository>(
    () => KycRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<MediaUploader>(
    () => MediaUploader(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<LocationRepository>(
    () => LocationRepository(dioClient: getIt<DioClient>()),
  );

  // Account settings (delete; phone/password/language to follow).
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<DeleteAccountCubit>(
    () => DeleteAccountCubit(repository: getIt<AccountRepository>()),
  );
  getIt.registerFactory<ChangePhoneBloc>(
    () => ChangePhoneBloc(repository: getIt<AccountRepository>()),
  );
  // M02 — forgotten password, before any session exists.
  getIt.registerLazySingleton<PasswordResetRepository>(
    () => PasswordResetRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<PasswordResetBloc>(
    () => PasswordResetBloc(repository: getIt<PasswordResetRepository>()),
  );
  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(repository: getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepository(dioClient: getIt<DioClient>()),
  );
  // M09 — the Mboa Score, read live and never cached.
  getIt.registerLazySingleton<MboaScoreRepository>(
    () => MboaScoreRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactoryParam<MboaScoreBloc, ScoreSource, void>(
    (source, _) => MboaScoreBloc(repository: getIt<MboaScoreRepository>(), source: source),
  );
  getIt.registerFactoryParam<NotificationPreferencesBloc, NotificationAudience, void>(
    (audience, _) => NotificationPreferencesBloc(
      repository: getIt<AppSettingsRepository>(),
      audience: audience,
    ),
  );
  getIt.registerLazySingleton<LocaleController>(
    () => LocaleController(
      cache: getIt<HiveCache>(),
      settings: getIt<AppSettingsRepository>(),
    ),
  );
  // Home / dashboard (M14).
  getIt.registerLazySingleton<ProDashboardRepository>(
    () => ProDashboardRepository(
      dioClient: getIt<DioClient>(),
      cache: getIt<HiveCache>(),
    ),
  );
  // Singleton, not a factory: the dashboard figures appear on both the home
  // and the Mes biens hub, and AuthenticatedWrapper provides this one instance
  // to every authenticated route.
  getIt.registerLazySingleton<HomeBloc>(
    () => HomeBloc(repository: getIt<ProDashboardRepository>()),
  );

  // Listings (M10). The list blocs are factories — each list screen owns one,
  // and the detail reads the list bloc it was pushed from.
  getIt.registerLazySingleton<AnnonceRepository>(
    () => AnnonceRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<ResidenceRepository>(
    () => ResidenceRepository(dioClient: getIt<DioClient>()),
  );
  // Singletons: AnnonceDetailPage is a *sibling* route of the list, not a
  // child, so a list-scoped provider would not reach it. Sharing one instance
  // also means a transition on the detail updates the list behind it.
  getIt.registerLazySingleton<AnnoncesBloc>(
    () => AnnoncesBloc(repository: getIt<AnnonceRepository>()),
  );
  getIt.registerLazySingleton<ResidencesBloc>(
    () => ResidencesBloc(repository: getIt<ResidenceRepository>()),
  );
  getIt.registerFactory<AnnonceFormBloc>(
    () => AnnonceFormBloc(
      annonces: getIt<AnnonceRepository>(),
      residences: getIt<ResidenceRepository>(),
      uploader: getIt<MediaUploader>(),
    ),
  );

  // Subscriptions (M13). SubscriptionBloc is a singleton because it feeds
  // AccessContext.tier for the whole app; SubscribeBloc is per-checkout.
  // --- Agent assignment (M11) ---
  getIt.registerLazySingleton<AssignmentRepository>(
    () => AssignmentRepository(dioClient: getIt<DioClient>()),
  );
  // Both route-scoped: one instance per property screen, one per hub visit.
  getIt.registerFactory<PropertyAgentBloc>(
    () => PropertyAgentBloc(repository: getIt<AssignmentRepository>()),
  );
  getIt.registerLazySingleton<AgentMissionRepository>(
    () => AgentMissionRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<AgentMissionsBloc>(
    () => AgentMissionsBloc(repository: getIt<AgentMissionRepository>()),
  );
  getIt.registerFactory<AgentDetailBloc>(
    () => AgentDetailBloc(repository: getIt<AssignmentRepository>()),
  );
  // Session-scoped, not route-scoped: Mes agents *and* the agent detail read
  // it, and a bloc provided by one route is invisible to its siblings.
  getIt.registerLazySingleton<MyAgentsBloc>(
    () => MyAgentsBloc(repository: getIt<AssignmentRepository>()),
  );

  // --- Agent visits (M16) ---
  // Registered so VisitDetailBloc can take it as a dependency and be tested
  // without a device; the listing form still constructs its own inline.
  getIt.registerLazySingleton<LocationCapture>(LocationCapture.new);
  getIt.registerLazySingleton<AgentVisitRepository>(
    () => AgentVisitRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<AgentAgendaBloc>(
    () => AgentAgendaBloc(source: getIt<AgentVisitRepository>()),
  );
  // RM-M11-10 — the prestataire's own visits, same agenda, other source.
  getIt.registerLazySingleton<PrestataireVisitRepository>(
    () => PrestataireVisitRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<PrestataireAgendaBloc>(
    () => PrestataireAgendaBloc(source: getIt<PrestataireVisitRepository>()),
  );
  // --- Messagerie (M12) ---
  // Repository, list and thread are shared with the tenant app; the pro side
  // can only answer (RM-M12-01).
  getIt.registerLazySingleton<MessagingRepository>(
    () => MessagingRepository(
      dioClient: getIt<DioClient>(),
      cache: getIt<HiveCache>(),
    ),
  );
  getIt.registerLazySingleton<ConversationsBloc>(
    () => ConversationsBloc(repository: getIt<MessagingRepository>()),
  );
  getIt.registerFactory<ThreadBloc>(
    () => ThreadBloc(repository: getIt<MessagingRepository>()),
  );

  // --- Contracts (M08) ---
  getIt.registerLazySingleton<ContractRepository>(
    () => ContractRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<ContractsBloc>(
    () => ContractsBloc(repository: getIt<ContractRepository>()),
  );
  getIt.registerFactory<ContractDetailBloc>(
    () => ContractDetailBloc(repository: getIt<ContractRepository>()),
  );
  getIt.registerFactory<ContractFormBloc>(
    () => ContractFormBloc(repository: getIt<ContractRepository>()),
  );

  // M29 — the requests on his listings. The home's counter is a singleton
  // (the wrapper provides it, the detail tells it by event); the list and
  // the detail are built per screen.
  getIt.registerLazySingleton<IncomingReservationsRepository>(
    () => IncomingReservationsRepository(dioClient: getIt<DioClient>(), cache: getIt<HiveCache>()),
  );
  getIt.registerLazySingleton<PendingReservationsBloc>(
    () => PendingReservationsBloc(repository: getIt<IncomingReservationsRepository>()),
  );
  getIt.registerFactoryParam<IncomingReservationsBloc, String?, String?>(
    (annonceId, residenceId) => IncomingReservationsBloc(
      repository: getIt<IncomingReservationsRepository>(),
      annonceId: annonceId,
      residenceId: residenceId,
    ),
  );

  // M30 — "Loyers", the landlord's side of "Mon Logement" (no add-on,
  // RM-M30-15). The home's counter is a singleton like the requests'; the
  // lists, a space and a declaration are built per screen.
  getIt.registerLazySingleton<HomesRepository>(
    () => HomesRepository(dioClient: getIt<DioClient>(), cache: getIt<HiveCache>()),
  );
  // M30 lot 3 — tenants' requests: the home's counter is a singleton like
  // the others; the lists and one request are built per screen.
  getIt.registerLazySingleton<HomeRequestsRepository>(
    () => HomeRequestsRepository(dioClient: getIt<DioClient>(), cache: getIt<HiveCache>()),
  );
  getIt.registerLazySingleton<EvidenceRepository>(
    () => EvidenceRepository(dioClient: getIt<DioClient>(), cache: getIt<HiveCache>()),
  );
  getIt.registerFactoryParam<EvidenceBloc, String, void>(
    (contractId, _) => EvidenceBloc(repository: getIt<EvidenceRepository>(), contractId: contractId),
  );
  getIt.registerFactory<EvidenceBatchBloc>(() => EvidenceBatchBloc(repository: getIt<EvidenceRepository>()));
  getIt.registerLazySingleton<OpenRequestsBloc>(
    () => OpenRequestsBloc(repository: getIt<HomeRequestsRepository>()),
  );
  getIt.registerFactoryParam<HomeRequestsBloc, String?, void>(
    (contractId, _) => HomeRequestsBloc(repository: getIt<HomeRequestsRepository>(), contractId: contractId),
  );
  getIt.registerFactory<HomeRequestBloc>(
    () => HomeRequestBloc(repository: getIt<HomeRequestsRepository>(), messaging: getIt<MessagingRepository>()),
  );
  getIt.registerLazySingleton<WaitingDeclarationsBloc>(
    () => WaitingDeclarationsBloc(repository: getIt<HomesRepository>()),
  );
  getIt.registerFactoryParam<RentsBloc, String?, String?>(
    (annonceId, residenceId) =>
        RentsBloc(repository: getIt<HomesRepository>(), annonceId: annonceId, residenceId: residenceId),
  );
  getIt.registerFactory<HomeSpaceBloc>(
    () => HomeSpaceBloc(repository: getIt<HomesRepository>()),
  );
  getIt.registerFactory<DeclarationBloc>(
    () => DeclarationBloc(repository: getIt<HomesRepository>()),
  );
  getIt.registerFactory<IncomingReservationBloc>(
    () => IncomingReservationBloc(
      repository: getIt<IncomingReservationsRepository>(),
      annonces: getIt<AnnonceRepository>(),
    ),
  );

  // M27 — he does not write a resident review; he answers one, once.
  getIt.registerLazySingleton<ResidentReviewRepository>(
    () => ResidentReviewRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<ResidentReplyBloc>(
    () => ResidentReplyBloc(repository: getIt<ResidentReviewRepository>()),
  );

  // M23 — reporting a listing, a message or a review (RM-M27-06). One door,
  // both apps; the reporter never learns the outcome (RM-M23-05).
  getIt.registerLazySingleton<ReportRepository>(
    () => ReportRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<ReportCubit>(
    () => ReportCubit(repository: getIt<ReportRepository>()),
  );

  // M07bis — the client's review, read by whoever carried the visit out.
  getIt.registerLazySingleton<VisitReviewRepository>(
    () => VisitReviewRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerFactory<VisitReviewBloc>(
    () => VisitReviewBloc(repository: getIt<VisitReviewRepository>()),
  );
  getIt.registerFactory<PrestataireVisitsBloc>(
    () => PrestataireVisitsBloc(
      repository: getIt<PrestataireVisitRepository>(),
      location: getIt<LocationCapture>(),
    ),
  );
  // One sheet, two visitors (§14): the agent's visits and the owner's own
  // come from different routes but answer with the same detail.
  getIt.registerFactoryParam<VisitDetailBloc, VisitPersona, void>(
    (persona, _) => VisitDetailBloc(
      repository: switch (persona) {
        VisitPersona.agent => getIt<AgentVisitRepository>(),
        VisitPersona.owner => getIt<PrestataireVisitRepository>(),
      },
      location: getIt<LocationCapture>(),
      persona: persona,
    ),
  );

  // --- Agent (M15) ---
  getIt.registerLazySingleton<AgentRepository>(
    () => AgentRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<AgentAvailabilityRepository>(
    () => AgentAvailabilityRepository(dioClient: getIt<DioClient>()),
  );
  // Session-scoped, like ProProfileBloc — the shell, the profile screen and the
  // zones screen all read one instance.
  getIt.registerLazySingleton<AgentProfileBloc>(
    () => AgentProfileBloc(
      repository: getIt<AgentRepository>(),
      uploader: getIt<MediaUploader>(),
    ),
  );
  // Route-scoped: only the availability screen reads it.
  getIt.registerFactory<AgentAvailabilityBloc>(
    () => AgentAvailabilityBloc(
      repository: getIt<AgentAvailabilityRepository>(),
    ),
  );

  getIt.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<SubscriptionBloc>(
    () => SubscriptionBloc(repository: getIt<SubscriptionRepository>()),
  );
  getIt.registerFactory<SubscribeBloc>(
    () => SubscribeBloc(repository: getIt<SubscriptionRepository>()),
  );

  getIt.registerLazySingleton<KycCubit>(
    () => KycCubit(
      repository: getIt<KycRepository>(),
      uploader: getIt<MediaUploader>(),
    ),
  );
}

/// Drops every bloc scoped to a signed-in session.
///
/// These are get_it **singletons**, so without this they survive a sign-out and
/// the next account inherits them. That is not only a stale-data problem: the
/// previous prestataire's listings, subscription and profile would be sitting
/// in memory for whoever signs in next on the same device.
///
/// It also caused a hang. `ProfileBloc` skips `ProfileLoadInProgress` when it
/// already holds data, and a reload producing an equal `ProfileReady` is
/// dropped as a duplicate — so a second sign-in to the same account emitted
/// **nothing**, and anything waiting on a state change waited forever.
///
/// Call **after** navigating away from the authenticated stack, so the widgets
/// holding these are already gone.
Future<void> resetSessionScopedBlocs() async {
  await getIt.resetLazySingleton<ProProfileBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<HomeBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<AnnoncesBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<ResidencesBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<AgentProfileBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<SubscriptionBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<MyAgentsBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<PendingReservationsBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<WaitingDeclarationsBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<OpenRequestsBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<KycCubit>(
    disposingFunction: (cubit) => cubit.close(),
  );
}
