/// One recorded action in the append-only consent audit trail (Issue
/// #215) — future consent flows (e.g. #540) can add their own values.
enum ConsentAction { termsAccepted, dataUsageConsentGranted, dataUsageConsentRevoked }
