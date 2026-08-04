import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/login/bloc/credential_login_bloc.dart';
import '../../features/login/data/credential_auth_repository.dart';
import '../../features/kyc/data/kyc_repository.dart';
import '../../features/kyc/logic/kyc_cubit.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../features/profile/profile_types.dart';
import '../../features/register/bloc/register_bloc.dart';
import '../../features/register/data/register_repository.dart';
import '../../features/splash/logic/splash_cubit.dart';

/// Registers App-Mboa-Pro dependencies on top of the shared core module.
void registerAppModule() {
  // Routing — the snapshot the guards read, and the feature-access policy.
  getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
  getIt.registerLazySingleton<AccessPolicy>(AccessPolicy.new);

  // Session gate.
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      dioClient: getIt<DioClient>(),
      tokenStorage: getIt<SecureTokenStorage>(),
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
  getIt.registerLazySingleton<KycCubit>(
    () => KycCubit(
      repository: getIt<KycRepository>(),
      uploader: getIt<MediaUploader>(),
    ),
  );
}
