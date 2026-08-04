import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';

import 'widgets/tab_placeholder.dart';

/// Gestionnaire tab — agent delegation (CDC M15/M16).
///
/// Placeholder: `api_client` exposes no agent endpoints yet, so there is
/// nothing to fetch. `AccessPolicy` reports [FeatureKey.mesAgents] as
/// [AccessRestriction.comingSoon] for the same reason.
@RoutePage()
class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    return TabPlaceholder(
      icon: LucideIcons.users,
      title: l10n.navManager,
      body: l10n.accessComingSoonBody,
    );
  }
}
