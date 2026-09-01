import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:growth_pilot_ai/core/utils/string_similarity.dart';

/// Level 2 of the mapping engine (Issue #57): when no user rule matches,
/// find the Chart-of-Accounts entry whose name is closest to the raw
/// category (e.g. Plaid's "Food & Drink" vs. QBO's "Meals & Entertainment").
class AccountFuzzyMatcher {
  static ({ChartOfAccount? account, double confidence}) findBestMatch(
    String rawCategory,
    List<ChartOfAccount> accounts,
  ) {
    ChartOfAccount? best;
    var bestScore = 0.0;
    for (final account in accounts) {
      final score = StringSimilarity.compare(rawCategory, account.accountName);
      if (score > bestScore) {
        bestScore = score;
        best = account;
      }
    }
    return (account: best, confidence: bestScore);
  }
}
