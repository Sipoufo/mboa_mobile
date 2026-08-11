import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/agent_detail_bloc.dart';
import '../bloc/my_agents_bloc.dart';
import '../models/assignment.dart';

/// One agent, as the prestataire who works with them sees it (CDC M11).
///
/// Two sources, deliberately: the **public profile** says who they are and what
/// they have done overall (`GET /search/agents/{id}`); **`MyAgentsBloc`** says
/// what they hold *for this prestataire*, which no endpoint reports and which
/// the hub has already loaded.
///
/// No phone and no email: the API does not return them, by design. An agent's
/// number reaches the people who need it on the day of a visit, not everyone
/// who has ever been offered their services.
@RoutePage()
class AgentDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const AgentDetailPage({super.key, required this.agentAccountId});

  final String agentAccountId;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<AgentDetailBloc>(
        create: (_) => getIt<AgentDetailBloc>()
          ..add(AgentDetailRequested(agentAccountId)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.agentDetailTitle)),
      body: BlocBuilder<MyAgentsBloc, MyAgentsState>(
        builder: (context, agentsState) {
          // Looked up by id rather than passed in, so a refresh behind this
          // screen does not strand it on a stale row.
          final row = switch (agentsState) {
            MyAgentsReady(:final rows) =>
              rows.where((r) => r.agentAccountId == agentAccountId).firstOrNull,
            _ => null,
          };

          return ListView(
            padding: const EdgeInsets.all(Dimens.spacing),
            children: [
              _Header(fallbackName: row?.agentName),
              const SizedBox(height: Dimens.spacingLg),
              _Zones(),
              const SizedBox(height: Dimens.spacingLg),
              _Properties(row: row),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.fallbackName});

  /// The assignment list already knows the name, so a failed profile fetch
  /// costs the stats rather than leaving the screen anonymous.
  final String? fallbackName;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<AgentDetailBloc, AgentDetailState>(
      builder: (context, state) {
        final profile = state is AgentDetailReady ? state.profile : null;
        final name = profile?.fullName.isNotEmpty ?? false
            ? profile!.fullName
            : (fallbackName ?? '');

        return Column(
          children: [
            MboaAvatar(
              imageUrl: profile?.photoUrl,
              initials: initialsFromFullName(name),
            ),
            const SizedBox(height: Dimens.spacingSm),
            Text(name, style: context.mboaText.h2),
            if (state is AgentDetailLoadInProgress) ...[
              const SizedBox(height: Dimens.spacingSm),
              const SizedBox(height: 20, width: 20, child: Loader()),
            ] else if (state is AgentDetailFailure) ...[
              const SizedBox(height: Dimens.spacingXs),
              Text(
                l10n.agentDetailUnavailable,
                style: context.mboaText.caption
                    .copyWith(color: colors.textTertiary),
              ),
            ] else if (profile != null) ...[
              const SizedBox(height: Dimens.spacingXs),
              _Rating(profile: profile),
              const SizedBox(height: Dimens.spacingXs),
              Text(
                l10n.agentsVisitCount(profile.completedVisitCount),
                style: context.mboaText.caption
                    .copyWith(color: colors.textSecondary),
              ),
              if (profile.memberSince case final since?)
                Text(
                  l10n.agentDetailMemberSince(
                    DateFormat.yMMMM().format(since),
                  ),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
            ],
          ],
        );
      },
    );
  }
}

/// An unrated agent shows "pas encore noté", never "0 ★".
///
/// Rating a visit is optional (RM-M07-07), so twelve visits and no rating is an
/// ordinary state — rendering it as zero stars would libel them.
class _Rating extends StatelessWidget {
  const _Rating({required this.profile});

  final AgentPublicProfileView profile;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    if (!profile.hasRating) {
      return Text(
        l10n.agentRatingNone,
        style: context.mboaText.caption.copyWith(color: colors.textTertiary),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(LucideIcons.star, size: Dimens.iconSm, color: colors.warning),
        const SizedBox(width: Dimens.spacingXs),
        Text(
          profile.averageRating!.toStringAsFixed(1),
          style: context.mboaText.label.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: Dimens.spacingXs),
        Text(
          l10n.agentRatingCount(profile.ratingCount),
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}

class _Zones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<AgentDetailBloc, AgentDetailState>(
      builder: (context, state) {
        if (state is! AgentDetailReady || state.profile.zones.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.agentDetailZones, style: context.mboaText.h3),
            const SizedBox(height: Dimens.spacingSm),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingXs,
              children: [
                for (final zone in state.profile.zones)
                  Chip(
                    label: Text(
                      zone.isWholeCity
                          ? '${zone.city} — ${l10n.agentDetailWholeCity}'
                          : zone.label,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// What this agent holds for this prestataire — live work first, then offers
/// they have not answered.
class _Properties extends StatelessWidget {
  const _Properties({this.row});

  final AgentRow? row;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final live = row?.live ?? const <Assignment>[];
    final pending = (row?.assignments ?? const <Assignment>[])
        .where((a) => a.status.isPending)
        .toList();

    if (live.isEmpty && pending.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingLg),
        child: Text(
          l10n.agentDetailNoProperties,
          textAlign: TextAlign.center,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (live.isNotEmpty) ...[
          Text(l10n.agentDetailProperties, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacingSm),
          for (final assignment in live) _PropertyTile(assignment: assignment),
        ],
        if (pending.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingLg),
          Text(l10n.agentDetailPending, style: context.mboaText.h3),
          const SizedBox(height: Dimens.spacingSm),
          for (final assignment in pending)
            _PropertyTile(assignment: assignment, isPending: true),
        ],
      ],
    );
  }
}

class _PropertyTile extends StatelessWidget {
  const _PropertyTile({required this.assignment, this.isPending = false});

  final Assignment assignment;
  final bool isPending;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final isResidence = assignment.target is ResidenceTarget;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isResidence ? LucideIcons.layers : LucideIcons.house,
        color: isPending ? colors.textTertiary : colors.primary,
      ),
      title: Text(assignment.propertyTitle ?? ''),
      subtitle: Text(
        isPending
            ? l10n.agentsAwaitingResponse
            : assignment.unitCount == null
                ? ''
                : l10n.agentsUnitsCovered(assignment.unitCount!),
      ),
      trailing: Icon(LucideIcons.chevronRight, color: colors.textTertiary),
      // Straight to the property's own agent screen, where withdrawing and the
      // applications already live — no second copy of those actions here.
      onTap: () => context.router.push(
        AgentAssignmentRoute(target: assignment.target),
      ),
    );
  }
}
