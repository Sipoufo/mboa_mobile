import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../bloc/credential_login_bloc.dart';

/// App Mboa Pro login — email + password, then an email OTP. A single screen
/// with two steps driven by [CredentialLoginBloc]'s state.
class LoginView extends StatelessWidget {
  const LoginView({super.key, this.onRegister});

  /// Navigate to the registration screen (footer link).
  final VoidCallback? onRegister;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CredentialLoginBloc>(
      create: (_) => getIt<CredentialLoginBloc>(),
      child: _LoginFlow(onRegister: onRegister),
    );
  }
}

class _LoginFlow extends StatelessWidget {
  const _LoginFlow({this.onRegister});

  final VoidCallback? onRegister;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<CredentialLoginBloc, CredentialLoginState>(
      listener: (context, state) {
        switch (state) {
          case CredentialLoginSuccess():
            context.read<AuthBloc>().add(const AuthSessionEstablished());
          case CredentialLoginEnterCredentials(error: final error?):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: _errorText(l10n, error),
            );
          case CredentialLoginEnterOtp(error: final error?):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: _errorText(l10n, error),
            );
          case CredentialLoginEnterOtp(justResent: true):
            MboaToast.info(context: context, title: l10n.authOtpResent);
          default:
            break;
        }
      },
      builder: (context, state) {
        final (loading, showOtp) = switch (state) {
          CredentialLoginEnterCredentials(:final loading) => (loading, false),
          CredentialLoginEnterOtp(:final loading) => (loading, true),
          CredentialLoginSuccess() => (false, true),
        };

        return StackedLoaderView(
          isLoading: loading,
          child: AuthScaffold(
            onBack: showOtp
                ? () => context.read<CredentialLoginBloc>().add(const CredentialLoginBackToCredentials())
                : null,
            child: switch (state) {
              CredentialLoginEnterOtp(:final email) => _OtpStep(email: email, loading: loading),
              _ => _CredentialsStep(loading: loading, onRegister: onRegister),
            },
          ),
        );
      },
    );
  }

  String _errorText(I18n l10n, CredentialLoginError error) => switch (error) {
        CredentialLoginError.invalidCredentials => l10n.authLoginInvalidCredentials,
        CredentialLoginError.invalidCode => l10n.otpInvalidCode,
        CredentialLoginError.otpResendFailed => l10n.commonError,
      };
}

class _CredentialsStep extends StatefulWidget {
  const _CredentialsStep({required this.loading, this.onRegister});

  final bool loading;
  final VoidCallback? onRegister;

  @override
  State<_CredentialsStep> createState() => _CredentialsStepState();
}

class _CredentialsStepState extends State<_CredentialsStep> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CredentialLoginBloc>().add(
            CredentialLoginSubmitted(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.spacingSm),
          Text(
            l10n.loginTitle,
            textAlign: TextAlign.center,
            style: context.mboaText.h1.copyWith(color: context.mboaColors.primary),
          ),
          const SizedBox(height: Dimens.spacingXl),
          Input(
            controller: _emailController,
            enabled: !widget.loading,
            labelText: l10n.authEmailLabel,
            hintText: l10n.authEmailHint,
            variant: InputVariant.underline,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.none,
            autofillHints: const [AutofillHints.email],
            validator: (value) =>
                _emailPattern.hasMatch(value?.trim() ?? '') ? null : l10n.authEmailInvalid,
          ),
          const SizedBox(height: Dimens.spacingLg),
          PasswordField(
            controller: _passwordController,
            enabled: !widget.loading,
            labelText: l10n.authPasswordLabel,
            hintText: l10n.authPasswordHint,
            onSubmitted: (_) => _submit(),
            validator: (value) =>
                (value == null || value.isEmpty) ? l10n.authPasswordRequired : null,
          ),
          const SizedBox(height: Dimens.spacingXl),
          Button.primary(
            title: l10n.authLoginButton,
            isLoading: widget.loading,
            onPressed: widget.loading ? null : _submit,
          ),
          const SizedBox(height: Dimens.spacingLg),
          _RegisterLink(onRegister: widget.onRegister, l10n: l10n),
        ],
      ),
    );
  }
}

class _RegisterLink extends StatelessWidget {
  const _RegisterLink({required this.onRegister, required this.l10n});

  final VoidCallback? onRegister;
  final I18n l10n;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onRegister,
      behavior: HitTestBehavior.opaque,
      child: Text.rich(
        TextSpan(
          text: '${l10n.loginNoAccountQuestion} ',
          style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
          children: [
            TextSpan(
              text: l10n.loginSignUpAction,
              style: context.mboaText.label.copyWith(
                color: context.mboaColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _OtpStep extends StatefulWidget {
  const _OtpStep({required this.email, required this.loading});

  final String email;
  final bool loading;

  @override
  State<_OtpStep> createState() => _OtpStepState();
}

class _OtpStepState extends State<_OtpStep> {
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
      context.read<CredentialLoginBloc>().add(CredentialLoginOtpSubmitted(code));
    }
  }

  void _resend() {
    _controller.clear();
    context.read<CredentialLoginBloc>().add(const CredentialLoginOtpResent());
    _startCooldown();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final canResend = _secondsLeft == 0 && !widget.loading;

    return Column(
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
          l10n.otpCodeSentTo(widget.email),
          textAlign: TextAlign.center,
          style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingXl),
        OtpField(
          controller: _controller,
          length: _codeLength,
          enabled: !widget.loading,
          onCompleted: (_) => _submit(),
        ),
        const SizedBox(height: Dimens.spacingLg),
        Button.primary(
          title: l10n.otpValidate,
          isLoading: widget.loading,
          onPressed: widget.loading ? null : _submit,
        ),
        const SizedBox(height: Dimens.spacingLg),
        Text(
          l10n.otpNoCodeQuestion,
          textAlign: TextAlign.center,
          style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
        ),
        TextButton(
          onPressed: canResend ? _resend : null,
          child: Text(
            canResend ? l10n.otpResend : l10n.otpResendIn(_secondsLeft),
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
