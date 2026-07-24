import 'package:get_it/get_it.dart';
import 'package:mboa_core/mboa_core.dart';

import 'bloc/login_bloc.dart';
import 'data/login_repository.dart';

/// Registers the shared login feature's dependencies. Call from each app's DI
/// setup after `registerCoreModule`. The app additionally registers its own
/// [LoginFlowController] implementation.
void registerLoginModule(GetIt getIt) {
  if (!getIt.isRegistered<LoginRepository>()) {
    getIt.registerLazySingleton<LoginRepository>(
      () => LoginRepository(
        dioClient: getIt<DioClient>(),
        tokenStorage: getIt<SecureTokenStorage>(),
      ),
    );
  }
  // A fresh bloc per screen (factory), so each step of the flow owns its state.
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(repository: getIt<LoginRepository>()),
  );
}
