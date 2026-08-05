import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/residences_bloc.dart';
import '../models/annonce_draft.dart';
import '../models/residence.dart';
import '../models/annonce_status.dart';
import 'widgets/annonce_status_chip.dart';
import 'widgets/status_actions_menu.dart';

/// Biens Multiples list (CDC M10).
@RoutePage()
class ResidencesListPage extends StatefulWidget {
  const ResidencesListPage({super.key});

  @override
  State<ResidencesListPage> createState() => _ResidencesListPageState();
}

class _ResidencesListPageState extends State<ResidencesListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ResidencesBloc>().add(const ResidencesLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.annoncesMultipleTitle)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.router.push(
          AnnonceFormRoute(kind: AnnonceKind.residence),
        ),
        backgroundColor: colors.primary,
        foregroundColor: colors.onBrand,
        child: const Icon(LucideIcons.plus),
      ),
      body: BlocConsumer<ResidencesBloc, ResidencesState>(
        listenWhen: (prev, curr) =>
            curr is ResidencesReady && curr.lastActionFailed,
        listener: (context, state) => MboaToast.error(
          context: context,
          title: l10n.commonErrorTitle,
          description: l10n.annonceActionFailed,
        ),
        builder: (context, state) => switch (state) {
          ResidencesInitial() || ResidencesLoadInProgress() =>
            const Center(child: Loader()),
          ResidencesFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<ResidencesBloc>()
                    .add(const ResidencesLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          ResidencesReady(:final items, :final mutatingId) =>
            RefreshIndicator(
              onRefresh: () async => context
                  .read<ResidencesBloc>()
                  .add(const ResidencesRefreshRequested()),
              child: items.isEmpty
                  ? _Empty(label: l10n.annoncesEmptyAvailable)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        Dimens.spacing,
                        Dimens.spacing,
                        Dimens.spacing,
                        Dimens.spacing3Xl,
                      ),
                      itemCount: items.length,
                      itemBuilder: (context, index) => _ResidenceCard(
                        residence: items[index],
                        activeCount: state.activeCount,
                        isBusy: mutatingId == items[index].id,
                        onTransition: (transition) => context
                            .read<ResidencesBloc>()
                            .add(ResidenceStatusChangeRequested(
                              items[index].id,
                              transition,
                            )),
                      ),
                    ),
            ),
        },
      ),
    );
  }
}

class _ResidenceCard extends StatelessWidget {
  const _ResidenceCard({
    required this.residence,
    required this.isBusy,
    required this.activeCount,
    required this.onTransition,
  });

  final Residence residence;
  final bool isBusy;
  final int activeCount;
  final ValueChanged<AnnonceTransition> onTransition;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Opacity(
      opacity: isBusy ? 0.6 : 1,
      child: Container(
        margin: const EdgeInsets.only(bottom: Dimens.spacing),
        padding: const EdgeInsets.all(Dimens.spacing),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusLg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LucideIcons.layers,
                  size: Dimens.icon,
                  color: colors.primary,
                ),
                const SizedBox(width: Dimens.spacingSm),
                Expanded(
                  child: Text(
                    residence.name,
                    style: context.mboaText.h3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AnnonceStatusChip(status: residence.status),
                StatusActionsMenu(
                  status: residence.status,
                  // Bulk publish covers many units; the per-listing photo rule
                  // does not apply, and the backend validates each unit.
                  photoCount: 3,
                  activeCount: activeCount,
                  enabled: !isBusy,
                  onSelected: onTransition,
                ),
              ],
            ),
            if (residence.district case final district?) ...[
              const SizedBox(height: Dimens.spacingXs),
              Text(
                district,
                style: context.mboaText.caption
                    .copyWith(color: colors.textSecondary),
              ),
            ],
            const SizedBox(height: Dimens.spacingMd),
            Wrap(
              spacing: Dimens.spacingSm,
              runSpacing: Dimens.spacingSm,
              children: [
                _Pill(label: l10n.annoncesUnitsSummary(residence.unitCount ?? 0)),
                _Pill(
                  label: l10n.annoncesUnitsPublished(
                    residence.publishedUnitCount ?? 0,
                  ),
                ),
              ],
            ),
            if (isBusy) ...[
              const SizedBox(height: Dimens.spacingMd),
              const LinearProgressIndicator(minHeight: 2),
            ],
          ],
        ),
      ),
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

class _Empty extends StatelessWidget {
  const _Empty({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: Dimens.spacing3Xl),
        Padding(
          padding: const EdgeInsets.all(Dimens.spacingXl),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: context.mboaText.body
                .copyWith(color: context.mboaColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
