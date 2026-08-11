import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/property_agent_bloc.dart';
import '../models/assignment.dart';
import 'widgets/agent_row_tile.dart';

/// One property's agent (CDC M11): who holds it, who applied, and the
/// alphabetical list of who could.
///
/// The candidate list is the Annuaire design — the server has already filtered
/// it to active agents whose zones cover this property (RM-M11-08), so the
/// screen shows what it is given rather than re-deciding eligibility.
@RoutePage()
class AgentAssignmentPage extends StatelessWidget implements AutoRouteWrapper {
  const AgentAssignmentPage({super.key, required this.target});

  final AssignmentTarget target;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<PropertyAgentBloc>(
        create: (_) => getIt<PropertyAgentBloc>()
          ..add(PropertyAgentLoadRequested(target)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentsAssignTitle)),
      body: BlocConsumer<PropertyAgentBloc, PropertyAgentState>(
        listenWhen: (prev, curr) =>
            curr is PropertyAgentReady &&
            (curr.lastActionFailed || curr.lastOutcome != null),
        listener: (context, state) {
          final ready = state as PropertyAgentReady;
          if (ready.lastActionFailed) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.agentsActionFailed,
            );
            return;
          }
          final outcome = ready.lastOutcome;
          if (outcome == null) return;
          // RM-M10bis-06 — say which units were left out rather than implying
          // the whole residence was offered.
          if (outcome.hasSkipped) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.agentsOfferSkipped(outcome.skipped.length),
            );
          }
        },
        builder: (context, state) => switch (state) {
          PropertyAgentInitial() || PropertyAgentLoadInProgress() =>
            const Center(child: Loader()),
          PropertyAgentFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<PropertyAgentBloc>()
                    .add(PropertyAgentLoadRequested(target)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final PropertyAgentReady ready => _Body(state: ready),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final PropertyAgentReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListView(
      padding: const EdgeInsets.all(Dimens.spacing),
      children: [
        if (state.live case final live?) ...[
          Text(l10n.agentsCurrentTitle, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacingSm),
          AgentRowTile(
            name: live.agentName ?? '',
            subtitle: live.unitCount == null
                ? null
                : l10n.agentsUnitsCovered(live.unitCount!),
            isBusy: state.mutatingId == live.agentAccountId,
            trailing: TextButton(
              onPressed: () => _confirmWithdraw(context, live),
              child: Text(
                l10n.agentsWithdraw,
                style: TextStyle(color: colors.error),
              ),
            ),
          ),
          const SizedBox(height: Dimens.spacingLg),
        ] else if (state.awaitingAgent case final pending?) ...[
          AgentRowTile(
            name: pending.agentName ?? '',
            subtitle: l10n.agentsAwaitingResponse,
            isBusy: state.mutatingId == pending.agentAccountId,
            trailing: TextButton(
              onPressed: () => _confirmWithdraw(context, pending),
              child: Text(
                l10n.agentsWithdraw,
                style: TextStyle(color: colors.error),
              ),
            ),
          ),
          const SizedBox(height: Dimens.spacingLg),
        ],

        if (state.applications.isNotEmpty) ...[
          Text(l10n.agentsApplicationsTitle, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            l10n.agentsAcceptWarning,
            style:
                context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: Dimens.spacingSm),
          for (final application in state.applications)
            AgentRowTile(
              name: application.agentName ?? '',
              subtitle:
                  l10n.agentsVisitCount(application.completedVisitCount),
              photoUrl: application.photoUrl,
              isBusy: state.mutatingId == application.agentAccountId,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () => context
                        .read<PropertyAgentBloc>()
                        .add(ApplicationDeclined(application)),
                    child: Text(l10n.agentsApplicationDecline),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<PropertyAgentBloc>()
                        .add(ApplicationAccepted(application)),
                    child: Text(l10n.agentsApplicationAccept),
                  ),
                ],
              ),
            ),
          const SizedBox(height: Dimens.spacingLg),
        ],

        // RM-M11-01 — one active agent per property, so the picker disappears
        // while somebody holds it or is being waited on.
        if (state.canOffer) ..._candidateSection(context),
      ],
    );
  }

  List<Widget> _candidateSection(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    if (state.candidates.isEmpty) {
      return [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.spacingLg),
          child: Text(
            l10n.agentsAssignEmpty,
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
        ),
      ];
    }

    final widgets = <Widget>[];
    String? letter;
    for (final candidate in state.candidates) {
      final initial =
          candidate.sortKey.isEmpty ? '#' : candidate.sortKey[0];
      if (initial != letter) {
        letter = initial;
        widgets.add(AgentSectionHeader(letter: initial));
      }
      widgets.add(
        AgentRowTile(
          name: candidate.fullName,
          subtitle: l10n.agentsVisitCount(candidate.completedVisitCount),
          photoUrl: candidate.photoUrl,
          initials: candidate.initials,
          isBusy: state.mutatingId == candidate.accountId,
          onTap: () => _confirmOffer(context, candidate),
          trailing: Icon(LucideIcons.chevronRight, color: colors.textTertiary),
        ),
      );
    }
    return widgets;
  }

  Future<void> _confirmOffer(
    BuildContext context,
    AgentCandidateView candidate,
  ) async {
    final l10n = I18n.of(context);
    final bloc = context.read<PropertyAgentBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.agentsAssignConfirmTitle(candidate.fullName)),
        content: Text(l10n.agentsAssignConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.agentsAssignAction),
          ),
        ],
      ),
    );

    if (confirmed ?? false) bloc.add(AgentOffered(candidate.accountId));
  }

  Future<void> _confirmWithdraw(
    BuildContext context,
    Assignment assignment,
  ) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<PropertyAgentBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.agentsWithdraw),
        // RM-M11-06 — planned visits are cancelled, so this is not reversible
        // for the tenants who booked them.
        content: Text(l10n.agentsWithdrawConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(l10n.agentsWithdraw),
          ),
        ],
      ),
    );

    if (confirmed ?? false) bloc.add(AssignmentWithdrawn(assignment));
  }
}
