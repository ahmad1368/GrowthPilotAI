import 'package:growth_pilot_ai/business/parse_commission_rate.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/models/adjustment_impact.dart';

/// Derives each commission-structure change's estimated impact on
/// merchant profitability (Issue #349, acceptance criteria 1-2) from
/// the audit trail (#343) — a rate decrease is read as merchants
/// retaining more of each sale, most recent first. Entries with a
/// fixed-amount before/after (no comparable percentage) are skipped.
class ComputeAdjustmentImpacts {
  static List<AdjustmentImpact> call(List<AuditLogEntity> logs) {
    final results = <AdjustmentImpact>[];
    for (final log in logs) {
      if (log.changeType != 'updated commission structure') continue;
      final previousRate = ParseCommissionRate.call(log.previousValue);
      final newRate = ParseCommissionRate.call(log.newValue);
      if (previousRate == null || newRate == null || previousRate == 0) continue;

      final impactPercent = ((previousRate - newRate) / previousRate) * 100;
      results.add(AdjustmentImpact(
        merchantName: log.targetMerchant,
        previousRatePercent: previousRate,
        newRatePercent: newRate,
        impactPercent: double.parse(impactPercent.toStringAsFixed(2)),
        timestamp: log.timestamp,
      ));
    }

    results.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return results;
  }
}
