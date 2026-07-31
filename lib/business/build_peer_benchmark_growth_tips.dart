import 'package:growth_pilot_ai/core/models/peer_benchmark_gap.dart';

/// Rule-based growth tip per axis where the merchant trails the sector
/// peer average (Issue #363) — not a literal top-performer-derived
/// recommendation, since no anonymized peer dataset exists in this repo.
class BuildPeerBenchmarkGrowthTips {
  static const _tips = {
    'Liquidity': 'Build up cash reserves to cover more operating expenses.',
    'Burn Velocity': 'Slow discretionary spending to extend your runway.',
    'Vendor Diversity': 'Onboard additional suppliers to reduce vendor risk.',
    'Punctuality': 'Automate bill payments to avoid late-payment penalties.',
    'Profit Margin': 'Review pricing or cost of goods to widen margins.',
  };

  static List<String> call(List<PeerBenchmarkGap> gaps) => [
        for (final gap in gaps)
          if (!gap.isAboveBenchmark && _tips.containsKey(gap.metricLabel))
            _tips[gap.metricLabel]!,
      ];
}
