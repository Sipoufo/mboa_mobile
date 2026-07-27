import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_user/app/router/app_router.gr.dart';

/// App-Mboa route adapter around the shared [WelcomeView]. The flow's UI and
/// logic live in `mboa_shared`; only the routing binding is app-specific.
@RoutePage()
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) => WelcomeView(
    toLogin: () => context.router.push(const LoginRoute()),
    toRegistration: () => context.router.push(const LoginRoute()),
  );
}
