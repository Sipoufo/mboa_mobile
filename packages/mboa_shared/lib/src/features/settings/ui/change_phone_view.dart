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
            MboaHeaderBackButton.pop(context);
          case ChangePhoneEnterCodes(justResent: true):
            MboaToast.info(context: context, title: l10n.authOtpResent);
          // The refusals about a number are said under it, not in a toast.
          case ChangePhoneEnterPhone(error: ChangePhoneError.requestFailed):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.commonError);
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
              automaticallyImplyLeading: false,
              leading: MboaHeaderBackButton.leading(context),
              backgroundColor: colors.surface,
              foregroundColor: colors.primary,
              title: Text(l10n.settingsChangePhone, style: context.mboaText.h3.copyWith(color: colors.primary)),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                child: switch (state) {
                  ChangePhoneEnterCodes(:final currentPhoneNumber, :final newPhoneNumber, :final error) => _CodesStep(
                      currentPhoneNumber: currentPhoneNumber,
                      newPhoneNumber: newPhoneNumber,
                      loading: loading,
                      burnt: error == ChangePhoneError.codeBurnt,
                    ),
                  ChangePhoneEnterPhone(:final error) => _PhoneStep(loading: loading, error: error),
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
        ChangePhoneError.codeBurnt => l10n.otpCodeBurnt,
        _ => l10n.commonError,
      };
}

/// RM-M02-02 — the current number first, then the new one. A refusal about
/// either is said under it, and goes as soon as that number is edited.
class _PhoneStep extends StatefulWidget {
  const _PhoneStep({required this.loading, this.error});

  final bool loading;
  final ChangePhoneError? error;

  @override
  State<_PhoneStep> createState() => _PhoneStepState();
}

class _PhoneStepState extends State<_PhoneStep> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();

  /// What was sent, so a refusal sticks to that number and not to its edit.
  String? _sentCurrent;
  String? _sentNext;

  @override
  void didUpdateWidget(_PhoneStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.error != null && widget.error != oldWidget.error) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _formKey.currentState?.validate());
    }
  }

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    super.dispose();
  }

  static bool _complete(String text) => text.trim().length == PhoneField.nationalDigits;

  bool get _ready => _complete(_current.text) && _complete(_next.text) && _current.text.trim() != _next.text.trim();

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false) || !_ready) return;
    _sentCurrent = _current.text.trim();
    _sentNext = _next.text.trim();
    context.read<ChangePhoneBloc>().add(
          ChangePhoneRequested(
            currentPhoneNumber: '${PhoneField.defaultDialCode}$_sentCurrent',
            newPhoneNumber: '${PhoneField.defaultDialCode}$_sentNext',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final error = widget.error;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PhoneField(
            controller: _current,
            enabled: !widget.loading,
            labelText: l10n.changePhoneCurrentLabel,
            hintText: l10n.loginPhoneHintLocal,
            textInputAction: TextInputAction.next,
            validator: (v) => switch (v?.trim()) {
              final text? when !_complete(text) => l10n.loginPhoneInvalid,
              final text when error == ChangePhoneError.currentMismatch && text == _sentCurrent =>
                l10n.changePhoneCurrentMismatch,
              _ => null,
            },
          ),
          const SizedBox(height: Dimens.spacingLg),
          PhoneField(
            controller: _next,
            enabled: !widget.loading,
            labelText: l10n.changePhoneNewLabel,
            hintText: l10n.loginPhoneHintLocal,
            onSubmitted: (_) => _submit(),
            validator: (v) => switch (v?.trim()) {
              final text? when !_complete(text) => l10n.loginPhoneInvalid,
              final text when text == _current.text.trim() => l10n.changePhoneSameNumber,
              final text when error == ChangePhoneError.unchanged && text == _sentNext => l10n.changePhoneSameNumber,
              final text when error == ChangePhoneError.alreadyUsed && text == _sentNext => l10n.changePhoneTaken,
              _ => null,
            },
          ),
          const SizedBox(height: Dimens.spacingLg),
          // Both complete and different before the codes can be asked for.
          ListenableBuilder(
            listenable: Listenable.merge([_current, _next]),
            builder: (context, _) => Button.primary(
              title: l10n.loginRequestCode,
              isLoading: widget.loading,
              onPressed: widget.loading || !_ready ? null : _submit,
            ),
          ),
        ],
      ),
    );
  }
}

class _CodesStep extends StatefulWidget {
  const _CodesStep({
    required this.currentPhoneNumber,
    required this.newPhoneNumber,
    required this.loading,
    this.burnt = false,
  });

  final String currentPhoneNumber;
  final String newPhoneNumber;
  final bool loading;

  /// The codes are dead: nothing to type until new ones come.
  final bool burnt;

  @override
  State<_CodesStep> createState() => _CodesStepState();
}

class _CodesStepState extends State<_CodesStep> {
  static const int _codeLength = 6;
  final _oldCode = TextEditingController();
  final _newCode = TextEditingController();

  @override
  void didUpdateWidget(_CodesStep oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.burnt && !oldWidget.burnt) {
      _oldCode.clear();
      _newCode.clear();
    }
  }

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
        // Each code names its number.
        Text(
          l10n.changePhoneNewCodeLabel(widget.currentPhoneNumber),
          style: context.mboaText.label.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        OtpField(controller: _oldCode, length: _codeLength, enabled: !widget.loading && !widget.burnt, autofocus: true),
        const SizedBox(height: Dimens.spacingLg),
        Text(
          l10n.changePhoneNewCodeLabel(widget.newPhoneNumber),
          style: context.mboaText.label.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        OtpField(
          controller: _newCode,
          length: _codeLength,
          enabled: !widget.loading && !widget.burnt,
          autofocus: false,
        ),
        const SizedBox(height: Dimens.spacingLg),
        Button.primary(
          title: l10n.changePhoneConfirm,
          isLoading: widget.loading,
          onPressed: widget.loading || widget.burnt ? null : _submit,
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
