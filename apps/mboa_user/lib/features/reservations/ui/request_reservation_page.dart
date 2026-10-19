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
import '../bloc/reservation_request_bloc.dart';
import '../data/reservations_repository.dart';
import '../models/reservation_draft.dart';
import 'widgets/reservation_bits.dart';

/// "Réservation" — asking to reserve a listing (CDC M29), after the founder's
/// mockup: three steps down a dotted line — the property, the stay, the rent.
///
/// **No payment.** The rent and an indicative total are shown because a
/// tenant asks what it will cost; nothing here takes an amount, and the
/// screen says so (RM-M29-09, CA-M29-04). The periodicity is the listing's —
/// the client chooses a start and a number of periods, and the end follows.
@RoutePage()
class RequestReservationPage extends StatelessWidget implements AutoRouteWrapper {
  const RequestReservationPage({super.key, required this.listing});

  final ReservationListing listing;

  @override
  Widget wrappedRoute(BuildContext context) =>
      BlocProvider<ReservationRequestBloc>(create: (_) => getIt<ReservationRequestBloc>(), child: this);

  @override
  Widget build(BuildContext context) => RequestReservationForm(listing: listing);
}

/// The form under its bloc — public so it can be pumped with a mock one.
class RequestReservationForm extends StatefulWidget {
  const RequestReservationForm({super.key, required this.listing, this.today});

  final ReservationListing listing;

  /// Injected by tests; the clock otherwise.
  final DateTime? today;

  @override
  State<RequestReservationForm> createState() => _RequestReservationFormState();
}

/// Form state only — what is chosen before anything is sent.
class _RequestReservationFormState extends State<RequestReservationForm> {
  late ReservationDraft _draft = ReservationDraft(listing: widget.listing);
  final _message = TextEditingController();

  DateTime get _now => widget.today ?? DateTime.now();

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _pickStart() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _draft.start ?? ReservationDraft.firstDay(_now),
      firstDate: ReservationDraft.firstDay(_now),
      lastDate: ReservationDraft.lastStartDay(_now),
    );
    if (picked != null) setState(() => _draft = _draft.copyWith(start: picked));
  }

  void _submit() {
    final start = _draft.start;
    if (start == null) return;
    context.read<ReservationRequestBloc>().add(
          ReservationRequestSubmitted(
            annonceId: widget.listing.id,
            start: start,
            units: _draft.units,
            message: _message.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<ReservationRequestBloc, ReservationRequestState>(
      listener: (context, state) {
        switch (state) {
          case ReservationRequestSent(:final reservation):
            MboaToast.success(context: context, title: l10n.reservationSentTitle, description: l10n.reservationSentBody);
            unawaited(context.router.replace(ReservationDetailRoute(id: reservation.id)));
          case ReservationRequestRefusedState(reason: RequestRefusal.profileIncomplete):
            // CE-M29-02 — the form stays as typed while the profile is done.
            MboaToast.info(
              context: context,
              title: l10n.reservationProfileIncompleteTitle,
              description: l10n.reservationProfileIncompleteBody,
            );
            unawaited(context.router.push(const EditProfileRoute()));
          case ReservationRequestRefusedState(:final reason):
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: _refusalText(l10n, reason));
          case ReservationRequestFailed():
            MboaToast.error(context: context, title: l10n.commonErrorTitle, description: l10n.reservationSendFailed);
          default:
            break;
        }
      },
      builder: (context, state) {
        final sending = state is ReservationRequestSubmitting;

        return Scaffold(
          backgroundColor: colors.background,
          appBar: AppBar(leading: const MboaHeaderBackButton(), title: Text(l10n.reservationTitle)),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(Dimens.screenMargin, Dimens.spacing, Dimens.screenMargin, Dimens.spacingXl),
            children: [
              _Step(
                done: true,
                icon: LucideIcons.house,
                child: _ListingCard(listing: widget.listing),
              ),
              _Step(
                done: _draft.start != null,
                icon: LucideIcons.calendarRange,
                title: l10n.reservationStayTitle,
                child: _StayCard(draft: _draft, onPickStart: sending ? null : _pickStart, onUnits: (units) {
                  setState(() => _draft = _draft.copyWith(units: units));
                }),
              ),
              _Step(
                done: _draft.isComplete,
                icon: LucideIcons.banknote,
                title: l10n.reservationRentTitle,
                last: true,
                child: _RentBlock(draft: _draft),
              ),
              const SizedBox(height: Dimens.spacing),
              TextField(
                controller: _message,
                enabled: !sending,
                maxLength: 1000,
                minLines: 2,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l10n.reservationMessageLabel,
                  hintText: l10n.reservationMessageHint,
                ),
              ),
              // RM-M29-02 — a visit is recommended, never required.
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(LucideIcons.info, size: Dimens.iconSm, color: colors.textTertiary),
                  const SizedBox(width: Dimens.spacingSm),
                  Expanded(
                    child: Text(
                      l10n.reservationVisitAdvice,
                      style: context.mboaText.caption.copyWith(color: colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(Dimens.spacing),
            child: Button.primary(
              title: l10n.reservationSend,
              isLoading: sending,
              onPressed: _draft.isComplete && !sending ? _submit : null,
            ),
          ),
        );
      },
    );
  }

  String _refusalText(I18n l10n, RequestRefusal reason) => switch (reason) {
        RequestRefusal.notReservable => l10n.reservationNotReservable,
        RequestRefusal.alreadyActive => l10n.reservationAlreadyActive,
        RequestRefusal.limitReached => l10n.reservationLimitReached,
        RequestRefusal.startPast => l10n.reservationStartPast,
        RequestRefusal.startTooFar => l10n.reservationStartTooFar,
        RequestRefusal.profileIncomplete => l10n.reservationProfileIncompleteBody,
      };
}

/// One step of the mockup's dotted line: a disc, the line down to the next,
/// and what the step holds.
class _Step extends StatelessWidget {
  const _Step({required this.done, required this.icon, required this.child, this.title, this.last = false});

  final bool done;
  final IconData icon;
  final String? title;
  final Widget child;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done ? colors.primary : colors.surface,
                    border: Border.all(color: colors.primary, width: 1.5),
                  ),
                  child: Icon(icon, size: Dimens.iconSm, color: done ? colors.onBrand : colors.primary),
                ),
                if (!last) Expanded(child: CustomPaint(painter: _DottedLine(colors.primary.withValues(alpha: 0.5)))),
              ],
            ),
          ),
          const SizedBox(width: Dimens.spacingMd),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : Dimens.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title case final title?) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(title, style: context.mboaText.label.copyWith(color: colors.textSecondary)),
                    ),
                    const SizedBox(height: Dimens.spacingSm),
                  ],
                  child,
                ],
              ),
            ),
          ),
        ],
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
    for (var y = 4.0; y < size.height; y += 6) {
      canvas.drawLine(Offset(size.width / 2, y), Offset(size.width / 2, y + 2.5), paint);
    }
  }

  @override
  bool shouldRepaint(_DottedLine old) => old.color != color;
}

