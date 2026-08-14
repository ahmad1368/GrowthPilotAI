import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';

/// Aggregates waived commission as a promotional acquisition-cost
/// line for financial reporting (Issue #420, acceptance criterion 5).
class ComputePromotionalWaiverReport {
  static ({int waiverCount, double totalWaivedAmount}) call(List<FeeWaiverRecordEntity> records) {
    final waived = records.where((r) => r.isWaived);
    final total = waived.fold<double>(0, (sum, r) => sum + r.waivedAmount);
    return (waiverCount: waived.length, totalWaivedAmount: total);
  }
}
