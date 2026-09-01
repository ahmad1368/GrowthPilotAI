import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';
import 'package:growth_pilot_ai/core/models/warranty_profitability_summary.dart';

/// Aggregates logged warranty claims into a profitability read
/// (Issue #389): coverage revenue collected vs claim payout cost.
class ComputeWarrantyProfitability {
  static WarrantyProfitabilitySummary call(List<WarrantyClaimEntity> claims) {
    final totalCoverageRevenue =
        claims.fold<double>(0, (sum, c) => sum + c.coverageRevenue);
    final totalClaimCost = claims.fold<double>(0, (sum, c) => sum + c.claimCost);
    final netProfit = totalCoverageRevenue - totalClaimCost;

    return WarrantyProfitabilitySummary(
      claimCount: claims.length,
      totalCoverageRevenue: totalCoverageRevenue,
      totalClaimCost: totalClaimCost,
      netProfit: netProfit,
      isProfitable: netProfit >= 0,
    );
  }
}
