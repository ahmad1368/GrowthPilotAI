import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_market_temperature.dart';
import 'package:growth_pilot_ai/core/enum/market_temperature.dart';

void main() {
  test('a small peer group is Cold', () {
    expect(ClassifyMarketTemperature.call(5), MarketTemperature.cold);
  });

  test('a mid-sized peer group is Warm', () {
    expect(ClassifyMarketTemperature.call(10), MarketTemperature.warm);
    expect(ClassifyMarketTemperature.call(50), MarketTemperature.warm);
  });

  test('a large peer group is Hot', () {
    expect(ClassifyMarketTemperature.call(51), MarketTemperature.hot);
  });
}
