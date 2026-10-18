import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../search/ui/widgets/search_hit_card.dart';
import '../bloc/saved_search_results_bloc.dart';
import '../bloc/saved_searches_bloc.dart';

/// What a saved search finds (RM-M04-07) — and where an N-01 tap lands.
///
/// [name] is passed from the list; a notification has only the id, so the
/// title is then read from the saved searches already loaded.
@RoutePage()
class SavedSearchResultsPage extends StatelessWidget implements AutoRouteWrapper {
  const SavedSearchResultsPage({super.key, @PathParam('id') required this.id, this.name});

  final String id;
  final String? name;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<SavedSearchResultsBloc>(
            create: (_) => getIt<SavedSearchResultsBloc>()..add(SavedSearchResultsRequested(id)),
          ),
          BlocProvider<SavedSearchesBloc>.value(value: getIt<SavedSearchesBloc>()),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final title = name ??
        switch (context.watch<SavedSearchesBloc>().state) {
          final SavedSearchesReady ready => ready.searches.where((s) => s.id == id).firstOrNull?.name,
          _ => null,
        } ??
        l10n.savedSearchesTitle;

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: BlocConsumer<SavedSearchResultsBloc, SavedSearchResultsState>(
        // Reading the results reset the count on the server; the list follows.
        listenWhen: (prev, curr) =>
            prev is SavedSearchResultsLoading && (curr is SavedSearchResultsReady || curr is SavedSearchResultsEmpty),
        listener: (context, _) => context.read<SavedSearchesBloc>().add(SavedSearchOpened(id)),
        builder: (context, state) => switch (state) {
          SavedSearchResultsLoading() => const Center(child: Loader()),
          SavedSearchResultsEmpty() => const _Empty(),
          SavedSearchResultsFailure() => _Failure(
              onRetry: () => context.read<SavedSearchResultsBloc>().add(SavedSearchResultsRequested(id)),
            ),
          final SavedSearchResultsReady ready => SavedSearchResultsList(state: ready),
        },
      ),
    );
  }
}

/// The hits, paged in as the list nears its end (RM-M04-03).
class SavedSearchResultsList extends StatelessWidget {
  const SavedSearchResultsList({super.key, required this.state});

  final SavedSearchResultsReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final bloc = context.read<SavedSearchResultsBloc>();
    final footer = state.isLoadingMore || state.loadMoreFailed;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 600) bloc.add(const SavedSearchResultsNextPageRequested());
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
        itemCount: state.hits.length + (footer ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.hits.length) {
            return Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Center(
                child: state.loadMoreFailed
                    ? TextButton(
                        onPressed: () => bloc.add(const SavedSearchResultsNextPageRequested()),
                        child: Text(l10n.commonRetry),
                      )
                    : const Loader(),
              ),
            );
          }
          final hit = state.hits[index];
          return SearchHitCard(
            hit: hit,
            onTap: () => switch (hit) {
              ListingHit() => context.router.root.push(ListingDetailRoute(id: hit.id)),
              ResidenceHit() => context.router.root.push(ResidenceDetailRoute(id: hit.id)),
            },
          );
        },
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
            Icon(LucideIcons.searchX, size: Dimens.iconLg, color: colors.textTertiary),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.savedSearchResultsEmpty,
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
      child: Padding(
        padding: const EdgeInsets.all(Dimens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.savedSearchResultsFailed,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacingSm),
            TextButton(onPressed: onRetry, child: Text(l10n.commonRetry)),
          ],
        ),
      ),
    );
  }
}
