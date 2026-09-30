import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../favorites/bloc/favorites_bloc.dart';

/// App Mboa's home for everyone, signed in or not.
///
/// **The shell is public** (CA-M04-04, RM-M04-05): a visitor searches and reads
/// fiches without an account, and the wall goes up on the actions — contacting
/// a prestataire, booking a visit — not at the door. The tabs that need an
/// account say so rather than being hidden, because a product's map should be
/// legible before you sign up.
@RoutePage()
class UserShellPage extends StatelessWidget implements AutoRouteWrapper {
  const UserShellPage({super.key});

  /// One `FavoritesBloc` above every tab **and** above the fiches pushed over
  /// them: the heart on a search card and the heart on that listing's fiche
  /// read the same state, or they end up disagreeing about the same property.
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<FavoritesBloc>.value(
        value: getIt<FavoritesBloc>(),
        child: this,
      );

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
