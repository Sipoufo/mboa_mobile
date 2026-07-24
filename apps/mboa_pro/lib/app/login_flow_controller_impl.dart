import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../features/auth/bloc/auth_bloc.dart';
import 'router/app_router.gr.dart';

/// App-Mboa-Pro binding for the shared login flow.
class MboaProLoginFlowController implements LoginFlowController {
  const MboaProLoginFlowController();

  @override
  void openOtp(BuildContext context, OtpSession session) {
    context.router.push(OtpRoute(session: session));
  }

  @override
  void onLoginSuccess(BuildContext context) {
    context.read<AuthBloc>().add(const AuthSessionEstablished());
  }
}
