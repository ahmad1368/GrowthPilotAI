import 'package:growth_pilot_ai/business/insight_narrative_templates.dart';
import 'package:growth_pilot_ai/core/enum/insight_narrative_type.dart';
import 'package:growth_pilot_ai/core/models/insight_narrative.dart';

/// "Data-to-Narrative Pipeline" (Issue #101): a deterministic decision
/// table over #96's price/distance percentiles — same inputs always
/// select the same [InsightNarrativeType] (AC: "Deterministic"), first
/// matching rule wins, falling back to [InsightNarrativeType.marketCompetitive].
class GenerateInsightNarrative {
  static InsightNarrative call(int pricePercentile, int distancePercentile) {
    final type = _select(pricePercentile, distancePercentile);
    return InsightNarrative(type: type, text: insightNarrativeTemplates[type]!);
  }

  static InsightNarrativeType _select(int price, int distance) {
    if (price < 20 && distance < 30) return InsightNarrativeType.valueDiscovery;
    if (price < 15 && distance >= 70) return InsightNarrativeType.convenienceTradeOff;
    if (price >= 80 && distance < 20) return InsightNarrativeType.highDemandWarning;
    if (price >= 80 && distance >= 70) return InsightNarrativeType.premiumPick;
    if (price >= 40 && price <= 60 && distance >= 40 && distance <= 60) {
      return InsightNarrativeType.balancedMatch;
    }
    return InsightNarrativeType.marketCompetitive;
  }
}
