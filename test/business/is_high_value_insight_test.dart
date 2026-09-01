import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_high_value_insight.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';

void main() {
  group('IsHighValueInsight', () {
    test('flags a hidden gem regardless of its price position', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.warm,
        pricePosition: 0.5,
        scarcityIndex: 0.1,
        isHiddenGem: true,
      );
      expect(IsHighValueInsight.call(context), isTrue);
    });

    test('flags an item in the top 5% for value', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: 0.05,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );
      expect(IsHighValueInsight.call(context), isTrue);
    });

    test('does not flag an unremarkable, at-market item', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: 0.5,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );
      expect(IsHighValueInsight.call(context), isFalse);
    });

    test('does not flag when the price position is unavailable', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: null,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );
      expect(IsHighValueInsight.call(context), isFalse);
    });
  });
}
