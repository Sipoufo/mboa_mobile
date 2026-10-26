import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../favorites/ui/widgets/favorite_heart.dart';
import 'listing_bits.dart';

/// The mockup's star, in the brand's gold rather than the theme's green.
const _star = Color(0xFFFFC83D);

/// The fiche's photo, and what the founder's mockup lays over it: the
/// rating and the rent, the title, the place — and, bottom right, the full
/// gallery and the heart.
///
/// RM-M05-01 — three photos in the carousel, every one behind the gallery.
class ListingHero extends StatelessWidget {
  const ListingHero({super.key, required this.detail});

  final ListingDetail detail;

  static const double height = FicheHero.height;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final price = detail.displayPrice;

    return FicheHero(
      photoUrls: detail.photoUrls,
      title: detail.title,
      place: [detail.district, detail.city].nonNulls.join(', '),
      rating: detail.rating,
      price: price == null ? null : detail.rentalPeriod.priceLabel(l10n, price),
      trailing: FavoriteHeart(
        annonceId: detail.id,
        background: true,
        optimistic: optimisticFavorite(
          annonceId: detail.id,
          title: detail.title,
          photoKey: detail.photoKeys.firstOrNull,
          price: detail.displayPrice,
          rentalPeriod: detail.rentalPeriod,
          city: detail.city,
          district: detail.district,
        ),
      ),
    );
  }
}

/// A fiche's photo with its words laid over it — a listing's or a residence's.
/// Three photos in the carousel; the gallery button opens every one.
class FicheHero extends StatefulWidget {
  const FicheHero({
    super.key,
    required this.photoUrls,
    this.title,
    this.place = '',
    this.rating = const PropertyRatingSummary(),
    this.price,
    this.trailing,
  });

  final List<String> photoUrls;
  final String? title;
  final String place;
  final PropertyRatingSummary rating;

  /// Already worded: « 110 000 FCFA / mois », « À partir de … ».
  final String? price;

  /// Beside the gallery button — the listing's heart.
  final Widget? trailing;

  static const double height = 320;

  @override
  State<FicheHero> createState() => _FicheHeroState();
}

class _FicheHeroState extends State<FicheHero> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final urls = widget.photoUrls;
    final shown = urls.take(ListingDetail.carouselPhotos).toList();
    final rating = widget.rating;
    final price = widget.price;
    final place = widget.place;
    final trailing = widget.trailing;

    Widget placeholder() => ColoredBox(
          color: colors.primaryPale,
          child: Center(child: Icon(LucideIcons.image, color: colors.primary)),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: SizedBox(
        height: FicheHero.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: shown.isEmpty
                  ? placeholder()
                  : PageView.builder(
                      controller: _controller,
                      onPageChanged: (page) => setState(() => _page = page),
                      itemCount: shown.length,
                      // CE-M05-02 — a placeholder, never a broken frame.
                      itemBuilder: (context, index) => MboaNetworkImage(url: shown[index], placeholder: placeholder()),
                    ),
            ),
            // The words sit on a shade, never on the photo itself.
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Colors.black.withValues(alpha: 0.6), Colors.black.withValues(alpha: 0)],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: Dimens.spacing,
              // Clear of the buttons: one, or two with the heart.
              right: trailing == null ? 72 : 104,
              bottom: Dimens.spacingLg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // RM-M05-08 — no rating, no number.
                      if (rating.hasRating) ...[
                        Text(
                          rating.average!.toStringAsFixed(1),
                          style: context.mboaText.label.copyWith(color: colors.onBrand),
                        ),
                        const SizedBox(width: 2),
                        const Icon(LucideIcons.star, size: Dimens.iconSm, color: _star),
                        const SizedBox(width: Dimens.spacingSm),
                      ],
                      if (price != null)
                        Flexible(
                          child: Text(
                            price,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.mboaText.caption.copyWith(color: colors.onBrand),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    widget.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.h2.copyWith(color: colors.onBrand),
                  ),
                  if (place.isNotEmpty) ...[
                    const SizedBox(height: Dimens.spacingXs),
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: colors.onBrand),
                        const SizedBox(width: Dimens.spacingXs),
                        Flexible(
                          child: Text(
                            place,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.mboaText.label.copyWith(color: colors.onBrand),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              right: Dimens.spacing,
              bottom: Dimens.spacingLg,
              child: Row(
                children: [
                  if (urls.isNotEmpty)
                    _GlassButton(
                      tooltip: l10n.listingAllPhotos,
                      icon: LucideIcons.images,
                      onPressed: () => showListingGallery(context, urls: urls, initial: _page),
                    ),
                  if (trailing != null) ...[
                    const SizedBox(width: Dimens.spacingSm),
                    trailing,
                  ],
                ],
              ),
            ),
            if (shown.length > 1)
              Positioned(
                bottom: Dimens.spacingSm,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < shown.length; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: i == _page ? 18 : 6,
                          height: 4,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimens.radiusFull),
                            color: i == _page ? colors.onBrand : colors.onBrand.withValues(alpha: 0.45),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A round, see-through button over the photo.
class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.tooltip, required this.icon, required this.onPressed});

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.white.withValues(alpha: 0.28),
        shape: const CircleBorder(),
        child: IconButton(
          tooltip: tooltip,
          onPressed: onPressed,
          icon: Icon(icon, color: context.mboaColors.onBrand, size: Dimens.icon),
        ),
      );
}

