/// "Weighted Factor Engine" (Issue #135): Verified Reviews 50%, Response
/// Velocity 20%, Completion Rate 20%, Longevity/Identity 10%, minus a
/// flat penalty per active Strike (#124), plus a flat KYC
/// [verificationBonus] (Issue #144 AC: "+1.5 boost"), clamped to 0.0-10.0.
class ComputeTrustScore {
  static const strikePenaltyPoints = 1.5;
  static const kycVerificationBonus = 1.5;

  static double call({
    required double bayesianRating, // 0-5 scale, from #125
    required double responseVelocityScore, // 0-1
    required double completionScore, // 0-1 — neutral placeholder until #126 exists
    required double longevityScore, // 0-1
    required int activeStrikeCount,
    double verificationBonus = 0.0,
  }) {
    final raw = (bayesianRating / 5) * 10 * 0.5 +
        responseVelocityScore * 10 * 0.2 +
        completionScore * 10 * 0.2 +
        longevityScore * 10 * 0.1 -
        (activeStrikeCount * strikePenaltyPoints) +
        verificationBonus;
    return raw.clamp(0.0, 10.0);
  }
}
