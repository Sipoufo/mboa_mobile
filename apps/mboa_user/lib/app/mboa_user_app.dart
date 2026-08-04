import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../features/auth/bloc/auth_bloc.dart';
import 'router/app_router.dart';
import 'router/app_router.gr.dart';

/// App Mboa (public) root. Owns the router and the global [AuthBloc], and maps
/// session state changes onto stack replacements (login ⇄ home).
class MboaUserApp extends StatefulWidget {
  const MboaUserApp({super.key});

  @override
  State<MboaUserApp> createState() => _MboaUserAppState();
}

class _MboaUserAppState extends State<MboaUserApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Startup routing is owned by the splash feature (SplashCubit). AuthBloc
    // here handles only *runtime* session changes: login-success → Home, and
    // forced logout / refresh-failure → Login.
    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            curr is AuthAuthenticated || curr is AuthUnauthenticated,
        listener: (context, state) {
          // Keep the snapshot the route guards read in step with the bloc,
          // then drive the transition. The guards cover deep links and back
          // navigation; this covers login/logout while the app is running.
          switch (state) {
            case AuthAuthenticated():
              getIt<SessionSnapshot>().markAuthenticated();
              getIt<SessionExpiryWatcher>().start();
              _router.replaceAll([const AuthenticatedRouter()]);
            case AuthUnauthenticated():
              getIt<SessionSnapshot>().markUnauthenticated();
              getIt<SessionExpiryWatcher>().stop();
              _router.replaceAll([const WelcomeRoute()]);
            default:
              break;
          }
        },
        child: ValueListenableBuilder<Locale?>(
          valueListenable: getIt<LocaleController>(),
          builder: (context, locale, _) => MaterialApp.router(
            onGenerateTitle: (context) => I18n.of(context).appName,
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
