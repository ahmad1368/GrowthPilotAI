/// True once the AI screen has been inactive long enough to free the
/// model from RAM. Issue #197 asked for "more than 2 minutes"; Issue
/// #211 (a near-duplicate of the same lazy-unload requirement) asked
/// for 5 — kept at 2 minutes since that's the value already shipped
/// and tested here, the stricter (more memory-conscious) of the two;
/// reconciling to a different number is a product call, not a code
/// change to make silently. A null [lastActiveAt] (never marked
/// active) means nothing to unload.
class ShouldUnloadInferenceEngine {
  static const inactivityThreshold = Duration(minutes: 2);

  static bool call(DateTime? lastActiveAt, DateTime now) {
    if (lastActiveAt == null) return false;
    return now.difference(lastActiveAt) >= inactivityThreshold;
  }
}
