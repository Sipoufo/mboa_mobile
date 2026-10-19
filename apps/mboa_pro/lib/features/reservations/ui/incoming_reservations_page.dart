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
import '../bloc/incoming_reservations_bloc.dart';

/// "Demandes de réservation" (CDC M29) — every request on the prestataire's
/// listings, or one listing's when opened from its fiche.
///
/// After the founder's mockup: a timeline by day, the date on the left and a
/// dotted line down to the next. Waiting requests first — they are the ones
/// with a clock on them (RM-M29-05).
@RoutePage()
class IncomingReservationsPage extends StatelessWidget implements AutoRouteWrapper {
  const IncomingReservationsPage({super.key, this.annonceId, this.annonceTitle});

  /// Set to list one listing's requests.
  final String? annonceId;
  final String? annonceTitle;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<IncomingReservationsBloc>(
        create: (_) =>
            getIt<IncomingReservationsBloc>(param1: annonceId)..add(const IncomingReservationsRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) => IncomingReservationsView(annonceTitle: annonceTitle);
}

/// The list under its bloc — public so it can be pumped with a mock one.
class IncomingReservationsView extends StatelessWidget {
  const IncomingReservationsView({super.key, this.annonceTitle});

  final String? annonceTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.proReservationsTitle)),
      body: BlocBuilder<IncomingReservationsBloc, IncomingReservationsState>(
        builder: (context, state) => switch (state) {
          IncomingReservationsLoading() => const Center(child: Loader()),
          IncomingReservationsFailure() => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                  TextButton(
                    onPressed: () =>
                        context.read<IncomingReservationsBloc>().add(const IncomingReservationsRequested()),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          final IncomingReservationsReady ready => _Inbox(state: ready, annonceTitle: annonceTitle),
        },
      ),
    );
  }
}

enum _Filter { pending, all }

class _Inbox extends StatefulWidget {
  const _Inbox({required this.state, this.annonceTitle});

  final IncomingReservationsReady state;
  final String? annonceTitle;

  @override
  State<_Inbox> createState() => _InboxState();
}

/// The tab is view state, not data — the list itself is the bloc's.
class _InboxState extends State<_Inbox> {
  _Filter _filter = _Filter.pending;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final state = widget.state;
    final shown = _filter == _Filter.pending ? state.pending : state.items;
    final days = _byDay(shown);
    final bloc = context.read<IncomingReservationsBloc>();

    return RefreshIndicator(
      onRefresh: () async => bloc.add(const IncomingReservationsRequested()),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
        children: [
          if (widget.annonceTitle case final title?) ...[
            Row(
              children: [
                Icon(LucideIcons.house, size: Dimens.iconSm, color: colors.primary),
                const SizedBox(width: Dimens.spacingXs),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.label.copyWith(color: colors.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.spacingMd),
          ],
          if (state.isOffline) ...[
            _OfflineBanner(text: l10n.proReservationsOffline),
            const SizedBox(height: Dimens.spacingMd),
          ],
          MboaSegmentedControl<_Filter>(
            value: _filter,
            onChanged: (filter) => setState(() => _filter = filter),
            segments: [
              MboaSegment(
                value: _Filter.pending,
                label: '${l10n.proReservationsFilterPending} (${state.pending.length})',
              ),
              MboaSegment(value: _Filter.all, label: '${l10n.proReservationsFilterAll} (${state.items.length})'),
            ],
          ),
          const SizedBox(height: Dimens.spacingLg),
          if (shown.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXl),
              child: Column(
                children: [
                  Icon(LucideIcons.ticket, size: Dimens.iconLg, color: colors.textTertiary),
                  const SizedBox(height: Dimens.spacing),
                  Text(
                    _filter == _Filter.pending ? l10n.proReservationsEmptyPending : l10n.proReservationsEmptyAll,
                    textAlign: TextAlign.center,
                    style: context.mboaText.body.copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            )
          else
            for (final (index, day) in days.indexed)
              _Day(
                day: day.$1,
                items: day.$2,
                last: index == days.length - 1,
                onOpen: (reservation) async {
                  await context.router.push(IncomingReservationRoute(id: reservation.id));
                  // An answer given there shows here on the way back.
                  bloc.add(const IncomingReservationsRequested());
                },
              ),
        ],
      ),
    );
  }

  /// The requests by the day they were sent, newest day first; a request the
  /// cache kept without its date goes last.
  static List<(DateTime?, List<Reservation>)> _byDay(List<Reservation> items) {
    final days = <DateTime?, List<Reservation>>{};
    for (final r in items) {
      final at = r.createdAt;
      days.putIfAbsent(at == null ? null : DateTime(at.year, at.month, at.day), () => []).add(r);
    }
    final keys = days.keys.toList()
      ..sort((a, b) => a == null ? 1 : (b == null ? -1 : b.compareTo(a)));
    return [for (final k in keys) (k, days[k]!)];
  }
}

/// One day of the timeline: the date, the dotted line, the day's requests.
class _Day extends StatelessWidget {
  const _Day({required this.day, required this.items, required this.last, required this.onOpen});

  final DateTime? day;
  final List<Reservation> items;
  final bool last;
  final ValueChanged<Reservation> onOpen;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final day = this.day;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Column(
              children: [
                if (day != null) ...[
                  Text(DateFormat.d(locale).format(day), style: context.mboaText.h2.copyWith(color: colors.primaryDark)),
                  Text(
                    DateFormat.MMM(locale).format(day),
                    style: context.mboaText.caption.copyWith(color: colors.primaryDark),
                  ),
                ],
                const SizedBox(height: Dimens.spacingXs),
                if (!last) Expanded(child: CustomPaint(painter: _DottedLine(colors.primaryDark.withValues(alpha: 0.5)))),
              ],
            ),
          ),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              children: [
                for (final r in items) _Row(reservation: r, onTap: () => onOpen(r)),
                if (!last) const SizedBox(height: Dimens.spacingSm),
              ],
            ),
          ),
        ],
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
    final open = reservation.status == ReservationStatus.pending;
    final at = reservation.createdAt;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: open ? colors.primaryLight2 : colors.surfaceWarm,
              ),
              child: Icon(LucideIcons.ticket, size: Dimens.iconSm, color: open ? colors.primary : colors.textTertiary),
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.proReservationDetailTitle,
                    style: context.mboaText.label.copyWith(color: colors.primaryDark),
                  ),
                  Text(
                    l10n.proReservationRowBody(
                      reservation.client?.name ?? l10n.proReservationClient,
                      reservation.annonceTitle ?? l10n.reservationUntitled,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.caption.copyWith(color: colors.ink),
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Row(
                    children: [
                      if (at != null) ...[
                        Text(
                          DateFormat.Hm(locale).format(at),
                          style: context.mboaText.micro.copyWith(color: colors.textTertiary),
                        ),
                        const SizedBox(width: Dimens.spacingSm),
                      ],
                      ReservationStatusChip(status: reservation.status),
                    ],
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.textTertiary),
          ],
        ),
      ),
    );
  }
}

class _DottedLine extends CustomPainter {
  const _DottedLine(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    for (var y = 2.0; y < size.height; y += 6) {
      canvas.drawLine(Offset(size.width / 2, y), Offset(size.width / 2, y + 2.5), paint);
    }
  }

  @override
  bool shouldRepaint(_DottedLine old) => old.color != color;
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.text});

  final String text;

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
          Expanded(child: Text(text, style: context.mboaText.caption.copyWith(color: colors.warning))),
        ],
      ),
    );
  }
}
