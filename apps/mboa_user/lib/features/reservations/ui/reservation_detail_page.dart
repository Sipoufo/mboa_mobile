import 'dart:async';

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
import '../bloc/reservation_bloc.dart';
import 'widgets/reservation_bits.dart';

/// One reservation request, from the tenant's side (CDC M29).
///
/// What can be done next — cancelling — is the server's `canCancel`, never
/// worked out from the status. Accepted, the request reads as a ticket: a
/// reference, the day the hold ends, and the next step, which is the Mboa
/// Contract — not a payment (RM-M29-09).
@RoutePage()
class ReservationDetailPage extends StatelessWidget implements AutoRouteWrapper {
  const ReservationDetailPage({super.key, @PathParam('id') required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ReservationBloc>(
        create: (_) => getIt<ReservationBloc>()..add(ReservationRequested(id)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const ReservationDetailView();
}

/// The screen under its bloc — public so it can be pumped with a mock one.
class ReservationDetailView extends StatelessWidget {
  const ReservationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Scaffold(
      backgroundColor: context.mboaColors.background,
      appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.reservationDetailTitle)),
      body: BlocConsumer<ReservationBloc, ReservationState>(
        listenWhen: (previous, current) =>
            previous is ReservationReady && previous.isBusy && current is ReservationReady,
        listener: (context, state) {
          if (state is! ReservationReady) return;
          if (state.failed) {
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.reservationCancelFailed);
          } else if (state.reservation.status == ReservationStatus.cancelled) {
            MboaToast.success(context: context, title: l10n.reservationCancelDone);
          }
        },
        builder: (context, state) => switch (state) {
          ReservationLoading() => const Center(child: Loader()),
          ReservationFailure(:final id) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: context.mboaColors.textSecondary)),
                  TextButton(
                    onPressed: () => context.read<ReservationBloc>().add(ReservationRequested(id)),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          ReservationReady(:final reservation, :final isBusy) => _Body(reservation: reservation, isBusy: isBusy),
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.reservation, required this.isBusy});

  final Reservation reservation;
  final bool isBusy;

  Future<void> _cancel(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<ReservationBloc>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.reservationCancelConfirmTitle),
        content: Text(l10n.reservationCancelConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(false), child: Text(l10n.reservationKeep)),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: context.mboaColors.error),
            child: Text(l10n.reservationCancelConfirm),
          ),
        ],
      ),
    );

    if (confirmed ?? false) bloc.add(const ReservationCancelRequested());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final r = reservation;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                r.placeTitle ?? l10n.reservationUntitled,
                style: context.mboaText.h2.copyWith(color: colors.ink),
              ),
            ),
            const SizedBox(width: Dimens.spacingSm),
            Padding(padding: const EdgeInsets.only(top: 6), child: ReservationStatusChip(status: r.status)),
          ],
        ),
        const SizedBox(height: Dimens.spacing),
        if (r.status == ReservationStatus.accepted) ...[
          ReservationTicket(reservation: r, nextStep: l10n.reservationNextStepBody),
          const SizedBox(height: Dimens.spacingMd),
          const NoMoneyNotice(),
        ] else
          _StatusCard(reservation: r),
        const SizedBox(height: Dimens.spacing),
        _Section(
          title: l10n.reservationYourStay,
          child: _Stay(reservation: r),
        ),
        if (r.message case final message?) ...[
          const SizedBox(height: Dimens.spacing),
          _Section(
            title: l10n.reservationYourMessage,
            child: Text('« $message »', style: context.mboaText.body.copyWith(color: colors.ink)),
          ),
        ],
        const SizedBox(height: Dimens.spacingLg),
        // §28 — the contract drawn up from this request, once it is sent:
        // opened directly (to read, contest or sign it).
        if (r.contractId case final contractId?) ...[
          Button.primary(
            title: l10n.proReservationSeeContract,
            onPressed: () => context.router.push(MyContractDetailRoute(id: contractId)),
          ),
          const SizedBox(height: Dimens.spacingSm),
        ] else if (r.status == ReservationStatus.contracted) ...[
          Button.primary(
            title: l10n.reservationSeeContracts,
            onPressed: () => context.router.push(const MyContractsRoute()),
          ),
          const SizedBox(height: Dimens.spacingSm),
        ],
        // RM-M29-14 — the request opened the listing's thread.
        if (r.conversationId case final conversationId?) ...[
          Button.outline(
            title: l10n.reservationWriteProvider,
            icon: const Icon(LucideIcons.messageCircle, size: Dimens.icon),
            iconAlignment: IconAlignment.start,
            onPressed: () => context.router.root.push(
              ThreadRoute(
                conversation: Conversation(
                  id: conversationId,
                  annonceId: r.annonceId,
                  annonceTitle: r.annonceTitle,
                  peerAccountId: r.prestataire?.accountId,
                  peerName: r.prestataire?.name,
                  peerPhotoKey: r.prestataire?.photoKey,
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimens.spacingSm),
        ],
        if (r.annonceId case final annonceId?)
          Button.outline(
            title: l10n.reservationSeeListing,
            onPressed: () => context.router.root.push(ListingDetailRoute(id: annonceId)),
          ),
        if (r.canCancel) ...[
          const SizedBox(height: Dimens.spacingSm),
          Center(
            child: TextButton(
              onPressed: isBusy ? null : () => unawaited(_cancel(context)),
              style: TextButton.styleFrom(foregroundColor: colors.error),
              child: isBusy ? const Loader(size: Dimens.loaderSizeXs) : Text(l10n.reservationCancel),
            ),
          ),
        ],
      ],
    );
  }
}

