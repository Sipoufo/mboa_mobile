import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../assignments/models/assignment.dart';
import '../bloc/annonces_bloc.dart';
import '../models/annonce.dart';
import 'widgets/annonce_status_chip.dart';
import 'widgets/status_actions_menu.dart';

/// "Details du bien" (CDC M10).
///
/// Follows the design's shape: a photo header carrying price, title,
/// characteristics and place, then cards. Statistiques, Occupant and
/// Historique have no endpoints, so they render the "Aucune information
/// disponible pour le moment" state the design itself specifies.
///
/// Lifecycle actions live in the app bar's menu — the same [StatusActionsMenu]
/// the lists and the residence use, so the publish gate (RM-M10-01 / RM-M10-02
/// / CE-M10-03) has one implementation instead of a second one here.
@RoutePage()
class AnnonceDetailPage extends StatefulWidget {
  const AnnonceDetailPage({super.key, required this.id});

  final String id;

  @override
  State<AnnonceDetailPage> createState() => _AnnonceDetailPageState();
}

class _AnnonceDetailPageState extends State<AnnonceDetailPage> {
  @override
  void initState() {
    super.initState();
    // A residence unit is not in the list, and a deep link may arrive before
    // the list loads — fetch either way.
    context.read<AnnoncesBloc>().add(AnnonceDetailRequested(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<AnnoncesBloc, AnnoncesState>(
      builder: (context, state) {
        final annonce = state is AnnoncesReady ? state.items.where((a) => a.id == widget.id).firstOrNull : null;

        return Scaffold(
          backgroundColor: context.mboaColors.background,
          appBar: AppBar(
            title: Text(l10n.annonceDetailTitle),
            actions: [
              if (annonce != null && state is AnnoncesReady)
                StatusActionsMenu(
                  status: annonce.status,
                  photoCount: annonce.photoKeys.length,
                  activeCount: state.activeCount,
                  enabled: state.mutatingId != annonce.id,
                  // A unit does not count against the active-listing quota:
                  // a residence's allowance is enforced at creation.
                  isResidenceUnit: annonce.residenceId != null,
                  onSelected: (transition) =>
                      context.read<AnnoncesBloc>().add(AnnonceStatusChangeRequested(annonce.id, transition)),
                ),
            ],
          ),
          // Still fetching, or genuinely gone.
          body: annonce == null ? const Center(child: Loader()) : _Body(annonce: annonce),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacing,
        Dimens.spacingXl,
      ),
      children: [
        _Hero(annonce: annonce),
        if (annonce.residenceId != null) ...[
          const SizedBox(height: Dimens.spacingSm),
          // A unit is deliberately absent from Biens Uniques, so the detail
          // says what it belongs to rather than looking like a stray listing.
          Align(
            alignment: Alignment.centerLeft,
            child: _Tag(label: l10n.annonceDetailUnitOfResidence),
          ),
        ],
        const SizedBox(height: Dimens.spacing),

        // RM-M11-10 / RM-M11-01 — who can show this property. It belongs on the
        // listing: the pool is a property's, not the portfolio's.
        _VisitsCard(annonce: annonce),
        const SizedBox(height: Dimens.spacing),

        _FactsCard(annonce: annonce),
        const SizedBox(height: Dimens.spacing),

        // RM-M08-01 — only a prestataire initiates, and always from a bien:
        // the contract copies the property it carries (RM-M08-05), so this is
        // where one starts.
        _ContractCard(annonce: annonce),
        const SizedBox(height: Dimens.spacing),

        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _EmptyCard(title: l10n.annonceDetailStats)),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(child: _EmptyCard(title: l10n.annonceDetailOccupant)),
            ],
          ),
        ),

        if (annonce.amenities.isNotEmpty) ...[
          const SizedBox(height: Dimens.spacing),
          _SectionCard(
            title: l10n.annonceDetailAmenities,
            child: Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingSm,
              children: [
                for (final amenity in annonce.amenities) _Tag(label: amenity.label(l10n)),
              ],
            ),
          ),
        ],

        const SizedBox(height: Dimens.spacing),
        _SectionCard(
          title: l10n.annonceDetailHistory,
          child: _NoInfo(),
        ),
      ],
    );
  }
}

