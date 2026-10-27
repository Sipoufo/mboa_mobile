import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../favorites/ui/widgets/favorite_heart.dart';
import '../../../profile/profile_types.dart';
import '../../data/search_repository.dart' show SearchSort;
import 'search_hit_card.dart';

/// The search home's head, after the founder's mockup: two shortcuts on the
/// left, the greeting and the avatar on the right.
///
/// The profile is read from its session singleton — the search tab is
/// public (CA-M04-04), so it is not always under the wrapper that provides
/// it. A guest is welcomed instead, and the avatar leads to signing in.
class SearchGreeting extends StatefulWidget {
  const SearchGreeting({
    super.key,
    required this.onSavedSearches,
    required this.onMessages,
    required this.onAvatar,
    this.onNotifications,
  });

  final VoidCallback onSavedSearches;
  final VoidCallback onMessages;
  final VoidCallback onAvatar;

  /// §38 — the bell, for a signed-in reader: a guest has no notifications.
  final VoidCallback? onNotifications;

  @override
  State<SearchGreeting> createState() => _SearchGreetingState();
}

class _SearchGreetingState extends State<SearchGreeting> {
  UserProfileBloc? get _profile =>
      getIt.isRegistered<UserProfileBloc>() &&
          getIt.isRegistered<SessionSnapshot>() &&
          getIt<SessionSnapshot>().hasSession
      ? getIt<UserProfileBloc>()
      : null;

