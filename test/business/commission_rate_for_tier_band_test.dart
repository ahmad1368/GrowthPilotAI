import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/commission_rate_for_tier_band.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

void main() {
  test('maps each band to its published rate', () {
    expect(CommissionRateForTierBand.call(CommissionTierBand.upTo100), 0.0002);
    expect(CommissionRateForTierBand.call(CommissionTierBand.upTo1000), 0.0001);
    expect(CommissionRateForTierBand.call(CommissionTierBand.over10000), 0.0005);
  });
}
