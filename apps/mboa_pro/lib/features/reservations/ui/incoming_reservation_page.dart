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
import '../../annonces/models/annonce.dart';
import '../bloc/incoming_reservation_bloc.dart';
import '../bloc/pending_reservations_bloc.dart';
import '../data/incoming_reservations_repository.dart';
import 'widgets/decision_sheet.dart';

/// One request on a prestataire's listing (CDC M29), after the founder's
/// mockup: the property, the stay, the indicative total and who asks — then
/// one main action and "⋯" for the rest.
///
/// Waiting, the main action is accepting; refusing sits behind "⋯". Accepted,
/// it is drawing up the Mboa Contract (RM-M08-10); extending and cancelling
/// sit behind "⋯". Every action is the server's `can*` — none is guessed.
@RoutePage()
class IncomingReservationPage extends StatelessWidget implements AutoRouteWrapper {
  const IncomingReservationPage({super.key, @PathParam('id') required this.id});

  final String id;

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<IncomingReservationBloc>(
        create: (_) => getIt<IncomingReservationBloc>()..add(IncomingReservationRequested(id)),
        child: this,
      );

  @override
  Widget build(BuildContext context) => const IncomingReservationView();
}

/// The screen under its bloc — public so it can be pumped with a mock one.
class IncomingReservationView extends StatelessWidget {
  const IncomingReservationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<IncomingReservationBloc, IncomingReservationState>(
      listenWhen: (_, current) =>
          current is IncomingReservationReady &&
          (current.done != null || current.refusal != null || current.failed),
      listener: (context, state) {
        final ready = state as IncomingReservationReady;
        if (ready.done case final done?) {
          MboaToast.success(
            context: context,
            title: switch (done) {
              ReservationDecision.accepted => l10n.proReservationAcceptedToast,
              ReservationDecision.refused => l10n.proReservationRefusedToast,
              ReservationDecision.extended => l10n.proReservationExtendedToast,
              ReservationDecision.cancelled => l10n.proReservationCancelledToast,
            },
          );
          // The home's counter is another bloc's: told by event, not reached
          // into. Absent in a test or an agent session — nothing to tell.
          if (getIt.isRegistered<PendingReservationsBloc>()) {
            getIt<PendingReservationsBloc>().add(const PendingReservationsRequested());
          }
        } else {
          MboaToast.error(
            context: context,
            title: l10n.commonErrorTitle,
            description: switch (ready.refusal) {
              DecisionRefusal.closed => l10n.proReservationClosed,
              DecisionRefusal.notReservable => l10n.proReservationNotReservable,
              DecisionRefusal.alreadyExtended => l10n.proReservationAlreadyExtended,
              DecisionRefusal.notAccepted => l10n.proReservationNotAccepted,
              null => l10n.proReservationFailed,
            },
          );
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.proReservationDetailTitle)),
        body: switch (state) {
          IncomingReservationLoading() => const Center(child: Loader()),
          IncomingReservationFailure(:final id) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.commonError, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
                  TextButton(
                    onPressed: () => context.read<IncomingReservationBloc>().add(IncomingReservationRequested(id)),
                    child: Text(l10n.commonRetry),
                  ),
                ],
              ),
            ),
          final IncomingReservationReady ready => _Body(state: ready),
        },
        bottomNavigationBar: state is IncomingReservationReady ? _Actions(state: state) : null,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final IncomingReservationReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final r = state.reservation;

    return ListView(
      padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
      children: [
        _RequestCard(state: state),
        if (state.otherPending > 0) ...[
          const SizedBox(height: Dimens.spacing),
          // "Autres demandes pour ce bien" — the mockup's green strip.
          Material(
            color: colors.primaryPale,
            borderRadius: BorderRadius.circular(Dimens.radiusMd),
            child: InkWell(
              borderRadius: BorderRadius.circular(Dimens.radiusMd),
              onTap: () => context.router.push(
                IncomingReservationsRoute(annonceId: r.annonceId, annonceTitle: r.annonceTitle),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.spacing),
                child: Row(
                  children: [
                    Text(
                      '+${state.otherPending}',
                      style: context.mboaText.h2.copyWith(color: colors.primary),
                    ),
                    const SizedBox(width: Dimens.spacingMd),
                    Expanded(
                      child: Text(
                        l10n.proReservationOthers(state.otherPending),
                        style: context.mboaText.label.copyWith(color: colors.primary),
                      ),
                    ),
                    Icon(LucideIcons.chevronRight, size: Dimens.icon, color: colors.primary),
                  ],
                ),
              ),
            ),
          ),
        ],
        const SizedBox(height: Dimens.spacing),
        if (r.status == ReservationStatus.accepted) ...[
          ReservationTicket(reservation: r, nextStep: l10n.proReservationNextStep),
          if (r.extended) ...[
            const SizedBox(height: Dimens.spacingSm),
            Align(
              alignment: Alignment.centerLeft,
              child: _Tag(label: l10n.proReservationExtendedTag),
            ),
          ],
        ] else if (r.status == ReservationStatus.pending)
          _Note(
            icon: LucideIcons.hourglass,
            tone: colors.warning,
            text: r.expiresAt == null
                ? l10n.reservationSentBody
                : l10n.proReservationAnswerBy(DateFormat.MMMMd(locale).add_Hm().format(r.expiresAt!)),
          )
        else
          _Outcome(reservation: r),
        if (r.message case final message?) ...[
          const SizedBox(height: Dimens.spacing),
          _Plain(
            title: l10n.proReservationClientMessage,
            child: Text('« $message »', style: context.mboaText.body.copyWith(color: colors.ink)),
          ),
        ],
      ],
    );
  }
}

