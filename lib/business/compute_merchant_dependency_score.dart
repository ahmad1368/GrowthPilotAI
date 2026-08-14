/// Aggregates the four dependency signals into a 0-100 rule-based
/// score (Issue #424, acceptance criterion 3) — order volume and
/// visit frequency contribute proportionally up to a cap, while trial
/// completion and inventory liquidation are milestone thresholds that
/// award full weight once crossed.
class ComputeMerchantDependencyScore {
  static const orderVolumeWeight = 25;
  static const visitFrequencyWeight = 25;
  static const trialWeight = 25;
  static const liquidationWeight = 25;

  static const orderVolumeCapForFullPoints = 20;
  static const visitFrequencyCapForFullPoints = 5.0;
  static const liquidationThresholdPercent = 30.0;

  static int call({
    required int orderVolume,
    required double dailyVisitAverage,
    required bool trialCompleted,
    required double inventoryLiquidationPercent,
  }) {
    final orderPoints =
        (orderVolume / orderVolumeCapForFullPoints).clamp(0, 1) * orderVolumeWeight;
    final visitPoints =
        (dailyVisitAverage / visitFrequencyCapForFullPoints).clamp(0, 1) * visitFrequencyWeight;
    final trialPoints = trialCompleted ? trialWeight : 0;
    final liquidationPoints =
        inventoryLiquidationPercent >= liquidationThresholdPercent ? liquidationWeight : 0;

    return (orderPoints + visitPoints + trialPoints + liquidationPoints).round().clamp(0, 100);
  }
}
