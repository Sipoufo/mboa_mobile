import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import 'widgets/tab_placeholder.dart';

/// Finance tab — the "Portefeuille" surface from the Pro home design.
///
/// Placeholder by decision: there is no wallet API and no CDC module behind it
/// (M13 covers subscriptions, not a wallet), so this ships as an explicit
/// "bientôt disponible" rather than as fabricated figures.
@RoutePage()
class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return TabPlaceholder(
      icon: LucideIcons.wallet,
      title: l10n.navFinance,
      body: l10n.accessComingSoonBody,
    );
  }
}
