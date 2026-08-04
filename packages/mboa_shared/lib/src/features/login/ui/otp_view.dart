import 'dart:async';

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
  static const int _codeLength = 6;
  static const int _resendCooldown = 60;

  final _controller = TextEditingController();
  Timer? _timer;
  int _secondsLeft = _resendCooldown;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startCooldown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendCooldown);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  void _submit() {
    final code = _controller.text.trim();
    if (code.length == _codeLength) {
      FocusScope.of(context).unfocus();
      context.read<LoginBloc>().add(
            LoginCodeSubmitted(session: widget.session, code: code),
          );
    }
  }

  void _resend() {
    _controller.clear();
    context.read<LoginBloc>().add(LoginOtpResendRequested(widget.session.phoneNumber));
    _startCooldown();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) =>
          curr is LoginSuccess || curr is LoginFailure || curr is LoginOtpResent,
      listener: (context, state) {
        switch (state) {
          case LoginSuccess():
            GetIt.I<LoginFlowController>().onLoginSuccess(context);
          case LoginOtpResent():
            MboaToast.info(context: context, title: l10n.authOtpResent);
          case LoginFailure(:final error):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: error == LoginError.invalidCode ? l10n.otpInvalidCode : l10n.commonError,
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final loading = state is LoginInProgress;
        return StackedLoaderView(
          isLoading: loading,
          child: AuthScaffold(
            onBack: () => Navigator.of(context).maybePop(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  l10n.otpTitle,
                  textAlign: TextAlign.center,
                  style: context.mboaText.h1.copyWith(color: context.mboaColors.primary),
                ),
                const SizedBox(height: Dimens.spacingSm),
                Text(
                  l10n.otpCodeSentTo(widget.session.phoneNumber),
                  textAlign: TextAlign.center,
                  style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
                ),
                const SizedBox(height: Dimens.spacingXl),
                OtpField(
                  controller: _controller,
                  length: _codeLength,
                  enabled: !loading,
                  onCompleted: (_) => _submit(),
                ),
                const SizedBox(height: Dimens.spacingLg),
                Button.primary(
                  title: l10n.otpValidate,
                  isLoading: loading,
                  onPressed: loading ? null : _submit,
                ),
                const SizedBox(height: Dimens.spacingLg),
                _ResendRow(
                  secondsLeft: _secondsLeft,
                  onResend: _resend,
                  l10n: l10n,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// "Didn't get the code?" with a resend action gated by a countdown.
class _ResendRow extends StatelessWidget {
  const _ResendRow({
    required this.secondsLeft,
    required this.onResend,
    required this.l10n,
  });

  final int secondsLeft;
  final VoidCallback onResend;
  final I18n l10n;

  @override
  Widget build(BuildContext context) {
    final canResend = secondsLeft == 0;
    return Column(
      children: [
        Text(
          l10n.otpNoCodeQuestion,
          textAlign: TextAlign.center,
          style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingXs),
        TextButton(
          onPressed: canResend ? onResend : null,
          child: Text(
            canResend ? l10n.otpResend : l10n.otpResendIn(secondsLeft),
            style: context.mboaText.label.copyWith(
              color: canResend ? context.mboaColors.primary : context.mboaColors.textTertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
