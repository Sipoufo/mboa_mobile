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
/// Doc 10 is explicit that there is no weekly or nightly period: short-term
/// letting is a different product.
enum RentalPeriod {
  month,
  quarter,
  year;

  /// Existing listings pre-date the field, and a month is what they all were.
  static const RentalPeriod fallback = RentalPeriod.month;

  static RentalPeriod fromResponse(AnnonceResponseRentalPeriodEnum? value) =>
      switch (value) {
        AnnonceResponseRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        AnnonceResponseRentalPeriodEnum.YEAR => RentalPeriod.year,
        AnnonceResponseRentalPeriodEnum.MONTH => RentalPeriod.month,
        _ => fallback,
      };

  static RentalPeriod fromUnitSummary(UnitSummaryRentalPeriodEnum? value) =>
      switch (value) {
        UnitSummaryRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        UnitSummaryRentalPeriodEnum.YEAR => RentalPeriod.year,
        UnitSummaryRentalPeriodEnum.MONTH => RentalPeriod.month,
        _ => fallback,
      };

  CreateAnnonceRequestRentalPeriodEnum get asCreate => switch (this) {
        RentalPeriod.month => CreateAnnonceRequestRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => CreateAnnonceRequestRentalPeriodEnum.QUARTER,
        RentalPeriod.year => CreateAnnonceRequestRentalPeriodEnum.YEAR,
      };

  UpdateAnnonceRequestRentalPeriodEnum get asUpdate => switch (this) {
        RentalPeriod.month => UpdateAnnonceRequestRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => UpdateAnnonceRequestRentalPeriodEnum.QUARTER,
        RentalPeriod.year => UpdateAnnonceRequestRentalPeriodEnum.YEAR,
      };

  UnitGroupRentalPeriodEnum get asUnitGroup => switch (this) {
        RentalPeriod.month => UnitGroupRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => UnitGroupRentalPeriodEnum.QUARTER,
        RentalPeriod.year => UnitGroupRentalPeriodEnum.YEAR,
      };
}

/// Localised rendering of a price and its period, so the four call sites that
/// show a rent cannot disagree about the wording.
extension RentalPeriodLabel on RentalPeriod {
  String label(I18n l10n) => switch (this) {
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
