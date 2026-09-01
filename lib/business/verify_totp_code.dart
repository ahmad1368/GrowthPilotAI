import 'package:growth_pilot_ai/business/generate_totp_code.dart';

/// Verifies a user-entered TOTP code with a ±1 step tolerance (Issue
/// #317 feature #3) — standard authenticator-app practice, so a phone
/// slightly out of clock sync doesn't lock the user out.
class VerifyTotpCode {
  static bool call(List<int> secretBytes, String enteredCode, DateTime now) {
    for (final stepOffset in [0, -1, 1]) {
      final at = now.add(Duration(seconds: stepOffset * GenerateTotpCode.period));
      if (GenerateTotpCode.call(secretBytes, at) == enteredCode) return true;
    }
    return false;
  }
}
