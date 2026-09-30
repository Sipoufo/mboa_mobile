import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../features/auth/bloc/auth_bloc.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/profile/profile_types.dart';
import '../../features/favorites/bloc/favorites_bloc.dart';
import '../../features/favorites/data/favorites_repository.dart';
import '../../features/listing/bloc/listing_detail_bloc.dart';
import '../../features/listing/data/listing_repository.dart';
import '../../features/search/bloc/search_bloc.dart';
import '../../features/search/data/search_repository.dart';
import '../../features/splash/logic/splash_cubit.dart';
import '../login_flow_controller_impl.dart';

/// Registers App-Mboa-specific dependencies on top of the shared core module.
///
/// Order matters: [registerCoreModule] must have run first so [DioClient] and
/// [SecureTokenStorage] are available here.
void registerAppModule() {
  // Routing — the snapshot the guards read, and the feature-access policy.
  getIt.registerLazySingleton<SessionSnapshot>(SessionSnapshot.new);
  getIt.registerLazySingleton<AccessPolicy>(AccessPolicy.new);

  // Session gate.
  // Push notifications (M03). Registered before AuthRepository because logout
  // has to revoke the device *before* the tokens are cleared.
  getIt.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(dioClient: getIt<DioClient>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      dioClient: getIt<DioClient>(),
      tokenStorage: getIt<SecureTokenStorage>(),
      notifications: getIt<NotificationsRepository>(),
    ),
  );
  // The global AuthBloc is a singleton — the one BLoC shared app-wide.
  getIt.registerLazySingleton<AuthBloc>(
    () => AuthBloc(repository: getIt<AuthRepository>()),
  );

  // Search (M04) — public: no session required.
  getIt.registerLazySingleton<SearchRepository>(
    () => SearchRepository(
      dioClient: getIt<DioClient>(),
      cache: getIt<HiveCache>(),
    ),
  );
  getIt.registerFactory<SearchBloc>(
    () => SearchBloc(repository: getIt<SearchRepository>()),
  );

  // Fiche bien (M05) — public, like the search.
  getIt.registerLazySingleton<ListingRepository>(
    () => ListingRepository(
      dioClient: getIt<DioClient>(),
      cache: getIt<HiveCache>(),
    ),
  );
  getIt.registerFactory<ListingDetailBloc>(
    () => ListingDetailBloc(repository: getIt<ListingRepository>()),
  );

  // Favoris (M06) — session-scoped and read from three screens, so a single
  // instance: two hearts on the same listing must not disagree.
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepository(dioClient: getIt<DioClient>()),
  );
  getIt.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(repository: getIt<FavoritesRepository>()),
  );

  // Messagerie (M12) — repository, list and thread are shared with the pro
  // app; only the entry points differ (RM-M12-01).
  getIt.registerLazySingleton<MessagingRepository>(
    () => MessagingRepository(
      dioClient: getIt<DioClient>(),
      cache: getIt<HiveCache>(),
    ),
  );
  getIt.registerLazySingleton<ConversationsBloc>(
    () => ConversationsBloc(repository: getIt<MessagingRepository>()),
  );
  getIt.registerFactory<ThreadBloc>(
    () => ThreadBloc(repository: getIt<MessagingRepository>()),
  );
  // `MediaUploader` (message attachments) and `LocationRepository` (the city
  // picker the search bar opens) are registered once, with the profile module
  // below — they were here too, and get_it throws on the second registration.

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

/// Drops the blocs that belong to a signed-in account.
///
/// Favourites and conversations are lazy singletons so every heart and every
/// unread badge reads one instance; that also means they survive a sign-out
/// unless they are dropped here. Called **after** navigating away, so the
/// widgets holding them are already gone.
Future<void> resetSessionScopedBlocs() async {
  await getIt.resetLazySingleton<FavoritesBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
  await getIt.resetLazySingleton<ConversationsBloc>(
    disposingFunction: (bloc) => bloc.close(),
  );
}
