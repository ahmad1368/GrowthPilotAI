import 'package:growth_pilot_ai/core/enum/performance_tier.dart';

/// Doubles a background-work cadence for low-tier hardware or when the
/// user has enabled Power Saver Mode (Issue #110 AC: "reduce battery
/// consumption ... through increased sync intervals"), leaving mid/high
/// tier devices at their normal cadence.
class ScaleIntervalForPerformanceTier {
  static Duration call(Duration base, PerformanceTier tier, {bool powerSaverEnabled = false}) {
    final throttle = powerSaverEnabled || tier == PerformanceTier.low;
    return throttle ? base * 2 : base;
  }
}
