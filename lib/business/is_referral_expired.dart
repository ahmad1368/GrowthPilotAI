/// Whether a referral code's activation window has passed (Issue
/// #542, acceptance criterion 5) — an expired code can never be
/// redeemed, regardless of its stored status.
class IsReferralExpired {
  static bool call(DateTime expiresAt, DateTime now) => now.isAfter(expiresAt);
}
