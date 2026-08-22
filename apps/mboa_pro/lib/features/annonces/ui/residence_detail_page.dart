import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/residences_bloc.dart';
import '../models/annonce.dart';
import '../models/residence.dart';
import '../models/annonce_draft.dart';
import '../../../app/router/app_router.gr.dart';
import 'residences_list_page.dart';
import '../models/annonce_status.dart';
import 'widgets/annonce_status_chip.dart';
import 'widgets/status_actions_menu.dart';

/// Below this a search box is more chrome than help.
const int _searchThreshold = 6;

/// Residence detail (CDC M10) — the property, its unit counts, and the units
/// themselves.
///
/// A unit id **is** an annonce id (confirmed by the backend), so each row opens
/// the ordinary listing detail and the ordinary edit form. Nothing here is
/// unit-specific beyond the entry point.
@RoutePage()
class ResidenceDetailPage extends StatefulWidget {
  const ResidenceDetailPage({super.key, required this.id});

  final String id;

  @override
  State<ResidenceDetailPage> createState() => _ResidenceDetailPageState();
}

class _ResidenceDetailPageState extends State<ResidenceDetailPage> {
  /// Which units to show. View state over units the bloc already holds — no
  /// request is made and no API-sourced data is stored here.
  AnnonceFilter _filter = AnnonceFilter.available;
  String _query = '';

  final _searchController = TextEditingController();

  /// RM-M10bis-01 allows 200 units, which is more than anyone scrolls. Matching
  /// is accent- and case-insensitive so "Chambre 3" finds "chambre 3".
  List<ResidenceUnit> _visibleUnits(Residence residence) {
    final query = _normalise(_query);
    return residence.units
        .where((u) => _filter.matches(u.status))
        .where((u) => query.isEmpty || _normalise(u.title).contains(query))
        .toList();
  }

  static String _normalise(String value) {
    const accents = 'àâäáãåçéèêëíìîïñóòôöõúùûüýÿ';
    const plain = 'aaaaaaceeeeiiiinooooouuuuyy';
    var out = value.trim().toLowerCase();
    for (var i = 0; i < accents.length; i++) {
      out = out.replaceAll(accents[i], plain[i]);
    }
    return out;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // The list payload may omit the units array; fetch the full residence.
    context.read<ResidencesBloc>().add(ResidenceDetailRequested(widget.id));
  }