/// The photo, and everything the design overlays on it: rent, title, the
/// characteristics line, the place, and where the listing has got to.
class _Hero extends StatelessWidget {
  const _Hero({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final facts = [
      if (annonce.surfaceArea case final surface?) l10n.annoncesSurface('$surface'),
      if (annonce.roomCount case final rooms?) l10n.annoncesRooms(rooms),
    ].join(' · ');

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: Stack(
        children: [
          SizedBox(
            height: 220,
            width: double.infinity,
            // No photo: a dark block, not a pale one. The header's text is
            // white by design, and it was unreadable over the mint placeholder.
            child: annonce.coverUrl == null
                ? ColoredBox(
                    color: colors.primaryDark,
                    // Above the overlaid text rather than behind it.
                    child: Align(
                      alignment: const Alignment(0, -0.45),
                      child: Icon(
                        LucideIcons.image,
                        color: colors.onBrand.withValues(alpha: 0.4),
                        size: Dimens.iconLg,
                      ),
                    ),
                  )
                : Image.network(
                    annonce.coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => ColoredBox(
                      color: colors.primaryDark,
                      child: Icon(
                        LucideIcons.image,
                        color: colors.onBrand.withValues(alpha: 0.4),
                      ),
                    ),
                  ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    colors.ink.withValues(alpha: 0.75),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimens.spacing,
            right: Dimens.spacing,
            child: AnnonceStatusChip(status: annonce.status),
          ),
          Positioned(
            left: Dimens.spacing,
            right: Dimens.spacing,
            bottom: Dimens.spacing,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (annonce.displayPrice case final rent?)
                  Text(
                    annonce.rentalPeriod.priceLabel(l10n, rent),
                    style: context.mboaText.label.copyWith(color: colors.onBrand),
                  ),
                Text(
                  annonce.title,
                  style: context.mboaText.h2.copyWith(color: colors.onBrand),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (facts.isNotEmpty) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    facts,
                    style: context.mboaText.caption.copyWith(color: colors.onBrand),
                  ),
                ],
                const SizedBox(height: Dimens.spacingXs),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mapPin,
                      size: Dimens.iconSm,
                      color: colors.onBrand,
                    ),
                    const SizedBox(width: Dimens.spacingXs),
                    Expanded(
                      child: Text(
                        annonce.district ?? annonce.city ?? '',
                        style: context.mboaText.label.copyWith(color: colors.onBrand),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Who may show this property (M11).
///
/// The prestataire puts himself in its pool of bookable visitors (RM-M11-10)
/// and reaches the agents assigned to it from the same card — the tenant picks
/// among all of them when booking (RM-M07-01), so they belong side by side.
class _VisitsCard extends StatelessWidget {
  const _VisitsCard({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final state = context.watch<AnnoncesBloc>().state;
    final isSaving = state is AnnoncesReady && state.mutatingId == annonce.id;

    return _SectionCard(
      title: l10n.annonceDetailVisits,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agentsOwnerVisitsTitle,
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                    const SizedBox(height: Dimens.spacingXs),
                    Text(
                      l10n.agentsOwnerVisitsBody,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.spacingSm),
              if (isSaving)
                const SizedBox(
                  width: Dimens.iconMd,
                  height: Dimens.iconMd,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Switch(
                  value: annonce.ownerVisitsEnabled,
                  onChanged: (value) => context.read<AnnoncesBloc>().add(
                    AnnonceOwnerVisitsToggled(annonce.id, enabled: value),
                  ),
                ),
            ],
          ),
          const Divider(height: Dimens.spacingLg),
          InkWell(
            borderRadius: BorderRadius.circular(Dimens.radius),
            onTap: () => context.router.push(
              AgentAssignmentRoute(target: AnnonceTarget(annonce.id)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.users, size: Dimens.icon, color: colors.primary),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Text(
                    l10n.annonceDetailAgents,
                    style: context.mboaText.label.copyWith(color: colors.ink),
                  ),
                ),
                Icon(
                  LucideIcons.chevronRight,
                  size: Dimens.icon,
                  color: colors.textTertiary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// What the form knows and the detail used not to show at all.
class _FactsCard extends StatelessWidget {
  const _FactsCard({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    final facts = <(String, String)>[
      (l10n.annonceFormFieldType, annonce.propertyType.label(l10n)),
      if (annonce.surfaceArea case final surface?) (l10n.annonceFormFieldSurface, l10n.annoncesSurface('$surface')),
      if (annonce.roomCount case final rooms?) (l10n.annonceFormFieldRooms, '$rooms'),
      if (annonce.bathroomCount case final baths?) (l10n.annonceFormFieldBathrooms, '$baths'),
      if (annonce.furnished case final furnished?)
        (
          l10n.annonceFormFieldFurnished,
          furnished ? l10n.commonYes : l10n.commonNo,
        ),
      if (annonce.chargesIncluded case final included?)
        (
          l10n.annonceDetailCharges,
          included ? l10n.annonceDetailChargesIncluded : l10n.annonceDetailChargesExtra,
        ),
      if (annonce.availableFrom case final from?)
        (
          l10n.annonceFormFieldAvailability,
          DateFormat.yMMMMd().format(from),
        ),
    ];

    return _SectionCard(
      title: l10n.annonceDetailFacts,
      child: Column(
        children: [
          for (final (label, value) in facts)
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      label,
                      style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
                    ),
                  ),
                  Text(
                    value,
                    style: context.mboaText.label.copyWith(color: context.mboaColors.ink),
                  ),
                ],
              ),
            ),
          if (annonce.description case final description? when description.trim().isNotEmpty) ...[
            const SizedBox(height: Dimens.spacingXs),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description,
                style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The way into a Contrat Mboa for this property (M08).
class _ContractCard extends StatelessWidget {
  const _ContractCard({required this.annonce});

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return _SectionCard(
      title: l10n.contractsTitle,
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.radius),
        onTap: () => context.router.push(
          ContractFormRoute(annonceId: annonce.id),
        ),
        child: Row(
          children: [
            Icon(
              LucideIcons.fileSignature,
              size: Dimens.icon,
              color: colors.primary,
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Text(
                l10n.contractCreate,
                style: context.mboaText.label.copyWith(color: colors.ink),
              ),
            ),
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

/// A white block with a dark-green heading — the shape the design gives every
/// section on this screen.
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.mboaText.h3.copyWith(color: colors.primaryDark),
          ),
          const SizedBox(height: Dimens.spacing),
          child,
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

/// The design's own empty state, kept verbatim: these three surfaces have no
/// endpoint yet, and inventing numbers for them would be worse than saying so.
class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) => _SectionCard(title: title, child: _NoInfo());
}

class _NoInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Column(
      children: [
        const SizedBox(height: Dimens.spacingSm),
        Text(
          l10n.annonceDetailNoInfo,
          textAlign: TextAlign.center,
          style: context.mboaText.caption.copyWith(color: colors.primary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        Icon(LucideIcons.info, size: Dimens.icon, color: colors.primary),
        const SizedBox(height: Dimens.spacingSm),
      ],
    );
  }
}
