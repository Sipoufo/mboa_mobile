import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../../messaging/ui/contact_sheet.dart';
import '../bloc/visit_booking_bloc.dart';
import '../models/bookable_visitor.dart';

/// Planning a visit from a fiche (CDC M07).
///
/// A sheet rather than a route: the tenant is looking at the property and has
/// to come back to it, and CA-M07-01 counts the taps.
///
/// Returns the booked [Visit], or null if nothing was booked.
Future<Visit?> showBookVisitSheet(
  BuildContext context, {
  required String annonceId,
  String? annonceTitle,
}) =>
    showModalBottomSheet<Visit>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<VisitBookingBloc>(
        create: (_) =>
            getIt<VisitBookingBloc>()..add(BookingStarted(annonceId)),
        child: BookVisitSheetBody(
          annonceId: annonceId,
          annonceTitle: annonceTitle,
        ),
      ),
    );

/// The sheet's contents, public so they can be pumped on their own —
/// `showModalBottomSheet` cannot be driven from a widget test without a route
/// to open it from, and what is worth pinning is what the tenant reads.
class BookVisitSheetBody extends StatelessWidget {
  const BookVisitSheetBody({
    super.key,
    required this.annonceId,
    this.annonceTitle,
  });

  final String annonceId;
  final String? annonceTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return BlocConsumer<VisitBookingBloc, VisitBookingState>(
      listener: (context, state) {
        switch (state) {
          case BookingDone(:final visit, :final mode):
            Navigator.of(context).pop(visit);
            MboaToast.success(
              context: context,
              title: mode == BookingMode.onRequest
                  ? l10n.visitRequestedTitle
                  : l10n.visitBookedTitle,
              description:
                  mode == BookingMode.onRequest ? l10n.visitRequestedBody : null,
            );
          case BookingReady(alreadyBooked: true):
            // RM-M07-03 — not a failure, a fact about a visit they have.
            MboaToast.info(context: context, title: l10n.visitAlreadyBooked);
          case BookingReady(timeRejected: true):
            // §19 — say which rule, not "an error occurred".
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.visitTimeRejected,
            );
          case BookingReady(failed: true):
            MboaToast.error(context: context, title: l10n.commonError);
          case BookingReady():
          case BookingLoadInProgress():
          case BookingUnavailable():
          case BookingFailure():
            break;
        }
      },
      builder: (context, state) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimens.radiusLg),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _GrabHandle(),
              Flexible(
                child: switch (state) {
                  // `BookingDone` lives for the one frame between the booking
                  // and the listener popping the sheet.
                  BookingLoadInProgress() || BookingDone() => const SizedBox(
                      height: 220,
                      child: Center(child: Loader()),
                    ),
                  BookingFailure() => _Notice(
                      icon: LucideIcons.triangleAlert,
                      title: l10n.commonErrorTitle,
                      body: l10n.commonError,
                    ),
                  final BookingUnavailable unavailable => _Notice(
                      icon: LucideIcons.calendarX,
                      title: l10n.visitBookTitle,
                      body: switch (unavailable.reason) {
                        NoSlotReason.noAvailability =>
                          l10n.visitNoSlotAvailability,
                        NoSlotReason.allDaysBlocked => l10n.visitNoSlotBlocked,
                        NoSlotReason.fullyBooked ||
                        NoSlotReason.unknown =>
                          l10n.visitNoSlotBooked,
                      },
                      // §21 — a full week is not a dead end any more: the next
                      // one may have room, and that is the likelier way out.
                      primaryAction: unavailable.canSeeNextWeek
                          ? l10n.visitSeeNextWeek
                          : null,
                      onPrimary: () => context.read<VisitBookingBloc>().add(
                            BookingWeekChanged(unavailable.weekOffset + 1),
                          ),
                      backAction: unavailable.canGoPrevWeek
                          ? l10n.visitWeekPrev
                          : null,
                      onBack: () => context.read<VisitBookingBloc>().add(
                            BookingWeekChanged(unavailable.weekOffset - 1),
                          ),
                      // The provider can still open a slot, and messaging is
                      // how one asks (M12).
                      action: l10n.visitBookNoSlotAction,
                      onAction: () async {
                        Navigator.of(context).pop();
                        await showContactSheet(
                          context,
                          annonceId: annonceId,
                          annonceTitle: annonceTitle,
                        );
                      },
                    ),
                  final BookingReady ready => _Form(state: ready),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GrabHandle extends StatelessWidget {
  const _GrabHandle();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingMd),
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: context.mboaColors.border,
            borderRadius: BorderRadius.circular(Dimens.radiusFull),
          ),
        ),
      );
}

