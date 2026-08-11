import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import '../../../app/router/app_router.gr.dart';
import '../../shell/ui/widgets/pro_bottom_nav.dart';

/// The agent's home in App Mboa Pro.
///
/// A separate shell from [ProShellPage] rather than role checks inside it: the
/// prestataire's Accueil, Gestionnaire and Finance tabs are about listings and
/// subscriptions, none of which an agent has. Sharing the shell would mean an
/// `if (isAgent)` in every screen and a dashboard about properties they do not
/// own.
///
/// All three tabs are real: Visites is M16, Missions is M11, Profil is M15.
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
