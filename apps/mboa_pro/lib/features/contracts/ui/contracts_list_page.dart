import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';

/// The prestataire's Contrats Mboa (CDC M08) — the shared list, routed here.
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
  Widget build(BuildContext context) => ContractsListView(
        onOpen: (id) => context.router.push(ContractDetailRoute(id: id)),
        empty: (isFiltered) => _Empty(isFiltered: isFiltered),
      );
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
