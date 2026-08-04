import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/router/app_router.gr.dart';
import 'login_view.dart';

/// App-Mboa-Pro route adapter around the credential [LoginView].
@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => LoginView(
        onRegister: () => context.router.push(const RegisterRoute()),
      );
}
