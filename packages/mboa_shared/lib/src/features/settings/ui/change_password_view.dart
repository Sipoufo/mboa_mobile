import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/change_password_cubit.dart';

/// Change-password screen (Pro/admin). Plain widget embedded by the app's
/// `@RoutePage` adapter.
class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordCubit>(
      create: (_) => GetIt.I<ChangePasswordCubit>(),
      child: const _ChangePasswordForm(),
    );
  }
}

class _ChangePasswordForm extends StatefulWidget {
  const _ChangePasswordForm();

  @override
  State<_ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<_ChangePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ChangePasswordCubit>().submit(
            currentPassword: _current.text,
            newPassword: _next.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listenWhen: (prev, curr) =>
          curr is ChangePasswordSuccess || curr is ChangePasswordFailure,
      listener: (context, state) {
        switch (state) {
          case ChangePasswordSuccess():
            MboaToast.success(context: context, title: l10n.changePasswordSuccess);
            Navigator.of(context).maybePop();
          case ChangePasswordFailure():
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.changePasswordError,
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final saving = state is ChangePasswordInProgress;
        return StackedLoaderView(
          isLoading: saving,
          child: Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(
              backgroundColor: colors.surface,
              foregroundColor: colors.primary,
              title: Text(l10n.settingsChangePassword, style: context.mboaText.h3.copyWith(color: colors.primary)),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      PasswordField(
                        controller: _current,
                        enabled: !saving,
                        labelText: l10n.changePasswordCurrent,
                        textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? l10n.authPasswordRequired : null,
                      ),
                      const SizedBox(height: Dimens.spacingLg),
                      PasswordField(
                        controller: _next,
                        enabled: !saving,
                        labelText: l10n.changePasswordNew,
                        textInputAction: TextInputAction.next,
                        validator: (v) => (v == null || v.isEmpty) ? l10n.authPasswordRequired : null,
                      ),
                      const SizedBox(height: Dimens.spacingLg),
                      PasswordField(
                        controller: _confirm,
                        enabled: !saving,
                        labelText: l10n.changePasswordConfirm,
                        validator: (v) => v != _next.text ? l10n.changePasswordMismatch : null,
                      ),
                      const SizedBox(height: Dimens.spacingXl),
                      Button.primary(
                        title: l10n.changePasswordButton,
                        icon: const Icon(LucideIcons.save, size: Dimens.icon),
                        iconAlignment: IconAlignment.start,
                        isLoading: saving,
                        onPressed: saving ? null : _submit,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
