import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../home/ui/widgets/home_nudge_card.dart';
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
    return BlocBuilder<WaitingDeclarationsBloc, WaitingDeclarationsState>(
      builder: (context, state) {
        if (state is! WaitingDeclarationsCounted || state.count == 0) return const SizedBox.shrink();

        return HomeNudgeCard(
          icon: LucideIcons.handCoins,
          text: l10n.proRentsPending(state.count),
          action: l10n.proRentsPendingAction,
          onTap: () async {
            final bloc = context.read<WaitingDeclarationsBloc>();
            await context.router.push(RentsRoute());
            bloc.add(const WaitingDeclarationsRequested());
          },
        );
      },
    );
  }
}
