import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_peer_benchmark_growth_tips.dart';
import 'package:growth_pilot_ai/business/compute_peer_benchmark_gaps.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/peer_benchmark_gap_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/peer_benchmark_growth_tips_list.dart';

/// Renders the per-axis gap bars and growth tips for the Vancouver Peer
/// Benchmark Comparison Tool (Issue #363).
class PeerBenchmarkComparisonBody extends StatelessWidget {
  final BusinessCompassMetrics user;
  final BusinessCompassMetrics sector;

  const PeerBenchmarkComparisonBody(
      {super.key, required this.user, required this.sector});

  @override
  Widget build(BuildContext context) {
    final gaps = ComputePeerBenchmarkGaps.call(user, sector);
    final tips = BuildPeerBenchmarkGrowthTips.call(gaps);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final gap in gaps) PeerBenchmarkGapRow(gap: gap),
        const SizedBox(height: 8),
        const Text('Growth tips',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        PeerBenchmarkGrowthTipsList(tips: tips),
      ],
    );
  }
}
