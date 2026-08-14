import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_merchant_rank_score.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';

MerchantConfigEntity _config({
  double transactionCapAmount = 1000,
  double commissionRatePercent = 5,
}) =>
    MerchantConfigEntity(
      businessName: 'Test Merchant',
      businessId: 'M-1',
      commissionRatePercent: commissionRatePercent,
      transactionCapAmount: transactionCapAmount,
      updatedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('score scales up with a higher transaction cap', () {
    final low = ComputeMerchantRankScore.call(_config(transactionCapAmount: 1000));
    final high = ComputeMerchantRankScore.call(_config(transactionCapAmount: 5000));

    expect(high, greaterThan(low));
  });

  test('score scales up with a higher commission rate', () {
    final low = ComputeMerchantRankScore.call(_config(commissionRatePercent: 2));
    final high = ComputeMerchantRankScore.call(_config(commissionRatePercent: 20));

    expect(high, greaterThan(low));
  });

  test('score is the cap amount weighted by the commission rate', () {
    final result =
        ComputeMerchantRankScore.call(_config(transactionCapAmount: 1000, commissionRatePercent: 10));

    expect(result, 1100); // 1000 * (1 + 10/100)
  });
}
