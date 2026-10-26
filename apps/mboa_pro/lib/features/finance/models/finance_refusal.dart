import 'package:dio/dio.dart';
import 'package:mboa_shared/mboa_shared.dart';

/// Why the server turned a finance change down — each said in words by the
/// screen.
enum FinanceRefusal {
  /// The plan held now does not include the finance tools
  /// (`FINANCE_PLAN_REQUIRED`, RM-M13-09): Pro and Pro+ do. On a read, they
  /// were never held — what was held once stays readable.
  planRequired,

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

/// A read refused because the finance tools were never held: the screen
/// says where they are, rather than offering to try again forever.
Never throwIfPlanRequired(Object error) {
  if (error is DioException && ApiError.from(error).hasCode('FINANCE_PLAN_REQUIRED')) {
    throw const FinanceRefused(FinanceRefusal.planRequired);
  }
  Error.throwWithStackTrace(error, StackTrace.current);
}

/// Runs a finance change, turning the server's known refusals into
/// [FinanceRefused]; anything else goes up as it came.
Future<T> guardFinance<T>(Future<T> Function() call) async {
  try {
    return await call();
  } on DioException catch (error) {
    final api = ApiError.from(error);
    for (final (code, reason) in const [
      ('FINANCE_PLAN_REQUIRED', FinanceRefusal.planRequired),
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
