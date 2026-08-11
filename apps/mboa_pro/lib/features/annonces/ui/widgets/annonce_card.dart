import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/annonce.dart';
import '../../models/annonce_status.dart';
import '../../models/rental_period.dart';
import 'annonce_status_chip.dart';
import 'status_actions_menu.dart';

/// One listing on the Biens Uniques list.
///
/// The action row keeps the design's three slots, but Attributions and
/// Historique have no backend — they route to the coming-soon explainer rather
/// than being hidden, so the surface stays honest about what exists.
class AnnonceCard extends StatelessWidget {
  const AnnonceCard({
    super.key,
    required this.annonce,
    required this.onEdit,
    required this.onHistory,
    required this.onAttributions,
    required this.onTransition,
    required this.onDelete,
    required this.activeCount,
    this.onTap,
    this.isBusy = false,
  });

  final Annonce annonce;
  final VoidCallback onEdit;
  final VoidCallback onHistory;
  final VoidCallback onAttributions;
  final ValueChanged<AnnonceTransition> onTransition;
  final VoidCallback onDelete;

  /// Active listings across the portfolio, for the tier limit on publish.
  final int activeCount;
  final VoidCallback? onTap;

  /// A transition or delete is in flight for this listing specifically.
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Opacity(
      opacity: isBusy ? 0.6 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.spacing),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            InkWell(
              onTap: isBusy ? null : onTap,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacingMd),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Thumbnail(url: annonce.coverUrl),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(child: _Summary(annonce: annonce)),
                    StatusActionsMenu(
                      status: annonce.status,
                      photoCount: annonce.photoKeys.length,
                      activeCount: activeCount,
                      enabled: !isBusy,
                      onSelected: onTransition,
                      onDelete: onDelete,
                    ),
                  ],
                ),
              ),
            ),
            if (isBusy)
              const LinearProgressIndicator(minHeight: 2)
            else
              _Actions(
                onAttributions: onAttributions,
                onHistory: onHistory,
                onEdit: onEdit,
                historyLabel: l10n.annoncesActionHistory,
                editLabel: l10n.annoncesActionEdit,
                attributionsLabel: l10n.mesBiensAttributions,
              ),
          ],
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: SizedBox(
        width: 84,
        height: 84,
        child: url == null
            ? ColoredBox(
                color: colors.primaryPale,
                child: Icon(LucideIcons.image, color: colors.primary),
              )
            : Image.network(
                url!,
                fit: BoxFit.cover,
                // R2 may be unreachable offline; a broken listing card is worse
                // than a placeholder.
                errorBuilder: (context, error, stack) => ColoredBox(
                  color: colors.primaryPale,
                  child: Icon(LucideIcons.image, color: colors.primary),
                ),
              ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final facts = <String>[
      if (annonce.surfaceArea case final surface?)
        l10n.annoncesSurface('$surface'),
      if (annonce.roomCount case final rooms?) l10n.annoncesRooms(rooms),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: colors.primary),
            const SizedBox(width: Dimens.spacingXs),
            Expanded(
              child: Text(
                annonce.district ?? annonce.city ?? '',
                style: context.mboaText.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AnnonceStatusChip(status: annonce.status),
          ],
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          annonce.title,
          style: context.mboaText.h3,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (facts.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(
            facts.join(' – '),
            style: context.mboaText.caption
                .copyWith(color: colors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (annonce.displayPrice case final rent?) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(
            annonce.rentalPeriod.priceLabel(l10n, rent),
            style: context.mboaText.h3.copyWith(color: colors.primary),
          ),
        ],
      ],
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({
    required this.onAttributions,
    required this.onHistory,
    required this.onEdit,
    required this.attributionsLabel,
    required this.historyLabel,
    required this.editLabel,
  });

  final VoidCallback onAttributions;
  final VoidCallback onHistory;
  final VoidCallback onEdit;
  final String attributionsLabel;
  final String historyLabel;
  final String editLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ColoredBox(
      color: colors.primaryPale,
      child: Row(
        children: [
          _Action(
            icon: LucideIcons.keyRound,
            label: attributionsLabel,
            onTap: onAttributions,
          ),
          _Action(
            icon: LucideIcons.receiptText,
            label: historyLabel,
            onTap: onHistory,
          ),
          _Action(
            icon: LucideIcons.squarePen,
            label: editLabel,
            onTap: onEdit,
          ),
        ],
      ),
    );
  }
}

class _Action extends StatelessWidget {
  const _Action({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMd),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: Dimens.iconSm, color: colors.primary),
              const SizedBox(width: Dimens.spacingXs),
              Flexible(
                child: Text(
                  label,
                  style: context.mboaText.caption.copyWith(
                    color: colors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
