/// Whether the first-launch tour should be shown (Issue #162 AC: "State
/// Persistence" — a user who finished or explicitly skipped it once
/// should never see it again on this device).
class ShouldShowOnboarding {
  static bool call(bool hasCompletedOrSkipped) => !hasCompletedOrSkipped;
}
