import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// Money in or money out (CDC M25).
enum LedgerDirection {
  income,
  expense;

  String get wire => this == LedgerDirection.income ? 'INCOME' : 'EXPENSE';

  static LedgerDirection fromWire(String? name) => name == 'INCOME' ? LedgerDirection.income : LedgerDirection.expense;
}

/// What a line is for — the server's categories.
enum LedgerCategory {
  rent,
  charges,
  works,
  propertyTax,
  serviceProviders,
  other;

  String get wire => switch (this) {
        LedgerCategory.rent => 'RENT',
        LedgerCategory.charges => 'CHARGES',
        LedgerCategory.works => 'WORKS',
        LedgerCategory.propertyTax => 'PROPERTY_TAX',
        LedgerCategory.serviceProviders => 'SERVICE_PROVIDERS',
        LedgerCategory.other => 'OTHER',
      };

  static LedgerCategory fromWire(String? name) =>
      LedgerCategory.values.where((c) => c.wire == name).firstOrNull ?? LedgerCategory.other;
}

/// Which properties a view or a line is about (RM-M25-02).
sealed class LedgerProperty extends Equatable {
  const LedgerProperty();

  /// For a cache key: one view, one key.
  String get key;

  @override
  List<Object?> get props => [key];
}

/// Every line — a filter only.
final class AllProperties extends LedgerProperty {
  const AllProperties();

  @override
  String get key => 'all';
}

final class ListingProperty extends LedgerProperty {
  const ListingProperty(this.id, this.label);

  final String id;
  final String label;

  @override
  String get key => 'annonce:$id';
}

final class ResidenceProperty extends LedgerProperty {
  const ResidenceProperty(this.id, this.label);

  final String id;
  final String label;

  @override
  String get key => 'residence:$id';
}

/// « Non affecté » — a general expense.
final class UnassignedProperty extends LedgerProperty {
  const UnassignedProperty();

  @override
  String get key => 'none';
}

/// A period for the register — this month, the last three, this year, all.
enum LedgerPeriod {
  thisMonth,
  lastThreeMonths,
  thisYear,
  all;

  /// The first and last day, both included; null for all time.
  (DateTime, DateTime)? range(DateTime today) => switch (this) {
        LedgerPeriod.thisMonth => (DateTime(today.year, today.month), _end(today)),
        LedgerPeriod.lastThreeMonths => (DateTime(today.year, today.month - 2), _end(today)),
        LedgerPeriod.thisYear => (DateTime(today.year), DateTime(today.year, 12, 31)),
        LedgerPeriod.all => null,
      };

  static DateTime _end(DateTime today) => DateTime(today.year, today.month + 1, 0);
}

/// What the register is looking at: a period and which properties — the
/// same for the lines, the summary and the export.
class LedgerScope extends Equatable {
  const LedgerScope({this.period = LedgerPeriod.thisMonth, this.property = const AllProperties()});

  final LedgerPeriod period;
  final LedgerProperty property;

  String get key => '${period.name}|${property.key}';

  LedgerScope copyWith({LedgerPeriod? period, LedgerProperty? property}) =>
      LedgerScope(period: period ?? this.period, property: property ?? this.property);

  @override
  List<Object?> get props => [period, property];
}

/// One line of the register (CDC M25). A line kept from a confirmed payment
/// — an invoice, a rent — is [readOnly]: corrected at its source (RM-M30-08).
class LedgerEntry extends Equatable {
  const LedgerEntry({
    required this.id,
    required this.direction,
    required this.category,
    required this.amount,
    this.date,
    this.annonceId,
    this.residenceId,
    this.propertyLabel,
    this.note,
    this.hasAttachment = false,
    this.readOnly = false,
  });

  final String id;
  final LedgerDirection direction;
  final LedgerCategory category;
  final int amount;
  final DateTime? date;
  final String? annonceId;
  final String? residenceId;
  final String? propertyLabel;
  final String? note;
  final bool hasAttachment;
  final bool readOnly;

  /// Which property it is on, as the form edits it.
  LedgerProperty get property => switch ((annonceId, residenceId)) {
        (final id?, _) => ListingProperty(id, propertyLabel ?? ''),
        (_, final id?) => ResidenceProperty(id, propertyLabel ?? ''),
        _ => const UnassignedProperty(),
      };

