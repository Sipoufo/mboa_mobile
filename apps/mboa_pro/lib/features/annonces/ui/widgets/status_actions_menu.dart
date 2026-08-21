import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../profile/profile_types.dart';
import '../../../subscription/bloc/subscription_bloc.dart';
import '../../models/annonce_status.dart';
import '../../models/publish_gate.dart';

/// One entry in the menu: a lifecycle transition, or deletion.
class _MenuAction {
  const _MenuAction.of(this.transition);
  const _MenuAction.delete() : transition = null;

  final AnnonceTransition? transition;

  bool get isDelete => transition == null;

  @override
  bool operator ==(Object other) => other is _MenuAction && other.transition == transition;

  @override
  int get hashCode => transition.hashCode;
}

/// Lifecycle actions for a listing or a residence, from the list.
///
/// Only the transitions the current status allows are offered — an archived
/// item has none, a draft can only be published. Publishing runs [PublishGate]
/// first, so RM-M10-01 / RM-M10-02 / CE-M10-03 are enforced wherever it is
/// triggered, not just on the detail screen.
class StatusActionsMenu extends StatelessWidget {
  const StatusActionsMenu({
    super.key,
    required this.status,
    required this.photoCount,
    required this.activeCount,
    required this.onSelected,
    this.onDelete,
    this.enabled = true,
    this.isResidenceUnit = false,
  });

  final AnnonceStatus status;

  /// Residences have no single photo count; pass the minimum so the photo rule
  /// never blocks a bulk publish the backend will validate itself.
  final int photoCount;
  final int activeCount;
  final ValueChanged<AnnonceTransition> onSelected;

  /// RM-M10-07 — omitted where deletion doesn't apply (residences).
  final VoidCallback? onDelete;
  final bool enabled;

  /// A unit does not consume the active-listing quota: a residence's allowance
  /// is enforced when the residence is created (`RESIDENCE_UNIT_LIMIT`), so the
  /// tier limit must not be applied a second time here.
  final bool isResidenceUnit;

  static List<AnnonceTransition> transitionsFor(AnnonceStatus status) => switch (status) {
    AnnonceStatus.draft => [
      AnnonceTransition.publish,
      AnnonceTransition.archive,
    ],
    AnnonceStatus.published => [
      AnnonceTransition.reserve,
      AnnonceTransition.markRented,
      AnnonceTransition.archive,
    ],
    AnnonceStatus.reserved => [
      AnnonceTransition.markRented,
      AnnonceTransition.archive,
    ],
    AnnonceStatus.rented => [AnnonceTransition.archive],
    // Un-archiving returns the listing to DRAFT — publishing it again is a
    // second, separate step that re-checks the quota and the photo rule.
    AnnonceStatus.archived => [AnnonceTransition.unarchive],
    AnnonceStatus.unknown => const [],
  };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final transitions = transitionsFor(status);
    if (transitions.isEmpty && onDelete == null) return const SizedBox.shrink();

    return PopupMenuButton<_MenuAction>(
      enabled: enabled,
      tooltip: l10n.annoncesActionMore,
      icon: Icon(LucideIcons.ellipsisVertical, color: context.mboaColors.primary),
      onSelected: (action) {
        if (action.isDelete) {
          onDelete?.call();
          return;
        }
        final transition = action.transition!;
        if (transition == AnnonceTransition.publish && !_canPublish(context)) {
          return;
        }
        onSelected(transition);
      },
      itemBuilder: (context) => [
        for (final transition in transitions)
          PopupMenuItem(
            value: _MenuAction.of(transition),
            child: Text(
              switch (transition) {
                // Republishing an archived listing reads as "unarchive".
                AnnonceTransition.publish => l10n.annonceActionPublish,
                AnnonceTransition.reserve => l10n.annonceActionReserve,
                AnnonceTransition.markRented => l10n.annonceActionMarkRented,
                AnnonceTransition.archive => l10n.annonceActionArchive,
                AnnonceTransition.unarchive => l10n.annonceActionUnarchive,
              },
            ),
          ),
        if (onDelete != null) ...[
          const PopupMenuDivider(),
          PopupMenuItem(
            value: const _MenuAction.delete(),
            child: Text(
              l10n.annonceActionDelete,
              style: TextStyle(color: context.mboaColors.error),
            ),
          ),
        ],
      ],
    );
  }

  /// Explains the block rather than silently doing nothing.
  bool _canPublish(BuildContext context) {
    final l10n = I18n.of(context);
    const gate = PublishGate();

    final profileState = context.read<ProProfileBloc>().state;
    final profile = profileState is ProProfileReady ? profileState.data : null;
    final subscription = context.read<SubscriptionBloc>().state;
    final plan = subscription is SubscriptionReady ? subscription.plan : null;

    final decision = gate.check(
      // RM-M10-01 — the server's verdict, since it is what `publish` enforces.
      profileComplete: profile?.isProfileComplete ?? false,
      photoCount: photoCount,
      activeCount: activeCount,
      activeListingLimit: isResidenceUnit ? null : plan?.activeListingLimit,
    );

    if (decision.isAllowed) return true;

    final (title, body) = switch (decision.blocker!) {
      PublishBlocker.incompleteProfile => (
        l10n.publishBlockedProfileTitle,
        l10n.publishBlockedProfileBody,
      ),
      PublishBlocker.notEnoughPhotos => (
        l10n.publishBlockedPhotosTitle,
        l10n.publishBlockedPhotosBody(3),
      ),
      PublishBlocker.listingLimitReached => (
        l10n.publishBlockedLimitTitle,
        l10n.publishBlockedLimitBody(
          (gate.nextTier(subscription.tier) ?? SubscriptionTier.proPlus).label,
        ),
      ),
    };

    MboaToast.warning(context: context, title: title, description: body);
    return false;
  }
}
