import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../features/auth/bloc/auth_bloc.dart';
import 'notifications_bootstrap.dart';
import 'router/app_router.dart';
import 'router/app_router.gr.dart';

/// App Mboa Pro root. Owns the router and the global [AuthBloc]; startup routing
/// is handled by the splash feature, runtime session changes by [AuthBloc].
class MboaProApp extends StatefulWidget {
  const MboaProApp({super.key});

  @override
  State<MboaProApp> createState() => _MboaProAppState();
}

class _MboaProAppState extends State<MboaProApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            curr is AuthAuthenticated || curr is AuthUnauthenticated,
        listener: (context, state) {
          // Keep the snapshot the route guards read in step with the bloc, then
          // drive the transition. The guards cover deep links and back
          // navigation; this covers login/logout while the app is running.
          switch (state) {
            case AuthAuthenticated():
              getIt<SessionSnapshot>().markAuthenticated();
              getIt<SessionExpiryWatcher>().start();
              // Register for push now that the session exists — the endpoint is
              // authenticated. Logout revokes it via AuthRepository.
              startNotifications(router: _router, context: () => context);
              _router.replaceAll([const AuthenticatedRouter()]);
            case AuthUnauthenticated():
              getIt<SessionSnapshot>().markUnauthenticated();
              getIt<SessionExpiryWatcher>().stop();
              _router.replaceAll([const LoginRoute()]);
            default:
              break;
          }
        },
        child: ValueListenableBuilder<Locale?>(
          valueListenable: getIt<LocaleController>(),
          builder: (context, locale, _) => MaterialApp.router(
            onGenerateTitle: (context) => I18n.of(context).appNamePro,
            debugShowCheckedModeBanner: false,
            theme: MboaTheme.light(),
            darkTheme: MboaTheme.dark(),
            locale: locale,
            localizationsDelegates: MboaLocalizations.delegates,
            supportedLocales: MboaLocalizations.supportedLocales,
            routerConfig: _router.config(),
          ),
        ),
      ),
    );
  }
}
