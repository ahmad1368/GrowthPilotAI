import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_type.dart';

/// Applies a merchant's defined commission structure to a transaction
/// amount (Issue #348, acceptance criterion 2) — the automatic
/// enforcement point any transaction-calculation flow should call
/// instead of assuming a flat platform-wide rate.
class ComputeCommissionForTransaction {
  static double call(MerchantConfigEntity config, double transactionAmount) {
    return switch (config.commissionType) {
      CommissionType.percentage => transactionAmount * config.commissionRatePercent / 100,
      CommissionType.fixedAmount => config.commissionFixedAmount,
    };
  }
}
