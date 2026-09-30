import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../bloc/favorites_bloc.dart';
import '../../data/favorites_repository.dart';

/// The save button, wherever a listing appears (CDC M06).
///
/// One bloc behind every instance, so the heart on a search card and the heart
/// on that listing's fiche cannot disagree. A visitor gets the sign-in prompt
/// (RM-M04-05) rather than a tap that silently does nothing.
class FavoriteHeart extends StatelessWidget {
  const FavoriteHeart({
    super.key,
    required this.annonceId,
    required this.optimistic,
    this.background = false,
  });

  final String annonceId;

  /// What the list should show while the round trip is in flight — built from
  /// the card that was tapped, so nothing blinks.
  final Favorite optimistic;

  /// Drawn over a photo: the icon gets a disc behind it to stay legible.
  final bool background;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final saved = state.contains(annonceId);

        final icon = Icon(
          saved ? LucideIcons.heartCrack : LucideIcons.heart,
          size: Dimens.icon,
          color: saved ? colors.action : (background ? colors.ink : colors.textSecondary),
        );

        return IconButton(
          tooltip: saved ? l10n.favoritesRemove : l10n.favoritesAdd,
          style: background
              ? IconButton.styleFrom(
                  backgroundColor: colors.surface.withValues(alpha: 0.9),
                )
              : null,
          onPressed: () => _toggle(context, saved: saved),
          icon: icon,
        );
      },
    );
  }

  void _toggle(BuildContext context, {required bool saved}) {
    final l10n = I18n.of(context);

    // RM-M04-05 — saving needs an account; the prompt is the wall, not a
    // silent no-op.
    if (!getIt<SessionSnapshot>().hasSession) {
      MboaToast.info(
        context: context,
        title: l10n.favoritesSignInTitle,
        description: l10n.favoritesSignInBody,
      );
      context.router.root.push(LoginRoute());
      return;
    }

    context
        .read<FavoritesBloc>()
        .add(FavoriteToggled(annonceId, optimistic: optimistic));
  }
}

/// Builds the placeholder row a heart shows while the server catches up.
Favorite optimisticFavorite({
  required String annonceId,
  String? title,
  String? photoKey,
  int? price,
  RentalPeriod rentalPeriod = RentalPeriod.fallback,
  String? city,
  String? district,
}) =>
    Favorite(
      annonceId: annonceId,
      title: title,
      primaryPhotoKey: photoKey,
      price: price,
      rentalPeriod: rentalPeriod,
      city: city,
      district: district,
      savedAt: DateTime.now(),
    );
