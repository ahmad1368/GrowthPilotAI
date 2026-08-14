/// "Budget Exhaustion" guard (Issue #81 Security note): a user repeating
/// the same query many times can average out independent Laplace noise
/// draws to recover the true value, so cumulative epsilon spend per
/// user/session must be capped, not just per-query.
class IsPrivacyBudgetExhausted {
  static bool call(double totalEpsilonSpent, double maxBudget) =>
      totalEpsilonSpent >= maxBudget;
}
