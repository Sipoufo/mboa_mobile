import 'package:flutter/material.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../models/assignment.dart';
import 'agent_row_tile.dart';

/// Pick one more agent for a property's pool (RM-M11-01).
///
/// Takes the candidates it is given: the server has already filtered them to
/// active agents whose zones cover the property (RM-M11-08), and the caller has
/// already dropped everyone in the pool — offering the same agent twice is a
/// 409. Nothing here re-decides eligibility.
Future<AgentCandidateView?> showAgentCandidateSheet(
  BuildContext context, {
  required List<AgentCandidateView> candidates,
}) {
  final colors = context.mboaColors;

  return showModalBottomSheet<AgentCandidateView>(
    context: context,
    backgroundColor: colors.surface,
    isScrollControlled: true,
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusLg)),
    ),
    builder: (_) => _AgentCandidateSheet(candidates: candidates),
  );
}

class _AgentCandidateSheet extends StatelessWidget {
  const _AgentCandidateSheet({required this.candidates});

  final List<AgentCandidateView> candidates;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.8,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.agentsAddAgent, style: context.mboaText.h3),
              const SizedBox(height: Dimens.spacingXs),
              Text(
                l10n.agentsAddAgentBody,
                style: context.mboaText.caption
                    .copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacingSm),
              if (candidates.isEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: Dimens.spacingLg),
                  child: Text(
                    l10n.agentsAssignEmpty,
                    style: context.mboaText.body
                        .copyWith(color: colors.textSecondary),
                  ),
                )
              else
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: _rows(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Alphabetical, with the Annuaire's letter headers.
  List<Widget> _rows(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final widgets = <Widget>[];
    String? letter;
    for (final candidate in candidates) {
      final initial = candidate.sortKey.isEmpty ? '#' : candidate.sortKey[0];
      if (initial != letter) {
        letter = initial;
        widgets.add(AgentSectionHeader(letter: initial));
      }
      widgets.add(
        AgentRowTile(
          name: candidate.fullName,
          // Rating is optional (RM-M07-07), so an unrated agent shows their
          // visit count rather than "0 ★".
          subtitle: candidate.hasRating
              ? '${candidate.averageRating!.toStringAsFixed(1)} ★ · '
                  '${l10n.agentsVisitCount(candidate.completedVisitCount)}'
              : l10n.agentsVisitCount(candidate.completedVisitCount),
          photoUrl: candidate.photoUrl,
          initials: candidate.initials,
          onTap: () => Navigator.of(context).pop(candidate),
          trailing: Icon(Icons.chevron_right, color: colors.textTertiary),
        ),
      );
    }
    return widgets;
  }
}
