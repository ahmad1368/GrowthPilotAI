import 'package:flutter/foundation.dart';

/// Which metrics/radar axes matter for one product sector (Issue #104
/// scope item 1: "Intelligence Profiles"). [axisWeights] holds the
/// per-axis multipliers from the issue's own "Automotive Mileage has
/// 3x weight" example; unweighted axes default to 1x.
@immutable
class SectorProfile {
  final String sectorId;
  final List<String> primaryMetrics;
  final List<String> radarAxisLabels;
  final Map<String, double> axisWeights;

  const SectorProfile({
    required this.sectorId,
    required this.primaryMetrics,
    required this.radarAxisLabels,
    this.axisWeights = const {},
  });
}
