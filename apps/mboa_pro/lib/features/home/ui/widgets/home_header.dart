import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../profile/profile_types.dart';

/// Pro home header: notification/message affordances, the menu trigger, the
/// current location, and the greeting.
///
/// Binds to the session-scoped `ProProfileBloc` from `AuthenticatedWrapper`, so
/// it costs no extra `/me` call.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<ProProfileBloc, ProfileState>(
          builder: (context, state) {
            final profile = state is ProProfileReady ? state.data : null;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         l10n.homeLocationLabel,
                //         style: context.mboaText.label,
                //       ),
                //       const SizedBox(height: Dimens.spacingXs),
                //       Row(
                //         children: [
                //           Icon(
                //             LucideIcons.mapPin,
                //             size: Dimens.iconSm,
                //             color: colors.primary,
                //           ),
                //           const SizedBox(width: Dimens.spacingXs),
                //           Flexible(
                //             child: Text(
                //               profile?.mainCity ??
                //                   profile?.searchCity ??
                //                   l10n.homeLocationEmpty,
                //               style: context.mboaText.caption
                //                   .copyWith(color: colors.textSecondary),
                //               maxLines: 1,
                //               overflow: TextOverflow.ellipsis,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Column(
                    children: [
                      // One line that gives way: a long name ends in an
                      // ellipsis rather than pushing the icons off a small
                      // phone.
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            l10n.menuGreeting,
                            style: context.mboaText.h3
                                .copyWith(color: colors.primary),
                          ),
                          if (profile != null && profile.fullName.isNotEmpty)
                            Flexible(
                              child: Text(
                                profile.displayName ?? profile.fullName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: profile.displayName != null ? context.mboaText.h3
                                    .copyWith(color: colors.primary) : context.mboaText.caption
                                    .copyWith(color: colors.textSecondary),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: Dimens.spacingXs),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            size: Dimens.iconSm,
                            color: colors.primary,
                          ),
                          const SizedBox(width: Dimens.spacingXs),
                          // Label and city as one line, so the pair gives way
                          // together on a small phone.
                          Flexible(
                            child: Text(
                              '${l10n.homeLocationLabel} ${profile?.mainCity ?? profile?.searchCity ?? l10n.homeLocationEmpty}',
                              style: context.mboaText.caption
                                  .copyWith(color: colors.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // §38 — the page, and how many are unread.
                if (getIt.isRegistered<InboxBloc>())
                  NotificationBell(
                    bloc: getIt<InboxBloc>(),
                    onPressed: () => context.router.push(const NotificationsRoute()),
                    builder: (context, icon, onPressed) => IconButton(
                      tooltip: l10n.menuNotifications,
                      onPressed: onPressed,
                      visualDensity: VisualDensity.compact,
                      icon: icon,
                    ),
                  ),
                const SizedBox(width: Dimens.spacingSm),
                _HeaderIcon(
                  icon: LucideIcons.messageSquare,
                  tooltip: l10n.menuMessages,
                  // M12 — the inbox, the one the menu opens too.
                  onPressed: () => context.router.push(const MessagesRoute()),
                ),
                const SizedBox(width: Dimens.spacingSm),
                MboaAvatar(
                  imageUrl: profile?.avatarUrl,
                  initials: profile?.initials,
                  size: Dimens.avatar,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, color: context.mboaColors.primary),
    );
  }
}
