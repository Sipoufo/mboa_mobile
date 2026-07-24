import 'package:get_it/get_it.dart';

import '../api/dio_client.dart';
import '../network/network_monitor.dart';
import '../storage/hive_cache.dart';
import '../storage/secure_token_storage.dart';

/// The shared service locator. Each app calls [registerCoreModule] during
/// startup, then registers its own feature repositories/blocs on top.
final GetIt getIt = GetIt.instance;

/// Registers cross-cutting singletons every Mboa app needs.
///
/// [onSessionExpired] is the app-level hook the [AuthInterceptor] fires on a
/// failed refresh — typically it dispatches a logout event on the global
/// AuthBloc and routes back to the login screen.
Future<void> registerCoreModule({
  required Future<void> Function() onSessionExpired,
}) async {
  if (!getIt.isRegistered<SecureTokenStorage>()) {
    getIt.registerLazySingleton<SecureTokenStorage>(() => SecureTokenStorage());
  }
  if (!getIt.isRegistered<HiveCache>()) {
    getIt.registerLazySingleton<HiveCache>(() => HiveCache());
  }
  if (!getIt.isRegistered<NetworkMonitor>()) {
    getIt.registerLazySingleton<NetworkMonitor>(() => NetworkMonitor());
  }
  if (!getIt.isRegistered<DioClient>()) {
    getIt.registerLazySingleton<DioClient>(
      () => DioClient(
        storage: getIt<SecureTokenStorage>(),
        onSessionExpired: onSessionExpired,
      ),
    );
  }
}
