/// Invitation text embedding the referral code and its expiry (Issue
/// #542, acceptance criteria 2 and 5) — shared text for the SMS,
/// email, and share-sheet channels.
class BuildReferralInviteMessage {
  static String call(String appName, String referralCode, DateTime expiresAt) {
    final expiryDate = '${expiresAt.year}-${expiresAt.month.toString().padLeft(2, '0')}-'
        '${expiresAt.day.toString().padLeft(2, '0')}';
    return "Hey! I'm using $appName to run my business — join with my code "
        '$referralCode and we both get 10% off. Offer expires $expiryDate: '
        'https://growthpilot.ai/invite?code=$referralCode';
  }
}
