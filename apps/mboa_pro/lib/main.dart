import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'app/di/app_module.dart';
import 'app/mboa_pro_app.dart';
import 'features/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
