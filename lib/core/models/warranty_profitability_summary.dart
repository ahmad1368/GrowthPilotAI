import 'package:flutter/foundation.dart';

/// Aggregate profitability of logged warranty/service claims (Issue #389).
@immutable
class WarrantyProfitabilitySummary {
  final int claimCount;
  final double totalCoverageRevenue;
  final double totalClaimCost;
  final double netProfit;
  final bool isProfitable;

  const WarrantyProfitabilitySummary({
    required this.claimCount,
    required this.totalCoverageRevenue,
    required this.totalClaimCost,
    required this.netProfit,
    required this.isProfitable,
  });
}
