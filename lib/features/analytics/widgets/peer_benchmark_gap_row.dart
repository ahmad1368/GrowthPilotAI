import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/peer_benchmark_gap.dart';

/// One axis's user-vs-peer gap bar (Issue #363): a background track shows
/// the sector benchmark, an overlay bar shows the merchant's own value.
class PeerBenchmarkGapRow extends StatelessWidget {
  final PeerBenchmarkGap gap;

  const PeerBenchmarkGapRow({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final barColor = gap.isAboveBenchmark ? scheme.primary : scheme.error;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(gap.metricLabel, style: const TextStyle(fontSize: 12)),
              Text(
                '${(gap.userValue * 100).toStringAsFixed(0)}% vs '
                '${(gap.benchmarkValue * 100).toStringAsFixed(0)}% peer avg',
                style: TextStyle(
                    fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: scheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: gap.userValue.clamp(0.0, 1.0),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: barColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
