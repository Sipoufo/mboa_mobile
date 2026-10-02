import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../favorites/bloc/favorites_bloc.dart';
import '../../favorites/ui/widgets/favorite_heart.dart';
import '../../messaging/ui/contact_sheet.dart';
import '../../visits/ui/book_visit_sheet.dart';
import '../bloc/listing_detail_bloc.dart';
import 'widgets/listing_bits.dart';

/// The public fiche of a listing (CDC M05).
///
/// Readable by anyone (CA-M04-04). What needs an account — contacting, booking
/// — is gated by the server's own verdicts (`canContact`, `canPlanVisit`), so
/// the app never promises a screen that would open empty.
@RoutePage()
class ListingDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const ListingDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<ListingDetailBloc>(
            create: (_) =>
                getIt<ListingDetailBloc>()..add(ListingRequested(id)),
          ),
          // The fiche is a **root** route, a sibling of the tab shell — not a
          // screen inside a tab (see `AppRouter`). Nothing above it provides
          // the shell's `FavoritesBloc`, so the heart in the carousel threw
          // and took the whole gallery down with it. `.value` on the getIt
          // singleton: the same instance the tabs read, and this route must
          // not close it on pop.
          BlocProvider<FavoritesBloc>.value(value: getIt<FavoritesBloc>()),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.listingTitle)),
      body: BlocBuilder<ListingDetailBloc, ListingDetailState>(
        builder: (context, state) => switch (state) {
          ListingDetailInitial() || ListingDetailLoadInProgress() =>
            const Center(child: Loader()),
          ListingGone() => const _Gone(),
          ListingDetailFailure() => Center(
              child: TextButton(
                onPressed: () =>
                    context.read<ListingDetailBloc>().add(ListingRequested(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ListingDetailReady ready => _Body(state: ready),
        },
      ),
      bottomNavigationBar: BlocBuilder<ListingDetailBloc, ListingDetailState>(
        builder: (context, state) =>
            state is ListingDetailReady && !state.isOffline
                ? _Actions(detail: state.detail)
                : const SizedBox.shrink(),
      ),
    );
  }
}

/// CE-M05-01 — withdrawn or expired. Nothing to retry.
class _Gone extends StatelessWidget {
  const _Gone();

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
              l10n.listingGoneTitle,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.listingGoneBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final ListingDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final detail = state.detail;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        if (state.isOffline) const _OfflineBanner(),
        _Gallery(detail: detail),
        const SizedBox(height: Dimens.spacing),
        _Header(detail: detail),
        const SizedBox(height: Dimens.spacing),
        _Facts(detail: detail),
        if (detail.amenities.isNotEmpty)
          ListingSection(
            title: l10n.listingAmenities,
            child: Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingSm,
              children: [
                for (final amenity in detail.amenities)
                  _Tag(label: amenity.label(l10n)),
              ],
            ),
          ),
        if (detail.description case final description?
            when description.trim().isNotEmpty)
          ListingSection(
            title: l10n.listingDescription,
            child: Text(
              description,
              style: context.mboaText.body
                  .copyWith(color: context.mboaColors.ink),
            ),
          ),
        if (detail.provider case final provider?)
          _Provider(provider: provider),
        // RM-M05-08 — no review, no block: a "0/5" reads as a bad property
        // rather than an unrated one.
        if (detail.rating.hasRating || state.reviews.isNotEmpty)
          _Reviews(state: state),
      ],
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: Dimens.spacing),
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              l10n.listingOfflineBanner,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

/// RM-M05-01 — three photos in the carousel, the rest behind the gallery.
class _Gallery extends StatefulWidget {
  const _Gallery({required this.detail});

  final ListingDetail detail;

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
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
    final urls = widget.detail.photoUrls;
    final shown = urls.take(ListingDetail.carouselPhotos).toList();

