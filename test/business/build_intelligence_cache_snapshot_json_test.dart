import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_intelligence_cache_snapshot_json.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';

void main() {
  group('BuildIntelligenceCacheSnapshotJson', () {
    test('is byte-identical for two logically identical contexts', () {
      const a = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.1,
        scarcityIndex: 0.4,
        isHiddenGem: true,
      );
      const b = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.1,
        scarcityIndex: 0.4,
        isHiddenGem: true,
      );

      expect(
        BuildIntelligenceCacheSnapshotJson.call(a),
        BuildIntelligenceCacheSnapshotJson.call(b),
      );
    });

    test('differs when a single field differs', () {
      const a = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.1,
        scarcityIndex: 0.4,
        isHiddenGem: true,
      );
      const b = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.2,
        scarcityIndex: 0.4,
        isHiddenGem: true,
      );

      expect(
        BuildIntelligenceCacheSnapshotJson.call(a),
        isNot(BuildIntelligenceCacheSnapshotJson.call(b)),
      );
    });

    test('handles a null price position', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.cold,
        pricePosition: null,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );
      expect(BuildIntelligenceCacheSnapshotJson.call(context), contains('"pricePosition":null'));
    });
  });
}
