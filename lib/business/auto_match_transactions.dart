import 'package:growth_pilot_ai/business/calculate_match_score.dart';
import 'package:growth_pilot_ai/business/find_potential_matches.dart';
import 'package:growth_pilot_ai/business/merge_unified_transactions.dart';
import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';

/// Runs the Issue #69 matching pipeline over every unmatched record once
/// (e.g. on screen load / pull-to-refresh), merging each newly-found pair
/// and returning them so the caller can persist + log the change.
class AutoMatchTransactions {
  static List<(UnifiedTransactionEntity, UnifiedTransactionEntity)> call(
    List<UnifiedTransactionEntity> all,
  ) {
    final merged = <(UnifiedTransactionEntity, UnifiedTransactionEntity)>[];

    for (final tx in all) {
      if (tx.isMerged) continue;
      final match = FindPotentialMatches.call(tx, all);
      if (match == null) continue;

      final score = CalculateMatchScore.call(tx, match);
      tx.matchScore = score;
      match.matchScore = score;
      MergeUnifiedTransactions.call(tx, match);
      merged.add((tx, match));
    }

    return merged;
  }
}
