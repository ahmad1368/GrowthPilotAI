import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_commission_tier_band.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

void main() {
  test('classifies up to 100 as upTo100', () {
    expect(ClassifyCommissionTierBand.call(1), CommissionTierBand.upTo100);
    expect(ClassifyCommissionTierBand.call(100), CommissionTierBand.upTo100);
  });

  test('classifies 101 through 10,000 as upTo1000', () {
    expect(ClassifyCommissionTierBand.call(101), CommissionTierBand.upTo1000);
    expect(ClassifyCommissionTierBand.call(1000), CommissionTierBand.upTo1000);
    expect(ClassifyCommissionTierBand.call(10000), CommissionTierBand.upTo1000);
  });

  test('classifies beyond 10,000 as over10000', () {
    expect(ClassifyCommissionTierBand.call(10001), CommissionTierBand.over10000);
  });
}
