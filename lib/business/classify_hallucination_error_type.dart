import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

/// The `error_type` label for a logged hallucination event (Issue
/// #210) — only "Numeric_Mismatch" is achievable since #203's
/// Verification Engine only checks currency figures, not dates (see
/// that issue's own PR notes); null when the response wasn't actually
/// flagged.
class ClassifyHallucinationErrorType {
  static String? call(MatchConfidence confidence) =>
      confidence == MatchConfidence.exact ? null : 'Numeric_Mismatch';
}
