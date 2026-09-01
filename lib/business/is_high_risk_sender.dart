/// "Cross-referencing the user's Strike History" (Issue #152, reuses
/// #124's moderation strikes) — a flagged message from a sender who
/// already has a critical strike is treated as high-risk.
class IsHighRiskSender {
  static bool call({required bool messageFlagged, required bool hasCriticalStrike}) {
    return messageFlagged && hasCriticalStrike;
  }
}
