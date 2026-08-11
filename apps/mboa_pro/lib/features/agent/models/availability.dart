import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show TimeOfDay;
import 'package:mboa_core/mboa_core.dart';

/// Wire format for `AvailabilityRuleRequest.startTime` / `endTime`.
///
/// The spec declares a bare `type: string` with no format, pattern or example.
/// The backend field is a Java `LocalTime` with default Jackson settings, so it
/// **emits** ISO-8601 local time — `"08:00"` when the seconds are zero,
/// `"08:00:30"` when they are not — and **accepts** any ISO local time.
///
/// So: parse leniently, always send `HH:mm:ss`. A wrong format here means no
/// agent can be booked, and nothing in analyze or the bloc tests would show it.
abstract final class TimeCodec {
  /// Accepts `H:mm`, `HH:mm`, `HH:mm:ss` and `HH:mm:ss.SSS`. Returns null on
  /// anything else rather than throwing — one malformed rule must not take down
  /// the whole availability screen.
  static TimeOfDay? decode(String? value) {
    if (value == null) return null;
    final parts = value.trim().split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  /// Always `HH:mm:ss` — unambiguous, and `LocalTime.parse` takes it.
  static String encode(TimeOfDay time) =>
      '${_two(time.hour)}:${_two(time.minute)}:00';

  static String _two(int value) => value.toString().padLeft(2, '0');
}

/// One weekly availability window (RM-M15-01).
///
/// Recurring, not a calendar entry: "Monday 08:00–18:00, every week". Bookable
/// slots are derived server-side from these minus days off and booked visits,
/// so the app never computes them.
class AvailabilityRule extends Equatable {
  const AvailabilityRule({
    required this.dayOfWeek,
    required this.start,
    required this.end,
  });

  /// 1 = Monday … 7 = Sunday. Matches both ISO-8601 and Dart's
  /// `DateTime.weekday`, so no conversion is needed in either direction.
  final int dayOfWeek;
  final TimeOfDay start;
  final TimeOfDay end;

  bool get isValid => _minutes(end) > _minutes(start);

  static int _minutes(TimeOfDay t) => t.hour * 60 + t.minute;

  /// Overlapping the same day would make two windows out of one; the backend
  /// stores them as given, so the form is where this is caught.
  bool overlaps(AvailabilityRule other) =>
      dayOfWeek == other.dayOfWeek &&
      _minutes(start) < _minutes(other.end) &&
      _minutes(other.start) < _minutes(end);

  static AvailabilityRule? fromResponse(AvailabilityRuleRequest rule) {
    final start = TimeCodec.decode(rule.startTime);
    final end = TimeCodec.decode(rule.endTime);
    if (start == null || end == null) return null;
    return AvailabilityRule(
      dayOfWeek: rule.dayOfWeek,
      start: start,
      end: end,
    );
  }

  AvailabilityRuleRequest toRequest() => AvailabilityRuleRequest((b) => b
    ..dayOfWeek = dayOfWeek
    ..startTime = TimeCodec.encode(start)
    ..endTime = TimeCodec.encode(end));

  AvailabilityRule copyWith({int? dayOfWeek, TimeOfDay? start, TimeOfDay? end}) =>
      AvailabilityRule(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  @override
  List<Object?> get props => [dayOfWeek, start, end];
}

/// The agent's whole availability picture: the weekly pattern, how long a visit
/// takes, and the days they have blocked out.
class Availability extends Equatable {
  const Availability({
    this.rules = const [],
    this.visitDurationMinutes = defaultVisitMinutes,
    this.daysOff = const [],
  });

  /// Doc 10 RM-M15-01 — 60 minutes by default, 15–480 allowed.
  static const int defaultVisitMinutes = 60;
  static const int minVisitMinutes = 15;
  static const int maxVisitMinutes = 480;

  /// `UpdateAvailabilityRequest.rules` caps at 30.
  static const int maxRules = 30;

  final List<AvailabilityRule> rules;
  final int visitDurationMinutes;

  /// Whole days blocked out (RM-M15-03). Dates only — no time component.
  final List<DateTime> daysOff;

  List<AvailabilityRule> rulesFor(int dayOfWeek) =>
      rules.where((r) => r.dayOfWeek == dayOfWeek).toList()
        ..sort((a, b) => a.start.hour * 60 +
            a.start.minute -
            (b.start.hour * 60 + b.start.minute));

  bool get canAddRule => rules.length < maxRules;

  bool isDayOff(DateTime day) =>
      daysOff.any((d) => d.year == day.year && d.month == day.month && d.day == day.day);

  static Availability fromResponse(AvailabilityResponse response) =>
      Availability(
        rules: response.rules
                ?.map(AvailabilityRule.fromResponse)
                .nonNulls
                .toList() ??
            const [],
        visitDurationMinutes:
            response.visitDurationMinutes ?? defaultVisitMinutes,
        daysOff: response.daysOff?.map((d) => d.toDateTime()).toList() ??
            const [],
      );

  Availability copyWith({
    List<AvailabilityRule>? rules,
    int? visitDurationMinutes,
    List<DateTime>? daysOff,
  }) =>
      Availability(
        rules: rules ?? this.rules,
        visitDurationMinutes: visitDurationMinutes ?? this.visitDurationMinutes,
        daysOff: daysOff ?? this.daysOff,
      );

  @override
  List<Object?> get props => [rules, visitDurationMinutes, daysOff];
}
