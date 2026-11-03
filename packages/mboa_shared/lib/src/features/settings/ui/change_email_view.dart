import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/change_email_bloc.dart';
import 'widgets/verify_flow_bits.dart';

/// §40 A — App Mboa: add an email to the account, or change it. The address,
/// then its code — and the phone's when the account has one. The same kind
/// of screen as the number change.
class ChangeEmailView extends StatelessWidget {
  const ChangeEmailView({super.key, this.currentEmail, this.phoneNumber});

  /// Null: the account has none, it adds one.
  final String? currentEmail;

  /// The account's phone, which gets a code too; null when it has none.
  final String? phoneNumber;

  @override
  Widget build(BuildContext context) => BlocProvider<ChangeEmailBloc>(
        create: (_) => GetIt.I<ChangeEmailBloc>(),
        child: _Scaffold(currentEmail: currentEmail, phoneNumber: phoneNumber),
      );
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({this.currentEmail, this.phoneNumber});

  final String? currentEmail;
  final String? phoneNumber;

  bool get _adding => currentEmail == null;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ChangeEmailBloc, ChangeEmailState>(
      listenWhen: (prev, curr) =>
          curr is ChangeEmailSuccess ||
          (curr is ChangeEmailEnterAddress && curr.error == ChangeEmailError.requestFailed) ||
          (curr is ChangeEmailEnterCodes && (curr.error != null || curr.justResent)),
      listener: (context, state) {
        switch (state) {
          case ChangeEmailSuccess():
            MboaToast.success(context: context, title: _adding ? l10n.addEmailSuccess : l10n.changeEmailSuccess);
            MboaHeaderBackButton.pop(context);
          case ChangeEmailEnterCodes(justResent: true):
            MboaToast.info(context: context, title: l10n.authOtpResent);
          case ChangeEmailEnterCodes(error: final error?):
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: switch (error) {
                ChangeEmailError.invalidCode => l10n.otpInvalidCode,
                ChangeEmailError.codeBurnt => l10n.otpCodeBurnt,
                _ => l10n.commonError,
              },
            );
          // The refusals about the address are said under it.
          case ChangeEmailEnterAddress():
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
          default:
            break;
        }
      },
      builder: (context, state) {
        final loading = (state is ChangeEmailEnterAddress && state.loading) ||
            (state is ChangeEmailEnterCodes && state.loading);
        return StackedLoaderView(
          isLoading: loading,
          child: Scaffold(
            backgroundColor: colors.background,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: MboaHeaderBackButton.leading(context),
              title: Text(_adding ? l10n.addEmailTitle : l10n.changeEmailTitle),
            ),
            body: SafeArea(
              child: switch (state) {
                ChangeEmailEnterCodes(:final newEmail, :final withPhoneCode, :final error) => _Codes(
                    newEmail: newEmail,
                    phoneNumber: withPhoneCode ? phoneNumber : null,
                    adding: _adding,
                    loading: loading,
                    burnt: error == ChangeEmailError.codeBurnt,
                  ),
                ChangeEmailEnterAddress(:final error) => _Address(
                    currentEmail: currentEmail,
                    hasPhone: phoneNumber != null,
                    loading: loading,
                    error: error,
                  ),
                _ => _Address(currentEmail: currentEmail, hasPhone: phoneNumber != null, loading: loading),
              },
            ),
          ),
        );
      },
    );
  }
}

class _Address extends StatefulWidget {
  const _Address({this.currentEmail, required this.hasPhone, required this.loading, this.error});

  final String? currentEmail;
  final bool hasPhone;
  final bool loading;
  final ChangeEmailError? error;

  @override
  State<_Address> createState() => _AddressState();
}

