import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/search_bloc.dart';
import 'widgets/search_filters_sheet.dart';
import 'widgets/search_hit_card.dart';

/// Recherche (CDC M04) — the entry point of 90% of sessions, and the one screen
/// that must work without an account (CA-M04-04).
@RoutePage()
class SearchPage extends StatefulWidget implements AutoRouteWrapper {
  const SearchPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<SearchBloc>(
        create: (_) => getIt<SearchBloc>()..add(const SearchStarted()),
        child: this,
      );

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  /// RM-M04-03 — the next page is asked for before the bottom is reached, so
  /// the list does not visibly stop.
  void _onScroll() {
    if (!_scroll.hasClients) return;
    final remaining = _scroll.position.maxScrollExtent - _scroll.position.pixels;
    if (remaining < 600) {
      context.read<SearchBloc>().add(const SearchNextPageRequested());
    }
  }

  Future<void> _pickCity() async {
    final bloc = context.read<SearchBloc>();
    final state = bloc.state;
    if (state is! SearchReady) return;

    final city = await showCityPicker(
      context,
      repository: getIt<LocationRepository>(),
    );
    if (city == null) return;

    bloc
      ..add(
        SearchFilterChanged(
          // A new city invalidates the districts chosen in the old one.
          state.query.copyWith(
            cityId: city.id,
            cityName: city.name,
            districtIds: const [],
          ),
        ),
      )
      ..add(const SearchSubmitted());
  }

  Future<void> _openFilters() async {
    final bloc = context.read<SearchBloc>();
    final state = bloc.state;
    if (state is! SearchReady) return;

    final query = await showSearchFiltersSheet(context, query: state.query);
    if (query == null) return;

    bloc
      ..add(SearchFilterChanged(query))
      ..add(const SearchSubmitted());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.navSearch)),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => switch (state) {
          SearchInitial() => const Center(child: Loader()),
          SearchFailure() => _Failure(
              onRetry: () =>
                  context.read<SearchBloc>().add(const SearchSubmitted()),
            ),
          final SearchReady ready => Column(
              children: [
                _SearchBar(
                  state: ready,
                  onPickCity: _pickCity,
                  onOpenFilters: _openFilters,
                ),
                if (ready.isOffline) const _OfflineBanner(),
                Expanded(child: _Results(state: ready, controller: _scroll)),
              ],
            ),
        },
      ),
    );
  }
}

/// The city is the search: RM-M04-01 makes it the one mandatory criterion, so
/// it gets the bar and everything else lives behind "Filtres".
class _SearchBar extends StatelessWidget {
  const _SearchBar({
    required this.state,
    required this.onPickCity,
    required this.onOpenFilters,
  });

  final SearchReady state;
  final VoidCallback onPickCity;
  final VoidCallback onOpenFilters;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final count = state.query.activeFilterCount;

    return Padding(
      padding: const EdgeInsets.all(Dimens.spacing),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onPickCity,
              borderRadius: BorderRadius.circular(Dimens.radius),
              child: Container(
                height: Dimens.inputHeight,
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.spacing),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: Dimens.icon,
                      color: colors.primary,
                    ),
                    const SizedBox(width: Dimens.spacingSm),
                    Expanded(
                      child: Text(
                        state.query.cityName ?? l10n.searchCityPrompt,
                        style: context.mboaText.body.copyWith(
                          color: state.query.cityName == null
                              ? colors.textTertiary
                              : colors.ink,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      LucideIcons.chevronDown,
                      size: Dimens.icon,
                      color: colors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: Dimens.spacingSm),
          Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: IconButton.filledTonal(
              tooltip: l10n.searchFilters,
              onPressed: onOpenFilters,
              icon: const Icon(LucideIcons.slidersHorizontal),
            ),
          ),
        ],
      ),
    );
  }
}

/// CE-M04-02 — cached results are shown, and named as such.
class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      color: colors.warning.withValues(alpha: 0.12),
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacing,
        vertical: Dimens.spacingSm,
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              l10n.searchOfflineBanner,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.state, required this.controller});

  final SearchReady state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) return const Center(child: Loader());
    if (!state.query.isValid) return const _NoCityYet();
    if (state.isEmpty) return const _NoResult();

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        0,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      // One extra row for the loader that pulls the next page in.
      itemCount: state.hits.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.hits.length) {
          return const Padding(
            padding: EdgeInsets.all(Dimens.spacing),
            child: Center(child: Loader()),
          );
        }
        final hit = state.hits[index];
        return SearchHitCard(
          hit: hit,
          // A residence opens its own screen: what the tenant picks there is
          // which unit (RM-M10bis-11).
          onTap: () => switch (hit) {
            ListingHit() =>
              context.router.push(ListingDetailRoute(id: hit.id)),
            ResidenceHit() =>
              context.router.push(ResidenceDetailRoute(id: hit.id)),
          },
        );
      },
    );
  }
}

class _NoCityYet extends StatelessWidget {
  const _NoCityYet();

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
              LucideIcons.mapPin,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.searchStartTitle,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.searchStartBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

/// CE-M04-01 — nothing matched, and the way out is to widen.
class _NoResult extends StatelessWidget {
  const _NoResult();

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
              LucideIcons.searchX,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.searchEmptyTitle,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.searchEmptyBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            Button.outline(
              title: l10n.searchClearFilters,
              onPressed: () => context.read<SearchBloc>()
                ..add(const SearchFiltersCleared())
                ..add(const SearchSubmitted()),
            ),
          ],
        ),
      ),
    );
  }
}

/// CE-M04-03.
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
          Text(l10n.commonError, style: context.mboaText.body),
          const SizedBox(height: Dimens.spacingSm),
          TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
        ],
      ),
    );
  }
}
