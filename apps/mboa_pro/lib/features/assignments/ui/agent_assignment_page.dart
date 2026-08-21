import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/property_agent_bloc.dart';
import '../models/assignment.dart';
import 'widgets/agent_candidate_sheet.dart';
import 'widgets/agent_row_tile.dart';

/// One property's **pool of agents** (CDC M11, revised 2026-08-13): who is on
/// it, who applied, and a button to add one more.
///
/// A property may carry several active agents (RM-M11-01); the client chooses
/// their visitor among them when booking (RM-M07-01). The candidate picker is
/// therefore always available, and never lists somebody already in the pool.
/// The server has already filtered candidates to active agents whose zones
/// cover this property (RM-M11-08) — nothing here re-decides eligibility.
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
        Text(l10n.agentsPoolTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.agentsPoolBody,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingXs),
        // RM-M11-10 is a flag on the listing, and the switch lives there —
        // one screen owns it, so the two cannot disagree.
        Text(
          l10n.agentsOwnerVisitsElsewhere,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
        const SizedBox(height: Dimens.spacingSm),

        if (state.pool.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
            child: Text(
              l10n.agentsPoolEmpty,
              style:
                  context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          )
        else
          for (final assignment in state.pool)
            AgentRowTile(
              name: assignment.agentName ?? '',
              initials: initialsFromFullName(assignment.agentName),
              photoUrl: assignment.agentPhotoUrl,
              subtitle: _subtitleFor(context, assignment),
              isBusy: state.mutatingId == assignment.agentAccountId,
              trailing: state.canWithdraw
                  ? TextButton(
                      onPressed: () => _confirmWithdraw(context, assignment),
                      child: Text(
                        l10n.agentsWithdraw,
                        style: TextStyle(color: colors.error),
                      ),
                    )
                  : null,
            ),

        // RM-M11-06 — the removal endpoint names no agent, so with a pool of
        // several the app cannot say which one would go. Saying so beats
        // sending a request whose effect nobody can predict.
        if (!state.canWithdraw) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(
            l10n.agentsWithdrawUnavailable,
            style:
                context.mboaText.caption.copyWith(color: colors.textTertiary),
          ),
        ],

        const SizedBox(height: Dimens.spacing),
        Button.secondary(
          title: l10n.agentsAddAgent,
          onPressed: () => _pickCandidate(context),
        ),
        const SizedBox(height: Dimens.spacingLg),

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
              initials: initialsFromFullName(application.agentName),
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
        ],
      ],
    );
  }

  /// What this row is: an agent at work, or an offer nobody has answered.
  String? _subtitleFor(BuildContext context, Assignment assignment) {
    final l10n = I18n.of(context);
    if (assignment.status == AssignmentStatus.pending) {
      return l10n.agentsAwaitingResponse;
    }
    final units = state.unitsCoveredBy(assignment);
    // A standalone listing is one unit and says nothing; a residence says how
    // much of itself this agent covers.
    return units > 1 ? l10n.agentsUnitsCovered(units) : null;
  }

  Future<void> _pickCandidate(BuildContext context) async {
    final bloc = context.read<PropertyAgentBloc>();

    final candidate = await showAgentCandidateSheet(
      context,
      candidates: state.offerableCandidates,
    );
    if (candidate == null || !context.mounted) return;
    await _confirmOffer(context, candidate, bloc: bloc);
  }

  Future<void> _confirmOffer(
    BuildContext context,
    AgentCandidateView candidate, {
    required PropertyAgentBloc bloc,
  }) async {
    final l10n = I18n.of(context);

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

