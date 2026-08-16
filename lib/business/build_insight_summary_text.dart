import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

/// Plain-English summary of a query's real result (Issue #261's
/// `aiSummary`) — built from the actual filtered total, never a
/// model-generated guess, so it can't drift from the underlying data.
class BuildInsightSummaryText {
  static String call(QueryIntent intent, List<TransactionEntity> results, double total) {
    if (results.isEmpty) return "You have no matching transactions.";
    final subject = intent.category != null ? 'on ${intent.category}' : 'in total';
    return "You spent \$${total.toStringAsFixed(2)} $subject across ${results.length} "
        "transaction${results.length == 1 ? '' : 's'}.";
  }
}