/// Every photo, full screen, swiped through — RM-M05-01's "galerie".
Future<void> showListingGallery(BuildContext context, {required List<String> urls, int initial = 0}) =>
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).closeButtonLabel,
      barrierColor: Colors.black,
      pageBuilder: (dialogContext, _, _) => _Gallery(urls: urls, initial: initial),
    );

class _Gallery extends StatefulWidget {
  const _Gallery({required this.urls, required this.initial});

  final List<String> urls;
  final int initial;

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  late final _controller = PageController(initialPage: widget.initial);
  late int _page = widget.initial;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.urls.length,
              onPageChanged: (page) => setState(() => _page = page),
              itemBuilder: (context, index) => InteractiveViewer(
                child: Center(child: MboaNetworkImage(url: widget.urls[index], fit: BoxFit.contain)),
              ),
            ),
            Positioned(
              top: Dimens.spacingSm,
              left: Dimens.spacingSm,
              child: IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(LucideIcons.x, color: Colors.white),
              ),
            ),
            Positioned(
              top: Dimens.spacing,
              right: Dimens.spacing,
              child: Text(
                l10n.listingGalleryPosition('${_page + 1}', '${widget.urls.length}'),
                style: context.mboaText.label.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// What the place is, as pills — the mockup's row of characteristics, from
/// the facts and the amenities together.
class ListingFactChips extends StatelessWidget {
  const ListingFactChips({super.key, required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    final facts = <(IconData, String)>[
      (LucideIcons.house, detail.propertyType.label(l10n)),
      if (detail.surfaceArea case final surface?) (LucideIcons.ruler, l10n.annoncesSurface('$surface')),
      if (detail.roomCount case final rooms?) (LucideIcons.doorOpen, l10n.listingFactRooms(rooms)),
      if (detail.bathroomCount case final baths?) (LucideIcons.bath, l10n.listingFactBathrooms(baths)),
      if (detail.furnished case final furnished?)
        (LucideIcons.sofa, furnished ? l10n.listingFactFurnished : l10n.listingFactUnfurnished),
      if (detail.chargesIncluded case final included?)
        (LucideIcons.receipt, included ? l10n.listingFactChargesIncluded : l10n.listingFactChargesExtra),
      if (detail.availableFrom case final from?)
        (LucideIcons.calendarCheck, l10n.listingFactAvailableFrom(DateFormat.yMMMd(locale).format(from))),
      for (final amenity in detail.amenities) (LucideIcons.check, amenity.label(l10n)),
    ];

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [for (final (icon, label) in facts) FichePill(icon: icon, label: label)],
    );
  }
}

/// One characteristic, as a pill.
class FichePill extends StatelessWidget {
  const FichePill({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingMd, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surfaceWarm,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.textSecondary),
          const SizedBox(width: Dimens.spacingXs),
          Text(label, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
        ],
      ),
    );
  }
}

