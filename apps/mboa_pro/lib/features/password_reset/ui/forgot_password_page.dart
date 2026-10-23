import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/password_reset_bloc.dart';

/// "Mot de passe oublié" (M02, App Mboa Pro): the account's email, then the
/// code sent **by SMS** to the account's phone and a new password.
///
/// [email] is what was typed on the login screen, so it need not be typed
/// twice. On success the screen closes back to the login, which still holds
/// that email.
@RoutePage()
class ForgotPasswordPage extends StatelessWidget implements AutoRouteWrapper {
  const ForgotPasswordPage({super.key, this.email});

  final String? email;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<PasswordResetBloc>(create: (_) => getIt<PasswordResetBloc>(), child: this);

  @override
  Widget build(BuildContext context) => ForgotPasswordFlow(email: email);
}

/// The two steps under their bloc — public so it can be pumped with a mock.
class ForgotPasswordFlow extends StatelessWidget {
  const ForgotPasswordFlow({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocConsumer<PasswordResetBloc, PasswordResetState>(
      listener: (context, state) {
        switch (state) {
          case PasswordResetDone():
            MboaToast.success(context: context, title: l10n.pwdResetDoneTitle, description: l10n.pwdResetDoneBody);
            unawaited(context.router.maybePop());
          case PasswordResetEnterEmail(error: final error?) || PasswordResetEnterCode(error: final error?):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: _errorText(l10n, error));
          case PasswordResetEnterCode(justResent: true):
            MboaToast.info(context: context, title: l10n.authOtpResent);
          default:
            break;
        }
      },
      builder: (context, state) {
        final loading = switch (state) {
          PasswordResetEnterEmail(:final loading) || PasswordResetEnterCode(:final loading) => loading,
          PasswordResetDone() => true,
        };
        final onCode = state is PasswordResetEnterCode;

        return StackedLoaderView(
          isLoading: loading,
          child: AuthScaffold(
            onBack: onCode
                ? () => context.read<PasswordResetBloc>().add(const PasswordResetBackToEmail())
                : () => context.router.maybePop(),
            child: switch (state) {
              PasswordResetEnterCode(:final email, :final error) => _CodeStep(
                  email: email,
                  loading: loading,
                  // Dead even if right (OTP_MAX_ATTEMPTS, OTP_INVALID_OR_EXPIRED).
                  burnt: error == PasswordResetError.tooManyAttempts || error == PasswordResetError.expired,
                ),
              _ => _EmailStep(initialEmail: email, loading: loading),
            },
          ),
        );
      },
    );
  }

  String _errorText(I18n l10n, PasswordResetError error) => switch (error) {
        PasswordResetError.wrongCode => l10n.otpInvalidCode,
        PasswordResetError.expired => l10n.pwdResetCodeExpired,
        PasswordResetError.tooManyAttempts => l10n.pwdResetTooManyAttempts,
        PasswordResetError.failed => l10n.commonError,
      };
}

class _EmailStep extends StatefulWidget {
  const _EmailStep({required this.loading, this.initialEmail});

  final bool loading;
  final String? initialEmail;

  @override
  State<_EmailStep> createState() => _EmailStepState();
}

/// Form state only — what is typed before anything is sent.
class _EmailStepState extends State<_EmailStep> {
  final _formKey = GlobalKey<FormState>();
  late final _email = TextEditingController(text: widget.initialEmail);

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<PasswordResetBloc>().add(PasswordResetRequested(_email.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.spacingSm),
          Text(
            l10n.pwdResetTitle,
            textAlign: TextAlign.center,
            style: context.mboaText.h1.copyWith(color: colors.primary),
          ),
          const SizedBox(height: Dimens.spacingSm),
          Text(
            l10n.pwdResetEmailBody,
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: Dimens.spacingXl),
          Input(
            controller: _email,
            enabled: !widget.loading,
            labelText: l10n.authEmailLabel,
            hintText: l10n.authEmailHint,
            variant: InputVariant.underline,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            textCapitalization: TextCapitalization.none,
            autofillHints: const [AutofillHints.email],
            validator: (value) => _emailPattern.hasMatch(value?.trim() ?? '') ? null : l10n.authEmailInvalid,
          ),
          const SizedBox(height: Dimens.spacingXl),
          Button.primary(
            title: l10n.pwdResetSendCode,
            isLoading: widget.loading,
            onPressed: widget.loading ? null : _submit,
          ),
        ],
      ),
    );
  }
}

