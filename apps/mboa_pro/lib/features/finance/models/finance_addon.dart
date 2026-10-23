import 'package:equatable/equatable.dart';
import 'package:mboa_core/mboa_core.dart';

/// The « Gestion financière » add-on (RM-M13-09, M24–M26): 30 days at a
/// time, bought with Mobile Money, added after the running period.
///
/// Running, it writes; held once, it still reads, sums up and exports — the
/// server says which (`FINANCE_ADDON_REQUIRED`), the app only reads it off.
class FinanceAddon extends Equatable {
  const FinanceAddon({
    this.active = false,
    this.periodEnd,
    this.everSubscribed = false,
    this.monthlyPrice,
  });

  final bool active;

  /// The running period's last day.
  final DateTime? periodEnd;
  final bool everSubscribed;

  /// For 30 days, in FCFA — the server's price, shown as is.
  final int? monthlyPrice;

  /// Creating, changing, deleting.
  bool get canWrite => active;

  /// Reading the register, the invoices, the intervenants, and exporting.
  bool get canRead => active || everSubscribed;

  static FinanceAddon fromResponse(FinanceAddonResponse response) => FinanceAddon(
        active: response.active ?? false,
        periodEnd: response.periodEnd?.toLocal(),
        everSubscribed: response.everSubscribed ?? false,
        monthlyPrice: response.monthlyPrice,
      );

  Map<String, dynamic> toCache() => {
        'active': active,
        'periodEnd': periodEnd?.toIso8601String(),
        'ever': everSubscribed,
        'price': monthlyPrice,
      };

  static FinanceAddon? fromCache(Object? raw) {
    if (raw is! Map) return null;
    return FinanceAddon(
      active: raw['active'] as bool? ?? false,
      periodEnd: raw['periodEnd'] is String ? DateTime.tryParse(raw['periodEnd'] as String) : null,
      everSubscribed: raw['ever'] as bool? ?? false,
      monthlyPrice: raw['price'] as int?,
    );
  }

  @override
  List<Object?> get props => [active, periodEnd, everSubscribed, monthlyPrice];
}
