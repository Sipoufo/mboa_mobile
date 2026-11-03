import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import 'visit_row_tile.dart';

/// §40 D — a week the landlord reads: his agents' visits, or one listing's.
/// Each row says who carries it out; nothing is answered or confirmed here —
/// his own visits are acted on from « Mes visites », his agents' by them.
/// The sheet opens from a row (read only for an agent's), and the client's
/// report from a visit that is over.
class OwnerVisitsAgenda<B extends VisitsAgendaBloc> extends StatelessWidget {
  const OwnerVisitsAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<B, VisitsAgendaState>(
      builder: (context, state) => switch (state) {
        VisitsAgendaInitial() || VisitsAgendaLoadInProgress() => const Center(child: Loader()),
        VisitsAgendaFailure() => Center(
            child: TextButton(
              onPressed: () => context.read<B>().add(const AgendaRequested()),
              child: Text(l10n.commonRetry),
            ),
          ),
        final VisitsAgendaReady ready => VisitsAgendaView(
            state: ready,
            onDaySelected: (day) => context.read<B>().add(AgendaDaySelected(day)),
            onWeekChanged: (day) => context.read<B>().add(AgendaWeekChanged(day, selectedDay: day)),
            onRefresh: () => context.read<B>().add(const AgendaRefreshed()),
            itemBuilder: (context, visit) => VisitRowTile(
              visit: visit,
              showConductor: true,
              onTap: () async {
                await context.router.push(VisitDetailRoute(id: visit.id));
                // His own may have been answered or confirmed there.
                if (context.mounted) context.read<B>().add(const AgendaRefreshed());
              },
              actions: visit.status == VisitStatus.completed
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => context.router.push(
                          VisitReviewRoute(
                            id: visit.id,
                            propertyTitle: visit.annonceTitle,
                            // Only the visitor answers it (RM-M07bis-04).
                            readOnly: visit.conductor?.isAgent ?? false,
                          ),
                        ),
                        child: Text(l10n.visitsReviewOpen),
                      ),
                    )
                  : null,
            ),
          ),
      },
    );
  }
}
