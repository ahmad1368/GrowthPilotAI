import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';

/// Organic leaderboard ranking heuristic (Issue #408, acceptance
/// criterion 1) — this app has no per-merchant sales/engagement
/// analytics feed, so the admin-set transaction cap (financial scale)
/// and commission rate (activity tier) already on [MerchantConfigEntity]
/// (#338) stand in as the "aggregated financial and engagement
/// metrics", the same reuse-what's-already-logged approach
/// [ComputeMerchantTrustScores] (#347) takes.
class ComputeMerchantRankScore {
  static double call(MerchantConfigEntity config) {
    return config.transactionCapAmount * (1 + config.commissionRatePercent / 100);
  }
}
