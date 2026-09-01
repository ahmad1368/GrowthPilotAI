import 'package:growth_pilot_ai/business/hash_refresh_token.dart';

/// Verifies a raw refresh token against its stored hash (Issue #120)
/// — the raw token itself is never persisted, only compared by hash.
class VerifyRefreshToken {
  static bool call(String rawToken, String storedHash) => HashRefreshToken.call(rawToken) == storedHash;
}
