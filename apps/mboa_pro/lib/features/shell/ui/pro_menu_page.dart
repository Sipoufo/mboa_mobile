import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../profile/profile_types.dart';

/// Full-screen slide menu, pushed as a modal over the active tab.
///
/// Entries whose module isn't built yet route to [AccessRestrictedRoute] with
/// [AccessRestriction.comingSoon] rather than being hidden — the menu is the
/// product's map, so the surface stays visible and honest about its state.
@RoutePage()
class ProMenuPage extends StatelessWidget {
  const ProMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                tooltip: l10n.menuClose,
                icon: Icon(LucideIcons.x, color: colors.onBrand),
                onPressed: () => context.router.maybePop(),
              ),
            ),
            const _MenuHeader(),
            const SizedBox(height: Dimens.spacingLg),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacingXl,
                ),
                children: [
                  _MenuEntry(
                    icon: LucideIcons.mountain,
                    label: l10n.navHome,
                    isCurrent: true,
                    onTap: () => context.router.maybePop(),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.user,
                    label: l10n.menuProfile,
                    // The hub, not the edit form — it is the entry point to
                    // edit, certifications and password.
                    onTap: () => _go(context, const SettingsRoute()),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.bell,
                    label: l10n.menuNotifications,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.messageSquare,
                    label: l10n.menuMessages,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.users,
                    label: l10n.navManager,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.search,
                    label: l10n.menuSearch,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.compass,
                    label: l10n.menuExplore,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.wallet,
                    label: l10n.navFinance,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.bookmark,
                    label: l10n.menuBookmarks,
                    onTap: () => _comingSoon(context),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.settings,
                    label: l10n.settingsMenuTitle,
                    onTap: () => _go(context, const SettingsMenuRoute()),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.sparkles,
                    label: l10n.subscriptionTitle,
                    onTap: () => _go(context, const SubscriptionRoute()),
                  ),
                  _MenuEntry(
                    icon: LucideIcons.circleEllipsis,
                    label: l10n.menuOther,
                    onTap: () => _comingSoon(context),
                  ),
                ],
              ),
            ),
            const _QuitButton(),
            const SizedBox(height: Dimens.spacingLg),
          ],
        ),
      ),
    );
  }

  /// Closes the menu before navigating so the destination doesn't stack on top
  /// of the overlay.
  void _go(BuildContext context, PageRouteInfo route) {
    context.router
      ..maybePop()
      ..push(route);
  }

  void _comingSoon(BuildContext context) => _go(
        context,
        AccessRestrictedRoute(restriction: AccessRestriction.comingSoon),
      );
}

class _MenuHeader extends StatelessWidget {
  const _MenuHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<ProProfileBloc, ProfileState>(
      builder: (context, state) {
        final profile = state is ProProfileReady ? state.data : null;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingXl),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.menuGreeting,
                    style: context.mboaText.h3.copyWith(color: colors.onBrand),
                  ),
                  if (profile != null && profile.fullName.isNotEmpty)
                    Text(
                      profile.fullName,
                      style: context.mboaText.body.copyWith(
                        color: colors.onBrand.withValues(alpha: 0.8),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: Dimens.spacingMd),
              MboaAvatar(
                imageUrl: profile?.photoUrl,
                initials: profile?.initials,
                size: Dimens.avatar,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MenuEntry extends StatelessWidget {
  const _MenuEntry({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isCurrent = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    // The current entry reads at full strength; the rest sit back.
    final foreground =
        isCurrent ? colors.onBrand : colors.onBrand.withValues(alpha: 0.72);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMd),
        child: Row(
          children: [
            Icon(icon, size: Dimens.iconMd, color: foreground),
            const SizedBox(width: Dimens.spacing),
            Text(
              label,
              style: context.mboaText.bodyLarge.copyWith(
                color: foreground,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuitButton extends StatelessWidget {
  const _QuitButton();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Align(
      alignment: Alignment.centerRight,
      child: TextButton.icon(
        onPressed: () {
          // Close the overlay first; the root listener replaces the stack.
          context.router.maybePop();
          context.read<AuthBloc>().add(const AuthLogoutRequested());
        },
        iconAlignment: IconAlignment.end,
        icon: Icon(LucideIcons.logOut, color: colors.onBrand),
        label: Text(
          l10n.menuQuit,
          style: context.mboaText.bodyLarge.copyWith(color: colors.onBrand),
        ),
      ),
    );
  }
}
