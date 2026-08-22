import 'package:flutter_test/flutter_test.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';
import 'package:mboa_pro/features/annonces/models/annonce.dart';
import 'package:mboa_pro/features/annonces/models/annonce_draft.dart';
import 'package:mboa_pro/features/annonces/models/annonce_status.dart';

/// RM-M10-09 — a listing carries a price *and its period*.
///
/// `monthlyRent` is the equivalent the server derives to compare listings with
/// each other. It is not what anyone pays, so the app must neither display it
/// nor send it — but listings created before the rule have only that field, and
/// they were all monthly.
void main() {
  Annonce listing({int? price, int? monthlyRent, RentalPeriod? period}) =>
      Annonce(
        id: 'a1',
        title: 'Studio Bonapriso',
        status: AnnonceStatus.published,
        propertyType: PropertyType.studio,
        price: price,
        monthlyRent: monthlyRent,
        rentalPeriod: period ?? RentalPeriod.fallback,
      );

  group('displayPrice', () {
    test('shows the entered price, not the derived monthly equivalent', () {
      // 900 000/year derives to 75 000/month; showing the latter would tell the
      // prestataire a number nobody pays.
      final a = listing(
        price: 900000,
        monthlyRent: 75000,
        period: RentalPeriod.year,
      );

      expect(a.displayPrice, 900000);
      expect(a.rentalPeriod, RentalPeriod.year);
    });

    test('falls back to monthlyRent for a listing predating RM-M10-09', () {
      final a = listing(monthlyRent: 45000);

      expect(a.displayPrice, 45000);
      // Those listings really were monthly, so the default reads correctly.
      expect(a.rentalPeriod, RentalPeriod.month);
    });

    test('is null when the listing has neither', () {
      expect(listing().displayPrice, isNull);
    });
  });

  test('an absent period from the API reads as monthly', () {
    expect(RentalPeriod.fromResponse(null), RentalPeriod.month);
    expect(RentalPeriod.fromUnitSummary(null), RentalPeriod.month);
  });

  test('every value the API can send maps to its own period', () {
    // The fallback is for a value this build predates — never for one the enum
    // already has. Mapping DAY to month would show 5 000 F/day as 5 000 F/Mois.
    const expected = {
      AnnonceResponseRentalPeriodEnum.DAY: RentalPeriod.day,
      AnnonceResponseRentalPeriodEnum.WEEK: RentalPeriod.week,
      AnnonceResponseRentalPeriodEnum.MONTH: RentalPeriod.month,
      AnnonceResponseRentalPeriodEnum.QUARTER: RentalPeriod.quarter,
      AnnonceResponseRentalPeriodEnum.YEAR: RentalPeriod.year,
    };
    expected.forEach((wire, period) {
      expect(RentalPeriod.fromResponse(wire), period, reason: '$wire');
    });

    const units = {
      UnitSummaryRentalPeriodEnum.DAY: RentalPeriod.day,
      UnitSummaryRentalPeriodEnum.WEEK: RentalPeriod.week,
      UnitSummaryRentalPeriodEnum.MONTH: RentalPeriod.month,
      UnitSummaryRentalPeriodEnum.QUARTER: RentalPeriod.quarter,
      UnitSummaryRentalPeriodEnum.YEAR: RentalPeriod.year,
    };
    units.forEach((wire, period) {
      expect(RentalPeriod.fromUnitSummary(wire), period, reason: '$wire');
    });
  });

  test('every period can be sent back on all three request shapes', () {
    // A period the app can read but not write would make an edit silently
    // change the listing's terms.
    for (final period in RentalPeriod.values) {
      expect(period.asCreate.name, period.name.toUpperCase());
      expect(period.asUpdate.name, period.name.toUpperCase());
      expect(period.asUnitGroup.name, period.name.toUpperCase());
    }
  });

  test('the selector reads shortest period first', () {
    expect(RentalPeriod.values, [
      RentalPeriod.day,
      RentalPeriod.week,
      RentalPeriod.month,
      RentalPeriod.quarter,
      RentalPeriod.year,
    ]);
  });

  group('the form draft', () {
    test('requires a price, and defaults to a monthly period', () {
      const draft = AnnonceDraft(kind: AnnonceKind.single);
      expect(draft.rentalPeriod, RentalPeriod.month);
      expect(draft.hasRequiredFields, isFalse);
    });

    test('carries the period into a unit group', () {
      const group = UnitGroupDraft(
        count: 4,
        namePrefix: 'Chambre',
        price: 45000,
        rentalPeriod: RentalPeriod.quarter,
      );

      expect(group.isValid, isTrue);
      expect(group.rentalPeriod, RentalPeriod.quarter);
      // A group with no price cannot be submitted.
      expect(group.copyWith(price: 0).isValid, isFalse);
    });

    test('editing seeds the price from a pre-RM-M10-09 listing', () {
      final draft = AnnonceDraft.fromAnnonce(listing(monthlyRent: 45000));

      expect(draft.price, 45000);
      expect(draft.rentalPeriod, RentalPeriod.month);
    });

    test('props cover the period, so a change is not dropped', () {
      const a = AnnonceDraft(kind: AnnonceKind.single, price: 100);
      expect(a, isNot(a.copyWith(rentalPeriod: RentalPeriod.year)));
    });
  });
}
