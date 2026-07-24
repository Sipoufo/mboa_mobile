import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// App-Mboa-Pro route adapter around the shared [LoginView].
@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginView();
}
