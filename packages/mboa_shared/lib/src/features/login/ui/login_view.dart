import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/login_bloc.dart';
import '../login_flow_controller.dart';

/// Whether the entry screen presents itself as sign-in or sign-up. The
/// mechanics are identical (a phone or an email, then a code); only the copy
/// differs.
enum AuthMode { login, register }

/// The entry of the code sign-in: a phone number or, since §40 A, an email —
/// App Mboa is not for Cameroon alone.
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
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthMode _mode = widget.mode;

  /// §40 A — « Téléphone | E-mail ».
  bool _byEmail = false;

  /// §40 A — any country, Cameroon to start with.
  MboaCountry _country = MboaCountry.cameroon;

  /// What counts as an address here; the server has the last word.
  static final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  @override
  void dispose() {
    _controller.dispose();
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        _byEmail
            ? LoginOtpRequested(email: _email.text.trim())
            : LoginOtpRequested(phoneNumber: _country.e164(_controller.text)),
      );
    }
  }

  String? _validateEmail(I18n l10n, String? value) =>
      _emailPattern.hasMatch(value?.trim() ?? '') ? null : l10n.loginEmailInvalid;

  void _toggleMode() {
    setState(() {
      _mode = _mode == AuthMode.login ? AuthMode.register : AuthMode.login;
    });
  }

  String? _validatePhone(I18n l10n, String? value) {
    // The country's own lengths and ranges (libphonenumber), not Cameroon's.
    return _country.accepts(value ?? '') ? null : l10n.loginPhoneInvalid;
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
            // No WhatsApp on that number, and no SMS instead: the email is
            // the way in, so the screen turns to it.
            if (error == LoginError.whatsappUnavailable) setState(() => _byEmail = true);
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
                  MboaSegmentedControl<bool>(
                    value: _byEmail,
                    enabled: !loading,
                    backgroundColor: context.mboaColors.primaryLight2,
                    selectedColor: context.mboaColors.surface,
                    selectedTextColor: context.mboaColors.primaryDark,
                    unselectedTextColor: context.mboaColors.primaryDark,
                    onChanged: (byEmail) => setState(() => _byEmail = byEmail),
                    segments: [
                      MboaSegment(value: false, label: l10n.loginPhoneLabel),
                      MboaSegment(value: true, label: l10n.authEmailLabel),
                    ],
                  ),
                  const SizedBox(height: Dimens.spacingLg),
                  if (_byEmail)
                    Input(
                      controller: _email,
                      enabled: !loading,
                      labelText: l10n.authEmailLabel,
                      hintText: l10n.loginEmailHint,
                      variant: InputVariant.underline,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      onSubmitted: (_) => _submit(),
                      validator: (value) => _validateEmail(l10n, value),
                    )
                  else
                    PhoneField(
                      controller: _controller,
                      enabled: !loading,
                      country: _country,
                      onCountryChanged: (country) => setState(() => _country = country),
                      labelText: l10n.loginPhoneLabel,
                      hintText: _country == MboaCountry.cameroon ? l10n.loginPhoneHintLocal : _country.example,
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
    LoginError.codeBurnt => l10n.otpCodeBurnt,
    LoginError.whatsappUnavailable => l10n.loginWhatsappUnavailable,
    LoginError.usePasswordLogin => l10n.loginUsePasswordLogin,
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
