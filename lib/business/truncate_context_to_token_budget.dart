import 'package:growth_pilot_ai/business/estimate_token_count.dart';
import 'package:growth_pilot_ai/core/models/context_record.dart';

/// Keeps adding [records] (already ranked, most relevant first) until
/// the next one would push the estimated token count over [maxTokens]
/// (Issue #199's "~1000 tokens" Context Window Management AC).
class TruncateContextToTokenBudget {
  static List<ContextRecord> call(List<ContextRecord> records, int maxTokens) {
    final kept = <ContextRecord>[];
    var tokens = 0;
    for (final record in records) {
      final rowTokens = EstimateTokenCount.call(
          '${record.date}|${record.merchant}|${record.amount}|${record.category}');
      if (tokens + rowTokens > maxTokens) break;
      kept.add(record);
      tokens += rowTokens;
    }
    return kept;
  }
}
