import 'package:flutter/material.dart';
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
