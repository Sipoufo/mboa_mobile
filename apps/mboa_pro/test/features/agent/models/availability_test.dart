import 'package:flutter/material.dart' show TimeOfDay;
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_pro/features/agent/models/availability.dart';

/// The wire format for an availability window (RM-M15-01).
///
/// The spec declares a bare `type: string` — no format, no pattern, no example.
/// The backend field is a Java `LocalTime`, so it emits "08:00" when the seconds
/// are zero and "08:00:30" when they are not, and accepts any ISO local time.
/// Getting this wrong means no agent can ever be booked, and neither analyze nor
/// a bloc test would show it.
void main() {
  group('TimeCodec', () {
    test('reads every shape the backend can emit', () {
      expect(TimeCodec.decode('08:00'), const TimeOfDay(hour: 8, minute: 0));
      expect(TimeCodec.decode('08:00:00'), const TimeOfDay(hour: 8, minute: 0));
      expect(
        TimeCodec.decode('08:30:45'),
        const TimeOfDay(hour: 8, minute: 30),
      );
      expect(
        TimeCodec.decode('08:00:00.000'),
        const TimeOfDay(hour: 8, minute: 0),
      );
      // Jackson drops the leading zero on neither, but be generous anyway.
      expect(TimeCodec.decode('8:05'), const TimeOfDay(hour: 8, minute: 5));
      expect(TimeCodec.decode(' 18:00 '), const TimeOfDay(hour: 18, minute: 0));
    });

    test('always writes HH:mm:ss, which LocalTime.parse accepts', () {
      expect(TimeCodec.encode(const TimeOfDay(hour: 8, minute: 0)), '08:00:00');
      expect(TimeCodec.encode(const TimeOfDay(hour: 18, minute: 30)), '18:30:00');
      expect(TimeCodec.encode(const TimeOfDay(hour: 0, minute: 5)), '00:05:00');
    });

    test('returns null on nonsense rather than throwing', () {
      // One malformed rule must not take down the whole availability screen.
      for (final bad in [null, '', 'morning', '25:00', '08:99', '08', 'a:b']) {
        expect(TimeCodec.decode(bad), isNull, reason: '$bad');
      }
    });
  });

  group('AvailabilityRule', () {
    AvailabilityRule rule(int day, int fromHour, int toHour) => AvailabilityRule(
          dayOfWeek: day,
          start: TimeOfDay(hour: fromHour, minute: 0),
          end: TimeOfDay(hour: toHour, minute: 0),
        );

    test('a window must end after it starts', () {
      expect(rule(1, 8, 18).isValid, isTrue);
      expect(rule(1, 18, 8).isValid, isFalse);
      expect(rule(1, 8, 8).isValid, isFalse);
    });

    test('overlap is per day', () {
      expect(rule(1, 8, 12).overlaps(rule(1, 11, 15)), isTrue);
      // Touching is not overlapping: 08–12 then 12–18 is a legitimate split.
      expect(rule(1, 8, 12).overlaps(rule(1, 12, 18)), isFalse);
      // Same hours, different day.
      expect(rule(1, 8, 12).overlaps(rule(2, 8, 12)), isFalse);
    });

    test('round-trips through the request shape', () {
      final sent = rule(3, 8, 18).toRequest();

      expect(sent.dayOfWeek, 3);
      expect(sent.startTime, '08:00:00');
      expect(sent.endTime, '18:00:00');
      expect(AvailabilityRule.fromResponse(sent), rule(3, 8, 18));
    });

    test('a rule with an unreadable time is dropped, not guessed', () {
      final broken = AvailabilityRuleRequest((b) => b
        ..dayOfWeek = 1
        ..startTime = 'whenever'
        ..endTime = '18:00');

      expect(AvailabilityRule.fromResponse(broken), isNull);
    });
  });

  group('Availability', () {
    test('defaults match Doc 10 — 60 minutes, 15 to 480', () {
      expect(const Availability().visitDurationMinutes, 60);
      expect(Availability.minVisitMinutes, 15);
      expect(Availability.maxVisitMinutes, 480);
    });

    test('reads a response, dropping rules it cannot parse', () {
      final response = AvailabilityResponse((b) => b
        ..visitDurationMinutes = 45
        ..rules.addAll([
          AvailabilityRuleRequest((r) => r
            ..dayOfWeek = 1
            ..startTime = '08:00'
            ..endTime = '18:00'),
          AvailabilityRuleRequest((r) => r
            ..dayOfWeek = 2
            ..startTime = 'nope'
            ..endTime = '18:00'),
        ]));

      final availability = Availability.fromResponse(response);

      expect(availability.rules, hasLength(1));
      expect(availability.visitDurationMinutes, 45);
    });

    test('an empty response is an empty week on the default duration', () {
      final availability =
          Availability.fromResponse(AvailabilityResponse((b) => b));

      expect(availability.rules, isEmpty);
      expect(availability.visitDurationMinutes, 60);
      expect(availability.daysOff, isEmpty);
    });

    test('groups and sorts a day\'s windows', () {
      const availability = Availability(
        rules: [
          AvailabilityRule(
            dayOfWeek: 1,
            start: TimeOfDay(hour: 14, minute: 0),
            end: TimeOfDay(hour: 18, minute: 0),
          ),
          AvailabilityRule(
            dayOfWeek: 1,
            start: TimeOfDay(hour: 8, minute: 0),
            end: TimeOfDay(hour: 12, minute: 0),
          ),
          AvailabilityRule(
            dayOfWeek: 2,
            start: TimeOfDay(hour: 9, minute: 0),
            end: TimeOfDay(hour: 17, minute: 0),
          ),
        ],
      );

      final monday = availability.rulesFor(1);
      expect(monday, hasLength(2));
      expect(monday.first.start.hour, 8);
      expect(availability.rulesFor(7), isEmpty);
    });

    test('caps the weekly pattern at what the endpoint accepts', () {
      final full = Availability(
        rules: List.generate(
          Availability.maxRules,
          (i) => AvailabilityRule(
            dayOfWeek: (i % 7) + 1,
            start: const TimeOfDay(hour: 8, minute: 0),
            end: const TimeOfDay(hour: 9, minute: 0),
          ),
        ),
      );

      expect(full.canAddRule, isFalse);
      expect(const Availability().canAddRule, isTrue);
    });

    test('a day off is matched by date, ignoring any time component', () {
      final availability = Availability(daysOff: [DateTime(2026, 8, 20, 13, 5)]);

      expect(availability.isDayOff(DateTime(2026, 8, 20)), isTrue);
      expect(availability.isDayOff(DateTime(2026, 8, 21)), isFalse);
    });
  });
}