/// The mockup's white card: the property, the stay, the total, who asks.
class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.state});

  final IncomingReservationReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final r = state.reservation;
    final Annonce? listing = state.listing;
    final price = listing?.displayPrice;
    final units = r.durationUnits;
    String date(DateTime? d) => d == null ? '—' : DateFormat.yMMMd(locale).format(d);

    Widget label(IconData icon, String text) => Row(
          children: [
            Icon(icon, size: Dimens.iconSm, color: colors.textTertiary),
            const SizedBox(width: Dimens.spacingXs),
            Text(text, style: context.mboaText.caption.copyWith(color: colors.textSecondary)),
          ],
        );

    Widget cell(String title, String value) => Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.mboaText.label.copyWith(color: colors.ink)),
              const SizedBox(height: 2),
              Text(value, style: context.mboaText.body.copyWith(color: colors.textSecondary)),
            ],
          ),
        );

    return Container(
      padding: const EdgeInsets.all(Dimens.spacingLg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
        boxShadow: MboaShadows.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: label(LucideIcons.info, l10n.annonceDetailTitle)),
              ReservationStatusChip(status: r.status),
            ],
          ),
          const SizedBox(height: Dimens.spacingMd),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.radiusMd),
                child: SizedBox.square(
                  dimension: 72,
                  child: switch (listing?.coverUrl) {
                    final url? => Image.network(
                        url,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => ColoredBox(color: colors.primaryPale),
                      ),
                    null => ColoredBox(
                        color: colors.primary,
                        child: MboaBrandPattern(color: colors.onBrand, opacity: 0.12, scale: 0.5),
                      ),
                  },
                ),
              ),
              const SizedBox(width: Dimens.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.annonceTitle ?? l10n.reservationUntitled,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.mboaText.h3.copyWith(color: colors.ink),
                    ),
                    if (price != null && listing != null) ...[
                      const SizedBox(height: Dimens.spacingXs),
                      Text(
                        listing.rentalPeriod.priceLabel(l10n, price),
                        style: context.mboaText.label.copyWith(color: colors.primary),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const _Dotted(),
          label(LucideIcons.calendarRange, l10n.proReservationStay),
          const SizedBox(height: Dimens.spacingSm),
          Row(
            children: [
              cell(l10n.reservationStart, date(r.desiredStartDate)),
              cell(l10n.reservationEnd, date(r.lastDay)),
              cell(l10n.reservationDuration, units == null ? '—' : durationLabel(l10n, units, r.rentalPeriod)),
            ],
          ),
          if (price != null && units != null) ...[
            const SizedBox(height: Dimens.spacingMd),
            // Indicative: nothing is paid through a reservation (RM-M29-09).
            Text(
              l10n.reservationIndicativeTotal(moneyLabel(l10n, price * units)),
              style: context.mboaText.label.copyWith(color: colors.primary),
            ),
          ],
          const _Dotted(),
          _Requester(reservation: r),
        ],
      ),
    );
  }
}

