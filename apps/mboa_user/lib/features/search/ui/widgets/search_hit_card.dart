import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../favorites/ui/widgets/favorite_heart.dart';

/// One result (CDC M04 "Vue liste").
///
/// A listing and a residence are **not the same offer** — one is a place to
/// rent, the other a building with several — so the card switches on the
/// sealed hit rather than flattening both into a lowest common denominator.
class SearchHitCard extends StatelessWidget {
  const SearchHitCard({
    super.key,
    required this.hit,
    this.onTap,
    this.compact = false,
  });

  /// One result, laid out for a map: a thumbnail beside the text instead of a
  /// photo above it.
  ///
  /// The full card is two thirds of a phone screen. Over a map that is most of
  /// the map, and the reader loses the one thing they switched views for —
  /// where this place is in relation to the others.
  const SearchHitCard.compact({
    super.key,
    required this.hit,
    this.onTap,
  }) : compact = true;

  final SearchHit hit;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    if (compact) return _CompactCard(hit: hit, onTap: onTap);

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        boxShadow: MboaShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _Photo(hit: hit),
                Positioned(
                  top: Dimens.spacingMd,
                  left: Dimens.spacingMd,
                  child: _TypeBadge(hit: hit),
                ),
                // A residence is not saved: favourites are listings (M06), and
                // its units each have their own fiche.
                if (hit case final ListingHit listing)
                  Positioned(
                    top: Dimens.spacingSm,
                    right: Dimens.spacingSm,
                    child: FavoriteHeart(
                      annonceId: listing.id,
                      background: true,
                      optimistic: optimisticFavorite(
                        annonceId: listing.id,
                        title: listing.title,
                        photoKey: listing.primaryPhotoKey,
                        price: listing.displayPrice,
                        rentalPeriod: listing.rentalPeriod,
                        city: listing.city,
                        district: listing.district,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: switch (hit) {
                final ListingHit listing => _ListingBody(hit: listing),
                final ResidenceHit residence => _ResidenceBody(hit: residence),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.hit});

  final SearchHit hit;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    // 4:3 (Doc 05 §6.2) rather than a fixed height: the card then holds its
    // proportions on a small phone and a tablet alike.
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: MboaNetworkImage(
        url: hit.photoUrl,
        placeholder: ColoredBox(
          color: colors.primaryPale,
          child: Center(
            child: Icon(
              hit is ResidenceHit ? LucideIcons.layers : LucideIcons.image,
              color: colors.primary,
              size: Dimens.iconLg,
            ),
          ),
        ),
      ),
    );
  }
}

/// The pill over the photo: what kind of place this is, or that it is a whole
/// residence (Doc 05 §6.4).
class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.hit});

  final SearchHit hit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final isResidence = hit is ResidenceHit;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingMd,
        vertical: Dimens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isResidence) ...[
            Icon(LucideIcons.layers, size: 14, color: colors.primary),
            const SizedBox(width: Dimens.spacingXs),
          ],
          Text(
            switch (hit) {
              final ListingHit listing => listing.propertyType.label(l10n),
              ResidenceHit() => l10n.searchResidenceBadge,
            },
            style: context.mboaText.caption.copyWith(color: colors.primaryDark),
          ),
        ],
      ),
    );
  }
}

class _ListingBody extends StatelessWidget {
  const _ListingBody({required this.hit});

  final ListingHit hit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    // The numbers someone scans a list for, as icons: a row of glyphs is read
    // faster than "Studio · 2 pièces · 45 m²", and reads the same in French
    // and in English. Often empty — plenty of listings carry neither a room
    // count nor a surface — so the row and its spacing go together, or the
    // card keeps a blank band where the facts would have been.
    final facts = <(IconData, String)>[
      if (hit.roomCount case final rooms?) (LucideIcons.bedDouble, '$rooms'),
      if (hit.surfaceArea case final surface?)
        (LucideIcons.ruler, l10n.annoncesSurface('$surface')),
      if (hit.furnished ?? false)
        (LucideIcons.armchair, l10n.annonceFormFieldFurnished),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(hit.title),
        const SizedBox(height: Dimens.spacingXs),
        _Place(city: hit.city, district: hit.district),
        _Badges(badges: hit.badges),
        if (facts.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingMd),
          _Facts(facts: facts),
        ],
        if (hit.displayPrice case final price?) ...[
          const SizedBox(height: Dimens.spacingMd),
          _PriceRow(label: hit.rentalPeriod.priceLabel(l10n, price)),
        ],
      ],
    );
  }
}

class _ResidenceBody extends StatelessWidget {
  const _ResidenceBody({required this.hit});

  final ResidenceHit hit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Title(hit.title),
        const SizedBox(height: Dimens.spacingXs),
        _Place(city: hit.city, district: hit.district),
        _Badges(badges: hit.badges),
        const SizedBox(height: Dimens.spacingMd),
        _Facts(
          facts: [
            (
              LucideIcons.doorOpen,
              l10n.searchResidenceUnits(hit.availableUnitCount ?? 0),
            ),
          ],
        ),

