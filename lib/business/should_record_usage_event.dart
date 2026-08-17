/// Whether a local usage event may be logged (Issue #539) — gated on the
/// same data-usage consent #215 already tracks, so this feature can
/// never log anything the user hasn't agreed to.
class ShouldRecordUsageEvent {
  static bool call(bool dataUsageConsent) => dataUsageConsent;
}
