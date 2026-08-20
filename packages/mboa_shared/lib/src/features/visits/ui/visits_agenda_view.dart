import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/visits_agenda_bloc.dart';
import '../models/visit.dart';

/// A week of visits as an agenda: seven days across the top, the selected
/// day's visits underneath.
///
/// Shared by the agent's Visites tab and the prestataire's Gestionnaire tab —
/// both are looking at the same thing, a day's rounds. It takes a state and
/// callbacks rather than reading a bloc from the tree: each persona has its own
/// `VisitsAgendaBloc` subclass, and a widget that named one of them could not
/// serve the other.
class VisitsAgendaView extends StatelessWidget {
  const VisitsAgendaView({
    super.key,
    required this.state,
    required this.onDaySelected,
    required this.onWeekChanged,
    required this.onRefresh,
    required this.itemBuilder,
    this.header,
    this.emptyLabel,
  });

  final VisitsAgendaReady state;
  final ValueChanged<DateTime> onDaySelected;
  final ValueChanged<DateTime> onWeekChanged;
  final VoidCallback onRefresh;

  /// One row per visit — each app draws its own, because the actions and the
  /// wording differ by role.
  final Widget Function(BuildContext context, Visit visit) itemBuilder;

  /// Drawn above the day's list. The prestataire puts his pending requests
  /// there (RM-M15-06); the agent has none.
  final Widget? header;

  final String? emptyLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final visits = state.selectedVisits;

    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: Dimens.spacing),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
            child: _WeekHeader(state: state, onWeekChanged: onWeekChanged),
          ),
          const SizedBox(height: Dimens.spacingSm),
          _WeekStrip(state: state, onDaySelected: onDaySelected),
          const SizedBox(height: Dimens.spacingLg),
          if (header case final header?)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
              child: header,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.spacing),
            child: Text(
              DateFormat.yMMMMEEEEd().format(state.selectedDay),
              style: context.mboaText.h3,
            ),
          ),
          const SizedBox(height: Dimens.spacingSm),
          if (visits.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.spacing,
                vertical: Dimens.spacingLg,
              ),
              child: Text(
                emptyLabel ?? l10n.visitsAgendaEmptyDay,
                style:
                    context.mboaText.body.copyWith(color: colors.textSecondary),
              ),
            )
          else
            for (final visit in visits)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Dimens.spacing),
                child: itemBuilder(context, visit),
              ),
        ],
      ),
    );
  }
}

class _WeekHeader extends StatelessWidget {
  const _WeekHeader({required this.state, required this.onWeekChanged});

  final VisitsAgendaReady state;
  final ValueChanged<DateTime> onWeekChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Row(
      children: [
        Expanded(
          child: Text(
            DateFormat.yMMMM().format(state.weekStart),
            style: context.mboaText.h3,
          ),
        ),
        if (state.isLoadingWeek)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.spacingSm),
            child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        // Only worth a button when it would move: on today's week it is the
        // selection that changes, and the strip already shows that.
        if (!state.isOnToday)
          TextButton(
            onPressed: () => onWeekChanged(state.today),
            child: Text(l10n.visitsAgendaToday),
          ),
        IconButton(
          tooltip: l10n.visitsAgendaPreviousWeek,
          onPressed: () =>
              onWeekChanged(state.weekStart.subtract(const Duration(days: 7))),
          icon: Icon(Icons.chevron_left, color: colors.textSecondary),
        ),
        IconButton(
          tooltip: l10n.visitsAgendaNextWeek,
          onPressed: () =>
              onWeekChanged(state.weekStart.add(const Duration(days: 7))),
          icon: Icon(Icons.chevron_right, color: colors.textSecondary),
        ),
      ],
    );
  }
}

/// Seven cells. The dot carries the count of visits still standing that day —
/// what somebody scanning the week is actually looking for.
class _WeekStrip extends StatelessWidget {
  const _WeekStrip({required this.state, required this.onDaySelected});

  final VisitsAgendaReady state;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.mboaColors;
    final weekday = DateFormat.E();

    return SizedBox(
      height: 76,
      child: Row(
        children: [
          for (final day in state.days)
            Expanded(
              child: _DayCell(
                label: weekday.format(day),
                day: day.day,
                count: state.countOn(day),
                isSelected: VisitsAgendaBloc.sameDay(day, state.selectedDay),
                isToday: VisitsAgendaBloc.sameDay(day, state.today),
                colors: colors,
                onTap: () => onDaySelected(day),
              ),
            ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.label,
    required this.day,
    required this.count,
    required this.isSelected,
    required this.isToday,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final int day;
  final int count;
  final bool isSelected;
  final bool isToday;
  final MboaColorScheme colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? colors.onBrand : colors.ink;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radius),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : colors.surface,
          borderRadius: BorderRadius.circular(Dimens.radius),
          border: isToday && !isSelected
              ? Border.all(color: colors.primary)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: context.mboaText.caption.copyWith(
                color: isSelected ? colors.onBrand : colors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$day',
              style: context.mboaText.label
                  .copyWith(color: foreground, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            // An empty day keeps the space so the row does not jump as weeks
            // change; it simply has nothing in it.
            SizedBox(
              height: 6,
              child: count == 0
                  ? null
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < (count > 3 ? 3 : count); i++)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? colors.onBrand
                                  : colors.primary,
                            ),
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