/// Who asks: their face, their name, their Mboa Score (RM-M09-04), and the
/// thread the request opened (RM-M29-14).
class _Requester extends StatelessWidget {
  const _Requester({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final client = reservation.client;
    final name = client?.name ?? l10n.proReservationClient;
    final accountId = reservation.userAccountId ?? client?.accountId;
    final conversationId = reservation.conversationId;

    return Row(
      children: [
        MboaAvatar(imageUrl: client?.photoUrl, initials: _initials(name), size: 44),
        const SizedBox(width: Dimens.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.proReservationRequester, style: context.mboaText.micro.copyWith(color: colors.textSecondary)),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.mboaText.label.copyWith(color: colors.ink),
              ),
              if (accountId != null)
                GestureDetector(
                  onTap: () => showTenantScoreSheet(context, userAccountId: accountId, name: client?.name),
                  child: Text(
                    l10n.proReservationScore,
                    style: context.mboaText.caption.copyWith(
                      color: colors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: colors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (conversationId != null)
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colors.primaryPale,
              foregroundColor: colors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius)),
            ),
            onPressed: () => context.router.push(
              ThreadRoute(
                conversation: Conversation(
                  id: conversationId,
                  annonceId: reservation.annonceId,
                  annonceTitle: reservation.annonceTitle,
                  peerAccountId: accountId,
                  peerName: client?.name,
                  peerPhotoKey: client?.photoKey,
                ),
              ),
            ),
            child: Text(l10n.listingContact),
          ),
      ],
    );
  }

  static String _initials(String name) =>
      name.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).take(2).map((w) => w[0].toUpperCase()).join();
}

/// Every closed status: what happened, and the reason given if any.
class _Outcome extends StatelessWidget {
  const _Outcome({required this.reservation});

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final r = reservation;

    final text = switch (r.status) {
      ReservationStatus.refused => l10n.proReservationRefusedBody,
      ReservationStatus.notRetained => l10n.proReservationNotRetainedBody,
      ReservationStatus.expired => l10n.proReservationExpiredBody,
      ReservationStatus.cancelled => switch (r.cancelledBy) {
          CancelledBy.prestataire => l10n.proReservationCancelledByYou,
          CancelledBy.system => l10n.reservationCancelledBySystem,
          CancelledBy.client || null => l10n.proReservationCancelledByClient,
        },
      ReservationStatus.lapsed => l10n.reservationLapsedBody,
      ReservationStatus.contracted => l10n.proReservationContractedBody,
      ReservationStatus.pending || ReservationStatus.accepted || ReservationStatus.unknown =>
        l10n.reservationStatusUnknown,
    };
    final reason = r.ownerReason;

    return _Note(
      icon: r.status == ReservationStatus.contracted ? LucideIcons.fileCheck : LucideIcons.info,
      tone: r.status == ReservationStatus.contracted ? colors.primary : colors.textSecondary,
      text: reason == null ? text : '$text ${l10n.reservationRefusedReason(refusalReasonLabel(l10n, reason))}',
    );
  }
}

class _Note extends StatelessWidget {
  const _Note({required this.icon, required this.tone, required this.text});

  final IconData icon;
  final Color tone;
  final String text;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(Dimens.spacing),
        decoration: BoxDecoration(
          color: tone.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: Dimens.icon, color: tone),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(child: Text(text, style: context.mboaText.body.copyWith(color: context.mboaColors.ink))),
          ],
        ),
      );
}

class _Plain extends StatelessWidget {
  const _Plain({required this.title, required this.child});

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

class _Tag extends StatelessWidget {
  const _Tag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
      decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radiusFull)),
      child: Text(label, style: context.mboaText.caption.copyWith(color: colors.primary, fontWeight: FontWeight.w600)),
    );
  }
}

/// The mockup's dotted separators.
class _Dotted extends StatelessWidget {
  const _Dotted();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
        child: SizedBox(
          height: 1,
          child: CustomPaint(painter: _DotsPainter(context.mboaColors.border)),
        ),
      );
}

class _DotsPainter extends CustomPainter {
  const _DotsPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 5) {
      canvas.drawLine(Offset(x, 0), Offset(x + 2, 0), paint);
    }
  }

  @override
  bool shouldRepaint(_DotsPainter old) => old.color != color;
}

enum _More { refuse, extend, cancel }

/// One main action and "⋯" — never a column of buttons (the founder's call).
class _Actions extends StatelessWidget {
  const _Actions({required this.state});

  final IncomingReservationReady state;

