import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/residences_bloc.dart';
import '../models/annonce.dart';
import '../models/residence.dart';
import '../models/annonce_draft.dart';
import '../../../app/router/app_router.gr.dart';
import 'residences_list_page.dart';
import 'widgets/annonce_status_chip.dart';
import 'widgets/status_actions_menu.dart';

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
                if (residence.units.isEmpty)
                  Text(
                    l10n.annoncesEmptyAvailable,
                    style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary),
                  )
                else
                  for (final unit in residence.units)
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
            child: residence.coverUrl == null
                ? ColoredBox(
                    color: colors.primaryPale,
                    child: Icon(LucideIcons.layers, color: colors.primary),
                  )
                : Image.network(
                    residence.coverUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => ColoredBox(
                      color: colors.primaryPale,
                      child: Icon(LucideIcons.layers, color: colors.primary),
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
            left: Dimens.spacing,
            right: Dimens.spacing,
            bottom: Dimens.spacing,
            child: Row(
              children: [
                Expanded(
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
                        Text(
                          district,
                          style: context.mboaText.caption.copyWith(color: colors.onBrand),
                        ),
                    ],
                  ),
                ),
                AnnonceStatusChip(status: residence.status),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Counts extends StatelessWidget {
  const _Counts({required this.residence});

  final Residence residence;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [
        _Pill(label: l10n.annoncesUnitsSummary(residence.unitCount ?? 0)),
        _Pill(
          label: l10n.annoncesUnitsPublished(residence.publishedUnitCount ?? 0),
        ),
      ],
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label});

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
        style: context.mboaText.caption.copyWith(color: colors.primary),
      ),
    );
  }
}

String _typeLabel(PropertyType type) => switch (type) {
  PropertyType.apartment => 'Appartement',
  PropertyType.studio => 'Studio',
  PropertyType.villa => 'Villa',
  PropertyType.room => 'Chambre',
  PropertyType.office => 'Bureau',
  PropertyType.commercialSpace => 'Local commercial',
};

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
        borderRadius: BorderRadius.circular(Dimens.radius),
        border: Border.all(color: colors.border),
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacingMd),
          child: Row(
            children: [
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
                        _typeLabel(type),
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    ],
                    if (unit.monthlyRent case final rent?) ...[
                      const SizedBox(height: Dimens.spacingXs),
                      Text(
                        l10n.annoncesPerMonth(
                          NumberFormat.decimalPattern().format(rent),
                        ),
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
