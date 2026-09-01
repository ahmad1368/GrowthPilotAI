import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/insight_visual_hint.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

/// "Data-to-Visual Mapper" (Issue #261, section 2) — a rule-based
/// heuristic, not an LLM decision (no LLM backend exists in this repo;
/// see PR notes): a range spanning multiple days reads as a trend ->
/// chart; a single matching result reads as a total -> KPI; anything
/// else is a browsable set -> list.
class DetermineVisualHint {
  static InsightVisualHint call(QueryIntent intent, List<TransactionEntity> results) {
    final start = intent.rangeStart;
    final end = intent.rangeEnd;
    if (start != null && end != null && end.difference(start).inDays > 1) {
      return InsightVisualHint.chart;
    }
    if (results.length <= 1) return InsightVisualHint.kpi;
    return InsightVisualHint.list;
  }
}
