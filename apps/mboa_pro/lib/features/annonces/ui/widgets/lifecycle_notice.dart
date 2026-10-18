import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../bloc/annonces_bloc.dart';
import '../../models/annonce.dart';
import '../../models/annonce_status.dart';

/// What a listing's place in the Free-tier lifecycle asks of the prestataire,
/// if anything (RM-M10-04).
///
/// Three cases, each with its own way forward: an expired listing is
/// republished for another 30 days, one archived over a lapsed plan's limit
/// needs room or a plan, and a live one shows how long it has left. An
/// archive the prestataire made himself needs no explaining.
enum LifecycleNoticeKind { expired, planLimit, expiring }

class LifecycleNotice {
  const LifecycleNotice._(this.kind, [this.days = 0]);

  /// N-10 is sent five days ahead; the screen turns urgent at the same point.
  static const urgentDays = 5;

  final LifecycleNoticeKind kind;

  /// Days left, for [LifecycleNoticeKind.expiring] only.
  final int days;

  bool get isUrgent => kind != LifecycleNoticeKind.expiring || days <= urgentDays;

  static LifecycleNotice? of(Annonce annonce, {DateTime? now}) {
    if (annonce.status == AnnonceStatus.archived) {
      return switch (annonce.archivedReason) {
        ArchivedReason.expired => const LifecycleNotice._(LifecycleNoticeKind.expired),
        ArchivedReason.planLimit => const LifecycleNotice._(LifecycleNoticeKind.planLimit),
        ArchivedReason.owner || ArchivedReason.unknown || null => null,
      };
    }
    return switch (annonce.daysUntilExpiry(now: now)) {
      final days? => LifecycleNotice._(LifecycleNoticeKind.expiring, days),
      null => null,
    };
  }
}

/// The notice on the listing's detail, with the action that resolves it.
class LifecycleNoticeCard extends StatelessWidget {
  const LifecycleNoticeCard({
    super.key,
    required this.notice,
    required this.annonceId,
    this.isBusy = false,
  });

  final LifecycleNotice notice;
  final String annonceId;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final tone = notice.isUrgent ? colors.warning : colors.primary;

    final (title, body) = switch (notice.kind) {
      LifecycleNoticeKind.expired => (l10n.annonceExpiredTitle, l10n.annonceExpiredBody),
      LifecycleNoticeKind.planLimit => (l10n.annoncePlanLimitTitle, l10n.annoncePlanLimitBody),
      LifecycleNoticeKind.expiring => (l10n.annonceExpiresIn(notice.days), l10n.annonceExpiresBody),
    };

    final action = switch (notice.kind) {
      // Unarchiving returns it to draft; publishing again is the menu's own
      // step, which re-checks the quota and the photo rule.
      LifecycleNoticeKind.expired => Button.outline(
        title: l10n.annonceActionUnarchive,
        isLoading: isBusy,
        onPressed: () => context.read<AnnoncesBloc>().add(
          AnnonceStatusChangeRequested(annonceId, AnnonceTransition.unarchive),
        ),
      ),
      LifecycleNoticeKind.planLimit => Button.outline(
        title: l10n.annonceSeePlans,
        onPressed: () => context.router.push(const SubscriptionRoute()),
      ),
      // A paid tier lifts the deadline (RG-02) — worth saying once it is near.
      LifecycleNoticeKind.expiring when notice.isUrgent => Button.outline(
        title: l10n.annonceSeePlans,
        onPressed: () => context.router.push(const SubscriptionRoute()),
      ),
      LifecycleNoticeKind.expiring => null,
    };

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        border: Border.all(color: tone.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(LucideIcons.clock, size: Dimens.iconSm, color: tone),
              const SizedBox(width: Dimens.spacingSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: context.mboaText.label.copyWith(color: colors.ink)),
                    const SizedBox(height: Dimens.spacingXs),
                    Text(body, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
          if (action != null) ...[
            const SizedBox(height: Dimens.spacingMd),
            action,
          ],
        ],
      ),
    );
  }
}

/// The same notice, one line long, for the listing's card.
class LifecycleNoticeLine extends StatelessWidget {
  const LifecycleNoticeLine({super.key, required this.notice});

  final LifecycleNotice notice;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final tone = notice.isUrgent ? colors.warning : colors.textSecondary;

    final label = switch (notice.kind) {
      LifecycleNoticeKind.expired => l10n.annonceCardExpired,
      LifecycleNoticeKind.planLimit => l10n.annonceCardPlanLimit,
      LifecycleNoticeKind.expiring => l10n.annonceExpiresIn(notice.days),
    };

    return Row(
      children: [
        Icon(LucideIcons.clock, size: 12, color: tone),
        const SizedBox(width: Dimens.spacingXs),
        Flexible(
          child: Text(
            label,
            style: context.mboaText.caption.copyWith(color: tone),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
