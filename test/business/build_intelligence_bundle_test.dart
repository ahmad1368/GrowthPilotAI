import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_intelligence_bundle.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';

void main() {
  group('BuildIntelligenceBundle', () {
    test('scopes the bundle to the requested sector and its radar axes', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: 0.5,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );

      final bundle = BuildIntelligenceBundle.call('AUTOMOTIVE', context);

      expect(bundle.sector, 'AUTOMOTIVE');
      expect(bundle.radarAxisLabels, contains('Mileage'));
      expect(bundle.context, same(context));
    });

    test('falls back to the DEFAULT profile for an unrecognized sector', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: 0.5,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );

      final bundle = BuildIntelligenceBundle.call('NOT_A_REAL_SECTOR', context);

      expect(bundle.sector, 'DEFAULT');
    });

    test('surfaces a highlight for a hidden gem', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.warm,
        pricePosition: 0.05,
        scarcityIndex: 0.1,
        isHiddenGem: true,
      );

      final bundle = BuildIntelligenceBundle.call('ELECTRONICS', context);

      expect(bundle.highlights, contains(contains('Hidden gem')));
    });

    test('produces no highlights for an unremarkable, at-market context', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: 0.5,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );

      final bundle = BuildIntelligenceBundle.call('SERVICES', context);

      expect(bundle.highlights, isEmpty);
    });

    test('caps highlights at 3 even when every signal fires', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.05,
        scarcityIndex: 0.9,
        isHiddenGem: true,
      );

      final bundle = BuildIntelligenceBundle.call('HOME_GOODS', context);

      expect(bundle.highlights.length, lessThanOrEqualTo(3));
    });

    test('a null price position is not treated as a price extreme', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: null,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );

      final bundle = BuildIntelligenceBundle.call('DEFAULT', context);

      expect(bundle.highlights, isEmpty);
    });
  });
}
