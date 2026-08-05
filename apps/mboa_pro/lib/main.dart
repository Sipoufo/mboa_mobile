import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'app/di/app_module.dart';
import 'app/mboa_pro_app.dart';
import 'features/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Push (M03). Best-effort: a missing or misconfigured Firebase setup must not
  // stop the app booting — notifications simply stay off.
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  } catch (_) {}

  await HiveCache.init();
  await registerCoreModule(
    onSessionExpired: () async {
      // Interceptor could not refresh — force a clean logout so the root
      // listener routes back to login.
      getIt<AuthBloc>().add(const AuthLogoutRequested());
    },
  );
  registerAppModule();

  // Apply the persisted language before the first frame.
  await getIt<LocaleController>().load();

  Bloc.observer = SentryBlocObserver();

  runApp(const MboaProApp());
}
