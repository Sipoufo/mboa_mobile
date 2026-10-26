import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/residence_detail_bloc.dart';
import 'widgets/fiche_reviews.dart';
import 'widgets/fiche_sections.dart';
import 'widgets/listing_bits.dart';

/// The public fiche of a residence, and the way into its units (M10bis).
///
/// **A unit is a listing**, so each row opens the ordinary fiche — the same
/// identity the pro app relies on. This screen exists because a building is a
/// different offer from a flat: what a tenant chooses here is which unit. So it
/// carries **no action bar**: the choice is the action.
@RoutePage()
class ResidenceDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const ResidenceDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ResidenceDetailBloc>(
        create: (_) => getIt<ResidenceDetailBloc>()..add(ResidenceRequested(id)),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.residenceTitle)),
      body: BlocBuilder<ResidenceDetailBloc, ResidenceDetailState>(
        builder: (context, state) => switch (state) {
          ResidenceDetailInitial() || ResidenceDetailLoadInProgress() => const Center(child: Loader()),
          ResidenceGone() => const _Gone(),
          ResidenceDetailFailure() => Center(
              child: TextButton(
                onPressed: () => context.read<ResidenceDetailBloc>().add(ResidenceRequested(id)),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ResidenceDetailReady ready => _Body(state: ready),
        },
      ),
    );
  }
}

/// Withdrawn. Nothing to retry.
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
            Icon(LucideIcons.searchX, size: Dimens.iconLg, color: colors.textTertiary),
            const SizedBox(height: Dimens.spacing),
            Text(
              l10n.residenceGoneTitle,
              textAlign: TextAlign.center,
              style: context.mboaText.h3.copyWith(color: colors.ink),
            ),
            const SizedBox(height: Dimens.spacingXs),
            Text(
              l10n.residenceGoneBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}

/// The listing fiche's shape: the photos with what is laid over them, who
/// rents it out, the description, where it is and what people say — then the
/// units, by type.
class _Body extends StatefulWidget {
  const _Body({required this.state});

  final ResidenceDetailReady state;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  /// Where the "Avis" card scrolls to.
  final _reviewsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final state = widget.state;
    final residence = state.detail;
    final groups = residence.groups;
    final from = residence.from;
    final hasReviews = residence.rating.hasRating || state.reviews.isNotEmpty;
    final unitTitles = {for (final unit in residence.units) unit.id: unit.title};

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.spacing, Dimens.spacing, Dimens.spacing, Dimens.spacingXl),
      children: [
        // No action to switch off here: the banner only says the copy is old.
        if (state.isOffline) FicheOfflineBanner(text: l10n.homeOfflineBanner),
        FicheHero(
          photoUrls: residence.photoUrls,
          title: residence.name,
          place: [residence.district, residence.city].nonNulls.join(', '),
          rating: residence.rating,
          price: from == null ? null : l10n.searchResidenceFrom(from.$2.priceLabel(l10n, from.$1)),
        ),
        const SizedBox(height: Dimens.spacingSm),
        // RM-M04-06 — exact once any of its units was contacted.
        Text(
          residence.exactLocation ? l10n.listingLocationExactNote : l10n.listingLocationNote,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
        if (residence.provider case final provider?) ...[
          const SizedBox(height: Dimens.spacing),
          ListingProviderRow(provider: provider),
        ],
        if (groups.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final group in groups)
                FichePill(icon: LucideIcons.doorOpen, label: _groupLabel(l10n, group.type, group.units.length)),
            ],
          ),
        ],
        if (residence.description case final description? when description.trim().isNotEmpty) ...[
          const SizedBox(height: Dimens.spacingLg),
          Text(l10n.listingDescription, style: context.mboaText.h3.copyWith(color: colors.primaryDark)),
          const SizedBox(height: Dimens.spacingSm),
          Text(description, style: context.mboaText.body.copyWith(color: colors.ink)),
        ],
        const SizedBox(height: Dimens.spacingLg),
        ListingCardsRow(
          hasPosition: residence.hasPosition,
          rating: residence.rating,
          onOpenMap: () => context.router.push(
            ListingMapRoute(
              latitude: residence.latitude!,
              longitude: residence.longitude!,
              exact: residence.exactLocation,
              title: residence.name,
            ),
          ),
          onOpenReviews: () {
            final target = _reviewsKey.currentContext;
            if (target != null) {
              Scrollable.ensureVisible(target, duration: const Duration(milliseconds: 350), curve: Curves.easeOut);
            }
          },
        ),
        const SizedBox(height: Dimens.spacing),
        ListingSection(
          title: residence.units.isEmpty ? l10n.residenceUnitsTitle : l10n.residenceUnitsAvailable(residence.units.length),
          child: residence.units.isEmpty
              ? Text(l10n.residenceNoUnits, style: context.mboaText.body.copyWith(color: colors.textSecondary))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (index, group) in groups.indexed) ...[
                      if (index > 0) Divider(height: Dimens.spacingLg, color: colors.border),
                      _Group(key: ValueKey(group.type), group: group),
                    ],
                  ],
                ),
        ),
        // §36 — no review, no block: a "0/5" reads as a bad residence rather
        // than an unrated one.
        if (hasReviews)
          KeyedSubtree(
            key: _reviewsKey,
            child: FicheReviews(
              title: l10n.residenceReviewsTitle,
              rating: residence.rating,
              reviews: state.reviews,
              // A unit no longer live still counts, but has no name to give.
              unitOf: (review) => unitTitles[review.annonceId],
            ),
          ),
      ],
    );
  }
}

