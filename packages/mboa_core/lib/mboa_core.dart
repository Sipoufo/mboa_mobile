/// Shared core for the Mboa apps.
///
/// Re-exports the public surface: env constants, secure token storage, Hive
/// cache, the Dio client + auth interceptor, DI locator, and observability.
library;

// Constants
export  'src/constants/environment.dart';
export 'src/constants/storage_keys.dart';

// Models
export 'src/models/auth_tokens.dart';

// Storage
export 'src/storage/secure_token_storage.dart';
export 'src/storage/hive_cache.dart';

// Network
export 'src/network/network_monitor.dart';

// API
export 'src/api/dio_client.dart';
export 'src/api/interceptors/auth_interceptor.dart';
export 'src/api/session_expiry_watcher.dart';

// DI
export 'src/di/core_module.dart';

// Observability
export 'src/observability/sentry_bloc_observer.dart';

// Re-export the generated client so apps import a single package.
// The backend spec now ships its own `AuthTokens` DTO; we hide it so the public
// `AuthTokens` stays our domain model. Repositories map the DTO → domain type.
export 'package:api_client/api_client.dart' hide AuthTokens;
