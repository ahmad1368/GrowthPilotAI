/// "Interac Reference Number entry" (Issue #147 AC) — a real Interac
/// reference is alphanumeric, 6-20 characters; this is a format check
/// only, not real bank verification.
class SubmitInteracReference {
  static final _pattern = RegExp(r'^[A-Za-z0-9]{6,20}$');

  static bool isValid(String reference) => _pattern.hasMatch(reference.trim());
}
