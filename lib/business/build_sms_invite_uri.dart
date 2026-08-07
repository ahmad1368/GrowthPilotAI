/// Builds an `sms:` URI that opens the device's own Messages app with
/// the invite pre-filled (Issue #542, acceptance criteria 3 and 6) —
/// no SMS gateway/API credentials involved; the user still has to tap
/// Send themselves, which is what keeps this compliant with anti-spam
/// rules rather than an automated backend blast.
class BuildSmsInviteUri {
  static Uri call(String phoneNumber, String message) {
    return Uri(scheme: 'sms', path: phoneNumber, queryParameters: {'body': message});
  }
}
