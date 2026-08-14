import 'package:growth_pilot_ai/core/enum/commission_tier_band.dart';

/// One merchant's aggregated commission-revenue readout (Issue #425,
/// acceptance criterion 3) — transaction counts, fee accumulation, and
/// current tier status for the financial reporting dashboard.
class MerchantCommissionSummary {
  final String merchantName;
  final int transactionCount;
  final double totalCommission;
  final CommissionTierBand currentTierBand;

  const MerchantCommissionSummary({
    required this.merchantName,
    required this.transactionCount,
    required this.totalCommission,
    required this.currentTierBand,
  });
}
