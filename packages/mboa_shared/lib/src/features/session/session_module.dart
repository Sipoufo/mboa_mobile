import 'package:get_it/get_it.dart';
import 'package:mboa_core/mboa_core.dart';

import 'data/session_repository.dart';

/// Registers the shared [SessionRepository]. Call from each app's DI setup after
/// `registerCoreModule` (it needs `DioClient`, `SecureTokenStorage` and
/// `NetworkMonitor`).
void registerSessionModule(GetIt getIt) {
  if (!getIt.isRegistered<SessionRepository>()) {
    getIt.registerLazySingleton<SessionRepository>(
      () => SessionRepository(
        dioClient: getIt<DioClient>(),
        tokenStorage: getIt<SecureTokenStorage>(),
        networkMonitor: getIt<NetworkMonitor>(),
      ),
    );
  }
}
