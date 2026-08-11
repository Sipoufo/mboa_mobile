import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../annonces/bloc/annonces_bloc.dart';
import '../../../annonces/bloc/residences_bloc.dart';
import '../../../annonces/models/annonce.dart';
import '../../../annonces/models/residence.dart';
import '../../models/assignment.dart';

/// Choose the property an agent will be assigned to.
///
/// RM-M11-01 attaches an agent to a *bien*, so this comes first. Reads the two
/// session-scoped lists rather than fetching: whatever the prestataire has
/// already loaded is what they can assign.
Future<AssignmentTarget?> showPropertyPickerSheet(BuildContext context) {
  final l10n = I18n.of(context);
  final colors = context.mboaColors;

  // RM-M11-08 — only a published property can carry an agent, since the point
  // is a tenant scheduling a visit on it.
  final annonces = switch (context.read<AnnoncesBloc>().state) {
    AnnoncesReady(:final items) => items
        .where((a) => a.status.isActive && a.residenceId == null)
        .toList(),
    _ => const <Annonce>[],
  };
  final residences = switch (context.read<ResidencesBloc>().state) {
    ResidencesReady(:final items) =>
      items.where((r) => r.status.isActive).toList(),
    _ => const <Residence>[],
  };

  return showModalBottomSheet<AssignmentTarget>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (sheetContext) => SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(sheetContext).size.height * 0.7,
        ),
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.fromLTRB(
            Dimens.spacing,
            0,
            Dimens.spacing,
            Dimens.spacing,
          ),
          children: [
            Text(l10n.agentsPickPropertyTitle, style: context.mboaText.h3),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.agentsPickPropertyBody,
              style: context.mboaText.caption
                  .copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            if (annonces.isEmpty && residences.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.spacingLg),
                child: Text(
                  l10n.agentsPickPropertyEmpty,
                  textAlign: TextAlign.center,
                  style: context.mboaText.body
                      .copyWith(color: colors.textSecondary),
                ),
              ),
            for (final annonce in annonces)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(LucideIcons.house, color: colors.primary),
                title: Text(annonce.title),
                subtitle: Text(annonce.district ?? annonce.city ?? ''),
                onTap: () => Navigator.of(sheetContext)
                    .pop(AnnonceTarget(annonce.id)),
              ),
            for (final residence in residences)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(LucideIcons.layers, color: colors.primary),
                title: Text(residence.name),
                // A residence offer covers every free unit at once
                // (RM-M10bis-05), so the count is the useful context.
                subtitle: Text(
                  l10n.agentsUnitsCovered(residence.unitCount ?? 0),
                ),
                onTap: () => Navigator.of(sheetContext)
                    .pop(ResidenceTarget(residence.id)),
              ),
          ],
        ),
      ),
    ),
  );
}
