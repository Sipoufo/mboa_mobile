import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../../app/router/app_router.gr.dart';
import '../bloc/my_reservations_bloc.dart';

/// "Mes demandes de réservation" (CDC M29), from the Compte tab.
///
/// Readable offline: the last list read, marked as such.
@RoutePage()
class MyReservationsPage extends StatelessWidget implements AutoRouteWrapper {
  const MyReservationsPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<MyReservationsBloc>(
        create: (_) => getIt<MyReservationsBloc>()..add(const MyReservationsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const MyReservationsView();
}

/// The list under its bloc — public so it can be pumped with a mock one.
class MyReservationsView extends StatelessWidget {
  const MyReservationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.reservationsTitle)),
      body: BlocBuilder<MyReservationsBloc, MyReservationsState>(
        builder: (context, state) => switch (state) {
          MyReservationsLoading() => const Center(child: Loader()),
          MyReservationsFailure() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                  TextButton(
                    onPressed: () => context.read<MyReservationsBloc>().add(const MyReservationsRequested()),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          MyReservationsReady(:final items, :final isOffline) => RefreshIndicator(
              onRefresh: () async => context.read<MyReservationsBloc>().add(const MyReservationsRequested()),
              child: items.isEmpty && !isOffline
                  ? const _Empty()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(
                        Dimens.screenMargin,
                        Dimens.spacing,
                        Dimens.screenMargin,
                        Dimens.spacingXl,
                      ),
                      itemCount: items.length + (isOffline ? 1 : 0),
                      separatorBuilder: (_, _) => const SizedBox(height: Dimens.spacingMd),
                      itemBuilder: (context, index) {
                        if (isOffline && index == 0) return const _OfflineBanner();
                        final reservation = items[index - (isOffline ? 1 : 0)];
                        return _Row(
                          reservation: reservation,
                          onTap: () async {
                            final bloc = context.read<MyReservationsBloc>();
                            await context.router.push(ReservationDetailRoute(id: reservation.id));
                            // A cancellation on the detail shows here on the way back.
                            bloc.add(const MyReservationsRequested());
                          },
                        );
                      },
                    ),
            ),
        },
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.reservation, required this.onTap});

  final Reservation reservation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final start = reservation.desiredStartDate;
    final units = reservation.durationUnits;
    final open = reservation.status.isOpen;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(Dimens.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.spacing),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: open ? colors.primaryPale : colors.surfaceWarm,
                  borderRadius: BorderRadius.circular(Dimens.radius),
                ),
                child: Icon(
                  LucideIcons.calendarRange,
                  size: Dimens.icon,
                  color: open ? colors.primary : colors.textTertiary,
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reservation.placeTitle ?? l10n.reservationUntitled,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.label.copyWith(color: colors.ink),
                    ),
                    ReassignedNote(reservation: reservation),
                    if (start != null && units != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        l10n.reservationRowStay(
                          DateFormat.yMMMd(locale).format(start),
                          durationLabel(l10n, units, reservation.rentalPeriod),
                        ),
                        style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                      ),
                    ],
                    const SizedBox(height: Dimens.spacingSm),
                    ReservationStatusChip(status: reservation.status),
                  ],
                ),
              ),
              Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
            ],
          ),
        ),
      ),
    );
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingMd),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radius),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.wifiOff, size: Dimens.iconSm, color: colors.warning),
          const SizedBox(width: Dimens.spacingSm),
          Expanded(
            child: Text(
              I18n.of(context).reservationsOffline,
              style: context.mboaText.caption.copyWith(color: colors.warning),
            ),
          ),
        ],
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty();

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    // A scrollable, so pulling to refresh still works.
    return ListView(
      padding: const EdgeInsets.all(Dimens.spacingXl),
      children: [
        const SizedBox(height: Dimens.spacingXxl),
        Icon(LucideIcons.calendarRange, size: Dimens.iconLg, color: colors.textTertiary),
        const SizedBox(height: Dimens.spacing),
        Text(
          l10n.reservationsEmptyTitle,
          textAlign: TextAlign.center,
          style: context.mboaText.h3.copyWith(color: colors.ink),
        ),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.reservationsEmptyBody,
          textAlign: TextAlign.center,
          style: context.mboaText.body.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}
