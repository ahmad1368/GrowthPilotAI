import 'package:growth_pilot_ai/business/build_insight_summary_text.dart';
import 'package:growth_pilot_ai/business/compute_kpi_total.dart';
import 'package:growth_pilot_ai/business/determine_visual_hint.dart';
import 'package:growth_pilot_ai/business/filter_transactions_by_intent.dart';
import 'package:growth_pilot_ai/business/parse_query_intent.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/ai_insight_response.dart';

/// "Insight Engine" entry point (Issue #261) — turns a raw query string
/// into an [AiInsightResponse] against on-device data only, combining
/// [ParseQueryIntent] (Issue #199's keyword-based parser, not a real LLM;
/// see PR notes), [FilterTransactionsByIntent], [DetermineVisualHint], and
/// [BuildInsightSummaryText].
class BuildAiInsightResponse {
  static AiInsightResponse call(
      String query, List<TransactionEntity> allTransactions, DateTime now) {
    final intent = ParseQueryIntent.call(query, now);
    final results = FilterTransactionsByIntent.call(allTransactions, intent);
    final total = ComputeKpiTotal.call(results);

    return AiInsightResponse(
      queryParameters: intent,
      visualHint: DetermineVisualHint.call(intent, results),
      aiSummary: BuildInsightSummaryText.call(intent, results, total),
    );
  }
}