        if (hit.fromMonthlyRent case final from?) ...[
          const SizedBox(height: Dimens.spacingMd),
          _PriceRow(
            label: l10n.searchResidenceFrom(hit.rentFromLabel(from)),
          ),
        ],
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title(this.title);

  final String? title;

  @override
  Widget build(BuildContext context) => Text(
        title ?? '',
        style: context.mboaText.h3.copyWith(color: context.mboaColors.ink),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
}

/// The trust badges, as icons only (RM-M20, on cards since 2026-10-02).
///
/// No labels here: four of them would wrap onto three lines and bury the price.
/// The fiche spells them out — this is the signal that a card is worth opening.
class _Badges extends StatelessWidget {
  const _Badges({required this.badges});

  final List<TrustBadge> badges;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) return const SizedBox.shrink();
    final colors = context.mboaColors;
    final l10n = I18n.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: Dimens.spacingSm),
      child: Row(
        children: [
          for (final badge in badges) ...[
            Tooltip(
              message: badge.label(l10n),
              child: Container(
                padding: const EdgeInsets.all(Dimens.spacingXs),
                decoration: BoxDecoration(
                  color: colors.primaryPale,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  switch (badge) {
                    TrustBadge.trustedProvider => LucideIcons.award,
                    TrustBadge.recertified => LucideIcons.refreshCw,
                    TrustBadge.verifiedIdentity => LucideIcons.badgeCheck,
                    TrustBadge.verifiedPhotos => LucideIcons.camera,
                  },
                  size: 14,
                  color: colors.primaryDark,
                ),
              ),
            ),
            const SizedBox(width: Dimens.spacingXs),
          ],
        ],
      ),
    );
  }
}

/// Icon + value, repeated — bedrooms, surface, furnished.
class _Facts extends StatelessWidget {
  const _Facts({required this.facts});

  final List<(IconData, String)> facts;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    if (facts.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        for (final (index, (icon, value)) in facts.indexed) ...[
          if (index > 0) const SizedBox(width: Dimens.spacing),
          Icon(icon, size: Dimens.iconSm, color: colors.textSecondary),
          const SizedBox(width: Dimens.spacingXs),
          Text(
            value,
            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ],
    );
  }
}

/// The last line of the card: the price in coral, and the arrow that says the
/// whole card opens (Doc 05 §6.2).
class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: context.mboaText.h3.copyWith(color: colors.action),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colors.primaryPale,
            shape: BoxShape.circle,
          ),
          child: Icon(
            LucideIcons.arrowRight,
            size: Dimens.iconSm,
            color: colors.primary,
          ),
        ),
      ],
    );
  }
}

class _Place extends StatelessWidget {
  const _Place({this.city, this.district});

  final String? city;
  final String? district;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final place = [district, city].nonNulls.join(', ');
    if (place.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Icon(LucideIcons.mapPin, size: 14, color: colors.textTertiary),
        const SizedBox(width: Dimens.spacingXs),
        Expanded(
          child: Text(
            place,
            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

/// The map's card: thumbnail, price, title, where — and the heart, which is
/// the one action worth having without opening the fiche.
class _CompactCard extends StatelessWidget {
  const _CompactCard({required this.hit, this.onTap});

  final SearchHit hit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final l10n = I18n.of(context);

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingSm),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radius),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: MboaNetworkImage(
                    url: hit.photoUrl,
                    placeholder: const MboaImagePlaceholder(size: 64),
                  ),
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The same words as the full card, through the same
                    // helpers: a price that reads differently in two places is
                    // two prices to the reader.
                    Text(
                      switch (hit) {
                        final ListingHit listing
                            when listing.displayPrice != null =>
                          listing.rentalPeriod
                              .priceLabel(l10n, listing.displayPrice!),
                        final ResidenceHit residence
                            when residence.fromMonthlyRent != null =>
                          l10n.searchResidenceFrom(
                            residence.rentFromLabel(residence.fromMonthlyRent!),
                          ),
                        _ => '',
                      },
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.label
                          .copyWith(color: colors.primaryDark),
                    ),
                    Text(
                      hit.title ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.body.copyWith(color: colors.ink),
                    ),
                    Text(
                      [hit.district, hit.city].nonNulls.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption
                          .copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              if (hit case final ListingHit listing)
                FavoriteHeart(
                  annonceId: listing.id,
                  optimistic: optimisticFavorite(
                    annonceId: listing.id,
                    title: listing.title,
                    photoKey: listing.primaryPhotoKey,
                    price: listing.displayPrice,
                    rentalPeriod: listing.rentalPeriod,
                    city: listing.city,
                    district: listing.district,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
