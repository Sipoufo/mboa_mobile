import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/contracts_bloc.dart';
import 'widgets/contract_bits.dart';

/// The prestataire's Contrats Mboa (CDC M08).
///
/// Leads with what is waiting on **him** (RM-M08-09): a landlord opening this
/// wants to know what he is holding up, not how many drafts he has.
@RoutePage()
class ContractsListPage extends StatelessWidget implements AutoRouteWrapper {
  const ContractsListPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ContractsBloc>(
        create: (_) =>
            getIt<ContractsBloc>()..add(const ContractsLoadRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(title: Text(l10n.contractsTitle)),
      body: BlocBuilder<ContractsBloc, ContractsState>(
        builder: (context, state) => switch (state) {
          ContractsInitial() || ContractsLoadInProgress() =>
            const Center(child: Loader()),
          ContractsFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<ContractsBloc>()
                    .add(const ContractsLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          final ContractsReady ready => _Body(state: ready),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final ContractsReady state;

  @override
  Widget build(BuildContext context) {
    final visible = state.visible;

    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ContractsBloc>().add(const ContractsRefreshRequested()),
      child: ListView(
        padding: const EdgeInsets.all(Dimens.spacing),
        children: [
          _Filters(state: state),
          const SizedBox(height: Dimens.spacing),
          if (visible.isEmpty)
            _Empty(isFiltered: state.items.isNotEmpty)
          else
            for (final contract in visible)
              _ContractCard(
                contract: contract,
                onTap: () async {
                  await context.router
                      .push(ContractDetailRoute(id: contract.id));
                  if (context.mounted) {
                    context
                        .read<ContractsBloc>()
                        .add(const ContractsRefreshRequested());
                  }
                },
              ),
        ],
      ),
    );
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.state});

  final ContractsReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final count = state.awaitingMeCount;

    return Wrap(
      spacing: Dimens.spacingSm,
      runSpacing: Dimens.spacingSm,
      children: [
        _Chip(
          label: count == 0
              ? l10n.contractsFilterMine
              : '${l10n.contractsFilterMine} ($count)',
          selected: state.filter == const ContractFilter.awaitingMe(),
          filter: const ContractFilter.awaitingMe(),
        ),
        _Chip(
          label: l10n.contractsFilterAll,
          selected: state.filter == const ContractFilter.all(),
          filter: const ContractFilter.all(),
        ),
        _Chip(
          label: l10n.contractStatusSigned,
          selected: state.filter ==
              const ContractFilter.status(ContractStatus.signed),
          filter: const ContractFilter.status(ContractStatus.signed),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.filter,
  });

  final String label;
  final bool selected;
  final ContractFilter filter;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) =>
          context.read<ContractsBloc>().add(ContractsFilterChanged(filter)),
      labelStyle: context.mboaText.caption
          .copyWith(color: selected ? colors.onBrand : colors.textSecondary),
      selectedColor: colors.primary,
      backgroundColor: colors.surface,
      side: BorderSide(color: colors.border),
      showCheckmark: false,
    );
  }
}

class _ContractCard extends StatelessWidget {
  const _ContractCard({required this.contract, required this.onTap});

  final Contract contract;
  final VoidCallback onTap;

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
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      contract.annonceTitle ?? '',
                      style: context.mboaText.label
                          .copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ContractStatusChip(status: contract.status),
                ],
              ),
              const SizedBox(height: Dimens.spacingXs),
              Text(
                contract.tenant?.displayName ?? l10n.contractTenantPending,
                style: context.mboaText.caption
                    .copyWith(color: colors.textSecondary),
              ),
              if (contract.price case final price?) ...[
                const SizedBox(height: Dimens.spacingXs),
                Text(
                  contract.rentalPeriod.priceLabel(l10n, price),
                  style: context.mboaText.caption.copyWith(color: colors.primary),
                ),
              ],
              const SizedBox(height: Dimens.spacingSm),
              AwaitingLine(awaiting: contract.awaiting),
            ],
          ),
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.isFiltered});

  final bool isFiltered;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
      child: Column(
        children: [
          Icon(
            LucideIcons.fileText,
            size: Dimens.iconLg,
            color: colors.textTertiary,
          ),
          const SizedBox(height: Dimens.spacing),
          Text(
            isFiltered ? l10n.contractsEmptyFiltered : l10n.contractsEmptyTitle,
            textAlign: TextAlign.center,
            style: context.mboaText.h3.copyWith(color: colors.ink),
          ),
          if (!isFiltered) ...[
            const SizedBox(height: Dimens.spacingXs),
            // RM-M08-01 — a contract always starts from one of his listings,
            // so the empty state points there rather than offering a "+" that
            // would have nothing to attach itself to.
            Text(
              l10n.contractsEmptyBody,
              textAlign: TextAlign.center,
              style:
                  context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: Dimens.spacing),
            Button.outline(
              title: l10n.mesBiensTitle,
              onPressed: () => context.router.push(const MesBiensRoute()),
            ),
          ],
        ],
      ),
    );
  }
}
