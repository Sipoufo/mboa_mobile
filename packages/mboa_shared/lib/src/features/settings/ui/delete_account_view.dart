import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/delete_account_cubit.dart';

/// Deliberately friction-full account deletion: the user must type the exact
/// confirmation word before the destructive action is enabled.
///
/// Plain widget embedded by each app's `@RoutePage` adapter; [onDeleted] runs
/// after a successful deletion (the app clears its session and routes out).
class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({required this.onDeleted, super.key});

  final VoidCallback onDeleted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeleteAccountCubit>(
      create: (_) => GetIt.I<DeleteAccountCubit>(),
      child: _DeleteAccountForm(onDeleted: onDeleted),
    );
  }
}

class _DeleteAccountForm extends StatefulWidget {
  const _DeleteAccountForm({required this.onDeleted});

  final VoidCallback onDeleted;

  @override
  State<_DeleteAccountForm> createState() => _DeleteAccountFormState();
}

class _DeleteAccountFormState extends State<_DeleteAccountForm> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final confirmWord = l10n.deleteAccountConfirmWord;

    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listenWhen: (prev, curr) =>
          curr is DeleteAccountSuccess || curr is DeleteAccountFailure,
      listener: (context, state) {
        switch (state) {
          case DeleteAccountSuccess():
            widget.onDeleted();
          case DeleteAccountFailure():
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.commonError,
            );
          default:
            break;
        }
      },
      builder: (context, state) {
        final deleting = state is DeleteAccountInProgress;
        final matches = _controller.text.trim().toUpperCase() == confirmWord.toUpperCase();

        return StackedLoaderView(
          isLoading: deleting,
          child: Scaffold(
            backgroundColor: colors.surface,
            appBar: AppBar(
              backgroundColor: colors.surface,
              foregroundColor: colors.primary,
              title: Text(l10n.deleteAccountTitle, style: context.mboaText.h3.copyWith(color: colors.primary)),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(Dimens.spacing),
                      decoration: BoxDecoration(
                        color: colors.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(Dimens.radius),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(LucideIcons.triangleAlert, color: colors.error, size: Dimens.iconMd),
                          const SizedBox(width: Dimens.spacing),
                          Expanded(
                            child: Text(
                              l10n.deleteAccountWarning,
                              style: context.mboaText.body.copyWith(color: colors.ink),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.spacingLg),
                    Text(
                      l10n.deleteAccountConfirmLabel(confirmWord),
                      style: context.mboaText.body.copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: Dimens.spacingSm),
                    Input(
                      controller: _controller,
                      enabled: !deleting,
                      hintText: confirmWord,
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (_) => setState(() {}),
                    ),
                    const Spacer(),
                    Button.custom(
                      title: l10n.deleteAccountButton,
                      icon: const Icon(LucideIcons.trash2, size: Dimens.icon),
                      iconAlignment: IconAlignment.start,
                      isCenter: true,
                      backgroundColor: colors.error,
                      textColor: colors.onBrand,
                      isLoading: deleting,
                      onPressed: matches && !deleting ? () => context.read<DeleteAccountCubit>().delete() : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
