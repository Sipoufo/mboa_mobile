import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/di/app_module.dart';
import 'app/mboa_user_app.dart';
import 'features/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Offline cache boxes (Hive) — must be ready before any repository reads.
  // Push (M03). Best-effort: a missing or misconfigured Firebase setup must not
  // stop the app booting — notifications simply stay off.
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  } catch (_) {}

  await HiveCache.init();

  // Wire the service locator: core singletons first, then app dependencies.
  await registerCoreModule(
    onSessionExpired: () async {
      // Interceptor could not refresh the token — force a clean logout so the
      // root listener routes back to the login screen.
      getIt<AuthBloc>().add(const AuthLogoutRequested());
    },
  );
  registerAppModule();

  // Apply the persisted language before the first frame.
  await getIt<LocaleController>().load();

  Bloc.observer = SentryBlocObserver();

  final dsn = Environment.sentryDsn;
  if (dsn.isEmpty) {
    runApp(const MboaUserApp());
  } else {
    await SentryFlutter.init(
      (options) => options
        ..dsn = dsn
        ..environment = Environment.current.name,
      appRunner: () => runApp(const MboaUserApp()),
    );
  }
}