/// Why there is nothing to book — and, when there is one, what to do about it.
class _Notice extends StatelessWidget {
  const _Notice({
    required this.icon,
    required this.title,
    required this.body,
    this.action,
    this.onAction,
    this.primaryAction,
    this.onPrimary,
    this.backAction,
    this.onBack,
  });

  final IconData icon;
  final String title;
  final String body;

  /// Asking the provider — always there when set, as the fallback.
  final String? action;
  final VoidCallback? onAction;

  /// The likelier way forward when there is one (next week); [action] then
  /// becomes secondary.
  final String? primaryAction;
  final VoidCallback? onPrimary;

  final String? backAction;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenMargin,
        Dimens.spacing,
        Dimens.screenMargin,
        Dimens.spacingXl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colors.primaryPale,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: Dimens.iconMd, color: colors.primary),
          ),
          const SizedBox(height: Dimens.spacing),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.mboaText.h3.copyWith(color: colors.ink),
          ),
          const SizedBox(height: Dimens.spacingXs),
          Text(
            body,
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
          if (primaryAction != null) ...[
            const SizedBox(height: Dimens.spacingLg),
            SizedBox(
              width: double.infinity,
              child: Button.primary(title: primaryAction!, onPressed: onPrimary),
            ),
          ],
          if (action != null) ...[
            SizedBox(
              height: primaryAction != null ? Dimens.spacingSm : Dimens.spacingLg,
            ),
            SizedBox(
              width: double.infinity,
              child: primaryAction != null
                  ? Button.outline(title: action!, onPressed: onAction)
                  : Button.primary(title: action!, onPressed: onAction),
            ),
          ],
          if (backAction != null) ...[
            const SizedBox(height: Dimens.spacingSm),
            TextButton(onPressed: onBack, child: Text(backAction!)),
          ],
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({required this.state});

  final BookingReady state;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  /// The day whose times are on screen.
  ///
  /// Local, not in the bloc: the booking is a visitor and a slot, and which day
  /// the tenant happens to be looking at is not part of it.
  DateTime? _day;

  List<VisitSlot> get _slots => widget.state.selectedVisitor?.slots ?? const [];

  List<DateTime> get _days {
    final days = <DateTime>[];
    for (final slot in _slots) {
      final day = DateUtils.dateOnly(slot.startsAt);
      if (!days.contains(day)) days.add(day);
    }
    return days;
  }

  DateTime? get _selectedDay {
    final days = _days;
    if (days.isEmpty) return null;
    // Follow the slot when one is picked, so reopening the sheet on a chosen
    // time lands on its day rather than on the first.
    final slot = widget.state.selectedSlot;
    if (slot != null) return DateUtils.dateOnly(slot.startsAt);
    if (_day != null && days.contains(_day)) return _day;
    return days.first;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final state = widget.state;
    final day = _selectedDay;
    final hours =
        _slots.where((slot) => DateUtils.isSameDay(slot.startsAt, day)).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.visitBookTitle,
                style: context.mboaText.h2.copyWith(color: colors.ink),
              ),
              Text(
                l10n.visitBookSubtitle,
                style:
                    context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: Dimens.spacingLg),
            children: [
              // §21 — "who has time this week": paging sits above the visitor
              // choice because a full agent disappears from it, and turning
              // the page is how they come back.
              if (state.pageable) ...[
                _WeekNav(state: state),
                const SizedBox(height: Dimens.spacing),
              ],
              // One visitor is already chosen, so showing the picker would be
              // a list of one (CA-M07-01).
              if (state.hasVisitorChoice) ...[
                _SectionTitle(l10n.visitBookVisitor),
                SizedBox(
                  height: 92,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.screenMargin,
                    ),
                    itemCount: state.visitors.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: Dimens.spacingMd),
                    itemBuilder: (context, index) {
                      final candidate = state.visitors[index];
                      return _VisitorCard(
                        visitor: candidate,
                        selected:
                            candidate.accountId == state.selectedVisitorId,
                        onTap: () {
                          setState(() => _day = null);
                          context
                              .read<VisitBookingBloc>()
                              .add(BookingVisitorSelected(candidate.accountId));
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: Dimens.spacingLg),
              ],
              if (state.selectedVisitor?.mode == BookingMode.onRequest)
                // §19 — an owner showing their own bien publishes no slots;
                // the tenant proposes a time instead of reading "nothing free".
                _Proposal(selected: state.selectedSlot)
              else if (state.selectedVisitor != null) ...[
                _SectionTitle(l10n.visitBookDay),
                SizedBox(
                  // Weekday, day number and month, with room for the tallest
                  // of them in either language.
                  height: 92,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.screenMargin,
                    ),
                    itemCount: _days.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: Dimens.spacingSm),
                    itemBuilder: (context, index) {
                      final candidate = _days[index];
                      return _DayChip(
                        day: candidate,
                        selected: DateUtils.isSameDay(candidate, day),
                        onTap: () => setState(() => _day = candidate),
                      );
                    },
                  ),
                ),
                const SizedBox(height: Dimens.spacingLg),
                _SectionTitle(l10n.visitBookHour),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.screenMargin,
                  ),
                  child: hours.isEmpty
                      ? Text(
                          l10n.visitBookNoHour,
                          style: context.mboaText.body
                              .copyWith(color: colors.textSecondary),
                        )
                      : Wrap(
                          spacing: Dimens.spacingSm,
                          runSpacing: Dimens.spacingSm,
                          children: [
                            for (final slot in hours)
                              _HourChip(
                                slot: slot,
                                selected: slot == state.selectedSlot,
                                onTap: () => context
                                    .read<VisitBookingBloc>()
                                    .add(BookingSlotSelected(slot)),
                              ),
                          ],
                        ),
                ),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.screenMargin),
          child: Column(
            children: [
              // RM-M07-02 — free in MVP, and worth saying before the tap.
              Text(
                l10n.visitBookFree,
                style:
                    context.mboaText.caption.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacingSm),
              SizedBox(
                width: double.infinity,
                child: Button.primary(
                  title: state.selectedVisitor?.mode == BookingMode.onRequest
                      ? l10n.visitProposeSend
                      : l10n.visitBookConfirm,
                  isLoading: state.isSubmitting,
                  onPressed: state.canSubmit
                      ? () => context
                          .read<VisitBookingBloc>()
                          .add(const BookingSubmitted())
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.screenMargin,
          0,
          Dimens.screenMargin,
          Dimens.spacingSm,
        ),
        child: Text(
          title,
          style: context.mboaText.label.copyWith(color: context.mboaColors.ink),
        ),
      );
}

/// A visitor, and the record that lets a tenant choose between two.
class _VisitorCard extends StatelessWidget {
  const _VisitorCard({
    required this.visitor,
    required this.selected,
    required this.onTap,
  });

  final BookableVisitor visitor;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(Dimens.spacingMd),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusMd),
          border: Border.all(
            color: selected ? colors.primary : colors.border,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            MboaAvatar(
              imageUrl: visitor.photoUrl,
              initials: visitor.displayName?.characters.firstOrNull,
              size: Dimens.avatar,
            ),
            const SizedBox(width: Dimens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    visitor.displayName ?? '',
                    style: context.mboaText.label.copyWith(color: colors.ink),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    visitor.kind == VisitorKind.owner
                        ? l10n.visitVisitorOwner
                        : l10n.visitVisitorAgent,
                    style: context.mboaText.caption
                        .copyWith(color: colors.textSecondary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: Dimens.spacingXs),
                  Row(
                    children: [
                      if (visitor.hasRating) ...[
                        Icon(LucideIcons.star, size: 12, color: colors.warning),
                        const SizedBox(width: 2),
                        Text(
                          visitor.averageRating!.toStringAsFixed(1),
                          style: context.mboaText.caption
                              .copyWith(color: colors.textSecondary),
                        ),
                        const SizedBox(width: Dimens.spacingSm),
                      ],
                      Flexible(
                        child: Text(
                          l10n.visitVisitorRecord(visitor.completedVisitCount),
                          style: context.mboaText.caption
                              .copyWith(color: colors.textTertiary),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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

/// One day of the published window — weekday over day number, the way a
/// calendar strip reads.
class _DayChip extends StatelessWidget {
  const _DayChip({
    required this.day,
    required this.selected,
    required this.onTap,
  });

  final DateTime day;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 64,
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacingSm),
        decoration: BoxDecoration(
          color: selected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radius),
          border: Border.all(
            color: selected ? colors.primary : colors.border,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat.E(locale).format(day),
              style: context.mboaText.caption.copyWith(
                color: selected ? colors.onBrand : colors.textSecondary,
              ),
            ),
            Text(
              DateFormat.d(locale).format(day),
              style: context.mboaText.h3.copyWith(
                color: selected ? colors.onBrand : colors.ink,
              ),
            ),
            Text(
              DateFormat.MMM(locale).format(day),
              style: context.mboaText.micro.copyWith(
                color: selected ? colors.onBrand : colors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HourChip extends StatelessWidget {
  const _HourChip({
    required this.slot,
    required this.selected,
    required this.onTap,
  });

  final VisitSlot slot;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.spacing,
          vertical: Dimens.spacingSm,
        ),
        decoration: BoxDecoration(
          color: selected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radiusFull),
          border: Border.all(
            color: selected ? colors.primary : colors.border,
          ),
        ),
        child: Text(
          DateFormat.Hm(locale).format(slot.startsAt),
          style: context.mboaText.label.copyWith(
            color: selected ? colors.onBrand : colors.ink,
          ),
        ),
      ),
    );
  }
}

/// §21 — which week of the calendar is on screen, and the way to the next.
class _WeekNav extends StatelessWidget {
  const _WeekNav({required this.state});

  final BookingReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toString();
    final bloc = context.read<VisitBookingBloc>();

    final start = state.windowStart;
    final label = start == null
        ? l10n.visitBookWindow
        : l10n.visitWeekRange(
            DateFormat.MMMd(locale).format(start),
            DateFormat.MMMd(locale).format(start.add(const Duration(days: 6))),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
      child: Row(
        children: [
          IconButton(
            tooltip: l10n.visitWeekPrev,
            onPressed: state.canGoPrevWeek
                ? () => bloc.add(BookingWeekChanged(state.weekOffset - 1))
                : null,
            icon: const Icon(LucideIcons.chevronLeft),
          ),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: context.mboaText.label.copyWith(color: colors.ink),
            ),
          ),
          IconButton(
            tooltip: l10n.visitWeekNext,
            onPressed: state.canGoNextWeek
                ? () => bloc.add(BookingWeekChanged(state.weekOffset + 1))
                : null,
            icon: const Icon(LucideIcons.chevronRight),
          ),
        ],
      ),
    );
  }
}

/// §19 — proposing a time to an owner who shows their own bien.
///
/// A date picker then a time picker, bounded by what the server accepts
/// ([ProposalWindow]); the chosen moment travels as a [VisitSlot], the same
/// thing a slot visitor's time does, so the bloc books both the same way.
class _Proposal extends StatelessWidget {
  const _Proposal({this.selected});

  final VisitSlot? selected;

  Future<void> _pick(BuildContext context) async {
    final l10n = I18n.of(context);
    final bloc = context.read<VisitBookingBloc>();
    final now = DateTime.now();
    final earliest = ProposalWindow.earliest(now);
    final latest = ProposalWindow.latest(now);
    final initial = selected?.startsAt ?? earliest;

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateUtils.dateOnly(earliest),
      lastDate: latest,
    );
    if (date == null || !context.mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null || !context.mounted) return;

    final at = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    if (!ProposalWindow.accepts(at, DateTime.now())) {
      MboaToast.error(
        context: context,
        title: l10n.commonErrorTitle,
        description: l10n.visitTimeRejected,
      );
      return;
    }
    bloc.add(BookingSlotSelected(VisitSlot(startsAt: at)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toString();
    final at = selected?.startsAt;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(l10n.visitProposeTitle),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.screenMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.visitProposeHelp,
                style:
                    context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: Dimens.spacing),
              if (at != null) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(Dimens.spacingMd),
                  decoration: BoxDecoration(
                    color: colors.primaryPale,
                    borderRadius: BorderRadius.circular(Dimens.radius),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.calendarClock, color: colors.primary),
                      const SizedBox(width: Dimens.spacingSm),
                      Expanded(
                        child: Text(
                          DateFormat.yMMMMEEEEd(locale).add_Hm().format(at),
                          style:
                              context.mboaText.label.copyWith(color: colors.ink),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _pick(context),
                        child: Text(l10n.visitProposeChange),
                      ),
                    ],
                  ),
                ),
              ] else
                SizedBox(
                  width: double.infinity,
                  child: Button.outline(
                    title: l10n.visitProposePick,
                    icon: const Icon(LucideIcons.calendarClock, size: Dimens.icon),
                    iconAlignment: IconAlignment.start,
                    onPressed: () => _pick(context),
                  ),
                ),
              const SizedBox(height: Dimens.spacingXs),
              Text(
                l10n.visitProposeBounds,
                style:
                    context.mboaText.caption.copyWith(color: colors.textTertiary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
