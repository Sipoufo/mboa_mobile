import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/annonce_status.dart';

/// Status pill on a listing card.
///
/// Drafts get the action colour rather than the neutral one — a draft is the
/// one status that needs the prestataire to do something, and they sit in the
/// Disponibles tab alongside published listings.
class AnnonceStatusChip extends StatelessWidget {
  const AnnonceStatusChip({super.key, required this.status});

  final AnnonceStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, background, foreground) = switch (status) {
      AnnonceStatus.draft => (
          l10n.annonceStatusDraft,
          colors.actionPale,
          colors.actionDark,
        ),
      AnnonceStatus.published => (
          l10n.annonceStatusPublished,
          colors.border,
          colors.textSecondary,
        ),
      AnnonceStatus.reserved => (
          l10n.annonceStatusReserved,
          colors.primaryPale,
          colors.primary,
        ),
      AnnonceStatus.rented => (
          l10n.annonceStatusRented,
          colors.primaryPale,
          colors.primaryDark,
        ),
      AnnonceStatus.archived || AnnonceStatus.unknown => (
          l10n.annonceStatusArchived,
          colors.border,
          colors.textTertiary,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingMd,
        vertical: Dimens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Text(
        label,
        style: context.mboaText.caption.copyWith(color: foreground),
      ),
    );
  }
}
