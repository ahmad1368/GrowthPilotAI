/// [Issue #788] Secure-storage key(s) shared between [LoginController] and
/// [RegisterController] so both agree on how the "logged in" flag is
/// persisted, instead of duplicating the raw string literal in two places.
class AuthStorageKeys {
  static const isLoggedIn = 'is_logged_in';
}
