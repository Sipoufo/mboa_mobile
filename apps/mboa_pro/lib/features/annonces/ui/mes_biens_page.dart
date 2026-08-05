import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/ui/widgets/global_stats_card.dart';
import '../models/annonce_draft.dart';

/// "Mes biens" hub (CDC M10).
///
/// The two entry cards are real; Attributions, Réservations, Prospections and
/// "En attente de validation" have no endpoints, so they route to the
/// coming-soon explainer rather than being hidden — the hub is the map of the
/// product, and quietly dropping half of it would misrepresent it.
@RoutePage()
class MesBiensPage extends StatelessWidget {
  const MesBiensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.surfaceWarm,
      appBar: AppBar(title: Text(l10n.mesBiensTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(
          AnnonceFormRoute(kind: AnnonceKind.single),
        ),
        backgroundColor: colors.primary,
        foregroundColor: colors.onBrand,
        child: const Icon(LucideIcons.plus),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimens.spacing),
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _PendingCard(
                    onTap: () => _comingSoon(context),
                    label: l10n.mesBiensPending,
                  ),
                ),
                const SizedBox(width: Dimens.spacingMd),
                Expanded(
                  child: Column(
                    children: [
                      _KindCard(
                        icon: LucideIcons.house,
                        label: l10n.mesBiensSingle,
                        onTap: () =>
                            context.router.push(const AnnoncesListRoute()),
                      ),
                      const SizedBox(height: Dimens.spacingMd),
                      _KindCard(
                        icon: LucideIcons.layers,
                        label: l10n.mesBiensMultiple,
                        onTap: () =>
                            context.router.push(const ResidencesListRoute()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimens.spacing),
          _EntryRow(
            icon: LucideIcons.keyRound,
            title: l10n.mesBiensAttributions,
            subtitle: l10n.mesBiensAttributionsBody,
            onTap: () => _comingSoon(context),
          ),
          _EntryRow(
            icon: LucideIcons.clipboardList,
            title: l10n.mesBiensReservations,
            subtitle: l10n.mesBiensReservationsBody,
            onTap: () => _comingSoon(context),
          ),
          _EntryRow(
            icon: LucideIcons.radar,
            title: l10n.mesBiensProspections,
            subtitle: l10n.mesBiensProspectionsBody,
            onTap: () => _comingSoon(context),
          ),
          const SizedBox(height: Dimens.spacing),
          const _Stats(),
        ],
      ),
    );
  }

  void _comingSoon(BuildContext context) => context.router.push(
        AccessRestrictedRoute(restriction: AccessRestriction.comingSoon),
      );
}

/// Reuses the home dashboard card — the design shows the same figures here.
class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => switch (state) {
        HomeReady(:final stats) => GlobalStatsCard(
            stats: stats,
            access: const AccessContext.unknown(),
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _PendingCard extends StatelessWidget {
  const _PendingCard({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.spacingMd),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.actionPale,
                ),
                child: Icon(LucideIcons.clock, color: colors.action),
              ),
              const SizedBox(height: Dimens.spacingLg),
              Text(
                label,
                style: context.mboaText.h3.copyWith(color: colors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _KindCard extends StatelessWidget {
  const _KindCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(Dimens.spacingSm),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.primaryPale,
                ),
                child: Icon(icon, size: Dimens.icon, color: colors.primary),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Text(
                  label,
                  style: context.mboaText.label.copyWith(color: colors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntryRow extends StatelessWidget {
  const _EntryRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Dimens.spacing,
          vertical: Dimens.spacingSm,
        ),
        leading: Container(
          padding: const EdgeInsets.all(Dimens.spacingSm),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.primaryPale,
          ),
          child: Icon(icon, size: Dimens.icon, color: colors.primary),
        ),
        title: Text(title, style: context.mboaText.h3),
        subtitle: Text(
          subtitle,
          style: context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        trailing: Icon(LucideIcons.arrowDownRight, color: colors.primary),
        onTap: onTap,
      ),
    );
  }
}
