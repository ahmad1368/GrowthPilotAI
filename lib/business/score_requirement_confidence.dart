/// Heuristic "AI confidence" for one extraction (Issue #231's
/// "Confidence Indicators... heatmap style"), scored from the strength
/// of the matched modal indicator (Issue #228's [FindRequirementIndicator]) —
/// not a real model's calibrated probability (no ML model exists in this
/// repo; see PR notes).
class ScoreRequirementConfidence {
  static const _scores = {
    'shall': 0.95,
    'must': 0.95,
    'is required to': 0.9,
    'should': 0.7,
    'will': 0.55,
  };

  static double call(String indicator) => _scores[indicator] ?? 0.5;
}
