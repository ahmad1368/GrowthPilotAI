import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_price_deal.dart';
import 'package:growth_pilot_ai/core/enum/price_deal_tier.dart';

void main() {
  test('an index 15% or more below baseline is a great deal', () {
    expect(ClassifyPriceDeal.call(1.20), PriceDealTier.greatDeal);
    expect(ClassifyPriceDeal.call(1.15), PriceDealTier.greatDeal);
  });

  test('an index 15% or more above baseline is overpriced', () {
    expect(ClassifyPriceDeal.call(0.80), PriceDealTier.overpriced);
    expect(ClassifyPriceDeal.call(0.85), PriceDealTier.overpriced);
  });

  test('anything in between is a fair price', () {
    expect(ClassifyPriceDeal.call(1.0), PriceDealTier.fairPrice);
    expect(ClassifyPriceDeal.call(0.95), PriceDealTier.fairPrice);
  });
}