/// The property, as the mockup draws it: its photo, its title and place over
/// the charter's bottom shade (§ overlay on cards).
class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.listing});

  final ReservationListing listing;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final place = [listing.district, listing.city].nonNulls.join(', ');

    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusLg),
      child: SizedBox(
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (listing.photoUrl case final url?)
              Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => ColoredBox(color: colors.primary))
            else
              ColoredBox(color: colors.primary, child: MboaBrandPattern(color: colors.onBrand)),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withValues(alpha: 0.55), Colors.black.withValues(alpha: 0)],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    listing.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.mboaText.h3.copyWith(color: colors.onBrand),
                  ),
                  if (place.isNotEmpty)
                    Row(
                      children: [
                        Icon(LucideIcons.mapPin, size: Dimens.iconSm, color: colors.onBrand),
                        const SizedBox(width: Dimens.spacingXs),
                        Flexible(
                          child: Text(
                            place,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.mboaText.body.copyWith(color: colors.onBrand),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The stay: the listing's periodicity (fixed), a start, a duration, and the
/// end that follows.
class _StayCard extends StatelessWidget {
  const _StayCard({required this.draft, required this.onPickStart, required this.onUnits});

  final ReservationDraft draft;
  final VoidCallback? onPickStart;
  final ValueChanged<int> onUnits;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    String date(DateTime? d) => d == null ? l10n.reservationPickDate : DateFormat.yMMMd(locale).format(d);

    return Container(
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(color: colors.primaryPale, borderRadius: BorderRadius.circular(Dimens.radiusMd)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The listing's periodicity — said, not chosen (RM-M10-09).
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacingSm, vertical: 2),
            decoration: BoxDecoration(color: colors.surface, borderRadius: BorderRadius.circular(Dimens.radiusFull)),
            child: Text(
              draft.listing.rentalPeriod.label(l10n),
              style: context.mboaText.caption.copyWith(color: colors.primary, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: Dimens.spacingMd),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onPickStart,
                    borderRadius: BorderRadius.circular(Dimens.radius),
                    child: _DateCell(label: l10n.reservationStart, value: date(draft.start), placeholder: draft.start == null),
                  ),
                ),
                VerticalDivider(color: colors.primary.withValues(alpha: 0.2), width: Dimens.spacing),
                Expanded(
                  child: _DateCell(label: l10n.reservationEnd, value: date(draft.lastDay), placeholder: draft.lastDay == null),
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimens.spacingMd),
          Row(
            children: [
              Expanded(child: Text(l10n.reservationDuration, style: context.mboaText.label.copyWith(color: colors.ink))),
              IconButton(
                tooltip: l10n.reservationDurationLess,
                onPressed: draft.units > ReservationDraft.minUnits ? () => onUnits(draft.units - 1) : null,
                icon: const Icon(LucideIcons.minus),
              ),
              Text(
                durationLabel(l10n, draft.units, draft.listing.rentalPeriod),
                style: context.mboaText.label.copyWith(color: colors.primary, fontWeight: FontWeight.w700),
              ),
              IconButton(
                tooltip: l10n.reservationDurationMore,
                onPressed: draft.units < ReservationDraft.maxUnits ? () => onUnits(draft.units + 1) : null,
                icon: const Icon(LucideIcons.plus),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateCell extends StatelessWidget {
  const _DateCell({required this.label, required this.value, required this.placeholder});

  final String label;
  final String value;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.spacingXs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.mboaText.h3.copyWith(color: colors.primary)),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            value,
            style: context.mboaText.body.copyWith(color: placeholder ? colors.textTertiary : colors.ink),
          ),
        ],
      ),
    );
  }
}

/// The rent and the stay's indicative total — and the reminder that none of
/// it goes through Mboa.
class _RentBlock extends StatelessWidget {
  const _RentBlock({required this.draft});

  final ReservationDraft draft;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final price = draft.listing.price;
    final total = draft.indicativeTotal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (price != null)
          Text(
            draft.listing.rentalPeriod.priceLabel(l10n, price),
            style: context.mboaText.h2.copyWith(color: colors.primary),
          ),
        if (total != null && draft.units > 1) ...[
          const SizedBox(height: Dimens.spacingXs),
          Text(
            l10n.reservationIndicativeTotal(fcfa(context, total)),
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
        ],
        const SizedBox(height: Dimens.spacingMd),
        const NoMoneyNotice(),
      ],
    );
  }
}
