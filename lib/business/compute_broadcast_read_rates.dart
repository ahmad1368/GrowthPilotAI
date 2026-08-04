import 'package:growth_pilot_ai/core/data/entities/emergency_broadcast_entity.dart';
import 'package:growth_pilot_ai/core/models/broadcast_read_rate.dart';

/// Derives each broadcast's read rate among its reported recipients
/// (Issue #345, acceptance criterion 3), most recently dispatched first.
class ComputeBroadcastReadRates {
  static List<BroadcastReadRate> call(List<EmergencyBroadcastEntity> broadcasts) {
    final results = broadcasts.map((b) {
      final readRate = b.recipientCount == 0 ? 0.0 : (b.readCount / b.recipientCount) * 100;
      return BroadcastReadRate(
        id: b.id,
        messageBody: b.messageBody,
        targetNeighborhoods: b.targetNeighborhoods,
        recipientCount: b.recipientCount,
        readCount: b.readCount,
        readRatePercent: double.parse(readRate.toStringAsFixed(2)),
        dispatchedAt: b.dispatchedAt,
      );
    }).toList();

    results.sort((a, b) => b.dispatchedAt.compareTo(a.dispatchedAt));
    return results;
  }
}