/// Every status but "accepted": what happened, in a sentence — and, for a
/// refusal or a prestataire's cancellation, their reason and their word.
class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final r = reservation;

    final (icon, tone, title, body) = switch (r.status) {
      ReservationStatus.pending => (
          LucideIcons.hourglass,
          colors.warning,
          l10n.reservationPendingTitle,
          r.expiresAt == null
              ? l10n.reservationSentBody
              : l10n.reservationPendingUntil(DateFormat.MMMMd(locale).add_Hm().format(r.expiresAt!)),
        ),
      ReservationStatus.contracted => (
          LucideIcons.fileCheck,
          colors.primary,
          l10n.reservationStatusContracted,
          l10n.reservationContractedBody,
        ),
      ReservationStatus.refused => (
          LucideIcons.circleX,
          colors.error,
          l10n.reservationStatusRefused,
          l10n.reservationRefusedBody,
        ),
      ReservationStatus.notRetained => (
          LucideIcons.circleMinus,
          colors.textSecondary,
          l10n.reservationStatusNotRetained,
          l10n.reservationNotRetainedBody,
        ),
      ReservationStatus.expired => (
          LucideIcons.timerOff,
          colors.textSecondary,
          l10n.reservationStatusExpired,
          l10n.reservationExpiredBody,
        ),
      ReservationStatus.cancelled => (
          LucideIcons.ban,
          colors.textSecondary,
          l10n.reservationStatusCancelled,
          switch (r.cancelledBy) {
            CancelledBy.prestataire => l10n.reservationCancelledByProvider,
            CancelledBy.system => l10n.reservationCancelledBySystem,
            CancelledBy.client || null => l10n.reservationCancelledByYou,
          },
        ),
      ReservationStatus.lapsed => (
          LucideIcons.calendarX,
          colors.textSecondary,
          l10n.reservationStatusLapsed,
          l10n.reservationLapsedBody,
        ),
      // Drawn as the ticket above; listed so the switch stays exhaustive.
      ReservationStatus.accepted || ReservationStatus.unknown => (
          LucideIcons.info,
          colors.textSecondary,
          l10n.reservationStatusUnknown,
          '',
        ),
    };

    final reason = r.ownerReason;
    final note = r.ownerNote?.trim();

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: tone, size: Dimens.icon),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.mboaText.label.copyWith(color: colors.ink)),
                if (body.isNotEmpty) ...[
                  const SizedBox(height: Dimens.spacingXs),
                  Text(body, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                ],
                if (reason != null) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Text(
                    l10n.reservationRefusedReason(refusalReasonLabel(l10n, reason)),
                    style: context.mboaText.caption.copyWith(color: colors.ink),
                  ),
                ],
                if (note != null && note.isNotEmpty) ...[
                  const SizedBox(height: Dimens.spacingSm),
                  Text(l10n.reservationProviderNote, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
                  Text('« $note »', style: context.mboaText.body.copyWith(color: colors.ink)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusMd),
        boxShadow: MboaShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
          const SizedBox(height: Dimens.spacingSm),
          child,
        ],
      ),
    );
  }
}

class _Stay extends StatelessWidget {
  const _Stay({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(DateTime? d) => d == null ? '—' : DateFormat.yMMMd(locale).format(d);
    final units = reservation.durationUnits;

    Widget cell(String label, String value) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.mboaText.caption.copyWith(color: colors.primary)),
              const SizedBox(height: 2),
              Text(value, style: context.mboaText.label.copyWith(color: colors.ink)),
            ],
          ),
        );

    return Row(
      children: [
        cell(l10n.reservationStart, date(reservation.desiredStartDate)),
        cell(l10n.reservationEnd, date(reservation.lastDay)),
        cell(l10n.reservationDuration, units == null ? '—' : durationLabel(l10n, units, reservation.rentalPeriod)),
      ],
    );
  }
}
