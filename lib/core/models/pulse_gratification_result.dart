/// The "instant gratification" feedback shown right after submitting
/// an OmniPulse report (Issue #267/#268: "Your alert helped 47
/// financial managers protect an estimated $12,000") —
/// `PulseAnalyticsProcessor`'s output.
class PulseGratificationResult {
  final int estimatedPeopleHelped;
  final double estimatedValueProtectedCad;
  final int growthScoreEarned;

  const PulseGratificationResult({
    required this.estimatedPeopleHelped,
    required this.estimatedValueProtectedCad,
    required this.growthScoreEarned,
  });
}
