/// Requires typing "DELETE" (Issue #189: App Store 5.1.1(v) account
/// deletion) before the destructive local-data wipe is allowed to run —
/// a single misplaced tap should never be enough.
class IsDeleteConfirmationValid {
  static bool call(String input) => input.trim() == 'DELETE';
}
