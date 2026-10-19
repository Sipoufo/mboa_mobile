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

  /// From any generated enum's wire name (`DAY` … `YEAR`) — the API repeats
  /// the same five values on a dozen DTOs.
  static RentalPeriod fromWire(String? name) => switch (name) {
        'DAY' => RentalPeriod.day,
        'WEEK' => RentalPeriod.week,
        'MONTH' => RentalPeriod.month,
        'QUARTER' => RentalPeriod.quarter,
        'YEAR' => RentalPeriod.year,
        _ => fallback,
      };

  /// The last day of a stay of [units] periods starting on [start] — the
  /// day before the same date [units] periods later, which is what a "Fin"
  /// shows. Calendar months: a start on the 31st is clamped to the target
  /// month's last day. **Indicative**: the contract's own end is the server's.
  DateTime lastDay(DateTime start, int units) {
    final from = DateTime(start.year, start.month, start.day);
    final next = switch (this) {
      RentalPeriod.day => DateTime(from.year, from.month, from.day + units),
      RentalPeriod.week => DateTime(from.year, from.month, from.day + 7 * units),
      RentalPeriod.month => _addMonths(from, units),
      RentalPeriod.quarter => _addMonths(from, 3 * units),
      RentalPeriod.year => _addMonths(from, 12 * units),
    };
    return DateTime(next.year, next.month, next.day - 1);
  }

  static DateTime _addMonths(DateTime from, int months) {
    final target = DateTime(from.year, from.month + months);
    final lastOfTarget = DateTime(target.year, target.month + 1, 0).day;
    return DateTime(target.year, target.month, from.day > lastOfTarget ? lastOfTarget : from.day);
  }

  /// Every known value is mapped explicitly. The fallback is for a value this
  /// build predates or an absent field — never for one the enum already has, or
  /// a listing at 5 000 F/day would read "5 000 FCFA / mois".
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

  static RentalPeriod fromSearch(SearchResultItemRentalPeriodEnum? value) =>
      switch (value) {
        SearchResultItemRentalPeriodEnum.DAY => RentalPeriod.day,
        SearchResultItemRentalPeriodEnum.WEEK => RentalPeriod.week,
        SearchResultItemRentalPeriodEnum.MONTH => RentalPeriod.month,
        SearchResultItemRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        SearchResultItemRentalPeriodEnum.YEAR => RentalPeriod.year,
        _ => fallback,
      };

  static RentalPeriod fromDetail(AnnonceDetailResponseRentalPeriodEnum? v) =>
      switch (v) {
        AnnonceDetailResponseRentalPeriodEnum.DAY => RentalPeriod.day,
        AnnonceDetailResponseRentalPeriodEnum.WEEK => RentalPeriod.week,
        AnnonceDetailResponseRentalPeriodEnum.MONTH => RentalPeriod.month,
        AnnonceDetailResponseRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        AnnonceDetailResponseRentalPeriodEnum.YEAR => RentalPeriod.year,
        _ => fallback,
      };

  /// M27 — a review's residence period. **Nullable, and no fallback**: unlike
  /// a listing (which always has a period, so an absent one means "old build,
  /// assume month"), a review may simply carry no duration, and a fake "mois"
  /// under someone's review would be wrong. Null means "say nothing".
  static RentalPeriod? fromResidence(PropertyReviewResidencePeriodEnum? value) =>
      switch (value) {
        PropertyReviewResidencePeriodEnum.DAY => RentalPeriod.day,
        PropertyReviewResidencePeriodEnum.WEEK => RentalPeriod.week,
        PropertyReviewResidencePeriodEnum.MONTH => RentalPeriod.month,
        PropertyReviewResidencePeriodEnum.QUARTER => RentalPeriod.quarter,
        PropertyReviewResidencePeriodEnum.YEAR => RentalPeriod.year,
        _ => null,
      };

  /// M06 — a saved listing carries the same period as the fiche it points to.
  static RentalPeriod fromFavorite(FavoriResponseRentalPeriodEnum? value) =>
      switch (value) {
        FavoriResponseRentalPeriodEnum.DAY => RentalPeriod.day,
        FavoriResponseRentalPeriodEnum.WEEK => RentalPeriod.week,
        FavoriResponseRentalPeriodEnum.MONTH => RentalPeriod.month,
        FavoriResponseRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        FavoriResponseRentalPeriodEnum.YEAR => RentalPeriod.year,
        _ => fallback,
      };

  /// What `GET /search` expects for `rentalPeriods`.
  String get asSearchParam => switch (this) {
        RentalPeriod.day => 'DAY',
        RentalPeriod.week => 'WEEK',
        RentalPeriod.month => 'MONTH',
        RentalPeriod.quarter => 'QUARTER',
        RentalPeriod.year => 'YEAR',
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

  /// The same period as a contract's (M08). A bail is expressed in the
  /// property's own periodicity — RM-M08-08 — so this is the listing's value,
  /// not a second scale.
  static RentalPeriod fromContract(ContractResponseRentalPeriodEnum? value) =>
      switch (value) {
        ContractResponseRentalPeriodEnum.DAY => RentalPeriod.day,
        ContractResponseRentalPeriodEnum.WEEK => RentalPeriod.week,
        ContractResponseRentalPeriodEnum.MONTH => RentalPeriod.month,
        ContractResponseRentalPeriodEnum.QUARTER => RentalPeriod.quarter,
        ContractResponseRentalPeriodEnum.YEAR => RentalPeriod.year,
        _ => fallback,
      };

  CreateContractRequestRentalPeriodEnum get asContractCreate => switch (this) {
        RentalPeriod.day => CreateContractRequestRentalPeriodEnum.DAY,
        RentalPeriod.week => CreateContractRequestRentalPeriodEnum.WEEK,
        RentalPeriod.month => CreateContractRequestRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => CreateContractRequestRentalPeriodEnum.QUARTER,
        RentalPeriod.year => CreateContractRequestRentalPeriodEnum.YEAR,
      };

  UpdateContractRequestRentalPeriodEnum get asContractUpdate => switch (this) {
        RentalPeriod.day => UpdateContractRequestRentalPeriodEnum.DAY,
        RentalPeriod.week => UpdateContractRequestRentalPeriodEnum.WEEK,
        RentalPeriod.month => UpdateContractRequestRentalPeriodEnum.MONTH,
        RentalPeriod.quarter => UpdateContractRequestRentalPeriodEnum.QUARTER,
        RentalPeriod.year => UpdateContractRequestRentalPeriodEnum.YEAR,
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

  /// The lowercase form, for use inside a sentence or a price.
  ///
  /// §25 asks for normal case, so a price reads "75 000 FCFA / mois" while
  /// the picker beside it still opens its label with a capital.
  String inlineLabel(I18n l10n) => switch (this) {
        RentalPeriod.day => l10n.annoncePeriodDayInline,
        RentalPeriod.week => l10n.annoncePeriodWeekInline,
        RentalPeriod.month => l10n.annoncePeriodMonthInline,
        RentalPeriod.quarter => l10n.annoncePeriodQuarterInline,
        RentalPeriod.year => l10n.annoncePeriodYearInline,
      };

  /// "75 000 FCFA / mois".
  String priceLabel(I18n l10n, int price) => l10n.annoncePricePerPeriod(
        NumberFormat.decimalPattern().format(price),
        inlineLabel(l10n),
      );
}
