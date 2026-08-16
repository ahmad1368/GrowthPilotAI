/// Whether the user must be asked to explicitly agree to the ~2GB model
/// download before it starts (Issue #196 "Consent" requirement, tied to
/// Issue #183's data-charges consent pattern) — a user who has already
/// consented on this device is never re-prompted.
class ShouldPromptDownloadConsent {
  static bool call(bool hasConsented) => !hasConsented;
}
