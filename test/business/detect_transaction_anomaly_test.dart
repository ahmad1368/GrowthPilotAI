import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_transaction_anomaly.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';

void main() {
  final categoryHistory = List<double>.generate(12, (i) => 300.0 + i);
  final now = DateTime(2026, 1, 1);

  test('flags a 3x-sigma charge as a zScore anomaly', () {
    final anomaly = DetectTransactionAnomaly.call(
      transactionRefId: 'tx-1',
      merchantName: 'Zenith Office Supplies',
      amount: 5000,
      categoryHistory: categoryHistory,
      recentMerchantCharges: const [],
      now: now,
    );

    expect(anomaly, isNotNull);
    expect(anomaly!.type, AnomalyType.zScore);
    expect(anomaly.zScoreValue, greaterThan(3.0));
  });

  test('does not flag a charge within the normal range', () {
    final anomaly = DetectTransactionAnomaly.call(
      transactionRefId: 'tx-2',
      merchantName: 'BC Hydro',
      amount: 305,
      categoryHistory: categoryHistory,
      recentMerchantCharges: const [],
      now: now,
    );

    expect(anomaly, isNull);
  });

  test('never flags before 10 baseline points exist', () {
    final anomaly = DetectTransactionAnomaly.call(
      transactionRefId: 'tx-3',
      merchantName: 'New Vendor',
      amount: 99999,
      categoryHistory: const [100, 100, 100],
      recentMerchantCharges: const [],
      now: now,
    );

    expect(anomaly, isNull);
  });

  test('flags 3+ same-merchant charges within 24h as a velocity anomaly', () {
    final anomaly = DetectTransactionAnomaly.call(
      transactionRefId: 'tx-4',
      merchantName: 'Uber Eats',
      amount: 25,
      categoryHistory: const [],
      recentMerchantCharges: [
        now.subtract(const Duration(hours: 1)),
        now.subtract(const Duration(hours: 5)),
        now.subtract(const Duration(hours: 10)),
      ],
      now: now,
    );

    expect(anomaly, isNotNull);
    expect(anomaly!.type, AnomalyType.velocity);
  });

  test('ignores same-merchant charges outside the 24h velocity window', () {
    final anomaly = DetectTransactionAnomaly.call(
      transactionRefId: 'tx-5',
      merchantName: 'Uber Eats',
      amount: 25,
      categoryHistory: const [],
      recentMerchantCharges: [
        now.subtract(const Duration(hours: 1)),
        now.subtract(const Duration(days: 2)),
        now.subtract(const Duration(days: 3)),
      ],
      now: now,
    );

    expect(anomaly, isNull);
  });

  test('suppresses alerts for an ignored merchant despite an outlier amount',
      () {
    final anomaly = DetectTransactionAnomaly.call(
      transactionRefId: 'tx-6',
      merchantName: 'Zenith Office Supplies',
      amount: 5000,
      categoryHistory: categoryHistory,
      recentMerchantCharges: const [],
      now: now,
      ignoredMerchants: const {'Zenith Office Supplies'},
    );

    expect(anomaly, isNull);
  });
}
