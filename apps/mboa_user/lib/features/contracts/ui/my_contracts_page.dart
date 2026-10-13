import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// The tenant's Contrats Mboa (CDC M08) — the shared list, routed here.
///
/// The entitlement to write a resident review (M27) hangs off a signed
/// contract, so this is also where that journey starts.
@RoutePage()
class MyContractsPage extends StatelessWidget implements AutoRouteWrapper {
  const MyContractsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ContractsBloc>(
        create: (_) =>
            getIt<ContractsBloc>()..add(const ContractsLoadRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => ContractsListView(
        onOpen: (id) => context.router.push(MyContractDetailRoute(id: id)),
        empty: (isFiltered) => _Empty(isFiltered: isFiltered),
      );
}

/// A tenant with no contract has nothing to do about it.
///
/// RM-M08-01 gives drawing one up to the landlord, so the landlord's empty
/// state points him at his listings. Pointing a tenant anywhere would be
/// telling them to go and arrange their own tenancy.
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
            Text(
              l10n.contractsEmptyTenantBody,
              textAlign: TextAlign.center,
              style: context.mboaText.body.copyWith(color: colors.textSecondary),
            ),
          ],
        ],
      ),
    );
  }
}
