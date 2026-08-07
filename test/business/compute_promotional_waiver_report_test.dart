import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_promotional_waiver_report.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';

FeeWaiverRecordEntity _record({required bool isWaived, double waivedAmount = 0}) {
  return FeeWaiverRecordEntity(
    orderId: 1,
    merchantName: 'Merchant',
    grossAmount: 100,
    commissionRate: 0.05,
    commissionAmount: 5,
    waivedAmount: waivedAmount,
    isWaived: isWaived,
    recordedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('sums only waived amounts across records', () {
    final records = [
      _record(isWaived: true, waivedAmount: 5),
      _record(isWaived: false),
      _record(isWaived: true, waivedAmount: 8),
    ];

    final report = ComputePromotionalWaiverReport.call(records);

    expect(report.waiverCount, 2);
    expect(report.totalWaivedAmount, closeTo(13.0, 0.001));
  });

  test('no records report zero', () {
    final report = ComputePromotionalWaiverReport.call([]);
    expect(report.waiverCount, 0);
    expect(report.totalWaivedAmount, 0);
  });
}
