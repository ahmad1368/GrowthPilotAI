/// One recorded action in the append-only consent audit trail (Issue
/// #215) — future consent flows (e.g. #540) can add their own values.
///
/// [microphoneMonitoringOptIn]/[microphoneMonitoringOptOut] (Issue #540)
/// back a UI-only mock toggle — no microphone access is requested or
/// implemented anywhere in this app (see PR notes).
enum ConsentAction {
  termsAccepted,
  dataUsageConsentGranted,
  dataUsageConsentRevoked,
  microphoneMonitoringOptIn,
  microphoneMonitoringOptOut,
}
