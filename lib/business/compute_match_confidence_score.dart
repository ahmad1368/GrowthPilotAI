/// "The Matching Heuristic" (Issue #145): Semantic Similarity 40%,
/// Geospatial Proximity 30%, Reputation & Trust 20%, Capacity/
/// Availability 10% — all inputs already 0-1, so the total is too.
class ComputeMatchConfidenceScore {
  static const notificationThreshold = 0.85;

  static double call({
    required double semanticSimilarity,
    required double geoProximityScore,
    required double reputationScore,
    required double availabilityScore,
  }) {
    return semanticSimilarity * 0.4 +
        geoProximityScore * 0.3 +
        reputationScore * 0.2 +
        availabilityScore * 0.1;
  }
}
