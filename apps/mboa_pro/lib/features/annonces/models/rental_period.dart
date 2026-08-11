import 'package:intl/intl.dart';
import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_l10n/mboa_l10n.dart';

/// How often the rent on a listing falls due (RM-M10-09).
///
/// The prestataire enters a **price** and its period; the backend derives a
/// monthly equivalent used *only* to filter, sort and compare listings against
/// each other. A listing at 900 000 F/year therefore sits in the same bracket as
/// one at 75 000 F/month — but the derived figure is never billed and never
/// appears in the Contrat Mboa, which carries the price and its period.
///
/// **Divergence from Doc 10.** RM-M10-09 states, in as many words, that there is
/// no weekly or nightly period because short-term letting is a distinct
/// product. The API added `DAY` and `WEEK` anyway, so the app supports them —
/// but the CDC has not been updated to match, and short-term letting has no
/// rules of its own there (contract, tier limits, search brackets).
///
/// Ordered shortest to longest: that is how the selector reads.
enum RentalPeriod {
  day,
  week,
  month,
  quarter,
  year;

  /// Existing listings pre-date the field, and a month is what they all were.
  static const RentalPeriod fallback = RentalPeriod.month;

  /// Every known value is mapped explicitly. The fallback is for a value this
  /// build predates or an absent field — never for one the enum already has, or
  /// a listing at 5 000 F/day would read "5 000 XAF / Mois".
  static RentalPeriod fromResponse(AnnonceResponseRentalPeriodEnum? value) =>
      switch (value) {
        AnnonceResponseRentalPeriodEnum.DAY => RentalPeriod.day,
        AnnonceResponseRentalPeriodEnum.WEEK => RentalPeriod.week,
        AnnonceResponseRentalPeriodEnum.MONTH => RentalPeriod.month,
        AnnonceResponseRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        AnnonceResponseRentalPeriodEnum.YEAR => RentalPeriod.year,
        _ => fallback,
      };

  static RentalPeriod fromUnitSummary(UnitSummaryRentalPeriodEnum? value) =>
      switch (value) {
        UnitSummaryRentalPeriodEnum.DAY => RentalPeriod.day,
        UnitSummaryRentalPeriodEnum.WEEK => RentalPeriod.week,
        UnitSummaryRentalPeriodEnum.MONTH => RentalPeriod.month,
        UnitSummaryRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        UnitSummaryRentalPeriodEnum.YEAR => RentalPeriod.year,
        _ => fallback,
      };

  CreateAnnonceRequestRentalPeriodEnum get asCreate => switch (this) {
        RentalPeriod.day => CreateAnnonceRequestRentalPeriodEnum.DAY,
        RentalPeriod.week => CreateAnnonceRequestRentalPeriodEnum.WEEK,
        RentalPeriod.month => CreateAnnonceRequestRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => CreateAnnonceRequestRentalPeriodEnum.QUARTER,
        RentalPeriod.year => CreateAnnonceRequestRentalPeriodEnum.YEAR,
      };

  UpdateAnnonceRequestRentalPeriodEnum get asUpdate => switch (this) {
        RentalPeriod.day => UpdateAnnonceRequestRentalPeriodEnum.DAY,
        RentalPeriod.week => UpdateAnnonceRequestRentalPeriodEnum.WEEK,
        RentalPeriod.month => UpdateAnnonceRequestRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => UpdateAnnonceRequestRentalPeriodEnum.QUARTER,
        RentalPeriod.year => UpdateAnnonceRequestRentalPeriodEnum.YEAR,
      };

  UnitGroupRentalPeriodEnum get asUnitGroup => switch (this) {
        RentalPeriod.day => UnitGroupRentalPeriodEnum.DAY,
        RentalPeriod.week => UnitGroupRentalPeriodEnum.WEEK,
        RentalPeriod.month => UnitGroupRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => UnitGroupRentalPeriodEnum.QUARTER,
        RentalPeriod.year => UnitGroupRentalPeriodEnum.YEAR,
      };
}

/// Localised rendering of a price and its period, so the four call sites that
/// show a rent cannot disagree about the wording.
extension RentalPeriodLabel on RentalPeriod {
  String label(I18n l10n) => switch (this) {
        RentalPeriod.day => l10n.annoncePeriodDay,
        RentalPeriod.week => l10n.annoncePeriodWeek,
        RentalPeriod.month => l10n.annoncePeriodMonth,
        RentalPeriod.quarter => l10n.annoncePeriodQuarter,
        RentalPeriod.year => l10n.annoncePeriodYear,
      };

  /// "75 000 XAF / mois".
  String priceLabel(I18n l10n, int price) => l10n.annoncePricePerPeriod(
        NumberFormat.decimalPattern().format(price),
        label(l10n),
      );
}
