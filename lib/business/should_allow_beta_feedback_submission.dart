/// "Limit feedback submissions to 5 per user/day to prevent spam"
/// (Issue #169 AC) — a pure capacity check against today's already-
/// submitted count.
class ShouldAllowBetaFeedbackSubmission {
  static const dailyLimit = 5;

  static bool call(int submittedToday) => submittedToday < dailyLimit;
}
