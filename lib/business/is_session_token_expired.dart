/// Whether a session's access or refresh token has passed its expiry
/// (Issue #120).
class IsSessionTokenExpired {
  static bool call(DateTime expiresAt, DateTime now) => now.isAfter(expiresAt);
}
