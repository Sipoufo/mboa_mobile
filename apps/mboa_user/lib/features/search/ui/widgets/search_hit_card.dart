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
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
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
    final url = hit.photoUrl;

    // CE-M05-02 — a placeholder rather than a broken frame.
    Widget placeholder() => ColoredBox(
          color: colors.primaryPale,
          child: Center(
            child: Icon(
              hit is ResidenceHit ? LucideIcons.layers : LucideIcons.image,
              color: colors.primary,
            ),
          ),
        );

    return SizedBox(
      height: 170,
      width: double.infinity,
      child: MboaNetworkImage(url: url, placeholder: placeholder()),
    );
  }
}

class _ListingBody extends StatelessWidget {
  const _ListingBody({required this.hit});

  final ListingHit hit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final facts = [
      hit.propertyType.label(l10n),
      if (hit.roomCount case final rooms?) l10n.annoncesRooms(rooms),
      if (hit.surfaceArea case final surface?) l10n.annoncesSurface('$surface'),
    ].join(' · ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hit.displayPrice case final price?)
          Text(
            hit.rentalPeriod.priceLabel(l10n, price),
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          hit.title ?? '',
          style: context.mboaText.label.copyWith(color: colors.ink),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          facts,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingXs),
        _Place(city: hit.city, district: hit.district),
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
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (hit.fromMonthlyRent case final from?)
              Expanded(
                child: Text(
                  l10n.searchResidenceFrom(
                    hit.rentFromLabel(from),
                  ),
                  style:
                      context.mboaText.h3.copyWith(color: colors.primaryDark),
                ),
              )
            else
              const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spacingSm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: colors.primaryPale,
                borderRadius: BorderRadius.circular(Dimens.radiusFull),
              ),
              child: Text(
                l10n.searchResidenceBadge,
                style:
                    context.mboaText.caption.copyWith(color: colors.primaryDark),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          hit.title ?? '',
          style: context.mboaText.label.copyWith(color: colors.ink),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.searchResidenceUnits(hit.availableUnitCount ?? 0),
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingXs),
        _Place(city: hit.city, district: hit.district),
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
        Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: colors.primary),
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
