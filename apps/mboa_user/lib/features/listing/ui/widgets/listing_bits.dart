import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// A white block with a dark-green heading — the shape every section on a
/// fiche takes, as on the pro app's détail screens.
class ListingSection extends StatelessWidget {
  const ListingSection({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
          const SizedBox(height: Dimens.spacing),
          child,
        ],
      ),
    );
  }
}

/// One trust badge (CDC M05).
///
/// Drawn from the enum, in prestige order (RM-M05-03) — the server sends the
/// values unordered and has never promised otherwise.
class TrustBadgeChip extends StatelessWidget {
  const TrustBadgeChip({super.key, required this.badge});

  final TrustBadge badge;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, icon) = switch (badge) {
      TrustBadge.trustedProvider => (l10n.badgeTrustedProvider, LucideIcons.award),
      TrustBadge.recertified => (l10n.badgeRecertified, LucideIcons.refreshCw),
      TrustBadge.verifiedIdentity =>
        (l10n.badgeVerifiedIdentity, LucideIcons.badgeCheck),
      TrustBadge.verifiedPhotos => (l10n.badgeVerifiedPhotos, LucideIcons.camera),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingMd,
        vertical: Dimens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: colors.primaryPale,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Dimens.iconSm, color: colors.primaryDark),
          const SizedBox(width: Dimens.spacingXs),
          Text(
            label,
            style: context.mboaText.caption.copyWith(color: colors.primaryDark),
          ),
        ],
      ),
    );
  }
}

/// A label/value row, as the pro app's Caractéristiques card draws them.
class FactRow extends StatelessWidget {
  const FactRow({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                label,
                style: context.mboaText.body
                    .copyWith(color: context.mboaColors.textSecondary),
              ),
            ),
            Text(
              value,
              style: context.mboaText.label
                  .copyWith(color: context.mboaColors.ink),
            ),
          ],
        ),
      );
}

/// The name of a prestataire's kind, for the fiche's provider block.
String prestataireKindLabel(I18n l10n, PrestataireKind kind) => switch (kind) {
      PrestataireKind.particulier => l10n.prestataireKindParticulier,
      PrestataireKind.agence => l10n.prestataireKindAgence,
      PrestataireKind.promoteur => l10n.prestataireKindPromoteur,
    };
