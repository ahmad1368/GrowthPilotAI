import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_commission_revenue_report.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

CommissionTierRecordEntity _record(String merchant, double amount, DateTime recordedAt) {
  final r = CommissionTierRecordEntity(
    orderId: 1,
    merchantName: merchant,
    cumulativeTransactionCount: 1,
    commissionRate: 0.0002,
    commissionAmount: amount,
    dependencyVerified: true,
    recordedAt: recordedAt,
  );
  r.tierBand = CommissionTierBand.upTo100;
  return r;
}

void main() {
  test('sums commission and counts transactions per merchant', () {
    final records = [
      _record('Alpha', 1.0, DateTime(2026, 1, 1)),
      _record('Alpha', 2.0, DateTime(2026, 1, 2)),
      _record('Beta', 5.0, DateTime(2026, 1, 1)),
    ];
    final report = ComputeCommissionRevenueReport.call(records);
    final alpha = report.firstWhere((r) => r.merchantName == 'Alpha');
    final beta = report.firstWhere((r) => r.merchantName == 'Beta');

    expect(alpha.transactionCount, 2);
    expect(alpha.totalCommission, 3.0);
    expect(beta.transactionCount, 1);
    expect(beta.totalCommission, 5.0);
  });

  test('returns an empty list for no records', () {
    expect(ComputeCommissionRevenueReport.call([]), isEmpty);
  });
}
