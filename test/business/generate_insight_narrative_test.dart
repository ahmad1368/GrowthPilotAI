import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_insight_narrative.dart';
import 'package:growth_pilot_ai/core/enum/insight_narrative_type.dart';

void main() {
  test('cheap and close selects Value Discovery', () {
    expect(GenerateInsightNarrative.call(10, 10).type, InsightNarrativeType.valueDiscovery);
  });

  test('very cheap but far selects Convenience Trade-off', () {
    expect(
        GenerateInsightNarrative.call(10, 80).type, InsightNarrativeType.convenienceTradeOff);
  });

  test('expensive but very close selects High Demand Warning', () {
    expect(GenerateInsightNarrative.call(90, 10).type, InsightNarrativeType.highDemandWarning);
  });

  test('expensive and far selects Premium Pick', () {
    expect(GenerateInsightNarrative.call(90, 90).type, InsightNarrativeType.premiumPick);
  });

  test('mid-range price and distance selects Balanced Match', () {
    expect(GenerateInsightNarrative.call(50, 50).type, InsightNarrativeType.balancedMatch);
  });

  test('anything else falls back to Market Competitive', () {
    expect(GenerateInsightNarrative.call(35, 35).type, InsightNarrativeType.marketCompetitive);
  });

  test('is deterministic: the same inputs always select the same narrative', () {
    final a = GenerateInsightNarrative.call(10, 10);
    final b = GenerateInsightNarrative.call(10, 10);
    expect(a.type, b.type);
    expect(a.text, b.text);
  });

  test('the narrative text never contains a dollar amount', () {
    final narrative = GenerateInsightNarrative.call(10, 10);
    expect(narrative.text, isNot(contains('\$')));
  });
}
