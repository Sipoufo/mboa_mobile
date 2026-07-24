import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/login_bloc.dart';
import '../login_flow_controller.dart';
import '../models/otp_session.dart';

/// OTP code entry for a pending [session]. Plain widget embedded by each app's
/// `@RoutePage` adapter (see [LoginView]).
class OtpView extends StatelessWidget {
  const OtpView({required this.session, super.key});

  final OtpSession session;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => GetIt.I<LoginBloc>(),
      child: _OtpForm(session: session),
    );
  }
}

class _OtpForm extends StatefulWidget {
  const _OtpForm({required this.session});

  final OtpSession session;

  @override
  State<_OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<_OtpForm> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final code = _controller.text.trim();
    if (code.length >= 4) {
      context
          .read<LoginBloc>()
          .add(LoginCodeSubmitted(session: widget.session, code: code));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.otpTitle)),
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (prev, curr) => curr is LoginSuccess || curr is LoginFailure,
        listener: (context, state) {
          switch (state) {
            case LoginSuccess():
              GetIt.I<LoginFlowController>().onLoginSuccess(context);
            case LoginFailure(:final error):
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      error == LoginError.invalidCode
                          ? l10n.otpInvalidCode
                          : l10n.commonError,
                    ),
                  ),
                );
            default:
              break;
          }
        },
        builder: (context, state) {
          final loading = state is LoginInProgress;
          return Padding(
            padding: const EdgeInsets.all(Dimens.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Dimens.md),
                Text(
                  l10n.otpCodeSentTo(widget.session.phoneNumber),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: Dimens.md),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  enabled: !loading,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  decoration: InputDecoration(labelText: l10n.otpCodeLabel),
                ),
                const SizedBox(height: Dimens.sm),
                PrimaryButton(
                  label: l10n.otpValidate,
                  isLoading: loading,
                  onPressed: _submit,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
