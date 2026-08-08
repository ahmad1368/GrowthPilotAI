/// "Weighted Factor Engine" (Issue #135): Verified Reviews 50%, Response
/// Velocity 20%, Completion Rate 20%, Longevity/Identity 10%, minus a
/// flat penalty per active Strike (#124), clamped to the 0.0-10.0 scale.
class ComputeTrustScore {
  static const strikePenaltyPoints = 1.5;

  static double call({
    required double bayesianRating, // 0-5 scale, from #125
    required double responseVelocityScore, // 0-1
    required double completionScore, // 0-1 — neutral placeholder until #126 exists
    required double longevityScore, // 0-1
    required int activeStrikeCount,
  }) {
    final raw = (bayesianRating / 5) * 10 * 0.5 +
        responseVelocityScore * 10 * 0.2 +
        completionScore * 10 * 0.2 +
        longevityScore * 10 * 0.1 -
        (activeStrikeCount * strikePenaltyPoints);
    return raw.clamp(0.0, 10.0);
  }
}
