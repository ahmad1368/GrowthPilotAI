import 'dart:math' as math;

import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';

/// "Regional Price Volatility" (Issue #129) — the standard deviation of
/// requested budget midpoints per neighborhood; a high value means
/// wildly inconsistent pricing expectations in that area.
class ComputeRegionalPriceVolatility {
  static List<({String neighborhood, double stdDev})> call(
      List<ProcurementRequestEntity> requests) {
    final byNeighborhood = <String, List<double>>{};
    for (final r in requests) {
      byNeighborhood.putIfAbsent(r.neighborhood, () => []).add((r.budgetMin + r.budgetMax) / 2);
    }
    return byNeighborhood.entries
        .map((e) => (neighborhood: e.key, stdDev: _stdDev(e.value)))
        .toList();
  }

  static double _stdDev(List<double> values) {
    if (values.length < 2) return 0.0;
    final mean = values.reduce((a, b) => a + b) / values.length;
    final variance =
        values.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b) / values.length;
    return math.sqrt(variance);
  }
}
