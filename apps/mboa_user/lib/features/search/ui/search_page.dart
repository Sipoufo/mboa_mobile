import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../my_home/ui/widgets/next_rent_banner.dart';
import '../../saved_searches/bloc/saved_searches_bloc.dart';
import '../../saved_searches/ui/widgets/save_search_sheet.dart';
import '../bloc/search_bloc.dart';
import '../data/location_service.dart';
import '../data/search_repository.dart';
import 'widgets/search_filters_sheet.dart';
import 'widgets/search_home_widgets.dart';
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

  /// RM-M04-07 — keep this search, to be told when it has something new.
  ///
  /// An account is needed (the wall is on the action, RM-M04-05), and three
  /// is the limit: both are said before the sheet, not after it.
  Future<void> _save(SearchQuery query) async {
    final l10n = I18n.of(context);
    final saved = context.read<SavedSearchesBloc>();

    if (!getIt<SessionSnapshot>().hasSession) {
      MboaToast.info(context: context, title: l10n.saveSearchSignInTitle, description: l10n.saveSearchSignInBody);
      unawaited(context.router.root.push(LoginRoute()));
      return;
    }
    if (saved.state case final SavedSearchesReady ready when ready.isFull) {
      MboaToast.info(context: context, title: l10n.saveSearchLimitTitle, description: l10n.saveSearchLimitBody);
      return;
    }

    final choice = await showSaveSearchSheet(context);
    if (choice == null) return;
    saved.add(SavedSearchSaveRequested(query, name: choice.name, alertsEnabled: choice.alertsEnabled));
  }

  /// A category tab: one kind, or all — and search again.
  void _pickCategory(PropertyType? type) {
    final bloc = context.read<SearchBloc>();
    final state = bloc.state;
    if (state is! SearchReady) return;
    bloc
      ..add(SearchFilterChanged(state.query.copyWith(propertyTypes: type == null ? const [] : [type])))
      ..add(const SearchSubmitted());
  }

  void _openSavedSearches() {
    if (!getIt<SessionSnapshot>().hasSession) {
      unawaited(context.router.root.push(LoginRoute()));
      return;
    }
    unawaited(context.router.root.push(const AuthenticatedRouter(children: [SavedSearchesRoute()])));
  }

  /// The shell's tabs: Messages is the third, Compte the fourth.
  void _openTab(int index) => context.tabsRouter.setActiveIndex(index);

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      body: SafeArea(
        bottom: false,
        child: BlocListener<SavedSearchesBloc, SavedSearchesState>(
          // Only what a save came to: changes made on the list say their own.
          listenWhen: (prev, curr) =>
              prev is SavedSearchesReady && prev.isSaving && curr is SavedSearchesReady && curr.outcome != null,
          listener: (context, state) {
            if (state is! SavedSearchesReady) return;
            switch (state.outcome) {
              case SavedSearchOutcome.saved:
                MboaToast.success(context: context, title: l10n.saveSearchDone, description: l10n.saveSearchDoneBody);
              case SavedSearchOutcome.limitReached:
                MboaToast.info(context: context, title: l10n.saveSearchLimitTitle, description: l10n.saveSearchLimitBody);
              case SavedSearchOutcome.alreadySaved:
                MboaToast.info(context: context, title: l10n.saveSearchDuplicate);
              case SavedSearchOutcome.failed:
                MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.saveSearchFailed);
              case null:
                break;
            }
          },
          child: Column(
            children: [
              SearchGreeting(
                onSavedSearches: _openSavedSearches,
                onMessages: () => _openTab(2),
                onAvatar: () => getIt<SessionSnapshot>().hasSession
                    ? _openTab(3)
                    : unawaited(context.router.root.push(LoginRoute())),
              ),
              Expanded(
                child: BlocConsumer<SearchBloc, SearchState>(
                  // RM-M04-08 — no position: said, and where it helps, the
                  // way to the settings.
                  listenWhen: (_, curr) => curr is SearchReady && curr.locationRefusal != null,
                  listener: (context, state) => _sayNoPosition(context, (state as SearchReady).locationRefusal!),
                  builder: (context, state) => switch (state) {
                    SearchInitial() => const Center(child: Loader()),
                    SearchFailure() => _Failure(
                        onRetry: () => context.read<SearchBloc>().add(const SearchSubmitted()),
                      ),
                    final SearchReady ready => _Home(
                        state: ready,
                        view: _view,
                        controller: _scroll,
                        onPickCity: _pickCity,
                        onOpenFilters: _openFilters,
                        onCategory: _pickCategory,
                        onSave: () => _save(ready.query),
                        onToggleView: () => setState(() => _view = _view == _View.list ? _View.map : _View.list),
                      ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Why there is no position. A refusal for good, or the phone's location
/// off, only the settings can change: a sheet with that one door. Otherwise
/// a word — tapping « Près de toi » again asks again.
Future<void> _sayNoPosition(BuildContext context, LocationRefusal reason) async {
  final l10n = I18n.of(context);
  final colors = context.mboaColors;
  final (title, body) = switch (reason) {
    LocationRefusal.deniedForever => (l10n.searchLocationBlockedTitle, l10n.searchLocationBlockedBody),
    LocationRefusal.serviceOff => (l10n.searchLocationOffTitle, l10n.searchLocationOffBody),
    LocationRefusal.denied => (null, l10n.searchLocationDenied),
    LocationRefusal.unavailable => (null, l10n.searchLocationUnavailable),
  };
  if (title == null) {
    MboaToast.info(context: context, title: body);
    return;
  }
  final bloc = context.read<SearchBloc>();
  final open = await showModalBottomSheet<bool>(
    context: context,
    backgroundColor: colors.surface,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl))),
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(LucideIcons.mapPinOff, size: Dimens.iconLg, color: colors.primary),
            const SizedBox(height: Dimens.spacing),
            Text(title, textAlign: TextAlign.center, style: context.mboaText.h3.copyWith(color: colors.ink)),
            const SizedBox(height: Dimens.spacingSm),
            Text(body, textAlign: TextAlign.center, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
            const SizedBox(height: Dimens.spacingLg),
            Button.primary(
              title: l10n.searchLocationOpenSettings,
              onPressed: () => Navigator.of(sheetContext).pop(true),
            ),
          ],
        ),
      ),
    ),
  );
  if (open ?? false) bloc.add(SearchLocationSettingsRequested(reason));
}

/// The search home under its bloc: the city and the filters, the category
/// tabs, then the list or the map — and the pill that switches them.
class _Home extends StatelessWidget {
  const _Home({
    required this.state,
    required this.view,
    required this.controller,
    required this.onPickCity,
    required this.onOpenFilters,
    required this.onCategory,
    required this.onSave,
    required this.onToggleView,
  });

  final SearchReady state;
  final _View view;
  final ScrollController controller;
  final VoidCallback onPickCity;
  final VoidCallback onOpenFilters;
  final ValueChanged<PropertyType?> onCategory;
  final VoidCallback onSave;
  final VoidCallback onToggleView;

  @override
  Widget build(BuildContext context) {
    final types = state.query.propertyTypes;
    // Nothing to switch between until a city is chosen (RM-M04-01), and an
    // empty map is not a second empty state.
    final hasResults = state.query.isValid && !state.isEmpty && !state.isLoading;

    return Column(
      children: [
        _SearchBar(state: state, onPickCity: onPickCity, onOpenFilters: onOpenFilters),
        SearchCategoryTabs(
          selected: types.length == 1 ? types.single : null,
          allSelected: types.isEmpty,
          onSelected: onCategory,
        ),
        if (state.cachedBecause case final reason?)
          _CacheBanner(
            reason: reason,
            onRetry: () => context.read<SearchBloc>().add(const SearchSubmitted()),
          ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: switch (view) {
                  _View.list => _Feed(state: state, controller: controller, onSave: onSave),
                  _View.map => Column(
                      children: [
                        if (hasResults) _ResultsHeader(count: state.hits.length, onSave: onSave),
                        Expanded(
                          child: SearchMapView(
                            state: state,
                            onOpen: (hit) => _open(context, hit),
                            // The tapped place's card sits above the pill.
                            cardBottomInset: 72,
                          ),
                        ),
                      ],
                    ),
                },
              ),
              if (hasResults)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: Dimens.spacing,
                  child: Center(child: SearchViewPill(showingMap: view == _View.map, onToggle: onToggleView)),
                ),
            ],
          ),
        ),
      ],
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

