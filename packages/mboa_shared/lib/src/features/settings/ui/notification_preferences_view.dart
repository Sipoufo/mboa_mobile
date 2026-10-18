import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/notification_preferences_bloc.dart';
import '../models/notification_preference.dart';

/// "Notifications" in Paramètres (RM-M03-01): a switch per notification the
/// person can actually receive and turn off.
///
/// The mandatory ones get no switch — a switch that cannot move is noise —
/// and one line says they stay on. Plain widget embedded by each app's
/// `@RoutePage` adapter, which says who is reading.
class NotificationPreferencesView extends StatelessWidget {
  const NotificationPreferencesView({super.key, required this.audience});

  final NotificationAudience audience;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotificationPreferencesBloc>(
      create: (_) => GetIt.I<NotificationPreferencesBloc>(param1: audience)
        ..add(const NotificationPreferencesRequested()),
      child: const NotificationPreferencesScreen(),
    );
  }
}

/// The screen under its bloc, public so it can be pumped with a mock one.
class NotificationPreferencesScreen extends StatelessWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        foregroundColor: colors.primary,
        title: Text(l10n.notifPrefsTitle, style: context.mboaText.h3.copyWith(color: colors.primary)),
      ),
      body: BlocConsumer<NotificationPreferencesBloc, NotificationPreferencesState>(
        listenWhen: (_, curr) => curr is NotificationPreferencesReady && curr.error != null,
        listener: (context, state) {
          if (state case NotificationPreferencesReady(error: final error?)) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: switch (error) {
                NotificationPreferencesError.mandatory => l10n.notifPrefsMandatoryRefused,
                NotificationPreferencesError.saveFailed => l10n.notifPrefsSaveFailed,
              },
            );
          }
        },
        builder: (context, state) => switch (state) {
          NotificationPreferencesLoading() => const Center(child: Loader()),
          NotificationPreferencesFailure() => _Failure(
              onRetry: () => context.read<NotificationPreferencesBloc>().add(const NotificationPreferencesRequested()),
            ),
          final NotificationPreferencesReady ready => _List(state: ready),
        },
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.state});

  final NotificationPreferencesReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<NotificationPreferencesBloc>();

    return ListView(
      padding: const EdgeInsets.all(Dimens.spacingLg),
      children: [
        for (final preference in state.visible)
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            value: preference.enabled,
            title: Text(notificationLabel(l10n, preference.code), style: context.mboaText.body),
            // One save at a time: the opt-out set replaces the stored one.
            onChanged: state.savingCode != null
                ? null
                : (enabled) => bloc.add(NotificationPreferenceToggled(preference.code, enabled: enabled)),
          ),
        const SizedBox(height: Dimens.spacingLg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(LucideIcons.shieldCheck, size: Dimens.iconSm, color: colors.textTertiary),
            const SizedBox(width: Dimens.spacingSm),
            Expanded(
              child: Text(
                l10n.notifPrefsMandatoryNote,
                style: context.mboaText.caption.copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.notifPrefsLoadFailed,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
          ],
        ),
      ),
    );
  }
}

/// What a notification type is called on the switch. Only the opt-out types
/// any audience is shown need a label; anything else reads as its code.
String notificationLabel(I18n l10n, String code) => switch (code) {
      'N01' => l10n.notifPrefN01,
      'N02' => l10n.notifPrefN02,
      'N03' => l10n.notifPrefN03,
      'N04' => l10n.notifPrefN04,
      'N05' => l10n.notifPrefN05,
      'N10' => l10n.notifPrefN10,
      'N15' => l10n.notifPrefN15,
      'N18' => l10n.notifPrefN18,
      'N21' => l10n.notifPrefN21,
      'N26' => l10n.notifPrefN26,
      _ => code,
    };
