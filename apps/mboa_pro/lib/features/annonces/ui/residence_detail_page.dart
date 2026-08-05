import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/residences_bloc.dart';
import '../models/residence.dart';
import 'widgets/annonce_status_chip.dart';
import 'widgets/status_actions_menu.dart';

/// Residence detail (CDC M10) — the property, its unit counts, and the units
/// themselves.
///
/// **Units are read-only here.** `ResidenceResponse.units` gives a summary
/// (id, title, type, status, rent) and there is no per-unit endpoint — the API
/// exposes only the *bulk* transitions. Editing a single unit lands once the
/// backend says whether a unit id is an annonce id.
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

          final residence =
              state.items.where((r) => r.id == widget.id).firstOrNull;
          // Still fetching, or genuinely gone.
          if (residence == null) return const Center(child: Loader());

          return RefreshIndicator(
            onRefresh: () async => context
                .read<ResidencesBloc>()
                .add(ResidenceDetailRequested(widget.id)),
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
                      onSelected: (transition) => context
                          .read<ResidencesBloc>()
                          .add(ResidenceStatusChangeRequested(
                            residence.id,
                            transition,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.spacingSm),
                if (residence.units.isEmpty)
                  Text(
                    l10n.annoncesEmptyAvailable,
                    style: context.mboaText.body
                        .copyWith(color: context.mboaColors.textSecondary),
                  )
                else
                  for (final unit in residence.units) _UnitRow(unit: unit),
                const SizedBox(height: Dimens.spacingMd),
                Text(
                  l10n.residenceUnitsPending,
                  style: context.mboaText.micro
                      .copyWith(color: context.mboaColors.textTertiary),
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
                        style: context.mboaText.h2
                            .copyWith(color: colors.onBrand),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (residence.district case final district?)
                        Text(
                          district,
                          style: context.mboaText.caption
                              .copyWith(color: colors.onBrand),
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

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.unit});

  final ResidenceUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radius),
        border: Border.all(color: colors.border),
      ),
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
                if (unit.monthlyRent case final rent?) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  Text(
                    l10n.annoncesPerMonth(
                      NumberFormat.decimalPattern().format(rent),
                    ),
                    style: context.mboaText.caption
                        .copyWith(color: colors.primary),
                  ),
                ],
              ],
            ),
          ),
          AnnonceStatusChip(status: unit.status),
        ],
      ),
    );
  }
}
