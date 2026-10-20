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
import '../bloc/my_homes_bloc.dart';

/// "Mes logements" (CDC M30), from the Compte tab: one space per signed
/// contract. Readable offline from the last read.
@RoutePage()
class MyHomesPage extends StatelessWidget implements AutoRouteWrapper {
  const MyHomesPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyHomesBloc>.value(
        value: getIt<MyHomesBloc>()..add(const MyHomesRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const MyHomesView();
}

/// The list under its bloc — public so it can be pumped with a mock one.
class MyHomesView extends StatelessWidget {
  const MyHomesView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.myHomesTitle)),
      body: BlocBuilder<MyHomesBloc, MyHomesState>(
        builder: (context, state) => switch (state) {
          MyHomesLoading() => const Center(child: Loader()),
          MyHomesFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<MyHomesBloc>().add(const MyHomesRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          MyHomesReady(:final items, :final isOffline) => RefreshIndicator(
              onRefresh: () async => context.read<MyHomesBloc>().add(const MyHomesRequested()),
              child: items.isEmpty
                  ? ListView(
                      padding: const EdgeInsets.all(Dimens.spacingXl),
                      children: [
                        const SizedBox(height: Dimens.spacingXxl),
                        Icon(LucideIcons.house, size: Dimens.iconLg, color: colors.textTertiary),
                        const SizedBox(height: Dimens.spacing),
                        Text(
                          l10n.myHomesEmptyTitle,
                          textAlign: TextAlign.center,
                          style: context.mboaText.h3.copyWith(color: colors.ink),
                        ),
                        const SizedBox(height: Dimens.spacingXs),
                        Text(
                          l10n.myHomesEmptyBody,
                          textAlign: TextAlign.center,
                          style: context.mboaText.body.copyWith(color: colors.textSecondary),
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(Dimens.screenMargin),
                      itemCount: items.length + (isOffline ? 1 : 0),
                      separatorBuilder: (_, _) => const SizedBox(height: Dimens.spacingMd),
                      itemBuilder: (context, index) {
                        if (isOffline && index == 0) {
                          return Text(l10n.myHomeOffline, style: context.mboaText.caption.copyWith(color: colors.warning));
                        }
                        final home = items[index - (isOffline ? 1 : 0)];
                        return HomeCard(
                          home: home,
                          onTap: () => context.router.push(MyHomeRoute(contractId: home.contractId)),
                        );
                      },
                    ),
            ),
        },
      ),
    );
  }
}

/// A space in a list: the place, and what is due next — or late.
class HomeCard extends StatelessWidget {
  const HomeCard({super.key, required this.home, required this.onTap});

  final Home home;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final next = home.nextDue;

    final (String line, Color tone) = switch (home) {
      _ when home.state == HomeStage.readOnly => (l10n.myHomeEnded, colors.textSecondary),
      _ when home.isOverdue => (l10n.myHomeOverdueCount(home.overdueCount), colors.error),
      _ when next?.dueDate != null => (
          '${l10n.myHomeNextRent} · ${fcfaOf(context, next!.remaining)} · ${DateFormat.MMMd(locale).format(next.dueDate!)}',
          colors.primary,
        ),
      _ => (l10n.myHomeUpToDate, colors.success),
    };

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radiusMd),
                child: SizedBox.square(
                  dimension: 64,
                  child: switch (home.coverUrl) {
                    final url? => MboaNetworkImage(url: url),
                    null => ColoredBox(
                        color: colors.primary,
                        child: MboaBrandPattern(color: colors.onBrand, opacity: 0.12, scale: 0.5),
                      ),
                  },
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      home.annonceTitle ?? l10n.reservationUntitled,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                    if ([home.district, home.city].nonNulls.join(', ') case final place when place.isNotEmpty)
                      Text(place, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                    const SizedBox(height: Dimens.spacingXs),
                    Text(line, style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}
