import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../features/auth/bloc/auth_bloc.dart';
import 'router/app_router.gr.dart';

/// App-Mboa binding for the shared login flow: maps the flow's navigation onto
/// this app's auto_route table and promotes the session on the global
/// [AuthBloc] once login succeeds.
class MboaUserLoginFlowController implements LoginFlowController {
  const MboaUserLoginFlowController();

  @override
  void openOtp(BuildContext context, OtpSession session) {
    context.router.push(OtpRoute(session: session));
  }

  @override
  void onLoginSuccess(BuildContext context) {
    // The root AuthBloc listener replaces the stack with HomeRoute.
    context.read<AuthBloc>().add(const AuthSessionEstablished());
  }
}
