import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mboa_core/mboa_core.dart';

import 'app/mboa_pro_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveCache.init();
  await registerCoreModule(
    // Pro auth flow lands in a later module; for the skeleton a logout hook is
    // a no-op placeholder.
    onSessionExpired: () async {},
  );

  Bloc.observer = SentryBlocObserver();

  runApp(const MboaProApp());
}
