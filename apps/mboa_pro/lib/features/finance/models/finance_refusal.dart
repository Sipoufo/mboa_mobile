import 'package:dio/dio.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why the server turned a finance change down — each said in words by the
/// screen.
enum FinanceRefusal {
  /// The add-on is not running (`FINANCE_ADDON_REQUIRED`): read, not written.
  addonRequired,

  /// Already paid or cancelled (`INVOICE_SETTLED`).
  settled,

  /// Settled by the tenant's confirmed declarations, not by hand
  /// (`INVOICE_NOT_DECLARED`): nothing to withdraw.
  notDeclaredByHand,

  /// An « Autre » charge needs its words (`INVOICE_LABEL_REQUIRED`).
  labelRequired,

  /// The contract no longer runs (RM-M24-02).
  contractNotActive,

  /// A line kept from a confirmed payment: corrected at its source
  /// (`LEDGER_ENTRY_READ_ONLY`, RM-M30-08).
  readOnlyLine,

  /// A property both listing and residence, or one and « non affecté »
  /// (`LEDGER_PROPERTY_CONFLICT`).
  propertyConflict,

  /// An intervenant with payments is archived, not deleted.
  providerHasPayments,

  /// An archived intervenant is restored before being paid.
  providerArchived,

  /// That contact is already an intervenant.
  providerDuplicate,
}

class FinanceRefused implements Exception {
  const FinanceRefused(this.reason);

  final FinanceRefusal reason;
}

/// Runs a finance change, turning the server's known refusals into
/// [FinanceRefused]; anything else goes up as it came.
Future<T> guardFinance<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (error) {
    final api = ApiError.from(error);
    for (final (code, reason) in const [
      ('FINANCE_ADDON_REQUIRED', FinanceRefusal.addonRequired),
      ('INVOICE_SETTLED', FinanceRefusal.settled),
      ('INVOICE_NOT_DECLARED', FinanceRefusal.notDeclaredByHand),
      ('INVOICE_LABEL_REQUIRED', FinanceRefusal.labelRequired),
      ('CONTRACT_NOT_ACTIVE', FinanceRefusal.contractNotActive),
      ('LEDGER_ENTRY_READ_ONLY', FinanceRefusal.readOnlyLine),
      ('LEDGER_PROPERTY_CONFLICT', FinanceRefusal.propertyConflict),
      ('SERVICE_PROVIDER_HAS_PAYMENTS', FinanceRefusal.providerHasPayments),
      ('SERVICE_PROVIDER_ARCHIVED', FinanceRefusal.providerArchived),
      ('SERVICE_PROVIDER_DUPLICATE', FinanceRefusal.providerDuplicate),
    ]) {
      if (api.hasCode(code)) throw FinanceRefused(reason);
    }
    rethrow;
  }
}
