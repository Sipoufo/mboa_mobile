import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'register_view.dart';

/// App-Mboa-Pro route adapter around the professional [RegisterView].
@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) => RegisterView(
        onLogin: () => context.router.maybePop(),
      );
}
