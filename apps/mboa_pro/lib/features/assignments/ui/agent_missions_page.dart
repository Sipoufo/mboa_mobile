import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/agent_missions_bloc.dart';
import '../models/assignment.dart';

/// The agent's Missions tab (CDC M11, agent side).
///
/// Three segments in the order they matter: work waiting on the agent, work
/// they hold, and work they could ask for. Offers open first — a proposition
/// sitting unanswered is the only one that costs them anything.
@RoutePage()
class AgentMissionsPage extends StatelessWidget implements AutoRouteWrapper {
  const AgentMissionsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<AgentMissionsBloc>(
        create: (_) =>
            getIt<AgentMissionsBloc>()..add(const MissionsLoadRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentNavMissions)),
      body: BlocConsumer<AgentMissionsBloc, AgentMissionsState>(
        listenWhen: (prev, curr) =>
            curr is MissionsReady && curr.lastActionFailed,
        listener: (context, state) => MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.missionsActionFailed,
        ),
        builder: (context, state) => switch (state) {
          MissionsInitial() || MissionsLoadInProgress() =>
            const Center(child: Loader()),
          MissionsFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<AgentMissionsBloc>()
                    .add(const MissionsLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final MissionsReady ready => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacing),
                  child: MboaSegmentedControl<MissionFilter>(
                    value: ready.filter,
                    segments: [
                      MboaSegment(
                        value: MissionFilter.offers,
                        label: ready.offerCount == 0
                            ? l10n.missionsTabOffers
                            : '${l10n.missionsTabOffers} (${ready.offerCount})',
                      ),
                      MboaSegment(
                        value: MissionFilter.mine,
                        label: l10n.missionsTabMine,
                      ),
                      MboaSegment(
                        value: MissionFilter.opportunities,
                        label: l10n.missionsTabOpportunities,
                      ),
                    ],
                    onChanged: (filter) => context
                        .read<AgentMissionsBloc>()
                        .add(MissionsFilterChanged(filter)),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => context
                        .read<AgentMissionsBloc>()
                        .add(const MissionsRefreshRequested()),
                    child: _Segment(state: ready),
                  ),
                ),
              ],
            ),
        },
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.state});

  final MissionsReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return switch (state.filter) {
      MissionFilter.offers => _List(
          isEmpty: state.offers.isEmpty,
          emptyTitle: l10n.missionsEmptyOffers,
          children: [
            for (final offer in state.offers)
              _MissionCard(
                assignment: offer,
                isBusy: state.mutatingId == offer.id,
                actions: [
                  TextButton(
                    onPressed: () => context
                        .read<AgentMissionsBloc>()
                        .add(MissionDeclined(offer)),
                    child: Text(l10n.missionsDecline),
                  ),
                  TextButton(
                    onPressed: () => context
                        .read<AgentMissionsBloc>()
                        .add(MissionAccepted(offer)),
                    child: Text(l10n.missionsAccept),
                  ),
                ],
              ),
          ],
        ),
      MissionFilter.mine => _List(
          isEmpty: state.mine.isEmpty && state.pendingApplications.isEmpty,
          emptyTitle: l10n.missionsEmptyMine,
          children: [
            for (final mission in state.mine)
              _MissionCard(
                assignment: mission,
                isBusy: state.mutatingId == mission.id,
                actions: [
                  TextButton(
                    onPressed: () => _confirmResign(context, mission),
                    style: TextButton.styleFrom(
                      foregroundColor: context.mboaColors.error,
                    ),
                    child: Text(l10n.missionsResign),
                  ),
                ],
              ),
            // The agent's own applications live here rather than under
            // Opportunités: they are no longer something to apply for.
            for (final application in state.pendingApplications)
              _MissionCard(
                assignment: application,
                subtitle: l10n.missionsApplied,
                isBusy: state.mutatingId == application.id,
                actions: [
                  TextButton(
                    onPressed: () => context
                        .read<AgentMissionsBloc>()
                        .add(ApplicationWithdrawn(application)),
                    child: Text(l10n.missionsWithdraw),
                  ),
                ],
              ),
          ],
        ),
      MissionFilter.opportunities => _List(
          isEmpty: state.opportunities.isEmpty,
          emptyTitle: l10n.missionsEmptyOpportunities,
          // The cause is the agent's own zones (RM-M15-04), which they can fix.
          emptyBody: l10n.missionsEmptyOpportunitiesBody,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
              child: Text(
                l10n.missionsApplyNote,
                style: context.mboaText.caption
                    .copyWith(color: context.mboaColors.textSecondary),
              ),
            ),
            for (final opportunity in state.opportunities)
              _OpportunityCard(
                opportunity: opportunity,
                isBusy: state.mutatingId == opportunity.target.id,
              ),
          ],
        ),
    };
  }

  Future<void> _confirmResign(
    BuildContext context,
    Assignment assignment,
  ) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<AgentMissionsBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.missionsResign),
        content: Text(l10n.missionsResignConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: colors.error),
            child: Text(l10n.missionsResign),
          ),
        ],
      ),
    );

    if (confirmed ?? false) bloc.add(MissionResigned(assignment));
  }
}