    Widget placeholder() => ColoredBox(
          color: colors.primaryPale,
          child: Center(
            child: Icon(LucideIcons.image, color: colors.primary),
          ),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: SizedBox(
        height: 240,
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
                      // Cached: swiping back and forth must not re-download.
                      itemBuilder: (context, index) => MboaNetworkImage(
                        url: shown[index],
                        placeholder: placeholder(),
                      ),
                    ),
            ),
            Positioned(
              top: Dimens.spacingSm,
              right: Dimens.spacingSm,
              child: FavoriteHeart(
                annonceId: widget.detail.id,
                background: true,
                optimistic: optimisticFavorite(
                  annonceId: widget.detail.id,
                  title: widget.detail.title,
                  photoKey: widget.detail.photoKeys.firstOrNull,
                  price: widget.detail.displayPrice,
                  rentalPeriod: widget.detail.rentalPeriod,
                  city: widget.detail.city,
                  district: widget.detail.district,
                ),
              ),
            ),
            if (shown.length > 1)
              Positioned(
                bottom: Dimens.spacingSm,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < shown.length; i++)
                      Container(
                        width: 6,
                        height: 6,
                        margin:
                            const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == _page
                              ? colors.onBrand
                              : colors.onBrand.withValues(alpha: 0.4),
                        ),
                      ),
                  ],
                ),
              ),
            if (urls.length > ListingDetail.carouselPhotos)
              Positioned(
                bottom: Dimens.spacingSm,
                right: Dimens.spacingSm,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.spacingSm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colors.ink.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(Dimens.radiusFull),
                  ),
                  child: Text(
                    l10n.listingPhotosCount(urls.length),
                    style:
                        context.mboaText.caption.copyWith(color: colors.onBrand),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (detail.displayPrice case final price?)
          Text(
            detail.rentalPeriod.priceLabel(l10n, price),
            style: context.mboaText.h2.copyWith(color: colors.primaryDark),
          ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          detail.title ?? '',
          style: context.mboaText.h3.copyWith(color: colors.ink),
        ),
        const SizedBox(height: Dimens.spacingXs),
        Row(
          children: [
            Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: colors.primary),
            const SizedBox(width: Dimens.spacingXs),
            Expanded(
              child: Text(
                [detail.district, detail.city].nonNulls.join(', '),
                style: context.mboaText.label
                    .copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacingXs),
        // RM-M05-02 / CA-M05-03 — the exact address is not withheld by the UI:
        // the API never sends it, and the coordinates are fuzzed by ~200 m.
        Text(
          l10n.listingLocationNote,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
      ],
    );
  }
}

class _Facts extends StatelessWidget {
  const _Facts({required this.detail});

  final ListingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    final facts = <(String, String)>[
      (l10n.annonceFormFieldType, detail.propertyType.label(l10n)),
      if (detail.surfaceArea case final surface?)
        (l10n.annonceFormFieldSurface, l10n.annoncesSurface('$surface')),
      if (detail.roomCount case final rooms?)
        (l10n.annonceFormFieldRooms, '$rooms'),
      if (detail.bathroomCount case final baths?)
        (l10n.annonceFormFieldBathrooms, '$baths'),
      if (detail.furnished case final furnished?)
        (
          l10n.annonceFormFieldFurnished,
          furnished ? l10n.commonYes : l10n.commonNo,
        ),
      if (detail.chargesIncluded case final included?)
        (
          l10n.annonceDetailCharges,
          included
              ? l10n.annonceDetailChargesIncluded
              : l10n.annonceDetailChargesExtra,
        ),
      if (detail.availableFrom case final from?)
        (l10n.annonceFormFieldAvailability, DateFormat.yMMMMd().format(from)),
    ];

    return ListingSection(
      title: l10n.listingCharacteristics,
      child: Column(
        children: [
          for (final (label, value) in facts)
            FactRow(label: label, value: value),
        ],
      ),
    );
  }
}

class _Provider extends StatelessWidget {
  const _Provider({required this.provider});

