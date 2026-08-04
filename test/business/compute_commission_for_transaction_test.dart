import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_commission_for_transaction.dart';
import 'package:growth_pilot_ai/business/describe_commission_structure.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_type.dart';

MerchantConfigEntity _config({
  double commissionRatePercent = 5,
  double commissionFixedAmount = 0,
  CommissionType commissionType = CommissionType.percentage,
}) {
  final config = MerchantConfigEntity(
    businessName: 'Acme Foods',
    businessId: 'ACM-001',
    commissionRatePercent: commissionRatePercent,
    commissionFixedAmount: commissionFixedAmount,
    transactionCapAmount: 10000,
    updatedAt: DateTime(2024, 3, 1),
  );
  config.commissionType = commissionType;
  return config;
}

void main() {
  group('ComputeCommissionForTransaction', () {
    test('applies the percentage rate to the transaction amount', () {
      final config = _config(commissionRatePercent: 5);

      expect(ComputeCommissionForTransaction.call(config, 200), closeTo(10, 1e-9));
    });

    test('applies a flat fixed amount regardless of transaction size', () {
      final config =
          _config(commissionType: CommissionType.fixedAmount, commissionFixedAmount: 3);

      expect(ComputeCommissionForTransaction.call(config, 200), 3);
      expect(ComputeCommissionForTransaction.call(config, 5000), 3);
    });
  });

  group('DescribeCommissionStructure', () {
    test('formats a percentage structure', () {
      expect(DescribeCommissionStructure.call(_config(commissionRatePercent: 5)), '5.0%');
    });

    test('formats a fixed-amount structure', () {
      final config =
          _config(commissionType: CommissionType.fixedAmount, commissionFixedAmount: 3);

      expect(DescribeCommissionStructure.call(config), '\$3.0 flat');
    });
  });
}