class _List extends StatelessWidget {
  const _List({
    required this.isEmpty,
    required this.emptyTitle,
    required this.children,
    this.emptyBody,
  });

  final bool isEmpty;
  final String emptyTitle;
  final String? emptyBody;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        0,
        Dimens.spacing,
        Dimens.spacing3Xl,
      ),
      children: isEmpty
          ? [
              const SizedBox(height: Dimens.spacing3Xl),
              Text(
                emptyTitle,
                textAlign: TextAlign.center,
                style: context.mboaText.h3,
              ),
              if (emptyBody case final body?) ...[
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
              ],
            ]
          : children,
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({
    required this.assignment,
    required this.actions,
    this.subtitle,
    this.isBusy = false,
  });

  final Assignment assignment;
  final List<Widget> actions;
  final String? subtitle;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _Card(
      isBusy: isBusy,
      icon: assignment.target is ResidenceTarget
          ? LucideIcons.layers
          : LucideIcons.house,
      title: assignment.propertyTitle ?? '',
      subtitle: subtitle ??
          (assignment.unitCount == null
              ? null
              : l10n.missionsUnits(assignment.unitCount!)),
      actions: actions,
      accent: colors.primary,
    );
  }
}

class _OpportunityCard extends StatelessWidget {
  const _OpportunityCard({required this.opportunity, this.isBusy = false});

  final Opportunity opportunity;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _Card(
      isBusy: isBusy,
      icon: opportunity.isResidence ? LucideIcons.layers : LucideIcons.house,
      title: opportunity.title,
      subtitle: [
        ?(opportunity.district ?? opportunity.city),
        if (opportunity.unitCount case final count?)
          l10n.missionsUnits(count),
      ].join(' · '),
      accent: colors.primary,
      actions: [
        TextButton(
          onPressed: () => context
              .read<AgentMissionsBloc>()
              .add(OpportunityApplied(opportunity)),
          child: Text(l10n.missionsApply),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    required this.icon,
    required this.title,
    required this.actions,
    required this.accent,
    this.subtitle,
    this.isBusy = false,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Color accent;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Opacity(
      opacity: isBusy ? 0.5 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
        padding: const EdgeInsets.all(Dimens.spacing),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: Dimens.icon, color: accent),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.mboaText.label
                            .copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle case final subtitle?
                          when subtitle.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: context.mboaText.caption
                              .copyWith(color: colors.textSecondary),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isBusy)
                  const SizedBox(width: 20, height: 20, child: Loader())
                else
                  const SizedBox.shrink(),
              ],
            ),
            if (!isBusy)
              Row(mainAxisAlignment: MainAxisAlignment.end, children: actions),
          ],
        ),
      ),
    );
  }
}
