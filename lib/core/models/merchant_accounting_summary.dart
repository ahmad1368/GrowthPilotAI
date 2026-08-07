/// One merchant's aggregated bookkeeping readout (Issue #427,
/// acceptance criterion 1) — fees charged, fees waived, payouts
/// settled, simulated tax withholding, and the platform's resulting
/// net earnings, combined from the commission (#425), fee-waiver
/// (#420), and banking-gateway (#421-423) ledgers.
class MerchantAccountingSummary {
  final String merchantName;
  final double totalFees;
  final double totalWaived;
  final double totalPayouts;
  final double taxDeduction;
  final double netEarnings;

  const MerchantAccountingSummary({
    required this.merchantName,
    required this.totalFees,
    required this.totalWaived,
    required this.totalPayouts,
    required this.taxDeduction,
    required this.netEarnings,
  });
}