  @override
  void initState() {
    super.initState();
    final profile = _profile;
    if (profile != null && profile.state is ProfileInitial) profile.add(const ProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final profile = _profile;

    Widget shortcut(IconData icon, String tooltip, VoidCallback onTap) => IconButton(
      tooltip: tooltip,
      onPressed: onTap,
      icon: Icon(icon, color: colors.primary, size: Dimens.iconMd),
    );

    Widget body(BaseProfile? data) => Row(
      children: [
        shortcut(LucideIcons.bookmark, l10n.savedSearchesTitle, widget.onSavedSearches),
        shortcut(LucideIcons.messageSquareText, l10n.navMessages, widget.onMessages),
        if (widget.onNotifications case final onNotifications? when profile != null && getIt.isRegistered<InboxBloc>())
          NotificationBell(bloc: getIt<InboxBloc>(), onPressed: onNotifications),
        // The greeting and the avatar as one group, against the right edge;
        // the words take what the shortcuts leave.
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(l10n.searchHello, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
                    Text(
                      data == null ? l10n.searchWelcome : (data.firstName ?? data.fullName),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Semantics(
                button: true,
                label: data == null ? l10n.loginTitle : l10n.navAccount,
                child: GestureDetector(
                  onTap: widget.onAvatar,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.radiusMd),
                    child: MboaAvatar(imageUrl: data?.photoUrl, initials: data?.initials ?? '', size: 44),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.spacingSm, Dimens.spacingSm, Dimens.screenMargin, 0),
      child: profile == null
          ? body(null)
          : BlocBuilder<UserProfileBloc, ProfileState>(
              bloc: profile,
              builder: (context, state) => body(state is UserProfileReady ? state.data : null),
            ),
    );
  }
}

/// The founder's category tabs — « Tous », then the kinds of place. One
/// kind is one tap: it replaces the type filter and searches again.
class SearchCategoryTabs extends StatelessWidget {
  const SearchCategoryTabs({super.key, required this.selected, required this.allSelected, required this.onSelected});

  /// The one type the search is on, if one.
  final PropertyType? selected;

  /// No type chosen: « Tous ». Several, chosen in the filters: no tab is.
  final bool allSelected;
  final ValueChanged<PropertyType?> onSelected;

  static const _order = [
    PropertyType.room,
    PropertyType.studio,
    PropertyType.apartment,
    PropertyType.villa,
    PropertyType.office,
    PropertyType.commercialSpace,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    String label(PropertyType? type) => switch (type) {
      null => l10n.searchCategoryAll,
      PropertyType.room => l10n.searchCategoryRoom,
      PropertyType.studio => l10n.searchCategoryStudio,
      PropertyType.apartment => l10n.searchCategoryApartment,
      PropertyType.villa => l10n.searchCategoryHouse,
      PropertyType.office => l10n.searchCategoryOffice,
      PropertyType.commercialSpace => l10n.searchCategoryCommercial,
    };

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
        children: [
          for (final type in [null, ..._order])
            Semantics(
              button: true,
              selected: type == null ? allSelected : type == selected,
              child: InkWell(
                onTap: () => onSelected(type),
                child: Padding(
                  padding: const EdgeInsets.only(right: Dimens.spacingLg),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        label(type),
                        style: (type == null ? allSelected : type == selected)
                            ? context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700)
                            : context.mboaText.label.copyWith(color: colors.textSecondary),
                      ),
                      const SizedBox(height: Dimens.spacingXs),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        height: 2,
                        width: (type == null ? allSelected : type == selected) ? 24 : 0,
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(Dimens.radiusFull),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// A place's price as the cards say it, through the shared helpers — a price
/// that reads differently in two places is two prices to the reader.
String? hitPriceLabel(I18n l10n, SearchHit hit) => switch (hit) {
  final ListingHit listing when listing.displayPrice != null => listing.rentalPeriod.priceLabel(
    l10n,
    listing.displayPrice!,
  ),
  final ResidenceHit residence when residence.fromMonthlyRent != null => l10n.searchResidenceFrom(
    residence.rentFromLabel(l10n, residence.fromMonthlyRent!),
  ),
  _ => null,
};

/// « 2 pièces · 45 m² · Meublé », or a residence's free units.
String hitFactsLine(I18n l10n, SearchHit hit) => switch (hit) {
  final ListingHit listing => [
    if (listing.roomCount case final rooms?) l10n.searchRooms(rooms),
    if (listing.surfaceArea case final surface?) l10n.annoncesSurface('$surface'),
    if (listing.furnished ?? false) l10n.annonceFormFieldFurnished,
  ].join(' · '),
  final ResidenceHit residence => l10n.searchResidenceUnits(residence.availableUnitCount ?? 0),
};

/// « Deido · à 2,3 km » — the district, and how far once the search carried
/// a position (RM-M04-08). [withCity]: « Akwa, Douala », where a card stands
/// alone on a map.
String? hitPlaceLine(BuildContext context, SearchHit hit, {bool withCity = false}) {
  final place = withCity
      ? [hit.district, hit.city].nonNulls.join(', ').ifEmptyNull
      : hit.district ?? hit.city;
  final km = hit.distanceKm;
  final distance = km == null
      ? null
      : I18n.of(context).searchDistance(NumberFormat('0.0', Localizations.localeOf(context).toLanguageTag()).format(km));
  final line = [?place, ?distance].join(' · ');
  return line.isEmpty ? null : line;
}

/// « ★ 4,2 (7) » — only with reviews: none reads as new, « 0/5 » as bad
/// (RM-M04-08, as on the fiche).
class HitRating extends StatelessWidget {
  const HitRating({super.key, required this.rating, this.color});

  final PropertyRatingSummary rating;

  /// On a photo, white; on a card, the ink.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (!rating.hasRating) return const SizedBox.shrink();
    final colors = context.mboaColors;
    final average = NumberFormat('0.0', Localizations.localeOf(context).toLanguageTag()).format(rating.average);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(LucideIcons.star, size: 14, color: colors.warning),
        const SizedBox(width: 2),
        Text(
          I18n.of(context).hitRating(average, rating.reviewCount),
          style: context.mboaText.caption.copyWith(color: color ?? colors.ink, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

/// RM-M04-08 — the order: the server's, or the nearest first. Choosing the
/// second asks for the position; while it is sought, the chip says so.
class SearchSortChips extends StatelessWidget {
  const SearchSortChips({super.key, required this.sort, required this.isLocating, required this.onChanged});

  final SearchSort sort;
  final bool isLocating;
  final ValueChanged<SearchSort> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    Widget chip(SearchSort value, String label, {Widget? avatar}) => ChoiceChip(
          label: Text(label),
          avatar: avatar,
          selected: sort == value,
          showCheckmark: false,
          onSelected: isLocating ? null : (_) => onChanged(value),
          selectedColor: colors.primaryPale,
          labelStyle: context.mboaText.label.copyWith(
            color: sort == value ? colors.primaryDark : colors.textSecondary,
            fontWeight: sort == value ? FontWeight.w700 : FontWeight.w500,
          ),
          side: BorderSide(color: sort == value ? colors.primary : colors.border),
          shape: const StadiumBorder(),
        );

    return Padding(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, 0, Dimens.screenMargin, Dimens.spacingSm),
      child: Row(
        children: [
          chip(SearchSort.relevance, l10n.searchSortRelevance),
          const SizedBox(width: Dimens.spacingSm),
          chip(
            SearchSort.distance,
            l10n.searchSortNearby,
            avatar: isLocating
                ? const SizedBox.square(dimension: 14, child: CircularProgressIndicator(strokeWidth: 2))
                : Icon(LucideIcons.navigation, size: 14, color: sort == SearchSort.distance ? colors.primary : colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String? get ifEmptyNull => isEmpty ? null : this;
}

String _kindLabel(I18n l10n, SearchHit hit) => switch (hit) {
  final ListingHit listing => listing.propertyType.label(l10n),
  ResidenceHit() => l10n.searchResidence,
};

Widget? _heart(SearchHit hit, {bool background = false}) => switch (hit) {
  // A residence is not saved: favourites are listings (M06).
  final ListingHit listing => FavoriteHeart(
    annonceId: listing.id,
    background: background,
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
  ResidenceHit() => null,
};

/// The founder's big card for the « À la une » carousel: the photo is the
/// card, the words sit on it.
class FeaturedHitCard extends StatelessWidget {
  const FeaturedHitCard({super.key, required this.hit, required this.onTap});

  static const double width = 280;
  static const double height = 340;

  final SearchHit hit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    const white = Colors.white;
    final price = hitPriceLabel(l10n, hit);
    final facts = hitFactsLine(l10n, hit);
    final place = hitPlaceLine(context, hit);
    final heart = _heart(hit, background: true);

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(28),
        clipBehavior: Clip.antiAlias,
        color: colors.primaryDark,
        child: InkWell(
          onTap: onTap,
          child: Stack(
            fit: StackFit.expand,
            children: [
              MboaNetworkImage(
                url: hit.photoUrl,
                placeholder: ColoredBox(
                  color: colors.primaryDark,
                  child: MboaBrandPattern(color: colors.onBrand, opacity: 0.08, scale: 0.6),
                ),
              ),
              // The words need a dark bed on any photo.
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.35, 1],
                    colors: [Colors.transparent, Color(0xCC000000)],
                  ),
                ),
              ),
              Positioned(
                top: Dimens.spacingMd,
                left: Dimens.spacingMd,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: Dimens.spacingXs),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.24),
                        borderRadius: BorderRadius.circular(Dimens.radiusFull),
                      ),
                      child: Text(_kindLabel(l10n, hit), style: context.mboaText.caption.copyWith(color: white)),
                    ),
                    const SizedBox(width: Dimens.spacingXs),
                    // RM-M20 — the trust badges, as on every card.
                    HitTrustBadges(badges: hit.badges, top: 0),
                  ],
                ),
              ),
              if (heart != null) Positioned(top: Dimens.spacingSm, right: Dimens.spacingSm, child: heart),
              Positioned(
                left: Dimens.spacing,
                right: Dimens.spacing,
                bottom: Dimens.spacing,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (price != null)
                          Expanded(
                            child: Text(
                              price,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.mboaText.label.copyWith(color: white, fontWeight: FontWeight.w700),
                            ),
                          )
                        else
                          const Spacer(),
                        HitRating(rating: hit.rating, color: white),
                      ],
                    ),
                    Text(
                      hit.title ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.h2.copyWith(color: white),
                    ),
                    if (facts.isNotEmpty)
                      Text(
                        facts,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.mboaText.caption.copyWith(color: white.withValues(alpha: 0.85)),
                      ),
                    if (place != null) ...[
                      const SizedBox(height: Dimens.spacingXs),
                      Row(
                        children: [
                          const Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: white),
                          const SizedBox(width: Dimens.spacingXs),
                          Flexible(
                            child: Text(
                              place,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.mboaText.label.copyWith(color: white, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The founder's row card: the photo beside the words — what, how, where,
/// and the price per period.
class HitRowCard extends StatelessWidget {
  const HitRowCard({super.key, required this.hit, required this.onTap});

  final SearchHit hit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final price = hitPriceLabel(l10n, hit);
    final facts = hitFactsLine(l10n, hit);
    final place = hitPlaceLine(context, hit);
    final heart = _heart(hit);

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingMd),
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.spacingSm),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.radiusMd),
                  child: SizedBox.square(
                    dimension: 88,
                    child: MboaNetworkImage(url: hit.photoUrl, placeholder: const MboaImagePlaceholder(size: 88)),
                  ),
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              hit.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.mboaText.label.copyWith(color: colors.ink, fontWeight: FontWeight.w700),
                            ),
                          ),
                          ?heart,
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 1),
                            decoration: BoxDecoration(
                              color: colors.primaryPale,
                              borderRadius: BorderRadius.circular(Dimens.radiusFull),
                            ),
                            child: Text(
                              _kindLabel(l10n, hit),
                              style: context.mboaText.micro.copyWith(
                                color: colors.primaryDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: Dimens.spacingXs),
                          // RM-M20 — the trust badges, as on every card.
                          HitTrustBadges(badges: hit.badges, top: 2),
                        ],
                      ),
                      if (facts.isNotEmpty) ...[
                        const SizedBox(height: Dimens.spacingXs),
                        Text(
                          facts,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                        ),
                      ],
                      if (place != null) ...[
                        const SizedBox(height: Dimens.spacingXs),
                        Row(
                          children: [
                            Icon(LucideIcons.mapPin, size: 14, color: colors.ink),
                            const SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                place,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.mboaText.caption.copyWith(
                                  color: colors.ink,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      // The price on its own line: beside the place, one of
                      // the two was always cut.
                      if (price != null || hit.rating.hasRating) ...[
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                price ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.mboaText.label.copyWith(color: colors.primary, fontWeight: FontWeight.w700),
                              ),
                            ),
                            HitRating(rating: hit.rating),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// List or map — one floating pill over either, under the thumb: the list is
/// the default, the map one tap away, and neither costs a line of screen.
class SearchViewPill extends StatelessWidget {
  const SearchViewPill({super.key, required this.showingMap, required this.onToggle});

  final bool showingMap;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.radiusFull), boxShadow: MboaShadows.card),
      child: Material(
        color: colors.primaryDark,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
        child: InkWell(
          borderRadius: BorderRadius.circular(Dimens.radiusFull),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingLg, vertical: Dimens.spacingMd),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(showingMap ? LucideIcons.list : LucideIcons.map, size: Dimens.iconSm, color: colors.onBrand),
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  showingMap ? l10n.searchViewList : l10n.searchViewMap,
                  style: context.mboaText.label.copyWith(color: colors.onBrand, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A section's heading on the search home.
class SearchSectionTitle extends StatelessWidget {
  const SearchSectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingMd),
    child: Text(text, style: context.mboaText.h3.copyWith(color: context.mboaColors.primaryDark)),
  );
}
