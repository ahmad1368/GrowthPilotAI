import 'package:flutter/foundation.dart';

/// One Business Compass axis compared against the Vancouver sector peer
/// average (Issue #363). [gap] is user minus benchmark — positive means
/// the merchant is at or above peer performance on this axis.
@immutable
class PeerBenchmarkGap {
  final String metricLabel;
  final double userValue;
  final double benchmarkValue;
  final double gap;
  final bool isAboveBenchmark;

  const PeerBenchmarkGap({
    required this.metricLabel,
    required this.userValue,
    required this.benchmarkValue,
    required this.gap,
    required this.isAboveBenchmark,
  });
}
