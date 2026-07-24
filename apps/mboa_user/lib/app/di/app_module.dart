import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../login_flow_controller_impl.dart';

/// Registers App-Mboa-specific dependencies on top of the shared core module.
///
/// Order matters: [registerCoreModule] must have run first so [DioClient] and
/// [SecureTokenStorage] are available here.
void registerAppModule() {
  // Session gate.
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(tokenStorage: getIt<SecureTokenStorage>()),
  );
  // The global AuthBloc is a singleton — the one BLoC shared app-wide.
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(repository: getIt<AuthRepository>()),
  );

  // Shared login feature + this app's binding for its navigation/session.
  registerLoginModule(getIt);
  getIt.registerLazySingleton<LoginFlowController>(
    () => const MboaUserLoginFlowController(),
  );
}
