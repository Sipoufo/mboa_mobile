import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import 'widgets/pro_bottom_nav.dart';

/// Tab shell for the authenticated Pro app: Accueil / Gestionnaire / Finance,
/// plus a Menu slot that opens the slide menu as a modal over the active tab
/// rather than switching to a fourth tab.
@RoutePage(name: 'ProShellRoute')
class ProShellPage extends StatefulWidget {
  const ProShellPage({super.key});

  /// Index of the Menu slot — it has no tab of its own.
  static const int menuSlot = 3;

  @override
  State<ProShellPage> createState() => _ProShellPageState();
}

class _ProShellPageState extends State<ProShellPage> {
  /// Visited tab indices, so Android back walks back through them (starts on
  /// Accueil).
  final List<int> _visitHistory = [0];
  DateTime? _lastBackPress;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return AutoTabsRouter(
      routes: const [HomeRoute(), PrestataireVisitsRoute(), FinanceRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) return;
            _handleBack(tabsRouter);
          },
          child: Scaffold(
            body: child,
            bottomNavigationBar: ProBottomNav(
              selectedIndex: tabsRouter.activeIndex,
              onTap: (index) => _onSlotTapped(index, tabsRouter),
              items: [
                ProBottomNavItem(icon: LucideIcons.mountain, label: l10n.navHome),
                ProBottomNavItem(
                  icon: LucideIcons.calendarCheck,
                  label: l10n.visitsMineTitle,
                ),
                ProBottomNavItem(icon: LucideIcons.wallet, label: l10n.navFinance),
                ProBottomNavItem(icon: LucideIcons.layoutGrid, label: l10n.navMenu),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSlotTapped(int index, TabsRouter tabsRouter) {
    // The menu is an overlay, not a destination — the active tab stays put.
    if (index == ProShellPage.menuSlot) {
      context.router.push(const ProMenuRoute());
      return;
    }

    if (tabsRouter.activeIndex == index) {
      tabsRouter.stackRouterOfIndex(index)?.popUntilRoot();
      return;
    }

    setState(() => _visitHistory.add(index));
    tabsRouter.setActiveIndex(index);
  }

  void _handleBack(TabsRouter tabsRouter) {
    // 1. Pop any screen stacked inside the active tab first.
    final tabStack = tabsRouter.stackRouterOfIndex(tabsRouter.activeIndex);
    if (tabStack != null && tabStack.canPop()) {
      tabStack.maybePop();
      return;
    }

    // 2. Otherwise walk back through the visited tabs.
    if (_visitHistory.length > 1) {
      setState(() {
        _visitHistory.removeLast();
        tabsRouter.setActiveIndex(_visitHistory.last);
      });
      return;
    }

    // 3. On the root tab, require a second press to leave the app.
    final now = DateTime.now();
    if (_lastBackPress == null ||
        now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
      _lastBackPress = now;
      final l10n = I18n.of(context);
      MboaToast.warning(
        context: context,
        title: l10n.exitAppTitle,
        description: l10n.exitAppBody,
      );
      return;
    }

    SystemNavigator.pop();
  }
}
