import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../bloc/my_visits_bloc.dart';
import '../../models/visit_rules.dart';

/// One visit, with whatever it is the tenant's turn to do.
///
/// The actions are on the card rather than behind a detail screen: there are
/// at most two of them, and "I'm here" is tapped standing in front of a gate.
class VisitCard extends StatelessWidget {
  const VisitCard({
    super.key,
    required this.visit,
    this.isBusy = false,
    this.isRated = false,
    this.onTap,
  });

  final Visit visit;
  final bool isBusy;
  final bool isRated;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        boxShadow: MboaShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      visit.annonceTitle ?? '',
                      style: context.mboaText.h3.copyWith(color: colors.ink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _StatusChip(status: visit.status),
                ],
              ),
              if (visit.scheduledAt case final at?) ...[
                const SizedBox(height: Dimens.spacingXs),
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 14,
                      color: colors.textTertiary,
                    ),
                    const SizedBox(width: Dimens.spacingXs),
                    Text(
                      DateFormat.MMMEd(locale).add_Hm().format(at),
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: Dimens.spacingXs),
              Text(
                visit.visitorKind == VisitorKind.owner ? l10n.visitVisitorOwner : l10n.visitVisitorAgent,
                style: context.mboaText.caption.copyWith(color: colors.textTertiary),
              ),
              VisitActions(visit: visit, isBusy: isBusy, isRated: isRated),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final VisitStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, colour) = switch (status) {
      VisitStatus.requested => (l10n.visitStatusRequested, colors.warning),
      VisitStatus.scheduled => (l10n.visitStatusScheduled, colors.success),
      VisitStatus.completed => (l10n.visitStatusCompleted, colors.primary),
      VisitStatus.cancelled => (l10n.visitStatusCancelled, colors.error),
      // RM-M07-05 — nobody confirmed. Not the tenant's fault and not the
      // visitor's, so it is stated rather than blamed.
      VisitStatus.notFulfilled || VisitStatus.unknown => (l10n.visitStatusNotFulfilled, colors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingSm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: colour.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Text(
        label,
        style: context.mboaText.caption.copyWith(color: colour),
      ),
    );
  }
}

/// Whatever it is the tenant's turn to do — often nothing.
///
/// Public because the card and the detail screen offer the same actions, and
/// two copies of "can this still be cancelled" is one copy too many.
class VisitActions extends StatelessWidget {
  const VisitActions({
    super.key,
    required this.visit,
    this.isBusy = false,
    this.isRated = false,
  });

  final Visit visit;
  final bool isBusy;
  final bool isRated;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<MyVisitsBloc>();

    if (VisitRules.isWaitingForVisitor(visit)) {
      return _Note(icon: LucideIcons.clock, text: l10n.visitWaitingVisitor);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (VisitRules.canConfirmPresence(visit)) ...[
          const SizedBox(height: Dimens.spacingMd),
          Button.primary(
            title: l10n.visitConfirmPresence,
            isLoading: isBusy,
            onPressed: () => bloc.add(VisitPresenceConfirmed(visit.id)),
          ),
        ],
        if (VisitRules.canCancel(visit)) ...[
          const SizedBox(height: Dimens.spacingSm),
          TextButton(
            onPressed: isBusy ? null : () => _confirmCancel(context, bloc, l10n),
            child: Text(
              l10n.visitCancel,
              style: context.mboaText.label.copyWith(color: colors.error),
            ),
          ),
        ] else if (VisitRules.isTooLateToCancel(visit)) ...[
          const SizedBox(height: Dimens.spacingSm),
          // CE-M07-03 — the visitor may already be on their way, so the screen
          // says to reach them rather than offering a button that is refused.
          _Note(icon: LucideIcons.info, text: l10n.visitCancelTooLate),
        ],
        // M07bis — the report on the property. Offered before the rating
        // because it is the one that feeds the property's note (RG-06); the
        // stars below rate the visitor's service, which is a different thing.
        if (VisitRules.canWriteReview(visit)) ...[
          const SizedBox(height: Dimens.spacingMd),
          Button.outline(
            title: l10n.reviewWriteCta,
            onPressed: () => context.router.root.push(
              AuthenticatedRouter(children: [WriteReviewRoute(visitId: visit.id)]),
            ),
          ),
        ],
        if (VisitRules.canRateVisitor(visit)) ...[
          const SizedBox(height: Dimens.spacingMd),
          if (isRated)
            _Note(icon: LucideIcons.check, text: l10n.visitRateDone)
          else
            _Rating(
              onRate: (rating) => bloc.add(VisitorRated(visitId: visit.id, rating: rating)),
            ),
        ],
      ],
    );
  }

  Future<void> _confirmCancel(
    BuildContext context,
    MyVisitsBloc bloc,
    I18n l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.visitCancel),
        content: Text(visit.annonceTitle ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.commonNo),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.commonYes),
          ),
        ],
      ),
    );
    if (confirmed ?? false) bloc.add(VisitCancelled(visit.id));
  }
}

/// RM-M07-07 — the visitor's service, 1 to 5, optional.
class _Rating extends StatelessWidget {
  const _Rating({required this.onRate});

  final ValueChanged<int> onRate;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.visitRateTitle,
          style: context.mboaText.label.copyWith(color: colors.ink),
        ),
        Text(
          // The distinction matters: the property's own review is M07bis.
          l10n.visitRateBody,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        Row(
          children: [
            for (var star = 1; star <= 5; star++)
              IconButton(
                onPressed: () => onRate(star),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                icon: Icon(
                  LucideIcons.star,
                  color: colors.warning,
                  size: Dimens.iconMd,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(top: Dimens.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: Dimens.iconSm, color: colors.textTertiary),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              text,
              style: context.mboaText.caption.copyWith(color: colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
