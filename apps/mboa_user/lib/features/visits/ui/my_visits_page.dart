import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
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
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyVisitsBloc>.value(
        value: getIt<MyVisitsBloc>()..add(const MyVisitsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(
        // Pushed into the nested `/app` router, where the inner Navigator has
        // nothing to pop — `AutoLeadingButton` knows about the stack above it.
        leading: const MboaHeaderBackButton(),
        title: Text(l10n.visitsTitle),
      ),
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

/// À venir / Passées.
enum _Filter { upcoming, past }

class _List extends StatefulWidget {
  const _List({required this.state});

  final MyVisitsReady state;

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  /// Upcoming first: a tenant opens this to check a visit they have, far more
  /// often than to look back at one they had.
  _Filter _filter = _Filter.upcoming;

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final bloc = context.read<MyVisitsBloc>();
    final shown =
        _filter == _Filter.upcoming ? state.upcoming : state.past;

    return Column(
      children: [
        if (state.isOffline)
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.screenMargin,
              Dimens.spacing,
              Dimens.screenMargin,
              0,
            ),
            child: _OfflineBanner(),
          ),
        Padding(
          padding: const EdgeInsets.all(Dimens.screenMargin),
          child: _FilterBar(
            filter: _filter,
            upcomingCount: state.upcoming.length,
            pastCount: state.past.length,
            onChanged: (filter) => setState(() => _filter = filter),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => bloc.add(const MyVisitsRequested()),
            child: shown.isEmpty
                ? _EmptyFilter(filter: _filter)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      Dimens.screenMargin,
                      0,
                      Dimens.screenMargin,
                      Dimens.spacingXl,
                    ),
                    itemCount: shown.length,
                    itemBuilder: (context, index) {
                      final visit = shown[index];
                      return VisitCard(
                        visit: visit,
                        isBusy: state.busyVisitId == visit.id,
                        isRated: state.ratedVisitIds.contains(visit.id),
                        onTap: () => context.router.push(
                          VisitDetailRoute(visitId: visit.id),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

/// The counts are on the tabs on purpose: "Passées (0)" answers the question
/// before the tap, and an empty tab you chose is not a surprise.
class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.filter,
    required this.upcomingCount,
    required this.pastCount,
    required this.onChanged,
  });

  final _Filter filter;
  final int upcomingCount;
  final int pastCount;
  final ValueChanged<_Filter> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surfaceWarm,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Row(
        children: [
          for (final value in _Filter.values)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(value),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimens.spacingSm,
                  ),
                  decoration: BoxDecoration(
                    color: value == filter ? colors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimens.radiusFull),
                  ),
                  child: Text(
                    switch (value) {
                      _Filter.upcoming =>
                        '${l10n.visitsFilterUpcoming} ($upcomingCount)',
                      _Filter.past => '${l10n.visitsFilterPast} ($pastCount)',
                    },
                    textAlign: TextAlign.center,
                    style: context.mboaText.label.copyWith(
                      color: value == filter ? colors.onBrand : colors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EmptyFilter extends StatelessWidget {
  const _EmptyFilter({required this.filter});

  final _Filter filter;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    // A scrollable, so the pull-to-refresh still works on an empty tab.
    return ListView(
      padding: const EdgeInsets.all(Dimens.spacingXl),
      children: [
        Text(
          filter == _Filter.upcoming
              ? l10n.visitsEmptyUpcoming
              : l10n.visitsEmptyPast,
          textAlign: TextAlign.center,
          style: context.mboaText.body
              .copyWith(color: context.mboaColors.textSecondary),
        ),
      ],
    );
  }
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
