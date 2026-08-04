import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../logic/locale_controller.dart';

/// The "Paramètres" hub: language, account actions (change phone / password when
/// wired) and — tucked at the very bottom — account deletion.
///
/// Plain widget embedded by each app's `@RoutePage` adapter. [onChangePhone] /
/// [onChangePassword] are null when the app doesn't offer them (e.g. App Mboa
/// users have no password).
class SettingsMenuView extends StatelessWidget {
  const SettingsMenuView({
    required this.localeController,
    required this.onDeleteAccount,
    this.onChangePhone,
    this.onChangePassword,
    super.key,
  });

  final LocaleController localeController;
  final VoidCallback onDeleteAccount;
  final VoidCallback? onChangePhone;
  final VoidCallback? onChangePassword;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.surface,
        foregroundColor: colors.primary,
        title: Text(l10n.settingsMenuTitle, style: context.mboaText.h3.copyWith(color: colors.primary)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(Dimens.spacingLg),
                children: [
                  Text(
                    l10n.settingsLanguage,
                    style: context.mboaText.label.copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                  ValueListenableBuilder<Locale?>(
                    valueListenable: localeController,
                    builder: (context, locale, _) {
                      final code =
                          (locale?.languageCode ?? Localizations.localeOf(context).languageCode) == 'en'
                              ? 'en'
                              : 'fr';
                      return MboaSegmentedControl<String>(
                        value: code,
                        onChanged: (c) => localeController.setLocale(Locale(c)),
                        segments: [
                          MboaSegment(value: 'fr', label: l10n.languageFrench),
                          MboaSegment(value: 'en', label: l10n.languageEnglish),
                        ],
                      );
                    },
                  ),
                  if (onChangePhone != null) ...[
                    const SizedBox(height: Dimens.spacingLg),
                    MboaTileCard(
                      icon: LucideIcons.phone,
                      title: l10n.settingsChangePhone,
                      onTap: onChangePhone,
                    ),
                  ],
                  if (onChangePassword != null) ...[
                    const SizedBox(height: Dimens.spacing),
                    MboaTileCard(
                      icon: LucideIcons.keyRound,
                      title: l10n.settingsChangePassword,
                      onTap: onChangePassword,
                    ),
                  ],
                ],
              ),
            ),
            TextButton(
              onPressed: onDeleteAccount,
              style: TextButton.styleFrom(foregroundColor: colors.textTertiary),
              child: Text(l10n.deleteAccountLink, style: context.mboaText.caption),
            ),
            const SizedBox(height: Dimens.spacingSm),
          ],
        ),
      ),
    );
  }
}
