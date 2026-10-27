import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/ui/widgets/global_stats_card.dart';
import '../models/annonce_draft.dart';

/// "Mes biens" hub (CDC M10).
///
/// The two kinds of property, then the agents and the reservations received.
/// « En attente de validation » and « Prospections » were « Bientôt » tiles
/// from the mockup with nothing in Doc 10 behind them; the founder had them
/// removed (2026-10-27) rather than promise screens that do not exist.
@RoutePage()
class MesBiensPage extends StatelessWidget {
  const MesBiensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
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
          Row(
            children: [
              Expanded(
                child: _KindCard(
                  icon: LucideIcons.house,
                  label: l10n.mesBiensSingle,
                  onTap: () => context.router.push(const AnnoncesListRoute()),
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: _KindCard(
                  icon: LucideIcons.layers,
                  label: l10n.mesBiensMultiple,
                  onTap: () => context.router.push(const ResidencesListRoute()),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.spacing),
          _EntryRow(
            icon: LucideIcons.keyRound,
            title: l10n.mesBiensAttributions,
            subtitle: l10n.mesBiensAttributionsBody,
            // M11 — the agents and what they are assigned to.
            onTap: () => context.router.push(const MesAgentsRoute()),
          ),
          _EntryRow(
            icon: LucideIcons.clipboardList,
            title: l10n.mesBiensReservations,
            subtitle: l10n.mesBiensReservationsBody,
            // M29 — the requests received on his listings.
            onTap: () => context.router.push(IncomingReservationsRoute()),
          ),
          const SizedBox(height: Dimens.spacing),
          const _Stats(),
        ],
      ),
    );
  }
}

/// Reuses the home dashboard card — the design shows the same figures here.
class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => switch (state) {
        HomeReady(:final stats) => GlobalStatsCard(stats: stats),
        _ => const SizedBox.shrink(),
      },
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
