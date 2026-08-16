/// True once the chat has been inactive long enough to clear its local
/// UI state (Issue #200 AC: "Session Expiry... after 10 minutes of
/// inactivity to prevent unauthorized access if the phone is left
/// unlocked"). A null [lastActivityAt] (no messages yet) means nothing
/// to clear.
class ShouldClearChatSession {
  static const inactivityThreshold = Duration(minutes: 10);

  static bool call(DateTime? lastActivityAt, DateTime now) {
    if (lastActivityAt == null) return false;
    return now.difference(lastActivityAt) >= inactivityThreshold;
  }
}
