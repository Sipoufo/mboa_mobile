import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/agent/bloc/agent_availability_bloc.dart';
import '../../features/assignments/bloc/agent_detail_bloc.dart';
import '../../features/assignments/bloc/agent_missions_bloc.dart';
import '../../features/assignments/bloc/my_agents_bloc.dart';
import '../../features/assignments/bloc/property_agent_bloc.dart';
import '../../features/assignments/data/agent_mission_repository.dart';
import '../../features/assignments/data/assignment_repository.dart';
import '../../features/annonces/data/location_capture.dart';
import '../../features/visits/bloc/prestataire_visits_bloc.dart';
import '../../features/visits/bloc/visits_agenda_blocs.dart';
import '../../features/visits/data/prestataire_visit_repository.dart';
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
import '../../features/register/data/register_repository.dart';
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
  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(repository: getIt<AccountRepository>()),
  );
  getIt.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepository(dioClient: getIt<DioClient>()),
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
  getIt.registerFactory<PrestataireVisitsBloc>(
    () => PrestataireVisitsBloc(
      repository: getIt<PrestataireVisitRepository>(),
      location: getIt<LocationCapture>(),
    ),
  );
  getIt.registerFactory<VisitDetailBloc>(
    () => VisitDetailBloc(
      repository: getIt<AgentVisitRepository>(),
      location: getIt<LocationCapture>(),
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
  await getIt.resetLazySingleton<KycCubit>(
    disposingFunction: (cubit) => cubit.close(),
  );
}
