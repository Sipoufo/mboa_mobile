import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../past_homes/bloc/past_homes_bloc.dart';
import '../bloc/my_homes_bloc.dart';

/// "Mes logements" (CDC M30), from the Compte tab: one space per signed
/// contract, in two tabs — « En cours » (running or to come) and « Anciens »
/// (over, CDC M31). Both readable offline from the last read.
@RoutePage()
class MyHomesPage extends StatelessWidget implements AutoRouteWrapper {
  const MyHomesPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<MyHomesBloc>.value(value: getIt<MyHomesBloc>()..add(const MyHomesRequested())),
          BlocProvider<PastHomesBloc>(create: (_) => getIt<PastHomesBloc>()..add(const PastHomesRequested())),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) => MyHomesView(
        onOpen: (home) => context.router.push(MyHomeRoute(contractId: home.contractId)),
        onOpenPast: (home) => context.router.push(PastHomeRoute(contractId: home.contractId)),
      );
}

/// The two lists under their blocs — public so it can be pumped with mock
/// ones.
class MyHomesView extends StatelessWidget {
  const MyHomesView({super.key, required this.onOpen, required this.onOpenPast});

  final void Function(Home home) onOpen;

  /// An ended tenancy opens its sheet, not its space.
  final void Function(Home home) onOpenPast;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          leading: const MboaHeaderBackButton(),
          title: Text(l10n.myHomesTitle),
          bottom: TabBar(
            labelColor: colors.primary,
            unselectedLabelColor: colors.textSecondary,
            labelStyle: context.mboaText.label.copyWith(fontWeight: FontWeight.w700),
            unselectedLabelStyle: context.mboaText.label,
            indicatorColor: colors.primary,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: colors.border,
            tabs: [Tab(text: l10n.myHomesTabCurrent), Tab(text: l10n.myHomesTabPast)],
          ),
        ),
        body: TabBarView(
          children: [
            BlocBuilder<MyHomesBloc, MyHomesState>(
              builder: (context, state) => switch (state) {
                MyHomesLoading() => const Center(child: Loader()),
                MyHomesFailure() => _Retry(onRetry: () => context.read<MyHomesBloc>().add(const MyHomesRequested())),
                MyHomesReady(:final items, :final isOffline) => _HomeList(
                    // Over: in « Anciens », where it opens its sheet.
                    items: [for (final home in items) if (home.state != HomeStage.readOnly) home],
                    offline: isOffline ? l10n.myHomeOffline : null,
                    empty: (l10n.myHomesEmptyTitle, l10n.myHomesEmptyBody),
                    onRefresh: () => context.read<MyHomesBloc>().add(const MyHomesRequested()),
                    onOpen: onOpen,
                  ),
              },
            ),
            BlocBuilder<PastHomesBloc, PastHomesState>(
              builder: (context, state) => switch (state) {
                PastHomesLoading() => const Center(child: Loader()),
                PastHomesFailure() =>
                  _Retry(onRetry: () => context.read<PastHomesBloc>().add(const PastHomesRequested())),
                PastHomesReady(:final items, :final isOffline) => _HomeList(
                    items: items,
                    offline: isOffline ? l10n.pastHomesOffline : null,
                    empty: (l10n.pastHomesEmptyTitle, l10n.pastHomesEmptyBody),
                    onRefresh: () => context.read<PastHomesBloc>().add(const PastHomesRequested()),
                    onOpen: onOpenPast,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Retry extends StatelessWidget {
  const _Retry({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) =>
      Center(child: TextButton(onPressed: onRetry, child: Text(I18n.of(context).commonRetry)));
}

class _HomeList extends StatelessWidget {
  const _HomeList({
    required this.items,
    required this.offline,
    required this.empty,
    required this.onRefresh,
    required this.onOpen,
  });

  final List<Home> items;

  /// What to say when read from the last connection.
  final String? offline;
  final (String title, String body) empty;
  final VoidCallback onRefresh;
  final void Function(Home home) onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final offline = this.offline;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: items.isEmpty
          ? ListView(
              padding: const EdgeInsets.all(Dimens.spacingXl),
              children: [
                const SizedBox(height: Dimens.spacingXxl),
                Icon(LucideIcons.house, size: Dimens.iconLg, color: colors.textTertiary),
                const SizedBox(height: Dimens.spacing),
                Text(
                  empty.$1,
                  textAlign: TextAlign.center,
                  style: context.mboaText.h3.copyWith(color: colors.ink),
                ),
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  empty.$2,
                  textAlign: TextAlign.center,
                  style: context.mboaText.body.copyWith(color: colors.textSecondary),
                ),
              ],
            )
          : ListView.separated(
              padding: const EdgeInsets.all(Dimens.screenMargin),
              itemCount: items.length + (offline != null ? 1 : 0),
              separatorBuilder: (_, _) => const SizedBox(height: Dimens.spacingMd),
              itemBuilder: (context, index) {
                if (offline != null && index == 0) {
                  return Text(offline, style: context.mboaText.caption.copyWith(color: colors.warning));
                }
                final home = items[index - (offline != null ? 1 : 0)];
                return HomeCard(home: home, onTap: () => onOpen(home));
              },
            ),
    );
  }
}
