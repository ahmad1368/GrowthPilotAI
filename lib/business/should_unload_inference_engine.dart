/// True once the AI screen has been inactive long enough to free the
/// model from RAM (Issue #197's "Lazy Unloading: ...more than 2
/// minutes"). A null [lastActiveAt] (never marked active) means
/// nothing to unload.
class ShouldUnloadInferenceEngine {
  static const inactivityThreshold = Duration(minutes: 2);

  static bool call(DateTime? lastActiveAt, DateTime now) {
    if (lastActiveAt == null) return false;
    return now.difference(lastActiveAt) >= inactivityThreshold;
  }
}
