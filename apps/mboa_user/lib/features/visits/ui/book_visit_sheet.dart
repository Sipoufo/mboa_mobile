import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_ui/mboa_ui.dart';

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
}) =>
    showModalBottomSheet<Visit>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<VisitBookingBloc>(
        create: (_) =>
            getIt<VisitBookingBloc>()..add(BookingStarted(annonceId)),
        child: const BookVisitSheetBody(),
      ),
    );

/// The sheet's contents, public so they can be pumped on their own —
/// `showModalBottomSheet` cannot be driven from a widget test without a route
/// to open it from, and what is worth pinning is what the tenant reads.
class BookVisitSheetBody extends StatelessWidget {
  const BookVisitSheetBody({super.key});

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
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(Dimens.radiusLg),
          ),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: switch (state) {
            // `BookingDone` lives for the one frame between the booking and
            // the listener popping the sheet; it keeps the loader's height so
            // nothing jumps on the way out.
            BookingLoadInProgress() || BookingDone() => const SizedBox(
                height: 220,
                child: Center(child: Loader()),
              ),
            BookingFailure() => _Notice(
                icon: LucideIcons.triangleAlert,
                body: l10n.commonError,
              ),
            BookingUnavailable(:final reason) => _Notice(
                icon: LucideIcons.calendarX,
                body: switch (reason) {
                  NoSlotReason.noAvailability => l10n.visitNoSlotAvailability,
                  NoSlotReason.allDaysBlocked => l10n.visitNoSlotBlocked,
                  NoSlotReason.fullyBooked ||
                  NoSlotReason.unknown =>
                    l10n.visitNoSlotBooked,
                },
              ),
            final BookingReady ready => _Form(state: ready),
          },
        ),
      ),
    );
  }
}

/// CE-M07-01 — why there is nothing to book, which is the useful half.
class _Notice extends StatelessWidget {
  const _Notice({required this.icon, required this.body});

  final IconData icon;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return Padding(
      padding: const EdgeInsets.all(Dimens.spacingXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: Dimens.iconLg, color: colors.textTertiary),
          const SizedBox(height: Dimens.spacing),
          Text(
            body,
            textAlign: TextAlign.center,
            style: context.mboaText.body.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatelessWidget {
  const _Form({required this.state});

  final BookingReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final visitor = state.selectedVisitor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.screenMargin,
            Dimens.spacing,
            Dimens.screenMargin,
            0,
          ),
          child: Text(
            l10n.visitBookTitle,
            style: context.mboaText.h2.copyWith(color: colors.ink),
          ),
        ),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              Dimens.screenMargin,
              Dimens.spacing,
              Dimens.screenMargin,
              0,
            ),
            children: [
              // One visitor is already chosen, so showing the picker would be
              // a list of one (CA-M07-01).
              if (state.hasVisitorChoice) ...[
                _SectionTitle(l10n.visitBookVisitor),
                for (final candidate in state.visitors)
                  _VisitorTile(
                    visitor: candidate,
                    selected: candidate.accountId == state.selectedVisitorId,
                    onTap: () => context
                        .read<VisitBookingBloc>()
                        .add(BookingVisitorSelected(candidate.accountId)),
                  ),
                const SizedBox(height: Dimens.spacing),
              ],
              if (visitor != null) ...[
                _SectionTitle(l10n.visitBookSlot),
                _Slots(
                  visitor: visitor,
                  selected: state.selectedSlot,
                  onPick: (slot) => context
                      .read<VisitBookingBloc>()
                      .add(BookingSlotSelected(slot)),
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
              Button.primary(
                title: l10n.visitBookConfirm,
                isLoading: state.isSubmitting,
                onPressed: state.canSubmit
                    ? () => context
                        .read<VisitBookingBloc>()
                        .add(const BookingSubmitted())
                    : null,
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
        padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
        child: Text(
          title,
          style: context.mboaText.label.copyWith(color: context.mboaColors.ink),
        ),
      );
}

/// A visitor, and the record that lets a tenant choose between two.
class _VisitorTile extends StatelessWidget {
  const _VisitorTile({
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

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radius),
        child: Container(
          padding: const EdgeInsets.all(Dimens.spacingMd),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(Dimens.radius),
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
                    ),
                    const SizedBox(height: Dimens.spacingXs),
                    Row(
                      children: [
                        if (visitor.hasRating) ...[
                          Icon(
                            LucideIcons.star,
                            size: 14,
                            color: colors.warning,
                          ),
                          const SizedBox(width: Dimens.spacingXs),
                          Text(
                            visitor.averageRating!.toStringAsFixed(1),
                            style: context.mboaText.caption
                                .copyWith(color: colors.textSecondary),
                          ),
                          const SizedBox(width: Dimens.spacingMd),
                        ],
                        Text(
                          l10n.visitVisitorRecord(visitor.completedVisitCount),
                          style: context.mboaText.caption
                              .copyWith(color: colors.textTertiary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(LucideIcons.check, color: colors.primary, size: Dimens.icon),
            ],
          ),
        ),
      ),
    );
  }
}

/// The visitor's free times, grouped by day.
class _Slots extends StatelessWidget {
  const _Slots({
    required this.visitor,
    required this.selected,
    required this.onPick,
  });

  final BookableVisitor visitor;
  final VisitSlot? selected;
  final ValueChanged<VisitSlot> onPick;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final day = DateFormat.MMMEd(locale);
    final hour = DateFormat.Hm(locale);

    // Grouped by day: seven days of times in one flat list is unreadable, and
    // the day is the first thing a tenant decides.
    final days = <String, List<VisitSlot>>{};
    for (final slot in visitor.slots) {
      days.putIfAbsent(day.format(slot.startsAt), () => []).add(slot);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in days.entries) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: Dimens.spacingSm),
            child: Text(
              entry.key,
              style: context.mboaText.caption
                  .copyWith(color: colors.textSecondary),
            ),
          ),
          Wrap(
            spacing: Dimens.spacingSm,
            runSpacing: Dimens.spacingSm,
            children: [
              for (final slot in entry.value)
                _SlotChip(
                  label: hour.format(slot.startsAt),
                  selected: slot == selected,
                  onTap: () => onPick(slot),
                ),
            ],
          ),
          const SizedBox(height: Dimens.spacing),
        ],
      ],
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          label,
          style: context.mboaText.label.copyWith(
            color: selected ? colors.onBrand : colors.ink,
          ),
        ),
      ),
    );
  }
}
