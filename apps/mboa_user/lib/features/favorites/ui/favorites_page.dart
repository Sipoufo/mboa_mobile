import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/favorites_bloc.dart';
import '../data/favorites_repository.dart';
import 'widgets/favorite_heart.dart';

/// Saved listings (CDC M06).
///
/// Needs an account — a visitor gets the same invitation the heart gives
/// (RM-M04-05) rather than an empty list that looks broken.
@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    if (getIt<SessionSnapshot>().hasSession) {
      context.read<FavoritesBloc>().add(const FavoritesLoadRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    // The shell survives a sign-in, so this page is never rebuilt by the
    // navigation — it has to listen for the session itself, or it keeps
    // offering to create an account to someone who just made one.
    return ListenableBuilder(
      listenable: getIt<SessionSnapshot>(),
      builder: (context, _) => _build(context),
    );
  }

  Widget _build(BuildContext context) {
    final l10n = I18n.of(context);

    if (!getIt<SessionSnapshot>().hasSession) {
      return Scaffold(
        backgroundColor: context.mboaColors.background,
        appBar: AppBar(title: Text(l10n.navFavorites)),
        body: const _SignInPrompt(),
      );
    }

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.navFavorites)),
      body: BlocConsumer<FavoritesBloc, FavoritesState>(
        listenWhen: (prev, curr) =>
            curr is FavoritesReady &&
            (curr.limitReached || curr.lastActionFailed),
        listener: (context, state) {
          final ready = state as FavoritesReady;
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: ready.limitReached
                ? l10n.favoritesLimitReached
                : l10n.commonError,
          );
        },
        builder: (context, state) => switch (state) {
          FavoritesInitial() || FavoritesLoadInProgress() =>
            const Center(child: Loader()),
          FavoritesFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<FavoritesBloc>()
                    .add(const FavoritesLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final FavoritesReady ready =>
            ready.items.isEmpty ? const _Empty() : _List(state: ready),
        },
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt();

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
              LucideIcons.heart,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.favoritesSignInTitle,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.favoritesSignInBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacingLg),
            Button.primary(
              title: l10n.accountSignIn,
              onPressed: () => context.router.root.push(LoginRoute()),
            ),
          ],
        ),
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
              LucideIcons.heart,
              size: Dimens.iconLg,
              color: colors.textTertiary,
            ),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.favoritesEmptyTitle,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.favoritesEmptyBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _List extends StatelessWidget {
  const _List({required this.state});

  final FavoritesReady state;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async => context
            .read<FavoritesBloc>()
            .add(const FavoritesLoadRequested()),
        child: ListView.builder(
          padding: const EdgeInsets.all(Dimens.spacing),
          itemCount: state.items.length,
          itemBuilder: (context, index) =>
              _FavoriteCard(favorite: state.items[index]),
        ),
      );
}

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.favorite});

  final Favorite favorite;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        // A listing that is gone has nothing to open (CE-M05-01 would meet the
        // tap anyway); the row stays as a record of what was saved.
        onTap: favorite.isAvailable
            ? () => context.router
                .push(ListingDetailRoute(id: favorite.annonceId))
            : null,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMd),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: MboaNetworkImage(
                    url: favorite.photoUrl,
                    placeholder: const MboaImagePlaceholder(size: 72),
                  ),
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.title ?? '',
                      style: context.mboaText.label.copyWith(color: colors.ink),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimens.spacingXs),
                    if (favorite.displayPrice case final price?)
                      Text(
                        favorite.rentalPeriod.priceLabel(l10n, price),
                        style: context.mboaText.caption
                            .copyWith(color: colors.primary),
                      ),
                    Text(
                      [favorite.district, favorite.city].nonNulls.join(', '),
                      style: context.mboaText.caption
                          .copyWith(color: colors.textTertiary),
                    ),
                    // Kept 30 days, flagged: dropping the row silently would
                    // look like the app lost it.
                    if (!favorite.isAvailable) ...[
                      const SizedBox(height: Dimens.spacingXs),
                      Text(
                        l10n.favoritesUnavailable,
                        style: context.mboaText.caption
                            .copyWith(color: colors.error),
                      ),
                      Text(
                        l10n.favoritesUnavailableNote,
                        style: context.mboaText.caption
                            .copyWith(color: colors.textTertiary),
                      ),
                    ],
                  ],
                ),
              ),
              FavoriteHeart(
                annonceId: favorite.annonceId,
                optimistic: favorite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
