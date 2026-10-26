import 'package:mboa_core/mboa_core.dart';
import 'package:mboa_shared/mboa_shared.dart';

import '../../subscription/data/subscription_repository.dart';
import '../models/finance_access.dart';

/// Where the landlord stands with the finance tools (RM-M13-09): the plan held
/// now, and which plans include them — both the subscription's, read as is.
class FinanceAccessRepository {
  FinanceAccessRepository({required SubscriptionRepository subscriptions, required HiveCache cache})
      : _subscriptions = subscriptions,
        _cache = cache;

  final SubscriptionRepository _subscriptions;
  final HiveCache _cache;

  static const String _key = 'access';

  /// Offline, the last read — enough to open what was recorded.
  Future<Cached<FinanceAccess>> access() async {
    try {
      final (plan, tiers) = await (_subscriptions.myPlan(), _subscriptions.tiers()).wait;
      final held = plan.effectiveTier;
      // The tiers come cheapest first: the first that includes them is the
      // one to point at.
      final from = [for (final t in tiers) if (t.includesFinance) t].firstOrNull;
      final access = FinanceAccess(
        tier: held,
        periodEnd: held == SubscriptionTier.gratuit ? null : plan.periodEnd,
        includesFinance: tiers.any((t) => t.tier == held && t.includesFinance),
        includedFromTier: from?.tier,
        includedFromPrice: from?.monthlyPrice,
      );
      await _cache.put(StorageKeys.financeBox, _key, access.toCache());
      return Cached(access);
    } catch (error) {
      final cached = FinanceAccess.fromCache(_cache.get(StorageKeys.financeBox, _key));
      if (cached == null) Error.throwWithStackTrace(error, StackTrace.current);
      return Cached(cached, fromCache: true);
    }
  }
}
