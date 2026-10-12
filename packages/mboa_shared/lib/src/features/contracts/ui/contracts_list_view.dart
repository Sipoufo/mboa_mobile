import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/contracts_bloc.dart';
import '../models/contract.dart';
import '../../listings/models/rental_period.dart';
import 'widgets/contract_bits.dart';

/// The account's Contrats Mboa (CDC M08) — the same list for either party.
///
/// Leads with what is waiting on **the reader** (RM-M08-09): whoever opens
/// this wants to know what they are holding up.
///
/// Shared, so the two couplings an app owns are handed in rather than reached
/// for: [onOpen] routes to the detail, and [empty] is the screen for a reader
/// with no contracts — which is not the same screen on both sides. A landlord
/// with none is pointed at his listings, because RM-M08-01 says a contract
/// starts from a bien; a tenant with none has nothing to do about it.
class ContractsListView extends StatelessWidget {
  const ContractsListView({
    super.key,
    required this.onOpen,
    required this.empty,
  });

  /// Opens one contract. Awaited: the list re-reads when it comes back, since
  /// the reader may have signed or contested in the meantime.
  final Future<void> Function(String contractId) onOpen;

  /// The empty state, told whether a filter is hiding everything.
  final Widget Function(bool isFiltered) empty;

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
          final ContractsReady ready =>
            _Body(state: ready, onOpen: onOpen, empty: empty),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state, required this.onOpen, required this.empty});

  final ContractsReady state;
  final Future<void> Function(String contractId) onOpen;
  final Widget Function(bool isFiltered) empty;

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
            empty(state.items.isNotEmpty)
          else
            for (final contract in visible)
              _ContractCard(
                contract: contract,
                onTap: () async {
                  await onOpen(contract.id);
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
