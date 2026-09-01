/// "isHiddenGem: High quality + Low price + Low distance" (Issue #103) —
/// mirrors the issue's own `zScore < -1.5 && distance < 5`. Both
/// thresholds are caller-configurable, since "how far is too far" is
/// category-dependent (the issue's own "Contextual Weighting" note —
/// users drive further for a car than a toaster).
class DetectHiddenGem {
  static bool call(
    double priceZScore,
    double distanceKm, {
    double zScoreThreshold = -1.5,
    double maxDistanceKm = 5.0,
  }) =>
      priceZScore < zScoreThreshold && distanceKm < maxDistanceKm;
}
