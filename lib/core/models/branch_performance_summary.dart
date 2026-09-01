import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';

/// One logged branch's supervisory read (Issue #400): its share of total
/// sales across all supervised branches, for drill-down ranking on the
/// master dashboard.
class BranchPerformanceSummary {
  final String branchName;
  final double salesTotal;
  final BranchInventoryStatus inventoryStatus;
  final double salesSharePercent;
  final DateTime reportedAt;

  const BranchPerformanceSummary({
    required this.branchName,
    required this.salesTotal,
    required this.inventoryStatus,
    required this.salesSharePercent,
    required this.reportedAt,
  });

  bool get needsAttention => inventoryStatus == BranchInventoryStatus.critical;
}
