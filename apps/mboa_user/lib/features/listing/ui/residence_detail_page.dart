import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../data/listing_repository.dart';
import 'widgets/listing_bits.dart';

/// The public fiche of a residence, and the way into its units.
///
/// **A unit is a listing**, so each row opens the ordinary fiche — the same
/// identity the pro app relies on. This screen exists because a building is a
/// different offer from a flat: what a tenant chooses here is which unit.
///
/// It holds no bloc of its own: one read, no actions, nothing to keep in sync.
/// A bloc here would be ceremony around a `FutureBuilder`.
@RoutePage()
class ResidenceDetailPage extends StatefulWidget {
  const ResidenceDetailPage({super.key, required this.id});

  final String id;

  @override
  State<ResidenceDetailPage> createState() => _ResidenceDetailPageState();
}

class _ResidenceDetailPageState extends State<ResidenceDetailPage> {
  late Future<ResidenceDetail> _future =
      getIt<ListingRepository>().residence(widget.id);

  void _retry() => setState(
        () => _future = getIt<ListingRepository>().residence(widget.id),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.residenceTitle)),
      body: FutureBuilder<ResidenceDetail>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: Loader());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: TextButton(
                onPressed: _retry,
                child: Text(l10n.commonRetry),
              ),
            );
          }
          return _Body(residence: snapshot.requireData);
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.residence});

  final ResidenceDetail residence;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        _Photo(residence: residence),
        const SizedBox(height: Dimens.spacing),
        Text(
          residence.name ?? '',
          style: context.mboaText.h2.copyWith(color: colors.ink),
        ),
        const SizedBox(height: Dimens.spacingXs),
        Row(
          children: [
            Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: colors.primary),
            const SizedBox(width: Dimens.spacingXs),
            Expanded(
              child: Text(
                [residence.district, residence.city].nonNulls.join(', '),
                style:
                    context.mboaText.label.copyWith(color: colors.textSecondary),
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.listingLocationNote,
          style: context.mboaText.caption.copyWith(color: colors.textTertiary),
        ),
        const SizedBox(height: Dimens.spacing),
        if (residence.description case final description?
            when description.trim().isNotEmpty)
          ListingSection(
            title: l10n.listingDescription,
            child: Text(
              description,
              style: context.mboaText.body.copyWith(color: colors.ink),
            ),
          ),
        ListingSection(
          title: l10n.residenceUnitsAvailable(residence.units.length),
          child: Column(
            children: [
              for (final unit in residence.units)
                _UnitRow(
                  unit: unit,
                  onTap: () => context.router
                      .push(ListingDetailRoute(id: unit.id)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({required this.residence});

  final ResidenceDetail residence;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final url = residence.photoUrls.firstOrNull;

    Widget placeholder() => ColoredBox(
          color: colors.primaryPale,
          child: Center(
            child: Icon(LucideIcons.layers, color: colors.primary),
          ),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: SizedBox(
        height: 220,
        width: double.infinity,
        child: url == null
            ? placeholder()
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => placeholder(),
              ),
      ),
    );
  }
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.unit, required this.onTap});

  final ListingUnit unit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          children: [
            Container(
              width: Dimens.avatar,
              height: Dimens.avatar,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.primaryLight.withValues(alpha: 0.35),
              ),
              child: Icon(
                LucideIcons.doorOpen,
                size: Dimens.icon,
                color: colors.primaryDark,
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
                  Text(
                    [
                      unit.propertyType.label(l10n),
                      if (unit.roomCount case final rooms?)
                        l10n.annoncesRooms(rooms),
                      if (unit.surfaceArea case final surface?)
                        l10n.annoncesSurface('$surface'),
                    ].join(' · '),
                    style: context.mboaText.caption
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            if (unit.displayPrice case final price?)
              Text(
                unit.rentalPeriod.priceLabel(l10n, price),
                style: context.mboaText.label.copyWith(color: colors.primaryDark),
              ),
            const SizedBox(width: Dimens.spacingXs),
            Icon(
              LucideIcons.chevronRight,
              size: Dimens.icon,
              color: colors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
