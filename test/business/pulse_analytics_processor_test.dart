import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/pulse_analytics_processor.dart';
import 'package:growth_pilot_ai/core/enum/pulse_category.dart';

void main() {
  group('PulseAnalyticsProcessor', () {
    test('scales estimated reach with impact and category (Issue #267/#268)', () {
      final result = PulseAnalyticsProcessor.call(
        category: PulseCategory.financialBlocker,
        estimatedImpactCad: 12000,
        helpfulCount: 0,
      );

      expect(result.estimatedPeopleHelped, 12 * 6);
      expect(result.estimatedValueProtectedCad, 12000);
      expect(result.growthScoreEarned, 50);
    });

    test('helpfulCount boosts both reach and value protected', () {
      final result = PulseAnalyticsProcessor.call(
        category: PulseCategory.operationalHazard,
        estimatedImpactCad: 500,
        helpfulCount: 10,
      );

      expect(result.estimatedPeopleHelped, 1 * 4 + 10);
      expect(result.estimatedValueProtectedCad, 1000); // 500 * (1 + 10*0.1)
      expect(result.growthScoreEarned, 15); // 5 + 10
    });

    test('different categories yield different reach multipliers for the same impact', () {
      final financial = PulseAnalyticsProcessor.call(
          category: PulseCategory.financialBlocker, estimatedImpactCad: 1000, helpfulCount: 0);
      final regulatory = PulseAnalyticsProcessor.call(
          category: PulseCategory.regulatoryUpdate, estimatedImpactCad: 1000, helpfulCount: 0);

      expect(financial.estimatedPeopleHelped, greaterThan(regulatory.estimatedPeopleHelped));
    });
  });
}
