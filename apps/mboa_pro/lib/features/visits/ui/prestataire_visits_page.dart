import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../annonces/data/location_capture.dart';
import '../bloc/prestataire_visits_bloc.dart';
import '../bloc/visits_agenda_blocs.dart';
import 'widgets/visit_row_tile.dart';

/// The visits a prestataire carries out himself (RM-M11-10 / RM-M15-06).
///
/// The same agenda the agent gets, with the two things only he does: answering
/// a proposed time, and confirming he is at his own property. Requests sit
/// above the day's list because they are answered whenever he opens the app,
/// not on the day they fall.
///
/// **He gets no detail screen**: `GET /prestataires/me/visites` is the only
/// read there is, and it carries no client name, no phone and no address
/// (`backend-requests.md` §14). Everything shown here is everything the API
/// gives.
@RoutePage()
class PrestataireVisitsPage extends StatelessWidget implements AutoRouteWrapper {
  const PrestataireVisitsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<PrestataireAgendaBloc>(
            create: (_) =>
                getIt<PrestataireAgendaBloc>()..add(const AgendaRequested()),
          ),
          BlocProvider<PrestataireVisitsBloc>(
            create: (_) => getIt<PrestataireVisitsBloc>(),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.visitsMineTitle)),
      body: BlocListener<PrestataireVisitsBloc, PrestataireVisitsState>(
        listener: (context, state) {
          switch (state) {
            case PrestataireVisitsDone():
              // The server owns what the answer did to the visit, so the week
              // is re-read rather than patched here.
              context.read<PrestataireAgendaBloc>().add(const AgendaRefreshed());
            case PrestataireVisitsFailed():
              MboaToast.error(
                context: context,
                title: l10n.commonErrorTitle,
                description: l10n.visitsActionFailed,
              );
            case PrestataireVisitsLocationFailed(:final failure):
              MboaToast.error(
                context: context,
                title: l10n.commonErrorTitle,
                description: switch (failure) {
                  LocationFailure.denied => l10n.visitsLocationDenied,
                  LocationFailure.deniedForever =>
                    l10n.visitsLocationDeniedForever,
                  LocationFailure.disabled => l10n.visitsLocationDisabled,
                  LocationFailure.unavailable => l10n.visitsLocationUnavailable,
                },
              );
            case PrestataireVisitsIdle() || PrestataireVisitsBusy():
              break;
          }
        },
        child: BlocBuilder<PrestataireAgendaBloc, VisitsAgendaState>(
          builder: (context, state) => switch (state) {
            VisitsAgendaInitial() || VisitsAgendaLoadInProgress() =>
              const Center(child: Loader()),
            VisitsAgendaFailure() => Center(
                child: TextButton(
                  onPressed: () => context
                      .read<PrestataireAgendaBloc>()
                      .add(const AgendaRequested()),
                  child: Text(l10n.commonRetry),
                ),
              ),
            final VisitsAgendaReady ready => _Agenda(state: ready),
          },
        ),
      ),
    );
  }
}

class _Agenda extends StatelessWidget {
  const _Agenda({required this.state});

  final VisitsAgendaReady state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrestataireVisitsBloc, PrestataireVisitsState>(
      builder: (context, action) {
        final busyId = action is PrestataireVisitsBusy ? action.id : null;

        return VisitsAgendaView(
          state: state,
          onDaySelected: (day) => context
              .read<PrestataireAgendaBloc>()
              .add(AgendaDaySelected(day)),
          onWeekChanged: (day) => context
              .read<PrestataireAgendaBloc>()
              .add(AgendaWeekChanged(day, selectedDay: day)),
          onRefresh: () => context
              .read<PrestataireAgendaBloc>()
              .add(const AgendaRefreshed()),
          header: state.awaitingAnswer.isEmpty
              ? null
              : _Requests(visits: state.awaitingAnswer, busyId: busyId),
          itemBuilder: (context, visit) => VisitRowTile(
            visit: visit,
            isBusy: busyId == visit.id,
            actions: _actionsFor(context, visit, busyId: busyId),
          ),
        );
      },
    );
  }

  /// A scheduled visit is the only one with anything to do on the day: he
  /// confirms being there, and the client confirms from their own app
  /// (RM-M07-05). Once he has, the row says so instead of asking twice.
  Widget? _actionsFor(
    BuildContext context,
    Visit visit, {
    required String? busyId,
  }) {
    final l10n = I18n.of(context);
    if (visit.status != VisitStatus.scheduled) return null;

    if (visit.visitorConfirmedAt != null) {
      return Text(
        visit.clientConfirmedAt == null
            ? l10n.visitsAwaitingClientTitle
            : l10n.visitsCompletedTitle,
        style: context.mboaText.caption
            .copyWith(color: context.mboaColors.textSecondary),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: busyId != null
            ? null
            : () => context
                .read<PrestataireVisitsBloc>()
                .add(OwnerPresenceConfirmed(visit.id)),
        child: Text(l10n.visitsConfirmPresence),
      ),
    );
  }
}

/// RM-M15-06 — times a client proposed, waiting on an answer.
class _Requests extends StatelessWidget {
  const _Requests({required this.visits, required this.busyId});

  final List<Visit> visits;
  final String? busyId;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.visitsRequestsTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.visitsRequestsBody,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        for (final visit in visits)
          VisitRowTile(
            visit: visit,
            isBusy: busyId == visit.id,
            actions: Row(
              children: [
                TextButton(
                  onPressed: busyId != null
                      ? null
                      : () => context
                          .read<PrestataireVisitsBloc>()
                          .add(VisitRequestDeclined(visit.id)),
                  style: TextButton.styleFrom(foregroundColor: colors.error),
                  child: Text(l10n.visitsRequestDecline),
                ),
                TextButton(
                  onPressed: busyId != null
                      ? null
                      : () => context
                          .read<PrestataireVisitsBloc>()
                          .add(VisitRequestConfirmed(visit.id)),
                  child: Text(l10n.visitsRequestConfirm),
                ),
              ],
            ),
          ),
        const SizedBox(height: Dimens.spacingLg),
      ],
    );
  }
}
