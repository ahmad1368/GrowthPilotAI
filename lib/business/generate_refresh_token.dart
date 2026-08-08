import 'dart:math';

/// Cryptographically random opaque refresh token (Issue #120) — a
/// UUID-like random hex string, matching the issue's "Refresh Token
/// (JWT/UUID)" option.
class GenerateRefreshToken {
  static String call() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
