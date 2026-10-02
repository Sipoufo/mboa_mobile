import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/my_visits_bloc.dart';
import 'widgets/visit_card.dart';

/// The tenant's visits (CDC M07).
///
/// Reached from the account tab rather than a fifth tab: Doc 05 §6.5 allows
/// five and the four we have are the ones used every session. A visit is
/// something you booked and then check twice.
@RoutePage()
class MyVisitsPage extends StatelessWidget implements AutoRouteWrapper {
  const MyVisitsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyVisitsBloc>(
        create: (_) => getIt<MyVisitsBloc>()..add(const MyVisitsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.visitsTitle)),
      body: BlocConsumer<MyVisitsBloc, MyVisitsState>(
        listenWhen: (previous, current) =>
            current is MyVisitsReady && current.failed,
        listener: (context, state) =>
            MboaToast.error(context: context, title: l10n.commonError),
        builder: (context, state) => switch (state) {
          MyVisitsInitial() ||
          MyVisitsLoadInProgress() =>
            const Center(child: Loader()),
          MyVisitsFailure() => _Failure(
              onRetry: () =>
                  context.read<MyVisitsBloc>().add(const MyVisitsRequested()),
            ),
          final MyVisitsReady ready =>
            ready.isEmpty ? const _Empty() : _List(state: ready),
        },
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.state});

  final MyVisitsReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final bloc = context.read<MyVisitsBloc>();

    return RefreshIndicator(
      onRefresh: () async => bloc.add(const MyVisitsRequested()),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          Dimens.screenMargin,
          Dimens.spacing,
          Dimens.screenMargin,
          Dimens.spacingXl,
        ),
        children: [
          if (state.isOffline) ...[
            _OfflineBanner(),
            const SizedBox(height: Dimens.spacing),
          ],
          if (state.upcoming.isNotEmpty) ...[
            _SectionTitle(l10n.visitsUpcoming),
            for (final visit in state.upcoming)
              VisitCard(
                visit: visit,
                isBusy: state.busyVisitId == visit.id,
                isRated: state.ratedVisitIds.contains(visit.id),
              ),
            const SizedBox(height: Dimens.spacingLg),
          ],
          if (state.past.isNotEmpty) ...[
            _SectionTitle(l10n.visitsPast),
            for (final visit in state.past)
              VisitCard(
                visit: visit,
                isBusy: state.busyVisitId == visit.id,
                isRated: state.ratedVisitIds.contains(visit.id),
              ),
          ],
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: Dimens.spacingMd),
        child: Text(
          title,
          style: context.mboaText.h3.copyWith(color: context.mboaColors.ink),
        ),
      );
}

class _OfflineBanner extends StatelessWidget {
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
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              I18n.of(context).visitsOffline,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.calendarCheck,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.visitsEmptyTitle,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.visitsEmptyBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Failure extends StatelessWidget {
  const _Failure({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.commonError,
            style: context.mboaText.body
                .copyWith(color: context.mboaColors.textSecondary),
          ),
          TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
        ],
      ),
    );
  }
}