  final ProviderSummary provider;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListingSection(
      title: l10n.listingProvider,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              MboaAvatar(
                imageUrl: provider.logoUrl,
                initials: (provider.displayName ?? '').isEmpty
                    ? ''
                    : provider.displayName![0].toUpperCase(),
                size: Dimens.avatar,
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.displayName ?? '',
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                    if (provider.type case final type?)
                      Text(
                        prestataireKindLabel(l10n, type),
                        style: context.mboaText.caption
                            .copyWith(color: colors.textTertiary),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (provider.badges.isNotEmpty) ...[
            const SizedBox(height: Dimens.spacing),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingSm,
              children: [
                for (final badge in provider.badges)
                  TrustBadgeChip(badge: badge),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// RM-M05-08 — the weighted average and the feed behind it.
class _Reviews extends StatelessWidget {
  const _Reviews({required this.state});

  final ListingDetailReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final rating = state.detail.rating;

    return ListingSection(
      title: l10n.listingReviewsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rating.hasRating) ...[
            Row(
              children: [
                Icon(LucideIcons.star, size: Dimens.icon, color: colors.primary),
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  l10n.listingRatingSummary(
                    rating.reviewCount,
                    rating.average!.toStringAsFixed(1),
                  ),
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
              ],
            ),
            const SizedBox(height: Dimens.spacing),
          ],
          for (final review in state.reviews)
            _Review(review: review),
        ],
      ),
    );
  }
}

class _Review extends StatelessWidget {
  const _Review({required this.review});

  final ReviewEntry review;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  // RM-M07bis-08 — the review outlives its author.
                  review.authorName ?? l10n.reviewDeletedAuthor,
                  style: context.mboaText.label.copyWith(color: colors.ink),
                ),
              ),
              if (review.rating case final rating?)
                Text(
                  '$rating/5',
                  style:
                      context.mboaText.label.copyWith(color: colors.primaryDark),
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacingXs),
          Row(
            children: [
              // RG-06 — which kind of testimony this is, because a tenant of a
              // year and a visitor of an hour do not weigh the same.
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.spacingSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: review.kind == ReviewKind.resident
                      ? colors.primaryPale
                      : colors.surfaceWarm,
                  borderRadius: BorderRadius.circular(Dimens.radiusFull),
                ),
                child: Text(
                  review.kind == ReviewKind.resident
                      ? l10n.listingReviewResident
                      : l10n.listingReviewVisit,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
              ),
              if (review.residenceMonths case final months?) ...[
                const SizedBox(width: Dimens.spacingSm),
                Text(
                  l10n.listingReviewMonths(months),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
              ],
              const Spacer(),
              if (review.publishedAt case final at?)
                Text(
                  DateFormat.yMMMd().format(at),
                  style: context.mboaText.caption
                      .copyWith(color: colors.textTertiary),
                ),
            ],
          ),
          if (review.comment case final comment?
              when comment.trim().isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingSm),
            Text(
              comment,
              style: context.mboaText.body.copyWith(color: colors.ink),
            ),
          ],
          for (final reply in review.replies) ...[
            const SizedBox(height: Dimens.spacingSm),
            Container(
              padding: const EdgeInsets.all(Dimens.spacingMd),
              decoration: BoxDecoration(
                color: colors.surfaceWarm,
                borderRadius: BorderRadius.circular(Dimens.radius),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reply.authorName ?? '',
                    style: context.mboaText.caption
                        .copyWith(color: colors.primaryDark),
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    reply.body ?? '',
                    style: context.mboaText.body
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacingMd,
        vertical: Dimens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: colors.primaryPale,
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Text(
        label,
        style: context.mboaText.caption.copyWith(color: colors.primaryDark),
      ),
    );
  }
}

/// Contacter / Planifier / Signaler.
///
/// The first two are the server's to allow: `canContact` carries RM-M04-05 and
/// `canPlanVisit` carries RM-M05-07 — a bookable visitor must exist, or the
/// button would open an empty booking screen.
class _Actions extends StatelessWidget {
  const _Actions({required this.detail});

  final ListingDetail detail;

  /// Opens the thread the first message created — or the one that already
  /// existed, since a second tap is a 409 and not a failure.
  Future<void> _contact(BuildContext context, ListingDetail detail) async {
    final l10n = I18n.of(context);
    final router = context.router;

    final conversation = await showContactSheet(
      context,
      annonceId: detail.id,
      annonceTitle: detail.title,
    );
    if (conversation == null || !context.mounted) return;

    MboaToast.success(context: context, title: l10n.messagingContactSent);
    await router.push(ThreadRoute(conversation: conversation));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final signedIn = getIt<SessionSnapshot>().hasSession;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Button.primary(
                    title: l10n.listingContact,
                    // RM-M12-01 — the tenant's first word, on this listing. The
                    // gate is the server's (`canContact`).
                    onPressed: detail.canContact
                        ? () => _contact(context, detail)
                        : null,
                  ),
                ),
                const SizedBox(width: Dimens.spacingSm),
                IconButton(
                  tooltip: l10n.listingReport,
                  onPressed: () => MboaToast.info(
                    context: context,
                    title: l10n.commonComingSoon,
                  ),
                  icon: Icon(LucideIcons.flag, color: colors.textSecondary),
                ),
              ],
            ),
            if (detail.canPlanVisit) ...[
              const SizedBox(height: Dimens.spacingSm),
              Button.outline(
                title: l10n.listingPlanVisit,
                // M07. `canPlanVisit` is the server's verdict that someone can
                // actually show this place (RM-M07-01); the sheet then says
                // who, and when.
                onPressed: () =>
                    showBookVisitSheet(context, annonceId: detail.id),
              ),
            ],
            // Only where it explains something: a signed-out reader whose
            // buttons are live has nothing to be told (and the server would
            // not return `canContact` for one anyway).
            if (!signedIn && !detail.canContact) ...[
              const SizedBox(height: Dimens.spacingSm),
              Text(
                l10n.listingActionsSignIn,
                textAlign: TextAlign.center,
                style:
                    context.mboaText.caption.copyWith(color: colors.textSecondary),
              ),
            ] else if (!detail.canPlanVisit) ...[
              const SizedBox(height: Dimens.spacingSm),
              Text(
                l10n.listingNoVisitor,
                textAlign: TextAlign.center,
                style:
                    context.mboaText.caption.copyWith(color: colors.textTertiary),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