/// How many results, and keeping the search to be told what is new.
///
/// The count earns its line: "12 biens" tells a reader whether to refine
/// before they start scrolling, and it is the honest place to say that the
/// map draws the same results as the list.
class _ResultsHeader extends StatelessWidget {
  const _ResultsHeader({required this.count, required this.onSave});

  final int count;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.spacingSm, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(l10n.searchResultCount(count), style: context.mboaText.label.copyWith(color: colors.ink)),
          ),
          IconButton(
            onPressed: onSave,
            tooltip: l10n.saveSearchAction,
            icon: Icon(LucideIcons.bookmarkPlus, color: colors.primary),
          ),
        ],
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
                padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
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
                            ? context.mboaText.body.copyWith(color: colors.textTertiary)
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

/// The list half, after the founder's mockup: the next rent if any, the
/// count, « À la une » — the Pro and Pro+ places the server ranks first,
/// as big photo cards — then every other place, as rows. Places are loaded
/// page by page as the end comes near (RM-M04-03).
class _Feed extends StatelessWidget {
  const _Feed({required this.state, required this.controller, required this.onSave});

  final SearchReady state;
  final ScrollController controller;
  final VoidCallback onSave;

  /// `tierRank`: 3 Pro+, 2 Pro — the server's own order puts them first.
  static const _featuredFrom = 2;
  static const _featuredMax = 8;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    if (state.isLoading) return const Center(child: Loader());
    if (!state.query.isValid) return const _NoCityYet();
    if (state.isEmpty) return const _NoResult();

