import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_ui/mboa_ui.dart';

import '../bloc/agent_availability_bloc.dart';
import '../models/availability.dart';

/// The agent's weekly pattern, visit length and blocked days (RM-M15-01/03).
///
/// The week is a draft saved as a whole — the endpoint is a PUT that replaces
/// the set. Blocked days are **not** part of that draft: blocking one cancels
/// the visits already booked on it, so it is saved on tap rather than left
/// sitting behind an unsaved form.
@RoutePage()
class AgentAvailabilityPage extends StatelessWidget implements AutoRouteWrapper {
  const AgentAvailabilityPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<AgentAvailabilityBloc>(
        create: (_) => getIt<AgentAvailabilityBloc>()
          ..add(const AvailabilityLoadRequested()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(l10n.agentAvailabilityTitle)),
      body: BlocConsumer<AgentAvailabilityBloc, AgentAvailabilityState>(
        listenWhen: (prev, curr) =>
            curr is AvailabilityReady &&
            (curr.lastActionFailed || curr.justSaved || curr.rejected),
        listener: (context, state) {
          final ready = state as AvailabilityReady;
          if (ready.rejected) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.agentSlotOverlap,
            );
          } else if (ready.lastActionFailed) {
            MboaToast.error(
              context: context,
              title: l10n.commonErrorTitle,
              description: l10n.agentSaveFailed,
            );
          } else {
            MboaToast.success(context: context, title: l10n.agentSaved);
          }
        },
        builder: (context, state) => switch (state) {
          AvailabilityInitial() ||
          AvailabilityLoadInProgress() =>
            const Center(child: Loader()),
          AvailabilityFailure() => Center(
              child: TextButton(
                onPressed: () => context
                    .read<AgentAvailabilityBloc>()
                    .add(const AvailabilityLoadRequested()),
                child: Text(l10n.commonRetry),
              ),
            ),
          AvailabilityReady(:final draft) => ListView(
              padding: const EdgeInsets.all(Dimens.spacing),
              children: [
                Text(
                  l10n.agentAvailabilityHelp,
                  style: context.mboaText.caption
                      .copyWith(color: colors.textSecondary),
                ),
                const SizedBox(height: Dimens.spacing),
                _VisitDuration(minutes: draft.visitDurationMinutes),
                const SizedBox(height: Dimens.spacingLg),
                for (var day = 1; day <= 7; day++)
                  _DayRow(dayOfWeek: day, rules: draft.rulesFor(day)),
                const SizedBox(height: Dimens.spacingLg),
                _DaysOff(daysOff: draft.daysOff),
              ],
            ),
        },
      ),
      bottomNavigationBar: BlocBuilder<AgentAvailabilityBloc, AgentAvailabilityState>(
        builder: (context, state) {
          if (state is! AvailabilityReady) return const SizedBox.shrink();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.spacing),
              child: Button.primary(
                title: l10n.profileSave,
                isLoading: state.isSaving,
                onPressed: state.isDirty
                    ? () => context
                        .read<AgentAvailabilityBloc>()
                        .add(const AvailabilitySaveRequested())
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Doc 10 allows 15–480 minutes; the steps are the ones a visit realistically
/// takes rather than a free-text field nobody wants to type into.
class _VisitDuration extends StatelessWidget {
  const _VisitDuration({required this.minutes});

  final int minutes;

  static const _options = [15, 30, 45, 60, 90, 120, 180, 240];

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);

    return Row(
      children: [
        Expanded(child: Text(l10n.agentVisitDuration)),
        DropdownButton<int>(
          value: _options.contains(minutes) ? minutes : Availability.defaultVisitMinutes,
          items: [
            for (final option in _options)
              DropdownMenuItem(
                value: option,
                child: Text(l10n.agentVisitDurationValue(option)),
              ),
          ],
          onChanged: (value) => value == null
              ? null
              : context
                  .read<AgentAvailabilityBloc>()
                  .add(VisitDurationChanged(value)),
        ),
      ],
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({required this.dayOfWeek, required this.rules});

  final int dayOfWeek;
  final List<AvailabilityRule> rules;

  static String labelOf(I18n l10n, int dayOfWeek) => switch (dayOfWeek) {
        1 => l10n.dayMonday,
        2 => l10n.dayTuesday,
        3 => l10n.dayWednesday,
        4 => l10n.dayThursday,
        5 => l10n.dayFriday,
        6 => l10n.daySaturday,
        _ => l10n.daySunday,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.spacingSm),
      padding: const EdgeInsets.all(Dimens.spacing),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(Dimens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  labelOf(l10n, dayOfWeek),
                  style: context.mboaText.label
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              IconButton(
                icon: const Icon(LucideIcons.plus),
                tooltip: l10n.agentAddSlot,
                onPressed: () => _addSlot(context),
              ),
            ],
          ),
          if (rules.isEmpty)
            Text(
              l10n.agentNoSlots,
              style: context.mboaText.caption
                  .copyWith(color: colors.textTertiary),
            )
          else
            for (final rule in rules)
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${rule.start.format(context)} – ${rule.end.format(context)}',
                      style: context.mboaText.body,
                    ),
                  ),
                  IconButton(
                    icon: Icon(LucideIcons.trash2, color: colors.error),
                    onPressed: () => context
                        .read<AgentAvailabilityBloc>()
                        .add(AvailabilityRuleRemoved(rule)),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Future<void> _addSlot(BuildContext context) async {
    final bloc = context.read<AgentAvailabilityBloc>();

    final start = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 8, minute: 0),
      helpText: labelOf(I18n.of(context), dayOfWeek),
    );
    if (start == null || !context.mounted) return;

    final end = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: (start.hour + 4).clamp(0, 23), minute: start.minute),
      helpText: labelOf(I18n.of(context), dayOfWeek),
    );
    if (end == null) return;

    bloc.add(
      AvailabilityRuleAdded(
        AvailabilityRule(dayOfWeek: dayOfWeek, start: start, end: end),
      ),
    );
  }
}