  /// Opens the ordinary edit form on the unit, then re-reads the residence so
  /// the row reflects the change on return.
  Future<void> _editUnit(ResidenceUnit unit) async {
    await context.router.push(
      AnnonceFormRoute(kind: AnnonceKind.single, annonceId: unit.id),
    );
    if (!mounted) return;
    context.read<ResidencesBloc>().add(ResidenceDetailRequested(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.residenceDetailTitle)),
      body: BlocBuilder<ResidencesBloc, ResidencesState>(
        builder: (context, state) {
          if (state is! ResidencesReady) {
            return const Center(child: Loader());
          }

          final residence = state.items.where((r) => r.id == widget.id).firstOrNull;
          // Still fetching, or genuinely gone.
          if (residence == null) return const Center(child: Loader());

          return RefreshIndicator(
            onRefresh: () async => context.read<ResidencesBloc>().add(ResidenceDetailRequested(widget.id)),
            child: ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                _Header(residence: residence),
                const SizedBox(height: Dimens.spacing),
                _Counts(residence: residence),
                const SizedBox(height: Dimens.spacingLg),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.residenceUnitsTitle,
                        style: context.mboaText.h3,
                      ),
                    ),
                    StatusActionsMenu(
                      status: residence.status,
                      // Bulk actions cover every unit; the per-listing photo
                      // rule doesn't apply and the backend validates each one.
                      photoCount: 3,
                      activeCount: state.activeCount,
                      enabled: state.mutatingId != residence.id,
                      onSelected: (transition) => context.read<ResidencesBloc>().add(
                        ResidenceStatusChangeRequested(
                          residence.id,
                          transition,
                        ),
                      ),
                      onDelete: () async {
                        await confirmDeleteResidence(context, residence);
                        if (context.mounted) await context.router.maybePop();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.spacingSm),
                // Only worth the room once there is something to sift through.
                if (residence.units.length > _searchThreshold) ...[
                  Input(
                    controller: _searchController,
                    hintText: l10n.residenceUnitsSearchHint,
                    prefixIcon: Icon(
                      LucideIcons.search,
                      size: Dimens.icon,
                      color: context.mboaColors.textTertiary,
                    ),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(LucideIcons.x, size: Dimens.iconSm),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                    onChanged: (value) => setState(() => _query = value),
                  ),
                  const SizedBox(height: Dimens.spacingSm),
                ],
                MboaSegmentedControl<AnnonceFilter>(
                  value: _filter,
                  segments: [
                    MboaSegment(
                      value: AnnonceFilter.available,
                      label: l10n.annoncesTabAvailable,
                    ),
                    MboaSegment(
                      value: AnnonceFilter.occupied,
                      label: l10n.annoncesTabOccupied,
                    ),
                    MboaSegment(
                      value: AnnonceFilter.archived,
                      label: l10n.annoncesTabArchived,
                    ),
                  ],
                  onChanged: (filter) => setState(() => _filter = filter),
                ),
                const SizedBox(height: Dimens.spacingSm),
                if (_visibleUnits(residence) case final units when units.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimens.spacingLg,
                    ),
                    child: Text(
                      // A search that finds nothing is a different situation
                      // from a tab that is simply empty.
                      _query.isEmpty
                          ? switch (_filter) {
                              AnnonceFilter.available => l10n.annoncesEmptyAvailable,
                              AnnonceFilter.occupied => l10n.annoncesEmptyOccupied,
                              AnnonceFilter.archived => l10n.annoncesEmptyArchived,
                            }
                          : l10n.residenceUnitsSearchEmpty(_query),
                      textAlign: TextAlign.center,
                      style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
                    ),
                  )
                else
                  for (final unit in _visibleUnits(residence))
                    _UnitRow(
                      unit: unit,
                      onOpen: () => context.router.push(AnnonceDetailRoute(id: unit.id)),
                      onEdit: () => _editUnit(unit),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.residence});

  final Residence residence;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: Stack(
        children: [
          SizedBox(
            height: 180,
            width: double.infinity,
            // Same reason as the listing header: white text needs a dark bed.
            child: residence.coverUrl == null
                ? ColoredBox(
                    color: colors.primaryDark,
                    child: Align(
                      alignment: const Alignment(0, -0.45),
                      child: Icon(
                        LucideIcons.layers,
                        color: colors.onBrand.withValues(alpha: 0.4),
                        size: Dimens.iconLg,
                      ),
                    ),
                  )
                : Image.network(
                    residence.coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => ColoredBox(
                      color: colors.primaryDark,
                      child: Icon(
                        LucideIcons.layers,
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
                    colors.ink.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimens.spacing,
            right: Dimens.spacing,
            child: AnnonceStatusChip(status: residence.status),
          ),
          Positioned(
            left: Dimens.spacing,
            right: Dimens.spacing,
            bottom: Dimens.spacing,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  residence.name,
                  style: context.mboaText.h2.copyWith(color: colors.onBrand),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (residence.district case final district?)
                  Row(
                    children: [
                      Icon(
                        LucideIcons.mapPin,
                        size: Dimens.iconSm,
                        color: colors.onBrand,
                      ),
                      const SizedBox(width: Dimens.spacingXs),
                      Text(
                        district,
                        style: context.mboaText.label.copyWith(color: colors.onBrand),
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

/// How the residence is doing, in three numbers.
///
/// The counts come from the residence payload where the server sends them and
/// from the units it carries otherwise — `unitCount` is absent on the list
/// shape but the detail always has the units themselves (RM-M10bis-01 caps
/// them at 200, so counting is free).
class _Counts extends StatelessWidget {
  const _Counts({required this.residence});

  final Residence residence;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    final units = residence.units;
    final total = residence.unitCount ?? units.length;
    final published = residence.publishedUnitCount ?? units.where((u) => u.status == AnnonceStatus.published).length;
    final occupied = units.where((u) => u.status == AnnonceStatus.reserved || u.status == AnnonceStatus.rented).length;

    return Row(
      children: [
        Expanded(
          child: _CountTile(
            value: total,
            label: l10n.residenceDetailUnitsLabel,
          ),
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: _CountTile(
            value: published,
            label: l10n.residenceDetailPublishedLabel,
          ),
        ),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: _CountTile(
            value: occupied,
            label: l10n.residenceDetailOccupiedLabel,
          ),
        ),
      ],
    );
  }
}

class _CountTile extends StatelessWidget {
  const _CountTile({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.spacing,
        vertical: Dimens.spacingMd,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$value',
            style: context.mboaText.h2.copyWith(color: colors.primaryDark),
          ),
          Text(
            label,
            style: context.mboaText.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({
    required this.unit,
    required this.onOpen,
    required this.onEdit,
  });

  final ResidenceUnit unit;
  final VoidCallback onOpen;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMd),
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
                      unit.title,
                      style: context.mboaText.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (unit.propertyType case final type?) ...[
                      const SizedBox(height: Dimens.spacingXs),
                      Text(
                        type.label(l10n),
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    ],
                    if (unit.price case final rent?) ...[
                      const SizedBox(height: Dimens.spacingXs),
                      Text(
                        unit.rentalPeriod.priceLabel(l10n, rent),
                        style: context.mboaText.caption.copyWith(color: colors.primary),
                      ),
                    ],
                  ],
                ),
              ),
              AnnonceStatusChip(status: unit.status),
              IconButton(
                tooltip: l10n.annoncesActionEdit,
                onPressed: onEdit,
                icon: Icon(LucideIcons.squarePen, size: Dimens.icon, color: colors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
