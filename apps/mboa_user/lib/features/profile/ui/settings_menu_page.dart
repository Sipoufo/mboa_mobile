import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../history/bloc/history_bloc.dart';

/// Route adapter for the shared "Paramètres" menu. App Mboa users have no
/// password, so only language + delete are offered (phone change to follow).
/// The consultation history (M06) is cleared from here (RM-M06-05).
@RoutePage()
class SettingsMenuPage extends StatelessWidget {
  const SettingsMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final history = getIt<HistoryBloc>();

    return BlocListener<HistoryBloc, HistoryState>(
      bloc: history,
      listenWhen: (_, current) => current is HistoryReady && current.outcome != null,
      listener: (context, state) => switch ((state as HistoryReady).outcome!) {
        HistoryClearOutcome.cleared => MboaToast.success(context: context, title: l10n.historyCleared),
        HistoryClearOutcome.failed =>
          MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.historyClearFailed),
      },
      child: SettingsMenuView(
        localeController: getIt<LocaleController>(),
        onNotifications: () => context.router.push(const NotificationPreferencesRoute()),
        onChangePhone: () => context.router.push(const ChangePhoneRoute()),
        onClearHistory: () async {
          final yes = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              content: Text(l10n.settingsClearHistoryConfirm),
              actions: [
                TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.commonCancel)),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: TextButton.styleFrom(foregroundColor: context.mboaColors.error),
                  child: Text(l10n.settingsClearHistory),
                ),
              ],
            ),
          );
          if (yes ?? false) history.add(const HistoryCleared());
        },
        onDeleteAccount: () => context.router.push(const DeleteAccountRoute()),
      ),
    );
  }
}
