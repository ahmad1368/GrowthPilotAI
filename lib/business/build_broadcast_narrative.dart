import 'package:growth_pilot_ai/core/models/broadcast_read_rate.dart';

/// One-sentence read naming the most recent broadcast and its read
/// rate (Issue #345).
class BuildBroadcastNarrative {
  static String call(List<BroadcastReadRate> results) {
    if (results.isEmpty) {
      return 'No emergency broadcasts dispatched yet.';
    }
    final latest = results.first;
    return 'Most recent broadcast to ${latest.targetNeighborhoods} reached '
        '${latest.readCount}/${latest.recipientCount} merchants '
        '(${latest.readRatePercent.toStringAsFixed(1)}% read).';
  }
}
