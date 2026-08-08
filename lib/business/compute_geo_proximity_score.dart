/// "Geospatial Proximity" input (Issue #145) — 1.0 at zero distance,
/// linearly decaying to 0.0 at [maxRadiusKm] (the issue's own 25km
/// "Regional Bias" default).
class ComputeGeoProximityScore {
  static const defaultMaxRadiusKm = 25.0;

  static double call(double distanceKm, {double maxRadiusKm = defaultMaxRadiusKm}) {
    if (maxRadiusKm <= 0) return 0.0;
    return (1 - (distanceKm / maxRadiusKm)).clamp(0.0, 1.0);
  }
}
