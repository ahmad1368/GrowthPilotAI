import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_warranty_profitability.dart';
import 'package:growth_pilot_ai/core/data/entities/warranty_claim_entity.dart';

WarrantyClaimEntity _claim(double claimCost, double coverageRevenue) =>
    WarrantyClaimEntity(
      itemName: 'Widget',
      claimCost: claimCost,
      coverageRevenue: coverageRevenue,
      date: DateTime(2024, 1, 1),
    );

void main() {
  group('ComputeWarrantyProfitability', () {
    test('flags the program profitable when coverage revenue exceeds claim cost',
        () {
      final claims = [_claim(100, 150), _claim(50, 80)];

      final summary = ComputeWarrantyProfitability.call(claims);

      expect(summary.claimCount, 2);
      expect(summary.totalClaimCost, 150);
      expect(summary.totalCoverageRevenue, 230);
      expect(summary.netProfit, 80);
      expect(summary.isProfitable, isTrue);
    });

    test('flags the program unprofitable when claim cost exceeds coverage revenue',
        () {
      final claims = [_claim(500, 100)];

      final summary = ComputeWarrantyProfitability.call(claims);

      expect(summary.netProfit, -400);
      expect(summary.isProfitable, isFalse);
    });

    test('handles no claims logged yet', () {
      final summary = ComputeWarrantyProfitability.call(const []);
      expect(summary.claimCount, 0);
      expect(summary.netProfit, 0);
      expect(summary.isProfitable, isTrue);
    });
  });
}