  Future<void> _accept(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<IncomingReservationBloc>();
    final confirmed = await _confirm(
      context,
      title: l10n.proReservationAcceptConfirmTitle,
      body: l10n.proReservationAcceptConfirmBody,
      action: l10n.proReservationAcceptConfirm,
    );
    if (confirmed) bloc.add(const IncomingReservationAccepted());
  }

  Future<void> _more(BuildContext context) async {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final bloc = context.read<IncomingReservationBloc>();
    final r = state.reservation;

    final choice = await showModalBottomSheet<_More>(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Dimens.radiusXl)),
      ),
      builder: (sheetContext) {
        Widget item(IconData icon, String label, _More value, {bool danger = false}) => ListTile(
              leading: Icon(icon, color: danger ? colors.error : colors.primary),
              title: Text(
                label,
                style: context.mboaText.label.copyWith(color: danger ? colors.error : colors.ink),
              ),
              onTap: () => Navigator.of(sheetContext).pop(value),
            );

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (r.canRefuse) item(LucideIcons.circleX, l10n.proReservationRefuse, _More.refuse, danger: true),
                if (r.canExtend) item(LucideIcons.calendarPlus, l10n.proReservationExtend, _More.extend),
                if (r.canCancel) item(LucideIcons.ban, l10n.proReservationCancel, _More.cancel, danger: true),
              ],
            ),
          ),
        );
      },
    );
    if (choice == null || !context.mounted) return;

    switch (choice) {
      case _More.refuse:
        final decision = await showDecisionSheet(
          context,
          title: l10n.proReservationRefuseTitle,
          hint: l10n.proReservationReasonHint,
          confirm: l10n.proReservationRefuse,
        );
        if (decision != null) bloc.add(IncomingReservationRefused(reason: decision.reason, note: decision.note));
      case _More.extend:
        if (!context.mounted) return;
        final confirmed = await _confirm(
          context,
          title: l10n.proReservationExtendConfirmTitle,
          body: l10n.proReservationExtendConfirmBody,
          action: l10n.proReservationExtendConfirm,
        );
        if (confirmed) bloc.add(const IncomingReservationExtended());
      case _More.cancel:
        final decision = await showDecisionSheet(
          context,
          title: l10n.proReservationCancelTitle,
          hint: l10n.proReservationCancelHint,
          confirm: l10n.proReservationCancel,
        );
        if (decision != null) bloc.add(IncomingReservationCancelled(reason: decision.reason, note: decision.note));
    }
  }

  static Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String body,
    required String action,
  }) async =>
      await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(I18n.of(context).commonCancel),
            ),
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(true), child: Text(action)),
          ],
        ),
      ) ??
      false;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final r = state.reservation;
    final annonceId = r.annonceId;

    final Widget? main = switch (r) {
      _ when r.canAccept => Button.primary(
          title: l10n.proReservationAccept,
          isLoading: state.isBusy,
          onPressed: () => unawaited(_accept(context)),
        ),
      // Already drawn up from this request: opened, not drawn again.
      _ when state.contractId != null => Button.primary(
          title: l10n.proReservationSeeContract,
          onPressed: () async {
            final bloc = context.read<IncomingReservationBloc>();
            await context.router.push(ContractDetailRoute(id: state.contractId!));
            bloc.add(IncomingReservationRequested(r.id));
          },
        ),
      // RM-M08-10 — the contract, drawn up from this request.
      _ when r.canDraftContract && annonceId != null => Button.primary(
          title: l10n.proReservationDraftContract,
          isLoading: state.isBusy,
          onPressed: () async {
            final bloc = context.read<IncomingReservationBloc>();
            await context.router.push(ContractFormRoute(annonceId: annonceId, reservation: r));
            // A contract drawn up changes what the request still offers.
            bloc.add(IncomingReservationRequested(r.id));
          },
        ),
      _ => null,
    };
    final hasMore = r.canRefuse || r.canExtend || r.canCancel;
    if (main == null && !hasMore) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(Dimens.spacing),
        child: Row(
          children: [
            Expanded(child: main ?? const SizedBox.shrink()),
            if (hasMore) ...[
              const SizedBox(width: Dimens.spacingSm),
              SizedBox.square(
                dimension: Dimens.buttonHeight,
                child: IconButton(
                  tooltip: l10n.listingMoreActions,
                  onPressed: state.isBusy ? null : () => unawaited(_more(context)),
                  style: IconButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.radius),
                      side: BorderSide(color: colors.primary),
                    ),
                  ),
                  icon: Icon(LucideIcons.ellipsis, color: colors.primary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
