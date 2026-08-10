import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/insight_narrative_type.dart';

/// One selected narrative from [GenerateInsightNarrative] (Issue #101).
@immutable
class InsightNarrative {
  final InsightNarrativeType type;
  final String text;

  const InsightNarrative({required this.type, required this.text});
}
