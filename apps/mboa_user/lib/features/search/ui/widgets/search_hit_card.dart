import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

/// One result (CDC M04 "Vue liste").
///
/// A listing and a residence are **not the same offer** — one is a place to
/// rent, the other a building with several — so the card switches on the
/// sealed hit rather than flattening both into a lowest common denominator.
class SearchHitCard extends StatelessWidget {
  const SearchHitCard({super.key, required this.hit, this.onTap});

  final SearchHit hit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

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
            _Photo(hit: hit),
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
      child: url == null
          ? placeholder()
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => placeholder(),
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
