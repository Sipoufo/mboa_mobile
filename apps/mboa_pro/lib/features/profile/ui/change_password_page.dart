import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Route adapter around the shared [ChangePasswordView] (Pro/admin only).
@RoutePage()
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) => const ChangePasswordView();
}
