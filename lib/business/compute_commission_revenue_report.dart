import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/models/merchant_commission_summary.dart';

/// Aggregates settlement records into a per-merchant revenue readout
/// (Issue #425, acceptance criterion 3) for the financial reporting
/// dashboard.
class ComputeCommissionRevenueReport {
  static List<MerchantCommissionSummary> call(List<CommissionTierRecordEntity> records) {
    final byMerchant = <String, List<CommissionTierRecordEntity>>{};
    for (final r in records) {
      byMerchant.putIfAbsent(r.merchantName, () => []).add(r);
    }
    return byMerchant.entries.map((entry) {
      final merchantRecords = entry.value;
      final totalCommission = merchantRecords.fold<double>(0, (sum, r) => sum + r.commissionAmount);
      final latest = merchantRecords.reduce((a, b) => a.recordedAt.isAfter(b.recordedAt) ? a : b);
      return MerchantCommissionSummary(
        merchantName: entry.key,
        transactionCount: merchantRecords.length,
        totalCommission: totalCommission,
        currentTierBand: latest.tierBand,
      );
    }).toList();
  }
}
