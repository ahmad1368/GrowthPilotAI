import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/datasources/help_terms_catalog.dart';

void main() {
  group('HelpTermsCatalog', () {
    test('every definition is non-empty plain text', () {
      for (final definition in HelpTermsCatalog.definitions.values) {
        expect(definition.trim(), isNotEmpty);
      }
    });

    test('includes the terms wired into EfficiencyGapBar and RadarComparisonChart', () {
      expect(HelpTermsCatalog.definitions.containsKey('efficiency_score'), isTrue);
      expect(HelpTermsCatalog.definitions.containsKey('market_comparison'), isTrue);
    });
  });
}
