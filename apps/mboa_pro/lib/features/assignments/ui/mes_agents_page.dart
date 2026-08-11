import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/my_agents_bloc.dart';
import 'widgets/agent_row_tile.dart';
import 'widgets/property_picker_sheet.dart';

/// "Mes agents" (CDC M11) — every agent working the prestataire's portfolio.
///
/// Lists **people**, not assignments: an agent on four properties is one row.
/// The design's second line is a job title, which agents do not have, so it
/// carries the property they work, or how many.
@RoutePage()
class MesAgentsPage extends StatelessWidget implements AutoRouteWrapper {
  const MesAgentsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyAgentsBloc>(
        create: (_) =>
            getIt<MyAgentsBloc>()..add(const MyAgentsLoadRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentsMineTitle)),
      floatingActionButton: FloatingActionButton(
        // Assignment always starts from a property — an agent is assigned to a
        // bien, never to the prestataire in general.
        onPressed: () => _pickProperty(context),
        backgroundColor: colors.primary,
        foregroundColor: colors.onBrand,
        child: const Icon(LucideIcons.plus),
      ),
      body: BlocBuilder<MyAgentsBloc, MyAgentsState>(
        builder: (context, state) => switch (state) {
          MyAgentsInitial() || MyAgentsLoadInProgress() =>
            const Center(child: Loader()),
          MyAgentsFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<MyAgentsBloc>()
                    .add(const MyAgentsLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          MyAgentsReady(:final rows) => RefreshIndicator(
              onRefresh: () async => context
                  .read<MyAgentsBloc>()
                  .add(const MyAgentsRefreshRequested()),
              child: rows.isEmpty
                  ? _Empty()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        Dimens.spacing,
                        Dimens.spacing,
                        Dimens.spacing,
                        Dimens.spacing3Xl,
                      ),
                      itemCount: rows.length,
                      itemBuilder: (context, index) {
                        final row = rows[index];
                        return AgentRowTile(
                          name: row.agentName ?? '',
                          initials: row.initials,
                          photoUrl: row.photoUrl,
                          subtitle: row.isAwaitingResponse
                              ? l10n.agentsAwaitingResponse
                              : row.soleProperty ??
                                  l10n.agentsPropertyCount(row.propertyCount),
                          trailing: Icon(
                            LucideIcons.chevronRight,
                            color: colors.textTertiary,
                          ),
                          onTap: () => context.router.push(
                            AgentDetailRoute(
                              agentAccountId: row.agentAccountId,
                            ),
                          ),
                        );
                      },
                    ),
            ),
        },
      ),
    );
  }

  Future<void> _pickProperty(BuildContext context) async {
    final target = await showPropertyPickerSheet(context);
    if (target != null && context.mounted) {
      await context.router.push(AgentAssignmentRoute(target: target));
    }
  }
}

class _Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListView(
      children: [
        const SizedBox(height: Dimens.spacing3Xl),
        Icon(LucideIcons.users, size: 48, color: colors.textTertiary),
        const SizedBox(height: Dimens.spacing),
        Text(
          l10n.agentsMineEmpty,
          textAlign: TextAlign.center,
          style: context.mboaText.h3,
        ),
        const SizedBox(height: Dimens.spacingXs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLg),
          child: Text(
            l10n.agentsMineEmptyBody,
            textAlign: TextAlign.center,
            style: context.mboaText.caption
                .copyWith(color: colors.textSecondary),
          ),
        ),
      ],
    );
  }
}
