import 'package:growth_pilot_ai/core/enum/insight_narrative_type.dart';

/// The narrative text for each [InsightNarrativeType] (Issue #101 scope
/// item 1) — split out so [GenerateInsightNarrative] stays a short
/// decision table. Anonymity-Safe by construction: only generic
/// percentile-category language, never a specific price or location.
const insightNarrativeTemplates = {
  InsightNarrativeType.valueDiscovery:
      'This is a rare find: priced in the bottom 20% and exceptionally close to your location.',
  InsightNarrativeType.convenienceTradeOff:
      "Maximum savings detected. You're saving significantly on price by looking slightly further afield.",
  InsightNarrativeType.highDemandWarning:
      'High demand nearby: this item is priced above most comparable listings but very convenient to reach.',
  InsightNarrativeType.premiumPick:
      'This item is priced above market average and located further away than most Lower Mainland alternatives.',
  InsightNarrativeType.balancedMatch:
      'A solidly average option on both price and distance for the Lower Mainland.',
  InsightNarrativeType.marketCompetitive:
      'This item is priced competitively for the Lower Mainland area based on current market trends.',
};
