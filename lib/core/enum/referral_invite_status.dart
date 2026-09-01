/// Lifecycle of one referral invite (Issue #542, acceptance criterion
/// 5) — [expired] codes can no longer be redeemed.
enum ReferralInviteStatus { pending, redeemed, expired }
