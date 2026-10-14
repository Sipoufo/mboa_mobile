import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_l10n/mboa_l10n.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// `ReviewEntry.stayLabel` — the residence duration in the contract's own unit
/// (CDC M27, RM-M27-02, docs/backend-requests.md §24.2).
void main() {
  late I18n fr;

  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    fr = await I18n.load(const Locale('fr'));
  });

  ReviewEntry entry({int? duration, RentalPeriod? period, int? months}) =>
      ReviewEntry(
        id: 'r-1',
        kind: ReviewKind.resident,
        residenceDuration: duration,
        residencePeriod: period,
        residenceMonths: months,
      );

  group('the unit is the contract’s own', () {
    test('a day let reads in days, not rounded to zero months', () {
      // The whole point of §24.2: a 3-day stay used to be residenceMonths=0.
      expect(entry(duration: 3, period: RentalPeriod.day).stayLabel(fr),
          '3 jours sur place');
    });

    test('singular and plural are distinguished', () {
      expect(entry(duration: 1, period: RentalPeriod.day).stayLabel(fr),
          '1 jour sur place');
      expect(entry(duration: 2, period: RentalPeriod.week).stayLabel(fr),
          '2 semaines sur place');
      expect(entry(duration: 1, period: RentalPeriod.week).stayLabel(fr),
          '1 semaine sur place');
    });

    test('mois is invariable, an/ans is not', () {
      expect(entry(duration: 12, period: RentalPeriod.month).stayLabel(fr),
          '12 mois sur place');
      expect(entry(duration: 1, period: RentalPeriod.year).stayLabel(fr),
          '1 an sur place');
      expect(entry(duration: 2, period: RentalPeriod.year).stayLabel(fr),
          '2 ans sur place');
    });

    test('a quarter has its own word', () {
      expect(entry(duration: 3, period: RentalPeriod.quarter).stayLabel(fr),
          '3 trimestres sur place');
    });
  });

  group('when it says nothing', () {
    test('no period → null, even if months is set', () {
      // A review from before §24.2 may carry only residenceMonths. Rather than
      // fall back to a possibly-wrong "mois", stayLabel declines — the fiche
      // shows no duration at all, which the test for it asserts.
      expect(entry(months: 6).stayLabel(fr), isNull);
    });

    test('no duration → null', () {
      expect(entry(period: RentalPeriod.month).stayLabel(fr), isNull);
    });

    test('a zero or negative duration → null, never "0 jour"', () {
      expect(entry(duration: 0, period: RentalPeriod.day).stayLabel(fr), isNull);
    });
  });
}
