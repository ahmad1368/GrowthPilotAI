import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_accounting_summary.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

void main() {
  test('combines commission, waiver, and settled gateway data per merchant', () {
    final commission = CommissionTierRecordEntity(
      orderId: 1,
      merchantName: 'Alpha',
      cumulativeTransactionCount: 1,
      commissionRate: 0.0002,
      commissionAmount: 10,
      dependencyVerified: true,
      recordedAt: DateTime(2026, 1, 1),
    );
    final waiver = FeeWaiverRecordEntity(
      orderId: 2,
      merchantName: 'Alpha',
      grossAmount: 100,
      commissionRate: 0.05,
      commissionAmount: 0,
      waivedAmount: 5,
      isWaived: true,
      recordedAt: DateTime(2026, 1, 1),
    );
    final gateway = BankingGatewayTransactionEntity(
      dbProvider: 0,
      merchantName: 'Alpha',
      counterpartyName: 'Beta',
      amount: 200,
      currency: 'CAD',
      convertedAmount: 200,
      exchangeRate: 1,
      feeAmount: 8,
      initiatedAt: DateTime(2026, 1, 1),
    );
    gateway.status = GatewayTransactionStatus.settled;

    final summaries = ComputeAccountingSummary.call(
      commissionRecords: [commission],
      waiverRecords: [waiver],
      gatewayTransactions: [gateway],
    );
    final alpha = summaries.single;

    expect(alpha.merchantName, 'Alpha');
    expect(alpha.totalFees, 18);
    expect(alpha.totalWaived, 5);
    expect(alpha.totalPayouts, 192);
    expect(alpha.taxDeduction, 0.9);
    expect(alpha.netEarnings, 17.1);
  });

  test('excludes gateway transactions that never settled', () {
    final gateway = BankingGatewayTransactionEntity(
      dbProvider: 0,
      merchantName: 'Alpha',
      counterpartyName: 'Beta',
      amount: 200,
      currency: 'CAD',
      convertedAmount: 200,
      exchangeRate: 1,
      feeAmount: 8,
      initiatedAt: DateTime(2026, 1, 1),
    );
    final summaries = ComputeAccountingSummary.call(
      commissionRecords: const [],
      waiverRecords: const [],
      gatewayTransactions: [gateway],
    );
    expect(summaries.single.totalPayouts, 0);
    expect(summaries.single.totalFees, 0);
  });
}
