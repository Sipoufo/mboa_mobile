import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../../app/router/app_router.gr.dart';
import '../../bloc/pending_reservations_bloc.dart';

/// The home's nudge (CDC M29): requests wait 48 h at most (RM-M29-05), so
/// the count is said where the prestataire looks first. Nothing when there
/// is nothing to answer.
///
/// Read on first show — the home is the prestataire's alone, so an agent
/// session never asks.
class PendingReservationsCard extends StatefulWidget {
  const PendingReservationsCard({super.key});

  @override
  State<PendingReservationsCard> createState() => _PendingReservationsCardState();
}

class _PendingReservationsCardState extends State<PendingReservationsCard> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<PendingReservationsBloc>();
    if (bloc.state is PendingReservationsUnknown) bloc.add(const PendingReservationsRequested());
    // Back in the app: a request may have come in meanwhile (seen on device —
    // the count read at sign-in stayed at 0 and the card never appeared).
    _lifecycle = AppLifecycleListener(onResume: () => bloc.add(const PendingReservationsRequested()));
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

    return BlocBuilder<PendingReservationsBloc, PendingReservationsState>(
      builder: (context, state) {
        if (state is! PendingReservationsCounted || state.count == 0) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(bottom: Dimens.spacingLg),
          child: Material(
            color: colors.primaryPale,
            borderRadius: BorderRadius.circular(Dimens.radiusLg),
            child: InkWell(
              borderRadius: BorderRadius.circular(Dimens.radiusLg),
              onTap: () async {
                final bloc = context.read<PendingReservationsBloc>();
                await context.router.push(IncomingReservationsRoute());
                bloc.add(const PendingReservationsRequested());
              },
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
                      child: Icon(LucideIcons.ticket, color: colors.onBrand, size: Dimens.icon),
                    ),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(
                      child: Text(
                        l10n.proReservationsPending(state.count),
                        style: context.mboaText.label.copyWith(color: colors.primaryDark),
                      ),
                    ),
                    const SizedBox(width: Dimens.spacingSm),
                    Text(
                      l10n.proReservationsPendingAction,
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
