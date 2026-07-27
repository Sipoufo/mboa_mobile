import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/login_bloc.dart';
import '../login_flow_controller.dart';

/// Phone-number entry — the shared entry point of the SMS OTP flow.
///
/// This is a plain widget (no routing annotations): each app embeds it in its
/// own `@RoutePage` adapter, so routing stays app-specific while the flow's UI
/// and logic are shared. Navigation is delegated via [LoginFlowController].
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => GetIt.I<LoginBloc>(),
      child: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(LoginOtpRequested(_controller.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Scaffold(
      backgroundColor: context.mboaColors.primary,
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (prev, curr) => curr is LoginOtpSent || curr is LoginFailure,
        listener: (context, state) {
          switch (state) {
            case LoginOtpSent(:final session):
              GetIt.I<LoginFlowController>().openOtp(context, session);
            case LoginFailure(:final error):
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(_errorText(l10n, error))));
            default:
              break;
          }
        },
        builder: (context, state) {
          final loading = state is LoginInProgress;
          return Container();
        },
      ),
    );
  }

  String _errorText(I18n l10n, LoginError error) => switch (error) {
        LoginError.otpRequestFailed => l10n.loginOtpSendError,
        LoginError.invalidCode => l10n.otpInvalidCode,
      };
}