/// Who rents it out — the mockup's "Managers" row: the face, the name, what
/// kind of prestataire, and the badges in prestige order (RM-M05-03).
class ListingProviderRow extends StatelessWidget {
  const ListingProviderRow({super.key, required this.provider});

  final ProviderSummary provider;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final name = provider.displayName ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MboaAvatar(
              imageUrl: provider.logoUrl,
              initials: name.isEmpty ? '' : name[0].toUpperCase(),
              size: Dimens.avatar,
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: context.mboaText.label.copyWith(color: colors.primaryDark)),
                  if (provider.type case final type?)
                    Text(
                      prestataireKindLabel(l10n, type),
                      style: context.mboaText.caption.copyWith(color: colors.textTertiary),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (provider.badges.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingMd),
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [for (final badge in provider.badges) TrustBadgeChip(badge: badge)],
          ),
        ],
      ],
    );
  }
}

/// The mockup's two cards side by side: where it is, and what people say.
/// Either may be absent — no position, no map; no rating, no reviews card
/// (RM-M05-08) — and the other then takes the row.
class ListingCardsRow extends StatelessWidget {
  const ListingCardsRow({
    super.key,
    required this.hasPosition,
    required this.rating,
    required this.onOpenMap,
    required this.onOpenReviews,
  });

  final bool hasPosition;
  final PropertyRatingSummary rating;
  final VoidCallback onOpenMap;
  final VoidCallback onOpenReviews;

  static const double height = 150;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final cards = <Widget>[
      if (hasPosition)
        _Card(
          title: l10n.listingLocationCard,
          onTap: onOpenMap,
          background: CustomPaint(painter: _MapSketch(colors)),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(Dimens.spacingSm),
              decoration: BoxDecoration(
                color: colors.primary,
                shape: BoxShape.circle,
                boxShadow: MboaShadows.card,
              ),
              child: Icon(LucideIcons.mapPin, color: colors.onBrand, size: Dimens.icon),
            ),
          ),
        ),
      if (rating.hasRating)
        _Card(
          title: l10n.listingReviewsCard,
          onTap: onOpenReviews,
          background: MboaDecorDiscs(color: colors.primary, opacity: 0.06),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      rating.average!.toStringAsFixed(1),
                      style: context.mboaText.h1.copyWith(color: colors.primaryDark),
                    ),
                    const SizedBox(width: Dimens.spacingXs),
                    const Icon(LucideIcons.star, color: _star),
                  ],
                ),
                Text(
                  l10n.listingReviewsCount(rating.reviewCount),
                  style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ),
    ];
    if (cards.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: height,
      child: Row(
        children: [
          for (final (index, card) in cards.indexed) ...[
            if (index > 0) const SizedBox(width: Dimens.spacingMd),
            Expanded(child: card),
          ],
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.onTap, required this.background, required this.child});

  final String title;
  final VoidCallback onTap;
  final Widget background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned.fill(child: background),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
                  Expanded(child: child),
                ],
              ),
            ),
            Positioned(
              right: Dimens.spacingMd,
              bottom: Dimens.spacingMd,
              child: Icon(LucideIcons.arrowDownRight, color: colors.primary, size: Dimens.icon),
            ),
          ],
        ),
      ),
    );
  }
}

/// A few streets and a roundabout — a map's look without a map's weight
/// (no tiles to load to say "there is a map behind this card").
class _MapSketch extends CustomPainter {
  const _MapSketch(this.colors);

  final MboaColorScheme colors;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = colors.primaryPale.withValues(alpha: 0.6));
    final road = Paint()
      ..color = colors.surface
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final w = size.width;
    final h = size.height;
    canvas
      ..drawLine(Offset(0, h * 0.62), Offset(w, h * 0.48), road)
      ..drawLine(Offset(w * 0.3, 0), Offset(w * 0.42, h), road)
      ..drawLine(Offset(w * 0.72, h * 0.15), Offset(w, h * 0.9), road..strokeWidth = 4)
      ..drawCircle(Offset(w * 0.38, h * 0.56), h * 0.16, road..strokeWidth = 6);
  }

  @override
  bool shouldRepaint(_MapSketch old) => old.colors != colors;
}
