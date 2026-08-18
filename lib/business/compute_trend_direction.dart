import 'package:growth_pilot_ai/core/enum/trend_direction.dart';

/// Compares a KPI's previous value to its current one (Issue #234's
/// `StatCard` trend arrow) — `previous == null` means there's no prior
/// snapshot to compare against yet.
class ComputeTrendDirection {
  static TrendDirection call(double? previous, double current) {
    if (previous == null) return TrendDirection.none;
    if (current > previous) return TrendDirection.up;
    if (current < previous) return TrendDirection.down;
    return TrendDirection.flat;
  }
}
