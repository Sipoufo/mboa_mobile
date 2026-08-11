import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import '../../../app/router/app_router.gr.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../shell/ui/access_restricted_page.dart';
import '../../shell/ui/widgets/pro_bottom_nav.dart';

/// The agent's home in App Mboa Pro.
///
/// A separate shell from [ProShellPage] rather than role checks inside it: the
/// prestataire's Accueil, Gestionnaire and Finance tabs are about listings and
/// subscriptions, none of which an agent has. Sharing the shell would mean an
/// `if (isAgent)` in every screen and a dashboard about properties they do not
/// own.
///
/// Visites (M16) and Missions (M11) have endpoints but no screens yet, so they
/// land on the coming-soon page — the same treatment Attributions and
/// Réservations get on the prestataire side, where the hub is the product's map.
@RoutePage()
class AgentShellPage extends StatelessWidget {
  const AgentShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return AutoTabsRouter(
      routes: const [
        AgentVisitsRoute(),
        AgentMissionsRoute(),
        AgentProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: ProBottomNav(
            selectedIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              ProBottomNavItem(
                icon: LucideIcons.calendarCheck,
                label: l10n.agentNavVisits,
              ),
              ProBottomNavItem(
                icon: LucideIcons.briefcase,
                label: l10n.agentNavMissions,
              ),
              ProBottomNavItem(
                icon: LucideIcons.userRound,
                label: l10n.agentNavProfile,
              ),
            ],
          ),
        );
      },
    );
  }
}

/// M16 — endpoints exist (`/agents/me/visites`), screens do not yet.
@RoutePage()
class AgentVisitsPage extends StatelessWidget {
  const AgentVisitsPage({super.key});

  @override
  Widget build(BuildContext context) => const AccessRestrictedPage(
        restriction: AccessRestriction.comingSoon,
      );
}

/// M11 — endpoints exist (`/agents/me/assignments`), screens do not yet.
@RoutePage()
class AgentMissionsPage extends StatelessWidget {
  const AgentMissionsPage({super.key});

  @override
  Widget build(BuildContext context) => const AccessRestrictedPage(
        restriction: AccessRestriction.comingSoon,
      );
}
