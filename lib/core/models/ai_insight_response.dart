import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/insight_visual_hint.dart';
import 'package:growth_pilot_ai/core/models/query_intent.dart';

/// Result of running one natural-language query through the on-device
/// Insight Engine (Issue #261) — mirrors the issue's `AIInsightResponse`
/// shape. [aiSummary] is generated from the real filtered/summed
/// transaction data, never a hallucinated figure (AC: "AI Summary text
/// accurately reflects the underlying ObjectBox data").
@immutable
class AiInsightResponse {
  final QueryIntent queryParameters;
  final InsightVisualHint visualHint;
  final String aiSummary;

  const AiInsightResponse({
    required this.queryParameters,
    required this.visualHint,
    required this.aiSummary,
  });
}
