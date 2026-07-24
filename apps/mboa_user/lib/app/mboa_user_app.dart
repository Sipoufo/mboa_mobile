import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
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
    return BlocProvider<AuthBloc>(
      create: (_) => getIt<AuthBloc>()..add(const AuthStarted()),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prev, curr) =>
            curr is AuthAuthenticated || curr is AuthUnauthenticated,
        listener: (context, state) {
          switch (state) {
            case AuthAuthenticated():
              _router.replaceAll([const HomeRoute()]);
            case AuthUnauthenticated():
              _router.replaceAll([const LoginRoute()]);
            default:
              break;
          }
        },
        child: MaterialApp.router(
          title: 'Mboa',
          debugShowCheckedModeBanner: false,
          theme: MboaTheme.light(MboaColors.userSeed),
          darkTheme: MboaTheme.dark(MboaColors.userSeed),
          routerConfig: _router.config(),
        ),
      ),
    );
  }
}
