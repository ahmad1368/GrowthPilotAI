import 'package:growth_pilot_ai/business/calculate_match_score.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';

/// Finds the best unmatched, cross-source candidate for [newTx] within a
/// 3-day window and auto-merges only above the high-confidence threshold
/// (Issue #69's "> 0.92" rule) — below that, a human should review it.
class FindPotentialMatches {
  static const autoMergeThreshold = 0.92;

  static UnifiedTransactionEntity? call(
    UnifiedTransactionEntity newTx,
    List<UnifiedTransactionEntity> candidates,
  ) {
    UnifiedTransactionEntity? best;
    var bestScore = 0.0;

    for (final candidate in candidates) {
      if (candidate.externalId == newTx.externalId) continue;
      if (candidate.isMerged || candidate.source == newTx.source) continue;
      if (newTx.date.difference(candidate.date).inDays.abs() > 3) continue;

      final score = CalculateMatchScore.call(newTx, candidate);
      if (score > bestScore) {
        bestScore = score;
        best = candidate;
      }
    }

    return bestScore > autoMergeThreshold ? best : null;
  }
}
