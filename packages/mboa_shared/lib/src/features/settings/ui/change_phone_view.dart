import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/change_phone_bloc.dart';

/// Two-step phone-number change screen: enter the new number, then confirm with
/// the codes sent to the old and new numbers. Plain widget embedded by each
/// app's `@RoutePage` adapter.
class ChangePhoneView extends StatelessWidget {
  const ChangePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePhoneBloc>(
      create: (_) => GetIt.I<ChangePhoneBloc>(),
      child: const _ChangePhoneScaffold(),
    );
  }
}

class _ChangePhoneScaffold extends StatelessWidget {
  const _ChangePhoneScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ChangePhoneBloc, ChangePhoneState>(
      listenWhen: (prev, curr) =>
          curr is ChangePhoneSuccess ||
          (curr is ChangePhoneEnterPhone && curr.error != null) ||
          (curr is ChangePhoneEnterCodes && (curr.error != null || curr.justResent)),
      listener: (context, state) {
        switch (state) {
          case ChangePhoneSuccess():
            MboaToast.success(context: context, title: l10n.changePhoneSuccess);
            Navigator.of(context).maybePop();
          case ChangePhoneEnterCodes(justResent: true):
            MboaToast.info(context: context, title: l10n.authOtpResent);
          case ChangePhoneEnterPhone(error: final e?):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: _err(l10n, e));
          case ChangePhoneEnterCodes(error: final e?):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: _err(l10n, e));
          default:
            break;
        }
      },
      builder: (context, state) {
        final loading = (state is ChangePhoneEnterPhone && state.loading) ||
            (state is ChangePhoneEnterCodes && state.loading);
        return StackedLoaderView(
          isLoading: loading,
          child: Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(
              backgroundColor: colors.surface,
              foregroundColor: colors.primary,
              title: Text(l10n.settingsChangePhone, style: context.mboaText.h3.copyWith(color: colors.primary)),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                child: switch (state) {
                  ChangePhoneEnterCodes(:final newPhoneNumber) =>
                    _CodesStep(newPhoneNumber: newPhoneNumber, loading: loading),
                  _ => _PhoneStep(loading: loading),
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _err(I18n l10n, ChangePhoneError e) => switch (e) {
        ChangePhoneError.invalidCode => l10n.otpInvalidCode,
        ChangePhoneError.requestFailed => l10n.commonError,
      };
}

class _PhoneStep extends StatefulWidget {
  const _PhoneStep({required this.loading});

  final bool loading;

  @override
  State<_PhoneStep> createState() => _PhoneStepState();
}

class _PhoneStepState extends State<_PhoneStep> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ChangePhoneBloc>().add(
            ChangePhoneRequested('${PhoneField.defaultDialCode}${_controller.text.trim()}'),
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
          PhoneField(
            controller: _controller,
            enabled: !widget.loading,
            labelText: l10n.loginPhoneLabel,
            hintText: l10n.loginPhoneHintLocal,
            onSubmitted: (_) => _submit(),
            validator: (v) =>
                (v?.trim().length ?? 0) == PhoneField.nationalDigits ? null : l10n.loginPhoneInvalid,
          ),
          const SizedBox(height: Dimens.spacingLg),
          Button.primary(
            title: l10n.loginRequestCode,
            isLoading: widget.loading,
            onPressed: widget.loading ? null : _submit,
          ),
        ],
      ),
    );
  }
}

class _CodesStep extends StatefulWidget {
  const _CodesStep({required this.newPhoneNumber, required this.loading});

  final String newPhoneNumber;
  final bool loading;

  @override
  State<_CodesStep> createState() => _CodesStepState();
}

class _CodesStepState extends State<_CodesStep> {
  static const int _codeLength = 6;
  final _oldCode = TextEditingController();
  final _newCode = TextEditingController();

  @override
  void dispose() {
    _oldCode.dispose();
    _newCode.dispose();
    super.dispose();
  }

  void _submit() {
    if (_oldCode.text.trim().length == _codeLength && _newCode.text.trim().length == _codeLength) {
      FocusScope.of(context).unfocus();
      context.read<ChangePhoneBloc>().add(
            ChangePhoneConfirmed(oldCode: _oldCode.text.trim(), newCode: _newCode.text.trim()),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    return ListView(
      children: [
        Text(l10n.changePhoneOldCodeLabel, style: context.mboaText.label.copyWith(color: colors.textSecondary)),
        const SizedBox(height: Dimens.spacingSm),
        OtpField(controller: _oldCode, length: _codeLength, enabled: !widget.loading, autofocus: true),
        const SizedBox(height: Dimens.spacingLg),
        Text(
          l10n.changePhoneNewCodeLabel(widget.newPhoneNumber),
          style: context.mboaText.label.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        OtpField(controller: _newCode, length: _codeLength, enabled: !widget.loading, autofocus: false),
        const SizedBox(height: Dimens.spacingLg),
        Button.primary(
          title: l10n.changePhoneConfirm,
          isLoading: widget.loading,
          onPressed: widget.loading ? null : _submit,
        ),
        const SizedBox(height: Dimens.spacingSm),
        TextButton(
          onPressed: widget.loading ? null : () => context.read<ChangePhoneBloc>().add(const ChangePhoneResent()),
          child: Text(l10n.otpResend),
        ),
      ],
    );
  }
}
