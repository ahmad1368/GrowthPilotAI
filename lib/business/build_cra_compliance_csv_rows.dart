import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';

/// Maps decrypted compliance rows to the row shape [ExportStrategy]
/// consumes (Issue #428, acceptance criterion 2).
class BuildCraComplianceCsvRows {
  static List<Map<String, dynamic>> call(List<CraComplianceRow> rows) {
    return [
      for (final r in rows)
        {
          'loggedAt': r.loggedAt,
          'counterpartyName': r.counterpartyName,
          'amount': r.amount,
          'currency': r.currency,
          'exchangeRateAtSettlement': r.exchangeRateAtSettlement,
          'taxCategory': r.taxCategory.name,
          'transactionHash': r.transactionHash,
          'integrityValid': r.integrityValid,
        },
    ];
  }
}
