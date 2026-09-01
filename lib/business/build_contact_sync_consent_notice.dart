/// The consent/explanation text shown before contact syncing runs
/// (Issue #541, acceptance criterion 1) — this app has no real
/// system contact-picker permission to request without a native
/// contacts plugin, so this notice is the explicit, honest substitute
/// explaining exactly what the hashing step does with pasted input.
class BuildContactSyncConsentNotice {
  static String call() {
    return "GrowthPilot AI hashes each contact's phone number or email on this "
        'device (SHA-256) before checking for matches — the raw value is never '
        'sent or stored anywhere. You can disable syncing and delete your match '
        'history anytime below.';
  }
}
