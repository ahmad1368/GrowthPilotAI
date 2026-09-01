/// Builds a `mailto:` URI that opens the device's own Mail app with
/// the invite pre-filled (Issue #542, acceptance criteria 3 and 6) —
/// no email service provider/API credentials involved; the user still
/// has to tap Send themselves.
class BuildEmailInviteUri {
  static Uri call(String email, String subject, String message) {
    return Uri(scheme: 'mailto', path: email, queryParameters: {
      'subject': subject,
      'body': message,
    });
  }
}
