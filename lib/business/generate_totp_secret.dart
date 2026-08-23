import 'dart:math';

/// Generates a cryptographically random 160-bit TOTP secret (Issue
/// #317 feature #3) — the standard length used by Google
/// Authenticator/Authy.
class GenerateTotpSecret {
  static List<int> call() {
    final random = Random.secure();
    return List<int>.generate(20, (_) => random.nextInt(256));
  }
}
