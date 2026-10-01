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
import 'widgets/search_map_view.dart';

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

/// List or map — CDC M04 offers both over the same results.
enum _View { list, map }

class _SearchPageState extends State<SearchPage> {
  final _scroll = ScrollController();

  /// Which half is on screen. `setState` is right here and only here: this is
  /// a preference about the current screen, not data from the API — the hits
  /// it switches between both come from `SearchBloc`.
  _View _view = _View.list;

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
                if (ready.cachedBecause case final reason?)
                  _CacheBanner(
                    reason: reason,
                    onRetry: () => context
                        .read<SearchBloc>()
                        .add(const SearchSubmitted()),
                  ),
                // Nothing to switch between until a city is chosen
                // (RM-M04-01), and an empty map is not a second empty state.
                if (ready.query.isValid && !ready.isEmpty && !ready.isLoading)
                  _ResultsHeader(
                    count: ready.hits.length,
                    view: _view,
                    onChanged: (view) => setState(() => _view = view),
                  ),
                Expanded(
                  child: switch (_view) {
                    _View.list =>
                      _Results(state: ready, controller: _scroll),
                    _View.map => SearchMapView(
                        state: ready,
                        onOpen: (hit) => _open(context, hit),
                      ),
                  },
                ),
              ],
            ),
        },
      ),
    );
  }
}

/// A residence opens its own screen: what the tenant picks there is which unit
/// (RM-M10bis-11). The list and the map both land here, so a marker and a row
/// cannot drift apart.
void _open(BuildContext context, SearchHit hit) => switch (hit) {
      ListingHit() => context.router.push(ListingDetailRoute(id: hit.id)),
      ResidenceHit() => context.router.push(ResidenceDetailRoute(id: hit.id)),
    };

/// How many results, and which half is showing them.
///
/// The count earns its line: "12 biens" tells a reader whether to refine
/// before they start scrolling, and it is the only honest place to say that
/// the map draws the same results as the list.
class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({
    required this.count,
    required this.view,
    required this.onChanged,
  });

  final int count;
  final _View view;
  final ValueChanged<_View> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenMargin,
        0,
        Dimens.screenMargin,
        Dimens.spacingMd,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              l10n.searchResultCount(count),
              style: context.mboaText.label.copyWith(color: colors.ink),
            ),
          ),
          _ViewToggle(view: view, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Liste / Carte, over one set of results.
///
/// Hand-built rather than a `SegmentedButton`: Material's version brings its
/// own outline, its own selected tint and a check mark, none of which belong
/// to this design system (Doc 05 §1.2 — "pas chargé").
class _ViewToggle extends StatelessWidget {
  const _ViewToggle({required this.view, required this.onChanged});

  final _View view;
  final ValueChanged<_View> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.surfaceWarm,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final value in _View.values)
            _ToggleSegment(
              value: value,
              selected: value == view,
              onTap: () => onChanged(value),
            ),
        ],
      ),
    );
  }
}

class _ToggleSegment extends StatelessWidget {
  const _ToggleSegment({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final _View value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Semantics(
      selected: selected,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.spacingMd,
            vertical: Dimens.spacingSm,
          ),
          decoration: BoxDecoration(
            color: selected ? colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(Dimens.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                switch (value) {
                  _View.list => LucideIcons.list,
                  _View.map => LucideIcons.map,
                },
                size: Dimens.iconSm,
                color: selected ? colors.onBrand : colors.textSecondary,
              ),
              const SizedBox(width: Dimens.spacingXs),
              Text(
                switch (value) {
                  _View.list => l10n.searchViewList,
                  _View.map => l10n.searchViewMap,
                },
                style: context.mboaText.caption.copyWith(
                  color: selected ? colors.onBrand : colors.textSecondary,
                ),
              ),
            ],
          ),
        ),
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
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenMargin,
        Dimens.spacingMd,
        Dimens.screenMargin,
        Dimens.spacing,
      ),
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
                  color: colors.surfaceWarm,
                  borderRadius: BorderRadius.circular(Dimens.radius),
                  border: Border.all(color: colors.border, width: 1.5),
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
                        style: state.query.cityName == null
                            ? context.mboaText.body
                                .copyWith(color: colors.textTertiary)
                            : context.mboaText.label.copyWith(color: colors.ink),
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

/// Cached results are shown, and named as such — saying **why**.
///
/// CE-M04-02 (no line) and CE-M04-03 (the server answered badly) look the same
/// from here — old results on screen — but only one of them is worth a retry,
/// and telling someone their connection is down while it is not sends them to
/// fix the wrong thing.
class _CacheBanner extends StatelessWidget {
  const _CacheBanner({required this.reason, required this.onRetry});

  final CacheReason reason;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final offline = reason == CacheReason.offline;

    return Container(
      width: double.infinity,
      color: colors.warning.withValues(alpha: 0.12),
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenMargin,
        Dimens.spacingSm,
        Dimens.spacingSm,
        Dimens.spacingSm,
      ),
      child: Row(
        children: [
          Icon(
            offline ? LucideIcons.wifiOff : LucideIcons.cloudAlert,
            size: Dimens.iconSm,
            color: colors.warning,
          ),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              offline ? l10n.searchOfflineBanner : l10n.searchStaleBanner,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
          // Nothing to retry without a line: the request would fail the same
          // way, and a dead button is worse than no button.
          if (!offline)
            TextButton(
              onPressed: onRetry,
              child: Text(l10n.commonRetry),
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
        Dimens.screenMargin,
        0,
        Dimens.screenMargin,
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
        return SearchHitCard(hit: hit, onTap: () => _open(context, hit));
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
