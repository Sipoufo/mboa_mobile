import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

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
