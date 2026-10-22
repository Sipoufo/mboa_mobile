import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../../home/ui/widgets/home_nudge_card.dart';
import '../../bloc/open_requests_bloc.dart';

/// The home's nudge (CDC M30, RM-M30-09): tenants' requests still waiting on
/// the landlord. Nothing when there is nothing to answer.
class OpenRequestsCard extends StatefulWidget {
  const OpenRequestsCard({super.key});

  @override
  State<OpenRequestsCard> createState() => _OpenRequestsCardState();
}

class _OpenRequestsCardState extends State<OpenRequestsCard> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<OpenRequestsBloc>();
    if (bloc.state is OpenRequestsUnknown) bloc.add(const OpenRequestsRequested());
    // Back in the app: a tenant may have asked meanwhile.
    _lifecycle = AppLifecycleListener(onResume: () => bloc.add(const OpenRequestsRequested()));
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return BlocBuilder<OpenRequestsBloc, OpenRequestsState>(
      builder: (context, state) {
        if (state is! OpenRequestsCounted || state.count == 0) return const SizedBox.shrink();

        return HomeNudgeCard(
          icon: LucideIcons.messagesSquare,
          text: l10n.proRequestsPending(state.count),
          action: l10n.proReservationsPendingAction,
          onTap: () async {
            final bloc = context.read<OpenRequestsBloc>();
            await context.router.push(const ReceivedRequestsRoute());
            bloc.add(const OpenRequestsRequested());
          },
        );
      },
    );
  }
}
