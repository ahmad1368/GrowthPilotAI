import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/distill_market_context.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';

void main() {
  test('a well-below-market, nearby price is flagged as a hidden gem', () {
    final peerPrices = [for (var i = 0; i < 9; i++) 100.0, 50.0];

    final context = DistillMarketContext.call(50, 2.0, peerPrices);

    expect(context.isHiddenGem, isTrue);
    expect(context.marketTemperature, MarketTemperature.warm);
    expect(context.scarcityIndex, 0.1);
    expect(context.pricePosition, closeTo(0.05, 1e-9));
  });

  test('an at-market price is not a hidden gem', () {
    final peerPrices = List.generate(5, (_) => 100.0);

    final context = DistillMarketContext.call(100, 2.0, peerPrices);

    expect(context.isHiddenGem, isFalse);
    expect(context.marketTemperature, MarketTemperature.cold);
  });

  test('never divides by zero when every peer price is identical', () {
    final peerPrices = List.generate(5, (_) => 100.0);
    expect(() => DistillMarketContext.call(50, 2.0, peerPrices), returnsNormally);
  });
}
