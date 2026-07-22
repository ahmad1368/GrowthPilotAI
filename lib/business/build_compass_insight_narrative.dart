import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';

/// Turns the gap between the user's Business Compass vector and the sector
/// benchmark into one human-readable sentence (Issue #111's `INSIGHT_TEXT`
/// report widget), naming the axis where the user trails the most.
class BuildCompassInsightNarrative {
  static String call(
      BusinessCompassMetrics user, BusinessCompassMetrics sector) {
    final userValues = user.toList();
    final sectorValues = sector.toList();

    var worstIndex = 0;
    var worstGap = 0.0;
    for (var i = 0; i < userValues.length; i++) {
      final gap = sectorValues[i] - userValues[i];
      if (gap > worstGap) {
        worstGap = gap;
        worstIndex = i;
      }
    }

    if (worstGap <= 0) {
      return "You're at or above the sector benchmark on every axis.";
    }

    final label = BusinessCompassMetrics.labels[worstIndex];
    final userPct = (userValues[worstIndex] * 100).toStringAsFixed(0);
    final sectorPct = (sectorValues[worstIndex] * 100).toStringAsFixed(0);
    return 'Your biggest gap vs. the sector is $label: $userPct% vs. a '
        '$sectorPct% benchmark.';
  }
}
