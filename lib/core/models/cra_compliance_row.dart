import 'package:growth_pilot_ai/core/enum/tax_category.dart';

/// A decrypted, display/export-ready readout of one
/// [CraTransactionLogEntity] (Issue #428) — decryption and integrity
/// verification happen once in the actions layer, so this model and
/// everything downstream of it stays synchronous and pure.
class CraComplianceRow {
  final DateTime loggedAt;
  final String counterpartyName;
  final double amount;
  final String currency;
  final double exchangeRateAtSettlement;
  final TaxCategory taxCategory;
  final String transactionHash;
  final bool integrityValid;

  const CraComplianceRow({
    required this.loggedAt,
    required this.counterpartyName,
    required this.amount,
    required this.currency,
    required this.exchangeRateAtSettlement,
    required this.taxCategory,
    required this.transactionHash,
    required this.integrityValid,
  });
}
