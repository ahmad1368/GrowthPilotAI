import 'package:growth_pilot_ai/core/data/entities/unified_transaction_entity.dart';
import 'package:growth_pilot_ai/core/utils/string_similarity.dart';

/// Weighted duplicate-match score (0.0-1.0) between a Plaid bank feed
/// record and an accounting-software record (Issue #69): exact amount
/// (0.5) + date proximity within 1-3 days (0.3) + merchant-name similarity
/// (0.2, via the Issue #57 [StringSimilarity] utility).
class CalculateMatchScore {
  static double call(UnifiedTransactionEntity a, UnifiedTransactionEntity b) {
    var score = 0.0;
    if (a.amount == b.amount) score += 0.5;

    final dayDiff = a.date.difference(b.date).inDays.abs();
    if (dayDiff <= 1) {
      score += 0.3;
    } else if (dayDiff <= 3) {
      score += 0.15;
    }

    score += StringSimilarity.compare(a.merchantName, b.merchantName) * 0.2;
    return score;
  }
}
