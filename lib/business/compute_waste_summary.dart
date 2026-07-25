import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/models/waste_reason_breakdown.dart';

/// Groups waste-log entries by reason, highest total loss first (Issue
/// #377).
class ComputeWasteSummary {
  static List<WasteReasonBreakdown> call(List<WasteLogEntity> entries) {
    final byReason = <WasteReason, List<WasteLogEntity>>{};
    for (final e in entries) {
      (byReason[e.reason] ??= []).add(e);
    }

    final results = byReason.entries.map((entry) {
      final total = entry.value.fold(0.0, (sum, e) => sum + e.estimatedValue);
      return WasteReasonBreakdown(
        reason: entry.key,
        totalValue: total,
        entryCount: entry.value.length,
      );
    }).toList()
      ..sort((a, b) => b.totalValue.compareTo(a.totalValue));

    return results;
  }
}
