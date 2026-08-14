import 'package:flutter/foundation.dart';

/// The user's trailing-30-day revenue vs. a regional category benchmark
/// (Issue #359), expressed as a rough "market share" percentage.
@immutable
class BrandPenetrationIndex {
  final double userVolume;
  final double neighborhoodBenchmarkVolume;
  final double indexPercent;

  const BrandPenetrationIndex({
    required this.userVolume,
    required this.neighborhoodBenchmarkVolume,
    required this.indexPercent,
  });
}
