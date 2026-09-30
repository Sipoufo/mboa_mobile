import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// App Mboa's home for everyone, signed in or not.
///
/// **The shell is public** (CA-M04-04, RM-M04-05): a visitor searches and reads
/// fiches without an account, and the wall goes up on the actions — contacting
/// a prestataire, booking a visit — not at the door. The tabs that need an
/// account say so rather than being hidden, because a product's map should be
/// legible before you sign up.
@RoutePage()
class UserShellPage extends StatelessWidget {
  const UserShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return AutoTabsScaffold(
      routes: const [
        SearchRoute(),
        FavoritesRoute(),
        MessagesRoute(),
        AccountRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) => MboaBottomNav(
        selectedIndex: tabsRouter.activeIndex,
        onTap: tabsRouter.setActiveIndex,
        items: [
          MboaBottomNavItem(
            icon: LucideIcons.search,
            label: l10n.navSearch,
          ),
          MboaBottomNavItem(
            icon: LucideIcons.heart,
            label: l10n.navFavorites,
          ),
          MboaBottomNavItem(
            icon: LucideIcons.messageSquare,
            label: l10n.navMessages,
          ),
          MboaBottomNavItem(
            icon: LucideIcons.userRound,
            label: l10n.navAccount,
          ),
        ],
      ),
    );
  }
}
