import 'package:growth_pilot_ai/business/compute_tax_deduction.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';
import 'package:growth_pilot_ai/core/models/merchant_accounting_summary.dart';

/// Aggregates fees, waivers, and settled payouts per merchant into a
/// bookkeeping-ready summary (Issue #427, acceptance criterion 1).
class ComputeAccountingSummary {
  static List<MerchantAccountingSummary> call({
    required List<CommissionTierRecordEntity> commissionRecords,
    required List<FeeWaiverRecordEntity> waiverRecords,
    required List<BankingGatewayTransactionEntity> gatewayTransactions,
  }) {
    final merchants = <String>{
      ...commissionRecords.map((r) => r.merchantName),
      ...waiverRecords.map((r) => r.merchantName),
      ...gatewayTransactions.map((t) => t.merchantName),
    };

    return merchants.map((name) {
      final settledGateway = gatewayTransactions
          .where((t) => t.merchantName == name && t.status == GatewayTransactionStatus.settled);
      final fees = commissionRecords
              .where((r) => r.merchantName == name)
              .fold<double>(0, (sum, r) => sum + r.commissionAmount) +
          waiverRecords
              .where((r) => r.merchantName == name && !r.isWaived)
              .fold<double>(0, (sum, r) => sum + r.commissionAmount) +
          settledGateway.fold<double>(0, (sum, t) => sum + t.feeAmount);
      final waived = waiverRecords
          .where((r) => r.merchantName == name && r.isWaived)
          .fold<double>(0, (sum, r) => sum + r.waivedAmount);
      final payouts = settledGateway.fold<double>(0, (sum, t) => sum + (t.amount - t.feeAmount));
      final tax = ComputeTaxDeduction.call(fees);

      return MerchantAccountingSummary(
        merchantName: name,
        totalFees: fees,
        totalWaived: waived,
        totalPayouts: payouts,
        taxDeduction: tax,
        netEarnings: fees - tax,
      );
    }).toList();
  }
}
