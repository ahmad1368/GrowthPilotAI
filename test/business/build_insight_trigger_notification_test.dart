import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_insight_trigger_notification.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';
import 'package:growth_pilot_ai/core/models/distilled_context.dart';

void main() {
  group('BuildInsightTriggerNotification', () {
    test('links the notification back to the item and sector', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.02,
        scarcityIndex: 0.1,
        isHiddenGem: true,
      );

      final notification = BuildInsightTriggerNotification.call('item-1', 'AUTOMOTIVE', context);

      expect(notification.metadataRefType, 'IntelligenceItem');
      expect(notification.metadataRefId, 'item-1');
      expect(notification.title, contains('AUTOMOTIVE'));
    });

    test('never includes a raw price or exact address in the body', () {
      const context = DistilledContext(
        marketTemperature: MarketTemperature.hot,
        pricePosition: 0.02,
        scarcityIndex: 0.1,
        isHiddenGem: false,
      );

      final notification = BuildInsightTriggerNotification.call('item-2', 'ELECTRONICS', context);

      expect(notification.body, isNot(contains('\$')));
      expect(notification.body, contains('ELECTRONICS'));
    });
  });
}
