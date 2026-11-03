import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Route adapter around the shared [ChangeEmailView] (§40 A, App Mboa only:
/// a Pro account's email is its password login).
@RoutePage()
class ChangeEmailPage extends StatelessWidget {
  const ChangeEmailPage({super.key, this.currentEmail, this.phoneNumber});

  final String? currentEmail;
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) => ChangeEmailView(currentEmail: currentEmail, phoneNumber: phoneNumber);
}
