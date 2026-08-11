import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/agent_visits_bloc.dart';
import '../models/agent_visit.dart';

/// The agent's visits (CDC M16).
///
/// Opens on **today**: an agent looks at this to find out where they are going
/// now. A visit earlier today stays here rather than sliding into Passées —
/// 08:00 is still today's work at 09:00.
@RoutePage()
class AgentVisitsPage extends StatelessWidget implements AutoRouteWrapper {
  const AgentVisitsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<AgentVisitsBloc>(
        create: (_) =>
            getIt<AgentVisitsBloc>()..add(const VisitsLoadRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentNavVisits)),
      body: BlocConsumer<AgentVisitsBloc, AgentVisitsState>(
        listenWhen: (prev, curr) => curr is VisitsReady && curr.lastActionFailed,
        listener: (context, state) => MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.visitsActionFailed,
        ),
        builder: (context, state) => switch (state) {
          VisitsInitial() || VisitsLoadInProgress() =>
            const Center(child: Loader()),
          VisitsFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<AgentVisitsBloc>()
                    .add(const VisitsLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final VisitsReady ready => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimens.spacing),
                  child: MboaSegmentedControl<VisitFilter>(
                    value: ready.filter,
                    segments: [
                      MboaSegment(
                        value: VisitFilter.today,
                        label: ready.todayCount == 0
                            ? l10n.visitsTabToday
                            : '${l10n.visitsTabToday} (${ready.todayCount})',
                      ),
                      MboaSegment(
                        value: VisitFilter.upcoming,
                        label: l10n.visitsTabUpcoming,
                      ),
                      MboaSegment(
                        value: VisitFilter.past,
                        label: l10n.visitsTabPast,
                      ),
                    ],
                    onChanged: (filter) => context
                        .read<AgentVisitsBloc>()
                        .add(VisitsFilterChanged(filter)),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => context
                        .read<AgentVisitsBloc>()
                        .add(const VisitsRefreshRequested()),
                    child: ready.visible.isEmpty
                        ? _Empty(filter: ready.filter)
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              Dimens.spacing,
                              0,
                              Dimens.spacing,
                              Dimens.spacing3Xl,
                            ),
                            itemCount: ready.visible.length,
                            itemBuilder: (context, index) => _VisitCard(
                              visit: ready.visible[index],
                              isBusy: ready.mutatingId ==
                                  ready.visible[index].id,
                            ),
                          ),
                  ),
                ),
              ],
            ),
        },
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.filter});

  final VisitFilter filter;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return ListView(
      children: [
        const SizedBox(height: Dimens.spacing3Xl),
        Text(
          switch (filter) {
            VisitFilter.today => l10n.visitsEmptyToday,
            VisitFilter.upcoming => l10n.visitsEmptyUpcoming,
            VisitFilter.past => l10n.visitsEmptyPast,
          },
          textAlign: TextAlign.center,
          style: context.mboaText.h3,
        ),
      ],
    );
  }
}

class _VisitCard extends StatelessWidget {
  const _VisitCard({required this.visit, this.isBusy = false});

  final AgentVisit visit;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final at = visit.scheduledAt;

    return Opacity(
      opacity: isBusy ? 0.5 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(Dimens.spacing),
          leading: Icon(LucideIcons.calendarCheck, color: colors.primary),
          title: Text(
            visit.annonceTitle ?? '',
            style: context.mboaText.label.copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            at == null
                ? ''
                : visit.isToday()
                    ? DateFormat.Hm().format(at)
                    : DateFormat.yMMMEd().add_Hm().format(at),
          ),
          trailing: _StatusChip(status: visit.status),
          onTap: isBusy
              ? null
              : () => context.router.push(VisitDetailRoute(id: visit.id)),
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

    final (label, color) = switch (status) {
      VisitStatus.scheduled => (l10n.visitsStatusScheduled, colors.primary),
      VisitStatus.completed => (l10n.visitsStatusCompleted, colors.success),
      VisitStatus.cancelled => (l10n.visitsStatusCancelled, colors.error),
      VisitStatus.unknown => ('', colors.textTertiary),
    };

    if (label.isEmpty) return const SizedBox.shrink();

    return Chip(
      label: Text(label),
      labelStyle: context.mboaText.caption.copyWith(color: color),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
      visualDensity: VisualDensity.compact,
    );
  }
}
