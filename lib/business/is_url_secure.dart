/// TLS-enforcement guard (Issue #185) — rejects any non-`https://`
/// endpoint URL. This repo has no network client yet to wire this into
/// (see docs/security/encryption.md); it exists so the first real one
/// added can't silently point at a plaintext `http://` endpoint.
class IsUrlSecure {
  static bool call(String url) => url.startsWith('https://');
}
