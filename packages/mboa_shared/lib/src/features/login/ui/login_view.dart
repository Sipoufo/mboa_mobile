import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/login_bloc.dart';
import '../login_flow_controller.dart';

/// Whether the entry screen presents itself as sign-in or sign-up. The
/// mechanics are identical (phone + SMS OTP); only the copy differs.
enum AuthMode { login, register }

/// Phone-number entry — the shared entry point of the SMS OTP flow.
///
/// This is a plain widget (no routing annotations): each app embeds it in its
/// own `@RoutePage` adapter, so routing stays app-specific while the flow's UI
/// and logic are shared. Navigation is delegated via [LoginFlowController].
class LoginView extends StatelessWidget {
  const LoginView({super.key, this.mode = AuthMode.login});

  final AuthMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => GetIt.I<LoginBloc>(),
      child: _LoginForm(mode: mode),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({required this.mode});

  final AuthMode mode;

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthMode _mode = widget.mode;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      final phoneNumber = '${PhoneField.defaultDialCode}${_controller.text.trim()}';
      context.read<LoginBloc>().add(LoginOtpRequested(phoneNumber));
    }
  }

  void _toggleMode() {
    setState(() {
      _mode = _mode == AuthMode.login ? AuthMode.register : AuthMode.login;
    });
  }

  String? _validatePhone(I18n l10n, String? value) {
    final digits = value?.trim() ?? '';
    if (digits.length != PhoneField.nationalDigits) return l10n.loginPhoneInvalid;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) => curr is LoginOtpSent || curr is LoginFailure,
      listener: (context, state) {
        switch (state) {
          case LoginOtpSent(:final session):
            GetIt.I<LoginFlowController>().openOtp(context, session);
          case LoginFailure(:final error):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: _errorText(l10n, error),
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: Dimens.spacingSm),
                  Text(
                    _mode == AuthMode.login ? l10n.loginTitle : l10n.registerTitle,
                    textAlign: TextAlign.center,
                    style: context.mboaText.h1.copyWith(color: context.mboaColors.primary),
                  ),
                  const SizedBox(height: Dimens.spacingXl),
                  PhoneField(
                    controller: _controller,
                    enabled: !loading,
                    labelText: l10n.loginPhoneLabel,
                    hintText: l10n.loginPhoneHintLocal,
                    onSubmitted: (_) => _submit(),
                    validator: (value) => _validatePhone(l10n, value),
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                  Button.primary(
                    title: l10n.loginRequestCode,
                    isLoading: loading,
                    onPressed: loading ? null : _submit,
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                  OrDivider(label: l10n.commonOr),
                  const SizedBox(height: Dimens.spacingLg),
                  _SocialRow(l10n: l10n),
                  const SizedBox(height: Dimens.spacingLg),
                  _ModeSwitch(mode: _mode, onTap: _toggleMode, l10n: l10n),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _errorText(I18n l10n, LoginError error) => switch (error) {
        LoginError.otpRequestFailed => l10n.loginOtpSendError,
        LoginError.invalidCode => l10n.otpInvalidCode,
      };
}

/// Google + Apple sign-in. Rendered but disabled: the provider SDKs are wired
/// in a later step (RM-M01-03). Apple is mandatory alongside Google on iOS.
class _SocialRow extends StatelessWidget {
  const _SocialRow({required this.l10n});

  final I18n l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Dimens.spacingLg,
      children: [
        SocialAuthButton.google(semanticLabel: l10n.loginContinueWithGoogle),
        SocialAuthButton.apple(semanticLabel: l10n.loginContinueWithApple),
      ],
    );
  }
}

/// The "Don't have an account? Sign up" (and inverse) footer link.
class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({required this.mode, required this.onTap, required this.l10n});

  final AuthMode mode;
  final VoidCallback onTap;
  final I18n l10n;

  @override
  Widget build(BuildContext context) {
    final isLogin = mode == AuthMode.login;
    final question = isLogin ? l10n.loginNoAccountQuestion : l10n.registerHaveAccountQuestion;
    final action = isLogin ? l10n.loginSignUpAction : l10n.registerSignInAction;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Text.rich(
        TextSpan(
          text: '$question ',
          style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
          children: [
            TextSpan(
              text: action,
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
