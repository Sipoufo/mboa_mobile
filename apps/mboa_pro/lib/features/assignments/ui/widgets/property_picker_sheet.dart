import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../annonces/bloc/annonces_bloc.dart';
import '../../../annonces/bloc/residences_bloc.dart';
import '../../../annonces/models/annonce.dart';
import '../../../annonces/models/annonce_status.dart';
import '../../../annonces/models/residence.dart';
import '../../models/assignment.dart';

/// Choose the property an agent will be assigned to (RM-M11-01 attaches an
/// agent to a *bien*, so this comes first).
Future<AssignmentTarget?> showPropertyPickerSheet(BuildContext context) {
  final colors = context.mboaColors;
  // The sheet is a route on some Navigator, and which one decides whether the
  // session blocs sit above it. Handing them over explicitly makes that
  // irrelevant rather than load-bearing.
  final annonces = context.read<AnnoncesBloc>();
  final residences = context.read<ResidencesBloc>();

  return showModalBottomSheet<AssignmentTarget>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (sheetContext) => MultiBlocProvider(
      providers: [
        BlocProvider<AnnoncesBloc>.value(value: annonces),
        BlocProvider<ResidencesBloc>.value(value: residences),
      ],
      child: const _PropertyPickerSheet(),
    ),
  );
}

/// Loads its own data.
///
/// `AnnoncesBloc` and `ResidencesBloc` are session-scoped but **not loaded at
/// session start** — the list screens fetch on open. A prestataire who came
/// straight here from the home dashboard therefore had both blocs sitting in
/// their initial state and saw an empty or half-empty sheet.
class _PropertyPickerSheet extends StatefulWidget {
  const _PropertyPickerSheet();

  @override
  State<_PropertyPickerSheet> createState() => _PropertyPickerSheetState();
}

class _PropertyPickerSheetState extends State<_PropertyPickerSheet> {
  @override
  void initState() {
    super.initState();
    // Cheap when the lists are already loaded; the only way to be right when
    // they are not.
    context.read<AnnoncesBloc>().add(const AnnoncesLoadRequested());
    context.read<ResidencesBloc>().add(const ResidencesLoadRequested());
  }

  /// Only a **published** listing may take an agent: the backend refuses
  /// anything else with `ANNONCE_NOT_PUBLISHED`. `status.isActive` also covers
  /// `reserved`, which would have offered rows the server then rejected.
  List<Annonce> _assignable(AnnoncesState state) => switch (state) {
        AnnoncesReady(:final standalone) => standalone
            .where((a) => a.status == AnnonceStatus.published)
            .toList(),
        _ => const [],
      };

  /// A residence needs **one published unit**, not a published aggregate status
  /// — the backend's rule is `NO_PUBLISHED_UNITS`. A residence still marked
  /// draft overall can have units live.
  List<Residence> _assignableResidences(ResidencesState state) =>
      switch (state) {
        ResidencesReady(:final items) =>
          items.where((r) => (r.publishedUnitCount ?? 0) > 0).toList(),
        _ => const [],
      };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<AnnoncesBloc, AnnoncesState>(
      builder: (context, annoncesState) =>
          BlocBuilder<ResidencesBloc, ResidencesState>(
        builder: (context, residencesState) {
          // Either list still arriving: wait rather than show a partial answer
          // the prestataire would read as "that's everything".
          final loading = annoncesState is! AnnoncesReady ||
              residencesState is! ResidencesReady;

          final annonces = _assignable(annoncesState);
          final residences = _assignableResidences(residencesState);

          return SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                  Text(
                    l10n.agentsPickPropertyTitle,
                    style: context.mboaText.h3,
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    l10n.agentsPickPropertyBody,
                    style: context.mboaText.caption
                        .copyWith(color: colors.textSecondary),
                  ),
                  const SizedBox(height: Dimens.spacing),
                  if (loading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimens.spacingLg),
                      child: Center(child: Loader()),
                    )
                  else if (annonces.isEmpty && residences.isEmpty)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: Dimens.spacingLg),
                      child: Column(
                        children: [
                          Text(
                            l10n.agentsPickPropertyNone,
                            textAlign: TextAlign.center,
                            style: context.mboaText.label,
                          ),
                          const SizedBox(height: Dimens.spacingXs),
                          // Says what to do about it, rather than leaving the
                          // prestataire to guess why their biens are missing.
                          Text(
                            l10n.agentsPickPropertyNoneBody,
                            textAlign: TextAlign.center,
                            style: context.mboaText.caption
                                .copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ),
                    )
                  else ...[
                    for (final annonce in annonces)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(LucideIcons.house, color: colors.primary),
                        title: Text(annonce.title),
                        subtitle: Text(annonce.district ?? annonce.city ?? ''),
                        onTap: () => Navigator.of(context)
                            .pop(AnnonceTarget(annonce.id)),
                      ),
                    for (final residence in residences)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(LucideIcons.layers, color: colors.primary),
                        title: Text(residence.name),
                        // A residence offer covers every free published unit at
                        // once (RM-M10bis-05).
                        subtitle: Text(
                          l10n.agentsUnitsCovered(
                            residence.publishedUnitCount ?? 0,
                          ),
                        ),
                        onTap: () => Navigator.of(context)
                            .pop(ResidenceTarget(residence.id)),
                      ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
