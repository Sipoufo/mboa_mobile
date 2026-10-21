import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../bloc/waiting_declarations_bloc.dart';

/// The home's nudge (CDC M30): payments the tenants declared, waiting for the
/// landlord's answer — said where he looks first, as the reservations are.
/// Nothing when there is nothing to answer.
class WaitingDeclarationsCard extends StatefulWidget {
  const WaitingDeclarationsCard({super.key});

  @override
  State<WaitingDeclarationsCard> createState() => _WaitingDeclarationsCardState();
}

class _WaitingDeclarationsCardState extends State<WaitingDeclarationsCard> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<WaitingDeclarationsBloc>();
    if (bloc.state is WaitingDeclarationsUnknown) bloc.add(const WaitingDeclarationsRequested());
    // Back in the app: a tenant may have declared meanwhile.
    _lifecycle = AppLifecycleListener(onResume: () => bloc.add(const WaitingDeclarationsRequested()));
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocBuilder<WaitingDeclarationsBloc, WaitingDeclarationsState>(
      builder: (context, state) {
        if (state is! WaitingDeclarationsCounted || state.count == 0) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
          child: Material(
            color: colors.primaryPale,
            borderRadius: BorderRadius.circular(Dimens.radiusLg),
            child: InkWell(
              borderRadius: BorderRadius.circular(Dimens.radiusLg),
              onTap: () async {
                final bloc = context.read<WaitingDeclarationsBloc>();
                await context.router.push(RentsRoute());
                bloc.add(const WaitingDeclarationsRequested());
              },
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                      child: Icon(LucideIcons.handCoins, color: colors.onBrand, size: Dimens.icon),
                    ),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(
                      child: Text(
                        l10n.proRentsPending(state.count),
                        style: context.mboaText.label.copyWith(color: colors.primaryDark),
                      ),
                    ),
                    const SizedBox(width: Dimens.spacingSm),
                    Text(
                      l10n.proRentsPendingAction,
                      style: context.mboaText.label.copyWith(color: colors.primary, fontWeight: FontWeight.w700),
                    ),
                    Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.primary),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
