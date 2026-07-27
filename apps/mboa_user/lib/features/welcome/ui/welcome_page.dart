import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

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
  Widget build(BuildContext context) => const WelcomeView();
}
