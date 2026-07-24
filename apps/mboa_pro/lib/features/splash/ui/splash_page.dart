import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// Initial route for App Mboa Pro. Shows the shared splash briefly, then routes
/// to Home. When Pro's auth is wired, replace this with a session check like
/// App Mboa's splash.
@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const _minDisplay = Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(_minDisplay);
    if (!mounted) return;
    await context.router.replaceAll([const HomeRoute()]);
  }

  @override
  Widget build(BuildContext context) => const MboaSplashView();
}
