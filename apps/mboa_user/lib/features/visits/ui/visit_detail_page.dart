import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/my_visits_bloc.dart';
import 'widgets/visit_card.dart';

/// One visit, in full (CDC M07).
///
/// Reads the visit out of [MyVisitsBloc] rather than taking it as a frozen
/// argument: confirming presence re-reads the list, and a detail screen built
/// from a copy would keep showing the state the tenant just changed.
@RoutePage()
class VisitDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const VisitDetailPage({super.key, required this.visitId});

  final String visitId;

  /// The same instance the list holds — this is a root-level route, so nothing
  /// above it provides one, and a second bloc would open on an empty list.
  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyVisitsBloc>.value(
        value: getIt<MyVisitsBloc>(),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(l10n.visitDetailTitle),
      ),
      body: BlocBuilder<MyVisitsBloc, MyVisitsState>(
        builder: (context, state) {
          if (state is! MyVisitsReady) {
            return const Center(child: Loader());
          }
          final visit = [...state.upcoming, ...state.past]
              .where((candidate) => candidate.id == visitId)
              .firstOrNull;
          // Cancelled from here, the visit leaves the list; the screen goes
          // back rather than showing an empty one.
          if (visit == null) return const SizedBox.shrink();

          return VisitDetailBody(
            visit: visit,
            isBusy: state.busyVisitId == visit.id,
            isRated: state.ratedVisitIds.contains(visit.id),
          );
        },
      ),
    );
  }
}

/// The screen's contents, public so they can be pumped on their own: the page
/// itself needs an auto_route stack for its back button, and what is worth
/// pinning is what the tenant reads.
class VisitDetailBody extends StatelessWidget {
  const VisitDetailBody({
    super.key,
    required this.visit,
    this.isBusy = false,
    this.isRated = false,
  });

  final Visit visit;
  final bool isBusy;
  final bool isRated;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenMargin,
        Dimens.spacing,
        Dimens.screenMargin,
        Dimens.spacingXl,
      ),
      children: [
        Text(
          visit.annonceTitle ?? '',
          style: context.mboaText.h2.copyWith(color: colors.ink),
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          visit.visitorKind == VisitorKind.owner
              ? l10n.visitVisitorOwner
              : l10n.visitVisitorAgent,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
        ),
        if (visit.scheduledAt case final at?) ...[
          const SizedBox(height: Dimens.spacing),
          _Row(
            icon: LucideIcons.calendar,
            label: DateFormat.yMMMMEEEEd(locale).add_Hm().format(at),
          ),
        ],
        // RM-M15-06 — a proposed slot is not a booked one, and the tenant
        // cannot confirm it on the visitor's behalf.
        if (visit.status == VisitStatus.requested) ...[
          const SizedBox(height: Dimens.spacing),
          _Callout(icon: LucideIcons.clock, text: l10n.visitAwaitingVisitor),
        ],
        if (visit.status.isOpen) ...[
          const SizedBox(height: Dimens.spacingLg),
          _Presence(visit: visit),
        ],
        const SizedBox(height: Dimens.spacingLg),
        if (visit.annonceId case final annonceId?)
          Button.outline(
            title: l10n.visitSeeListing,
            onPressed: () =>
                context.router.root.push(ListingDetailRoute(id: annonceId)),
          ),
        VisitActions(visit: visit, isBusy: isBusy, isRated: isRated),
      ],
    );
  }
}

/// RM-M07-05 — who has said they are there, and who has not.
///
/// Two lines rather than one status, because "waiting" is ambiguous: the
/// tenant needs to know whether they are the one being waited for.
class _Presence extends StatelessWidget {
  const _Presence({required this.visit});

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        boxShadow: MboaShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.visitPresenceSection,
            style: context.mboaText.label.copyWith(color: colors.ink),
          ),
          const SizedBox(height: Dimens.spacingMd),
          _PresenceRow(
            who: l10n.visitPresenceYou,
            confirmed: visit.clientConfirmedAt != null,
          ),
          const SizedBox(height: Dimens.spacingSm),
          _PresenceRow(
            who: l10n.visitPresenceVisitor,
            confirmed: visit.visitorConfirmedAt != null,
          ),
          const SizedBox(height: Dimens.spacingMd),
          Text(
            l10n.visitPresenceExplainer,
            style: context.mboaText.caption
                .copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _PresenceRow extends StatelessWidget {
  const _PresenceRow({required this.who, required this.confirmed});

  final String who;
  final bool confirmed;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Row(
      children: [
        Icon(
          confirmed ? LucideIcons.circleCheck : LucideIcons.circleDashed,
          size: Dimens.icon,
          color: confirmed ? colors.success : colors.textTertiary,
        ),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(
          child: Text(
            who,
            style: context.mboaText.body.copyWith(color: colors.ink),
          ),
        ),
        Text(
          confirmed
              ? l10n.visitPresenceConfirmed
              : l10n.visitPresencePending,
          style: context.mboaText.caption.copyWith(
            color: confirmed ? colors.success : colors.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      children: [
        Icon(icon, size: Dimens.icon, color: colors.primary),
        const SizedBox(width: Dimens.spacingSm),
        Expanded(
          child: Text(
            label,
            style: context.mboaText.body.copyWith(color: colors.ink),
          ),
        ),
      ],
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              text,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}