    final nearest = state.sort == SearchSort.distance;
    // Nearest first is one list: a carousel ahead of it would break the order.
    final featured = nearest
        ? const <SearchHit>[]
        : [
            for (final hit in state.hits)
              if ((hit.tierRank ?? 0) >= _featuredFrom) hit,
          ].take(_featuredMax).toList();
    final rest = [for (final hit in state.hits) if (!featured.contains(hit)) hit];

    return CustomScrollView(
      controller: controller,
      slivers: [
        // M30 — the next rent, while a space is active.
        const SliverToBoxAdapter(child: NextRentBanner()),
        SliverToBoxAdapter(child: _ResultsHeader(count: state.hits.length, onSave: onSave)),
        // RM-M04-08 — not over cached results: they carry no distance, and
        // the order cannot be asked again offline.
        if (!state.isFromCache)
          SliverToBoxAdapter(
            child: SearchSortChips(
              sort: state.sort,
              isLocating: state.isLocating,
              onChanged: (sort) => context.read<SearchBloc>().add(SearchSortChanged(sort)),
            ),
          ),
        if (featured.isNotEmpty) ...[
          SliverToBoxAdapter(child: SearchSectionTitle(l10n.searchFeatured)),
          SliverToBoxAdapter(
            child: SizedBox(
              height: FeaturedHitCard.height,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
                itemCount: featured.length,
                separatorBuilder: (_, _) => const SizedBox(width: Dimens.spacingMd),
                itemBuilder: (context, index) =>
                    FeaturedHitCard(hit: featured[index], onTap: () => _open(context, featured[index])),
              ),
            ),
          ),
        ],
        if (rest.isNotEmpty)
          SliverToBoxAdapter(
            child: SearchSectionTitle(
              switch ((nearest, state.query.cityName)) {
                (true, final city?) => l10n.searchNearbyTitle(city),
                (false, final city?) => l10n.searchInCity(city),
                (_, null) => l10n.searchAllPlaces,
              },
            ),
          ),
        SliverPadding(
          // Room under the last row for the pill.
          padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, 96),
          sliver: SliverList.builder(
            // One extra row for the loader that pulls the next page in.
            itemCount: rest.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= rest.length) {
                return const Padding(padding: EdgeInsets.all(Dimens.spacing), child: Center(child: Loader()));
              }
              final hit = rest[index];
              return HitRowCard(hit: hit, onTap: () => _open(context, hit));
            },
          ),
        ),
      ],
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
