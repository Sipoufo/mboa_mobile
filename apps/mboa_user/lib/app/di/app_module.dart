import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/profile/profile_types.dart';
import '../../features/splash/logic/splash_cubit.dart';
import '../login_flow_controller_impl.dart';

/// Registers App-Mboa-specific dependencies on top of the shared core module.
///
/// Order matters: [registerCoreModule] must have run first so [DioClient] and
/// [SecureTokenStorage] are available here.
void registerAppModule() {
  // Session gate.
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      dioClient: getIt<DioClient>(),
      tokenStorage: getIt<SecureTokenStorage>(),
    ),
  );
  // The global AuthBloc is a singleton — the one BLoC shared app-wide.
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(repository: getIt<AuthRepository>()),
  );

  // Shared session check + startup splash controller.
  registerSessionModule(getIt);
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(sessionRepository: getIt<SessionRepository>()),
  );

  // Shared login feature + this app's binding for its navigation/session.
  registerLoginModule(getIt);
  getIt.registerLazySingleton<LoginFlowController>(
    () => const MboaUserLoginFlowController(),
  );

  // Profile / Settings (M02) — shared base profile. Singleton so the hub and
  // edit screen share it. The MediaUploader enables profile-photo capture.
  getIt.registerLazySingleton<BaseProfileRepository>(
    () => BaseProfileRepository(dioClient: getIt<DioClient>()),
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
  getIt.registerLazySingleton<AppSettingsRepository>(
    () => AppSettingsRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<LocaleController>(
    () => LocaleController(
      cache: getIt<HiveCache>(),
      settings: getIt<AppSettingsRepository>(),
    ),
  );

  getIt.registerLazySingleton<UserProfileBloc>(
    () => UserProfileBloc(
      repository: getIt<BaseProfileRepository>(),
      uploader: getIt<MediaUploader>(),
    ),
  );
}
