import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

/// A numeric `confidence_score` for a logged hallucination event (Issue
/// #210) — #203's [MatchConfidence] is a 3-way enum, not a score, so
/// this maps it onto a simple 0.0-1.0 scale.
class ComputeConfidenceScore {
  static double call(MatchConfidence confidence) => switch (confidence) {
        MatchConfidence.exact => 1.0,
        MatchConfidence.fuzzy => 0.5,
        MatchConfidence.mismatch => 0.0,
      };
}