  static LedgerEntry fromResponse(LedgerEntryResponse r) => LedgerEntry(
        id: r.id ?? '',
        direction: LedgerDirection.fromWire(r.direction?.name),
        category: LedgerCategory.fromWire(r.category?.name),
        amount: r.amount ?? 0,
        date: r.date?.toDateTime(),
        annonceId: r.annonceId,
        residenceId: r.residenceId,
        propertyLabel: r.propertyLabel,
        note: r.note,
        hasAttachment: r.hasAttachment ?? false,
        readOnly: r.readOnly ?? false,
      );

  Map<String, dynamic> toCache() => {
        'id': id,
        'direction': direction.name,
        'category': category.name,
        'amount': amount,
        'date': date?.toIso8601String(),
        'annonceId': annonceId,
        'residenceId': residenceId,
        'property': propertyLabel,
        'note': note,
        'attachment': hasAttachment,
        'readOnly': readOnly,
      };

  static LedgerEntry? fromCache(Object? raw) {
    if (raw is! Map || raw['id'] is! String) return null;
    return LedgerEntry(
      id: raw['id'] as String,
      direction: LedgerDirection.values.where((d) => d.name == raw['direction']).firstOrNull ?? LedgerDirection.expense,
      category: LedgerCategory.values.where((c) => c.name == raw['category']).firstOrNull ?? LedgerCategory.other,
      amount: raw['amount'] as int? ?? 0,
      date: raw['date'] is String ? DateTime.tryParse(raw['date'] as String) : null,
      annonceId: raw['annonceId'] as String?,
      residenceId: raw['residenceId'] as String?,
      propertyLabel: raw['property'] as String?,
      note: raw['note'] as String?,
      hasAttachment: raw['attachment'] as bool? ?? false,
      readOnly: raw['readOnly'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props =>
      [id, direction, category, amount, date, annonceId, residenceId, propertyLabel, note, hasAttachment, readOnly];
}

/// One category's total over the scope.
class LedgerCategoryTotal extends Equatable {
  const LedgerCategoryTotal({required this.direction, required this.category, required this.total});

  final LedgerDirection direction;
  final LedgerCategory category;
  final int total;

  @override
  List<Object?> get props => [direction, category, total];
}

/// The register's figures over a scope (RM-M25-03) — the server's sums.
class LedgerSummary extends Equatable {
  const LedgerSummary({this.income = 0, this.expense = 0, this.net = 0, this.entryCount = 0, this.byCategory = const []});

  final int income;
  final int expense;
  final int net;
  final int entryCount;
  final List<LedgerCategoryTotal> byCategory;

  static LedgerSummary fromResponse(LedgerSummaryResponse r) => LedgerSummary(
        income: r.income ?? 0,
        expense: r.expense ?? 0,
        net: r.net ?? 0,
        entryCount: r.entryCount ?? 0,
        byCategory: [
          for (final c in r.byCategory?.toList() ?? const <CategoryTotal>[])
            LedgerCategoryTotal(
              direction: LedgerDirection.fromWire(c.direction?.name),
              category: LedgerCategory.fromWire(c.category?.name),
              total: c.total ?? 0,
            ),
        ],
      );

  Map<String, dynamic> toCache() => {
        'income': income,
        'expense': expense,
        'net': net,
        'count': entryCount,
        'byCategory': [for (final c in byCategory) [c.direction.name, c.category.name, c.total]],
      };

  static LedgerSummary? fromCache(Object? raw) {
    if (raw is! Map) return null;
    return LedgerSummary(
      income: raw['income'] as int? ?? 0,
      expense: raw['expense'] as int? ?? 0,
      net: raw['net'] as int? ?? 0,
      entryCount: raw['count'] as int? ?? 0,
      byCategory: [
        for (final c in (raw['byCategory'] as List? ?? const []))
          if (c is List && c.length == 3)
            LedgerCategoryTotal(
              direction: LedgerDirection.values.firstWhere((d) => d.name == c[0], orElse: () => LedgerDirection.expense),
              category: LedgerCategory.values.firstWhere((x) => x.name == c[1], orElse: () => LedgerCategory.other),
              total: c[2] as int? ?? 0,
            ),
      ],
    );
  }

  @override
  List<Object?> get props => [income, expense, net, entryCount, byCategory];
}
