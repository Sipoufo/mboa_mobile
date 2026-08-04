import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../bloc/register_bloc.dart';
import '../models/professional_role.dart';

/// App Mboa Pro professional registration — role + email + password + phone,
/// then a phone OTP. A single screen with two steps driven by [RegisterBloc].
class RegisterView extends StatelessWidget {
  const RegisterView({super.key, this.onLogin});

  /// Navigate back to the login screen (footer link).
  final VoidCallback? onLogin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (_) => getIt<RegisterBloc>(),
      child: _RegisterFlow(onLogin: onLogin),
    );
  }
}

class _RegisterFlow extends StatelessWidget {
  const _RegisterFlow({this.onLogin});

  final VoidCallback? onLogin;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        switch (state) {
          case RegisterSuccess():
            context.read<AuthBloc>().add(const AuthSessionEstablished());
          case RegisterEnterDetails(error: final error?):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: _errorText(l10n, error),
            );
          case RegisterEnterOtp(error: final error?):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: _errorText(l10n, error),
            );
          case RegisterEnterOtp(justResent: true):
            MboaToast.info(context: context, title: l10n.authOtpResent);
          default:
            break;
        }
      },
      builder: (context, state) {
        final (loading, showOtp) = switch (state) {
          RegisterEnterDetails(:final loading) => (loading, false),
          RegisterEnterOtp(:final loading) => (loading, true),
          RegisterSuccess() => (false, true),
        };

        return StackedLoaderView(
          isLoading: loading,
          child: AuthScaffold(
            onBack: showOtp
                ? () => context.read<RegisterBloc>().add(const RegisterBackToDetails())
                : onLogin,
            child: switch (state) {
              RegisterEnterOtp(:final phone) => _OtpStep(phone: phone, loading: loading),
              _ => _DetailsStep(loading: loading, onLogin: onLogin),
            },
          ),
        );
      },
    );
  }

  String _errorText(I18n l10n, RegisterError error) => switch (error) {
        RegisterError.registrationFailed => l10n.registerFailed,
        RegisterError.invalidCode => l10n.otpInvalidCode,
        RegisterError.otpResendFailed => l10n.commonError,
      };
}

class _DetailsStep extends StatefulWidget {
  const _DetailsStep({required this.loading, this.onLogin});

  final bool loading;
  final VoidCallback? onLogin;

  @override
  State<_DetailsStep> createState() => _DetailsStepState();
}

class _DetailsStepState extends State<_DetailsStep> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  ProfessionalRole _role = ProfessionalRole.prestataire;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<RegisterBloc>().add(
            RegisterSubmitted(
              role: _role,
              email: _emailController.text.trim(),
              password: _passwordController.text,
              phone: '${PhoneField.defaultDialCode}${_phoneController.text.trim()}',
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
            l10n.registerTitle,
            textAlign: TextAlign.center,
            style: context.mboaText.h1.copyWith(color: context.mboaColors.primary),
          ),
          const SizedBox(height: Dimens.spacingXl),
          Text(
            l10n.registerRoleLabel,
            style: context.mboaText.label.copyWith(
              fontWeight: FontWeight.w700,
              color: context.mboaColors.primaryDark,
            ),
          ),
          const SizedBox(height: Dimens.spacingXs),
          MboaSegmentedControl<ProfessionalRole>(
            value: _role,
            enabled: !widget.loading,
            onChanged: (role) => setState(() => _role = role),
            segments: [
              MboaSegment(value: ProfessionalRole.prestataire, label: l10n.registerRolePrestataire),
              MboaSegment(value: ProfessionalRole.agent, label: l10n.registerRoleAgent),
            ],
          ),
          const SizedBox(height: Dimens.spacingLg),
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
            textInputAction: TextInputAction.next,
            validator: (value) =>
                (value == null || value.isEmpty) ? l10n.authPasswordRequired : null,
          ),
          const SizedBox(height: Dimens.spacingLg),
          PhoneField(
            controller: _phoneController,
            enabled: !widget.loading,
            labelText: l10n.loginPhoneLabel,
            hintText: l10n.loginPhoneHintLocal,
            validator: (value) => (value?.trim().length ?? 0) == PhoneField.nationalDigits
                ? null
                : l10n.loginPhoneInvalid,
          ),
          const SizedBox(height: Dimens.spacingXl),
          Button.primary(
            title: l10n.registerButton,
            isLoading: widget.loading,
            onPressed: widget.loading ? null : _submit,
          ),
          const SizedBox(height: Dimens.spacingLg),
          _LoginLink(onLogin: widget.onLogin, l10n: l10n),
        ],
      ),
    );
  }
}

class _LoginLink extends StatelessWidget {
  const _LoginLink({required this.onLogin, required this.l10n});

  final VoidCallback? onLogin;
  final I18n l10n;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLogin,
      behavior: HitTestBehavior.opaque,
      child: Text.rich(
        TextSpan(
          text: '${l10n.registerHaveAccountQuestion} ',
          style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
          children: [
            TextSpan(
              text: l10n.registerSignInAction,
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
  const _OtpStep({required this.phone, required this.loading});

  final String phone;
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
      context.read<RegisterBloc>().add(RegisterOtpSubmitted(code));
    }
  }

  void _resend() {
    _controller.clear();
    context.read<RegisterBloc>().add(const RegisterOtpResent());
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
          l10n.otpCodeSentTo(widget.phone),
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
