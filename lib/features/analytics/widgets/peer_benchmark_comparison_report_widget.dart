import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/peer_benchmark_comparison_body.dart';

/// Registers the Vancouver Peer Benchmark Comparison Tool (Issue #363) as
/// a pluggable report widget under id `PEER_BENCHMARK_COMPARISON` (#111).
class PeerBenchmarkComparisonReportWidget extends BaseReportWidget {
  const PeerBenchmarkComparisonReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return PeerBenchmarkComparisonBody(
      user: data['user'] as BusinessCompassMetrics,
      sector: data['sector'] as BusinessCompassMetrics,
    );
  }
}
