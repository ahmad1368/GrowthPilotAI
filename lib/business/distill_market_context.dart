import 'package:growth_pilot_ai/business/classify_market_temperature.dart';
import 'package:growth_pilot_ai/business/compute_percentile_rank.dart';
import 'package:growth_pilot_ai/business/compute_scarcity_index.dart';
import 'package:growth_pilot_ai/business/detect_hidden_gem.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';
import 'package:growth_pilot_ai/core/utils/anomaly_detector.dart';

/// The "Data Distillation" pipeline (Issue #103): boils a peer group of
/// prices down to a [DistilledContext] — reuses [AnomalyDetector]'s
/// mean/standardDeviation (its own `zScore` is absolute-valued, for
/// anomaly flagging; here a *signed* z-score is computed to tell a
/// below-market price from an above-market one) and #96's
/// [ComputePercentileRank], rather than reimplementing the statistics.
class DistillMarketContext {
  static DistilledContext call(
    double targetPrice,
    double targetDistanceKm,
    List<double> peerPrices,
  ) {
    final stdDev = AnomalyDetector.standardDeviation(peerPrices);
    final zScore =
        stdDev == 0 ? 0.0 : (targetPrice - AnomalyDetector.mean(peerPrices)) / stdDev;

    final percentile = ComputePercentileRank.call(targetPrice, peerPrices);

    return DistilledContext(
      marketTemperature: ClassifyMarketTemperature.call(peerPrices.length),
      pricePosition: percentile == null ? null : percentile / 100.0,
      scarcityIndex: ComputeScarcityIndex.call(peerPrices.length),
      isHiddenGem: DetectHiddenGem.call(zScore, targetDistanceKm),
    );
  }
}
