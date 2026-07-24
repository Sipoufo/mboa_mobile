import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// App-Mboa route adapter around the shared [LoginView]. The flow's UI and
/// logic live in `mboa_shared`; only the routing binding is app-specific.
@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginView();
}