class _AddressState extends State<_Address> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();

  /// What was sent, so a refusal sticks to that address and not to its edit.
  String? _sent;

  static final _pattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

  bool get _ready => _pattern.hasMatch(_email.text.trim());

  @override
  void didUpdateWidget(_Address oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error != null && widget.error != oldWidget.error) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _formKey.currentState?.validate());
    }
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false) || !_ready) return;
    _sent = _email.text.trim();
    context.read<ChangeEmailBloc>().add(ChangeEmailRequested(newEmail: _sent!, hasPhone: widget.hasPhone));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final adding = widget.currentEmail == null;
    final error = widget.error;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                VerifyIntro(
                  icon: LucideIcons.mail,
                  title: adding ? l10n.addEmailIntroTitle : l10n.changeEmailIntroTitle,
                  body: widget.hasPhone ? l10n.changeEmailIntroBodyWithPhone : l10n.changeEmailIntroBody,
                ),
                const SizedBox(height: Dimens.spacingLg),
                MboaStepHeader(current: 1, total: 2, title: l10n.changeEmailStepAddress),
                const SizedBox(height: Dimens.spacing),
                VerifyCard(
                  children: [
                    if (widget.currentEmail case final current?)
                      Text(
                        l10n.changeEmailCurrent(current),
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    Input(
                      controller: _email,
                      enabled: !widget.loading,
                      labelText: adding ? l10n.addEmailLabel : l10n.changeEmailNewLabel,
                      hintText: l10n.loginEmailHint,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      onSubmitted: (_) => _submit(),
                      validator: (value) => switch (value?.trim()) {
                        final text? when !_pattern.hasMatch(text) => l10n.loginEmailInvalid,
                        final text when error == ChangeEmailError.unchanged && text == _sent =>
                          l10n.changeEmailUnchanged,
                        final text when error == ChangeEmailError.alreadyUsed && text == _sent =>
                          l10n.changeEmailTaken,
                        _ => null,
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          VerifyActionBar(
            child: ListenableBuilder(
              listenable: _email,
              builder: (context, _) => Button.primary(
                title: widget.hasPhone ? l10n.changePhoneRequestCodes : l10n.addPhoneRequestCode,
                isLoading: widget.loading,
                onPressed: widget.loading || !_ready ? null : _submit,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Codes extends StatefulWidget {
  const _Codes({
    required this.newEmail,
    this.phoneNumber,
    required this.adding,
    required this.loading,
    this.burnt = false,
  });

  final String newEmail;

  /// Set when the phone gets a code too.
  final String? phoneNumber;
  final bool adding;
  final bool loading;
  final bool burnt;

  @override
  State<_Codes> createState() => _CodesState();
}

class _CodesState extends State<_Codes> {
  static const int _codeLength = 6;
  final _emailCode = TextEditingController();
  final _phoneCode = TextEditingController();

  @override
  void didUpdateWidget(_Codes oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.burnt && !oldWidget.burnt) {
      _emailCode.clear();
      _phoneCode.clear();
    }
  }

  @override
  void dispose() {
    _emailCode.dispose();
    _phoneCode.dispose();
    super.dispose();
  }

  void _submit() {
    final withPhone = widget.phoneNumber != null;
    if (_emailCode.text.trim().length != _codeLength) return;
    if (withPhone && _phoneCode.text.trim().length != _codeLength) return;
    FocusScope.of(context).unfocus();
    context.read<ChangeEmailBloc>().add(
          ChangeEmailConfirmed(
            emailCode: _emailCode.text.trim(),
            phoneCode: withPhone ? _phoneCode.text.trim() : null,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final enabled = !widget.loading && !widget.burnt;

    Widget code(String recipient, TextEditingController controller, {bool autofocus = false}) => VerifyCard(
          children: [
            Text(l10n.changePhoneNewCodeLabel(recipient), style: context.mboaText.label.copyWith(color: colors.ink)),
            OtpField(controller: controller, length: _codeLength, enabled: enabled, autofocus: autofocus),
          ],
        );

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              MboaStepHeader(
                current: 2,
                total: 2,
                title: widget.phoneNumber == null ? l10n.addPhoneStepCode : l10n.changePhoneStepCodes,
              ),
              const SizedBox(height: Dimens.spacing),
              code(widget.newEmail, _emailCode, autofocus: true),
              if (widget.phoneNumber case final phone?) ...[
                const SizedBox(height: Dimens.spacing),
                code(phone, _phoneCode),
              ],
              const SizedBox(height: Dimens.spacingSm),
              TextButton(
                onPressed: widget.loading ? null : () => context.read<ChangeEmailBloc>().add(const ChangeEmailResent()),
                child: Text(widget.phoneNumber == null ? l10n.otpResend : l10n.changePhoneResendCodes),
              ),
            ],
          ),
        ),
        VerifyActionBar(
          child: Button.primary(
            title: widget.adding ? l10n.addEmailConfirm : l10n.changePhoneConfirm,
            isLoading: widget.loading,
            onPressed: widget.loading || widget.burnt ? null : _submit,
          ),
        ),
      ],
    );
  }
}
