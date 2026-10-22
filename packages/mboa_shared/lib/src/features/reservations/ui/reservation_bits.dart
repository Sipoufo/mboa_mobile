import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../models/reservation.dart';

/// Where a request stands, as a pill — the same words on both sides.
class ReservationStatusChip extends StatelessWidget {
  const ReservationStatusChip({super.key, required this.status});

  final ReservationStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    final (label, tone) = switch (status) {
      ReservationStatus.pending => (l10n.reservationStatusPending, colors.warning),
      ReservationStatus.accepted => (l10n.reservationStatusAccepted, colors.success),
      ReservationStatus.contracted => (l10n.reservationStatusContracted, colors.primary),
      ReservationStatus.refused => (l10n.reservationStatusRefused, colors.error),
      ReservationStatus.notRetained => (l10n.reservationStatusNotRetained, colors.textSecondary),
      ReservationStatus.expired => (l10n.reservationStatusExpired, colors.textSecondary),
      ReservationStatus.cancelled => (l10n.reservationStatusCancelled, colors.textSecondary),
      ReservationStatus.lapsed => (l10n.reservationStatusLapsed, colors.textSecondary),
      ReservationStatus.unknown => (l10n.reservationStatusUnknown, colors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Dimens.radiusFull),
      ),
      child: Text(label, style: context.mboaText.caption.copyWith(color: tone, fontWeight: FontWeight.w600)),
    );
  }
}

/// RM-M29-06 — a refusal (or a prestataire's cancellation) reason, in words.
String refusalReasonLabel(I18n l10n, RefusalReason reason) => switch (reason) {
      RefusalReason.reservedElsewhere => l10n.reservationRefusalReservedElsewhere,
      RefusalReason.profileNotRetained => l10n.reservationRefusalProfileNotRetained,
      RefusalReason.datesIncompatible => l10n.reservationRefusalDatesIncompatible,
      RefusalReason.other => l10n.reservationRefusalOther,
    };

/// RM-M29-16 — the landlord assigned another unit of the residence than the
/// one asked for: said on both sides, under the unit's name. Nothing when
/// the unit is the one asked for.
class ReassignedNote extends StatelessWidget {
  const ReassignedNote({super.key, required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final asked = reservation.requestedAnnonceTitle;
    if (!reservation.wasReassigned || asked == null) return const SizedBox.shrink();
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.only(top: Dimens.spacingXs),
      child: Row(
        children: [
          Icon(LucideIcons.arrowRightLeft, size: Dimens.iconSm, color: colors.primary),
          const SizedBox(width: Dimens.spacingXs),
          Flexible(
            child: Text(
              I18n.of(context).reservationAssignedInsteadOf(asked),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.mboaText.caption.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Réservation confirmée" — the founder's ticket, without its barcode: a
/// reference, the hold's last day, and what comes next.
class ReservationTicket extends StatelessWidget {
  const ReservationTicket({super.key, required this.reservation, required this.nextStep});

  final Reservation reservation;

  /// What comes next — the tenant reads and signs, the prestataire drafts.
  final String nextStep;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final until = reservation.reservedUntil;
    final onBrandSoft = colors.onBrand.withValues(alpha: 0.75);

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: ColoredBox(
        color: colors.primary,
        child: Stack(
          children: [
            Positioned.fill(child: MboaBrandPattern(color: colors.onBrand, opacity: 0.06, scale: 0.7)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimens.spacingLg, Dimens.spacingLg, Dimens.spacingLg, Dimens.spacing),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(LucideIcons.ticketCheck, color: colors.onBrand, size: Dimens.iconMd),
                          const SizedBox(width: Dimens.spacingSm),
                          Expanded(
                            child: Text(
                              l10n.reservationConfirmedTitle,
                              style: context.mboaText.h3.copyWith(color: colors.onBrand),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.spacing),
                      Row(
                        children: [
                          Expanded(
                            child: _TicketField(
                              label: l10n.reservationReference,
                              value: reservation.reference,
                              labelColor: onBrandSoft,
                              valueColor: colors.onBrand,
                            ),
                          ),
                          if (until != null)
                            Expanded(
                              child: _TicketField(
                                label: l10n.reservationReservedUntil,
                                value: DateFormat.yMMMd(locale).format(until),
                                labelColor: onBrandSoft,
                                valueColor: colors.onBrand,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                _Perforation(notch: colors.background, line: colors.onBrand.withValues(alpha: 0.35)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(Dimens.spacingLg, Dimens.spacing, Dimens.spacingLg, Dimens.spacingLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.reservationNextStep, style: context.mboaText.caption.copyWith(color: onBrandSoft)),
                      const SizedBox(height: Dimens.spacingXs),
                      Text(nextStep, style: context.mboaText.body.copyWith(color: colors.onBrand)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TicketField extends StatelessWidget {
  const _TicketField({required this.label, required this.value, required this.labelColor, required this.valueColor});

  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.mboaText.caption.copyWith(color: labelColor)),
          const SizedBox(height: 2),
          Text(value, style: context.mboaText.label.copyWith(color: valueColor, letterSpacing: 0.5)),
        ],
      );
}

/// The tear line: a notch each side, in the page's colour, and dashes between.
class _Perforation extends StatelessWidget {
  const _Perforation({required this.notch, required this.line});

  final Color notch;
  final Color line;

  static const double _radius = 10;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: _radius * 2,
        child: Row(
          children: [
            Container(
              width: _radius,
              decoration: BoxDecoration(
                color: notch,
                borderRadius: const BorderRadius.horizontal(right: Radius.circular(_radius)),
              ),
            ),
            Expanded(child: CustomPaint(painter: _Dashes(line))),
            Container(
              width: _radius,
              decoration: BoxDecoration(
                color: notch,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(_radius)),
              ),
            ),
          ],
        ),
      );
}

class _Dashes extends CustomPainter {
  const _Dashes(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5;
    final y = size.height / 2;
    for (var x = 6.0; x < size.width - 6; x += 10) {
      canvas.drawLine(Offset(x, y), Offset(x + 5, y), paint);
    }
  }

  @override
  bool shouldRepaint(_Dashes old) => old.color != color;
}
