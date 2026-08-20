import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/visits_agenda_blocs.dart';
import 'widgets/visit_row_tile.dart';

/// The agent's visits as an agenda (CDC M16).
///
/// A week at a time, opening on today — an agent looks at this to find out
/// where they are going now, and the three tabs it replaced could not say
/// "next Tuesday" at all. Rows open the detail, which is where the exact
/// address, the two phone numbers and the presence confirmation live
/// (RM-M16-01).
@RoutePage()
class AgentVisitsPage extends StatelessWidget implements AutoRouteWrapper {
  const AgentVisitsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<AgentAgendaBloc>(
        create: (_) => getIt<AgentAgendaBloc>()..add(const AgendaRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.visitsTitle)),
      body: BlocBuilder<AgentAgendaBloc, VisitsAgendaState>(
        builder: (context, state) => switch (state) {
          VisitsAgendaInitial() || VisitsAgendaLoadInProgress() =>
            const Center(child: Loader()),
          VisitsAgendaFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<AgentAgendaBloc>()
                    .add(const AgendaRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final VisitsAgendaReady ready => VisitsAgendaView(
              state: ready,
              onDaySelected: (day) =>
                  context.read<AgentAgendaBloc>().add(AgendaDaySelected(day)),
              onWeekChanged: (day) => context
                  .read<AgentAgendaBloc>()
                  .add(AgendaWeekChanged(day, selectedDay: day)),
              onRefresh: () =>
                  context.read<AgentAgendaBloc>().add(const AgendaRefreshed()),
              itemBuilder: (context, visit) => VisitRowTile(
                visit: visit,
                onTap: () async {
                  await context.router.push(VisitDetailRoute(id: visit.id));
                  // The detail can cancel or confirm; the week is re-read when
                  // it closes rather than second-guessing what it did.
                  if (context.mounted) {
                    context.read<AgentAgendaBloc>().add(const AgendaRefreshed());
                  }
                },
              ),
            ),
        },
      ),
    );
  }
}