/// « 50 chambres » — a type, counted.
String _groupLabel(I18n l10n, PropertyType type, int count) => switch (type) {
      PropertyType.apartment => l10n.residenceGroupApartment(count),
      PropertyType.studio => l10n.residenceGroupStudio(count),
      PropertyType.villa => l10n.residenceGroupVilla(count),
      PropertyType.room => l10n.residenceGroupRoom(count),
      PropertyType.office => l10n.residenceGroupOffice(count),
      PropertyType.commercialSpace => l10n.residenceGroupCommercialSpace(count),
    };

/// One type of unit: its count and lowest rent, three rows, and the rest
/// behind « Voir les 50 chambres ».
class _Group extends StatefulWidget {
  const _Group({super.key, required this.group});

  final ResidenceUnitGroup group;

  /// Enough to compare, few enough that the next type is still in sight.
  static const int folded = 3;

  @override
  State<_Group> createState() => _GroupState();
}

class _GroupState extends State<_Group> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final group = widget.group;
    final label = _groupLabel(l10n, group.type, group.units.length);
    // A group of one says its rent on its row; « À partir de » would repeat it.
    final from = group.units.length > 1 ? group.from : null;
    final shown = _open ? group.units : group.units.take(_Group.folded);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: context.mboaText.label.copyWith(color: colors.primaryDark, fontWeight: FontWeight.w700),
              ),
            ),
            if (from != null)
              Text(
                l10n.searchResidenceFrom(from.$2.priceLabel(l10n, from.$1)),
                style: context.mboaText.caption.copyWith(color: colors.textSecondary),
              ),
          ],
        ),
        const SizedBox(height: Dimens.spacingXs),
        for (final unit in shown)
          _UnitRow(unit: unit, onTap: () => context.router.push(ListingDetailRoute(id: unit.id))),
        if (group.units.length > _Group.folded)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () => setState(() => _open = !_open),
              icon: Icon(_open ? LucideIcons.chevronUp : LucideIcons.chevronDown, size: Dimens.iconSm),
              label: Text(_open ? l10n.residenceGroupSeeLess : l10n.residenceGroupSeeAll(label)),
            ),
          ),
      ],
    );
  }
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.unit, required this.onTap});

  final ListingUnit unit;
  final VoidCallback onTap;

  static const double _thumb = 56;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    // The group's heading already says what type it is.
    final facts = [
      if (unit.roomCount case final rooms?) l10n.annoncesRooms(rooms),
      if (unit.surfaceArea case final surface?) l10n.annoncesSurface('$surface'),
    ];

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            // RM-M10bis-13 — the unit's own photo when its group had some,
            // else the residence's.
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radius),
              child: SizedBox.square(
                dimension: _thumb,
                child: MboaNetworkImage(
                  url: unit.photoUrl,
                  placeholder: ColoredBox(
                    color: colors.primaryPale,
                    child: Center(child: Icon(LucideIcons.doorOpen, size: Dimens.icon, color: colors.primaryDark)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    unit.title ?? '',
                    style: context.mboaText.label.copyWith(color: colors.ink),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (facts.isNotEmpty)
                    Text(
                      facts.join(' · '),
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  if (unit.displayPrice case final price?)
                    Text(
                      unit.rentalPeriod.priceLabel(l10n, price),
                      style: context.mboaText.label.copyWith(color: colors.action),
                    ),
                ],
              ),
            ),
            const SizedBox(width: Dimens.spacingXs),
            Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}
