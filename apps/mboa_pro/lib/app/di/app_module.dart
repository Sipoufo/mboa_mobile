import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/splash/logic/splash_cubit.dart';
import '../login_flow_controller_impl.dart';

/// Registers App-Mboa-Pro dependencies on top of the shared core module.
void registerAppModule() {
  // Session gate.
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(tokenStorage: getIt<SecureTokenStorage>()),
  );
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(repository: getIt<AuthRepository>()),
  );

  // Shared session check + startup splash controller.
  registerSessionModule(getIt);
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(sessionRepository: getIt<SessionRepository>()),
  );

  // Shared login feature + this app's navigation/session binding.
  registerLoginModule(getIt);
  getIt.registerLazySingleton<LoginFlowController>(
    () => const MboaProLoginFlowController(),
  );
}
