import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:growth_pilot_ai/core/models/branch_performance_summary.dart';

/// Aggregates logged supervised-branch snapshots into a ranked drill-down
/// list (Issue #400) — this app has no multi-tenant backend/enterprise
/// account model, so each branch's totals are logged manually and
/// compared against the combined enterprise total instead.
class ComputeMultiMerchantOverview {
  static List<BranchPerformanceSummary> call(List<MerchantBranchEntity> branches) {
    final totalSales = branches.fold<double>(0, (sum, b) => sum + b.salesTotal);

    final results = branches.map((b) {
      final share = totalSales == 0
          ? 0.0
          : double.parse((b.salesTotal / totalSales * 100).toStringAsFixed(2));

      return BranchPerformanceSummary(
        branchName: b.branchName,
        salesTotal: b.salesTotal,
        inventoryStatus: b.inventoryStatus,
        salesSharePercent: share,
        reportedAt: b.reportedAt,
      );
    }).toList();

    results.sort((a, b) => b.salesTotal.compareTo(a.salesTotal));
    return results;
  }
}
