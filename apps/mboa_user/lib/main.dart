import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app/di/app_module.dart';
import 'app/mboa_user_app.dart';
import 'features/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Offline cache boxes (Hive) — must be ready before any repository reads.
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