class _CodeStep extends StatefulWidget {
  const _CodeStep({required this.email, required this.loading, this.burnt = false});

  final String email;
  final bool loading;

  /// The code is dead: nothing to type until a new one comes.
  final bool burnt;

  @override
  State<_CodeStep> createState() => _CodeStepState();
}

/// Form state and the resend cooldown — the same 60 s as the login's code.
class _CodeStepState extends State<_CodeStep> {
  static const int _codeLength = 6;
  static const int _resendCooldown = 60;

  /// What the server accepts (`ResetPasswordRequest.newPassword`).
  static const int _minLength = 8;
  static const int _maxLength = 72;

  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  Timer? _timer;
  int _secondsLeft = _resendCooldown;

  @override
  void initState() {
    super.initState();
    _startCooldown();
  }

  @override
  void didUpdateWidget(_CodeStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Cleared, and a new code may be asked at once.
    if (widget.burnt && !oldWidget.burnt) {
      _code.clear();
      _timer?.cancel();
      setState(() => _secondsLeft = 0);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _code.dispose();
    _password.dispose();
    _confirm.dispose();
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

  void _resend() {
    _code.clear();
    context.read<PasswordResetBloc>().add(const PasswordResetCodeResent());
    _startCooldown();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    final complete = _code.text.trim().length == _codeLength;
    if ((_formKey.currentState?.validate() ?? false) && complete) {
      context
          .read<PasswordResetBloc>()
          .add(PasswordResetSubmitted(code: _code.text.trim(), newPassword: _password.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final canResend = _secondsLeft == 0 && !widget.loading;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: Dimens.spacingSm),
          Text(
            l10n.pwdResetTitle,
            textAlign: TextAlign.center,
            style: context.mboaText.h1.copyWith(color: colors.primary),
          ),
          const SizedBox(height: Dimens.spacingSm),
          // Said the same whether or not the email has an account.
          Text(
            l10n.pwdResetCodeBody(widget.email),
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: Dimens.spacingXl),
          OtpField(controller: _code, length: _codeLength, enabled: !widget.loading && !widget.burnt),
          const SizedBox(height: Dimens.spacingLg),
          PasswordField(
            controller: _password,
            enabled: !widget.loading,
            labelText: l10n.changePasswordNew,
            textInputAction: TextInputAction.next,
            validator: (value) {
              final length = value?.length ?? 0;
              if (length < _minLength) return l10n.pwdResetTooShort(_minLength);
              if (length > _maxLength) return l10n.pwdResetTooLong(_maxLength);
              return null;
            },
          ),
          const SizedBox(height: Dimens.spacingLg),
          PasswordField(
            controller: _confirm,
            enabled: !widget.loading,
            labelText: l10n.changePasswordConfirm,
            onSubmitted: (_) => _submit(),
            validator: (value) => value == _password.text ? null : l10n.changePasswordMismatch,
          ),
          const SizedBox(height: Dimens.spacingXl),
          Button.primary(
            title: l10n.pwdResetSubmit,
            isLoading: widget.loading,
            onPressed: widget.loading || widget.burnt ? null : _submit,
          ),
          const SizedBox(height: Dimens.spacingLg),
          Text(
            l10n.otpNoCodeQuestion,
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
          TextButton(
            onPressed: canResend ? _resend : null,
            child: Text(
              canResend ? l10n.otpResend : l10n.otpResendIn(_secondsLeft),
              style: context.mboaText.label.copyWith(
                color: canResend ? colors.primary : colors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
