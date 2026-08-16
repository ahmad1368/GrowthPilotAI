import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

/// Overall verification outcome for one AI response (Issue #203) —
/// [overallConfidence] is the worst-case (most severe) result among
/// [extractedAmounts]; [unmatchedAmounts] are the ones a self-
/// correction prompt or UI warning should call out.
@immutable
class ResponseVerification {
  final MatchConfidence overallConfidence;
  final List<double> extractedAmounts;
  final List<double> unmatchedAmounts;

  const ResponseVerification({
    required this.overallConfidence,
    required this.extractedAmounts,
    required this.unmatchedAmounts,
  });

  factory ResponseVerification.verified() => const ResponseVerification(
        overallConfidence: MatchConfidence.exact,
        extractedAmounts: [],
        unmatchedAmounts: [],
      );
}
