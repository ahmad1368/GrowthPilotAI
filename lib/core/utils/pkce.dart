import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

/// PKCE (RFC 7636) for the Xero OAuth authorization-code flow. The client keeps
/// the [generateVerifier] secret and sends only the S256 [challengeFor] it, so
/// an intercepted authorization code cannot be exchanged by an attacker.
class Pkce {
  /// A high-entropy, URL-safe code verifier (43 chars from 32 random bytes).
  static String generateVerifier([int byteLength = 32]) {
    final rng = Random.secure();
    final bytes = List<int>.generate(byteLength, (_) => rng.nextInt(256));
    return base64UrlEncode(bytes).replaceAll('=', '');
  }

  /// S256 challenge: BASE64URL( SHA256( ASCII(verifier) ) ), no padding.
  static String challengeFor(String verifier) {
    final digest = sha256.convert(ascii.encode(verifier));
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }
}
