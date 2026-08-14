/// "Reputation & Trust" input (Issue #145: "factors in the Trust Score
/// (#135) and KYC Verification Status (#144)") — combines the #125
/// Bayesian rating (0-5, scaled to 0-1) with a flat KYC bonus, capped
/// at 1.0. The full #135 pipeline needs account-longevity/response-
/// velocity context a matching function shouldn't have to gather, so
/// this uses its two most directly relevant inputs instead.
class ComputeReputationScore {
  static const kycBonus = 0.15;

  static double call({required double bayesianRating, required bool isKycVerified}) {
    final base = bayesianRating / 5;
    final withBonus = base + (isKycVerified ? kycBonus : 0.0);
    return withBonus.clamp(0.0, 1.0);
  }
}