/// RM-M15-03. Saved on tap, and the copy says why.
class _DaysOff extends StatelessWidget {
  const _DaysOff({required this.daysOff});

  final List<DateTime> daysOff;

  @override
  Widget build(BuildContext context) {
    final l10n = I18n.of(context);
    final colors = context.mboaColors;
    final format = DateFormat.yMMMMd();
    final sorted = [...daysOff]..sort();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.agentDaysOffTitle, style: context.mboaText.h3),
        const SizedBox(height: Dimens.spacingXs),
        Text(
          l10n.agentDaysOffHelp,
          style:
              context.mboaText.caption.copyWith(color: colors.textSecondary),
        ),
        const SizedBox(height: Dimens.spacingSm),
        if (sorted.isEmpty)
          Text(
            l10n.agentDaysOffNone,
            style: context.mboaText.caption.copyWith(color: colors.textTertiary),
          )
        else
          for (final day in sorted)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(LucideIcons.calendarOff, color: colors.error),
              title: Text(format.format(day)),
              trailing: IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () => context
                    .read<AgentAvailabilityBloc>()
                    .add(DayOffUnblocked(day)),
              ),
            ),
        const SizedBox(height: Dimens.spacingSm),
        TextButton.icon(
          icon: const Icon(LucideIcons.calendarPlus),
          label: Text(l10n.agentBlockDay),
          onPressed: () => _blockDay(context),
        ),
      ],
    );
  }

  Future<void> _blockDay(BuildContext context) async {
    final bloc = context.read<AgentAvailabilityBloc>();
    final now = DateTime.now();

    final day = await showDatePicker(
      context: context,
      initialDate: now,
      // Blocking a day in the past would cancel nothing and mean nothing.
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (day != null) bloc.add(DayOffBlocked(day));
  }
}
