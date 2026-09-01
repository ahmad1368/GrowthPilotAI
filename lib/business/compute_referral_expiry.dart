/// Time-limited activation window for a referral code (Issue #542,
/// acceptance criterion 5) — creates urgency to redeem the offer.
class ComputeReferralExpiry {
  static const validityWindow = Duration(days: 7);

  static DateTime call(DateTime issuedAt) => issuedAt.add(validityWindow);
}
