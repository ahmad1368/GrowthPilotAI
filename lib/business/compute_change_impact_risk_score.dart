/// "RiskScore: An AI-calculated percentage of how 'disruptive' this
/// change is" (Issue #240) — a disclosed local heuristic (weighted
/// fan-out count), not an AI-calculated score (no LLM/backend exists
/// in this repo; see PR notes).
class ComputeChangeImpactRiskScore {
  static int call({
    required int directGoalCount,
    required int directTestCaseCount,
    required int indirectRequirementCount,
    required int contradictionCount,
  }) {
    final score = (directGoalCount * 15) +
        (directTestCaseCount * 10) +
        (indirectRequirementCount * 8) +
        (contradictionCount * 25);
    return score.clamp(0, 100);
  }
}
