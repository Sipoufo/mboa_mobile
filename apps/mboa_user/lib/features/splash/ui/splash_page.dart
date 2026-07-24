import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// Initial route for App Mboa. Shows the shared splash while the global
/// [AuthBloc] resolves the session (`AuthStarted`); the root listener in
/// `MboaUserApp` then replaces the stack with Home or Login.
@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => const MboaSplashView();
}
