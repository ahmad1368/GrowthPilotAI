import 'dart:convert';
import 'dart:math';

/// Cryptographically secure OAuth 2.0 `state` values for CSRF protection.
/// [generate] uses [Random.secure] (web-safe); [verify] guards the callback.
class OAuthState {
  static String generate([int byteLength = 32]) {
    final rng = Random.secure();
    final bytes = List<int>.generate(byteLength, (_) => rng.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  /// The state returned by the provider must exactly match the one we issued.
  static bool verify(String returned, String expected) =>
      expected.isNotEmpty && returned == expected;
}
