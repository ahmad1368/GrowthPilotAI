import 'package:growth_pilot_ai/business/log_cra_transaction.dart';
import 'package:growth_pilot_ai/business/verify_cra_log_integrity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';
import 'package:growth_pilot_ai/core/models/cra_compliance_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cra_compliance_repos.dart';

/// Syncs settled gateway transactions into the CRA compliance ledger
/// and decrypts logged rows for display/export (Issue #428, acceptance
/// criteria 1-2 and 5) — split out of [CraComplianceBody].
class CraComplianceActions {
  final CraComplianceRepos repos;

  CraComplianceActions(this.repos);

  Future<void> syncSettledTransactions() async {
    final settled = repos.gatewayTransactions
        .getAll()
        .where((t) => t.status == GatewayTransactionStatus.settled);
    for (final transaction in settled) {
      if (repos.logs.hasLogFor(transaction.id)) continue;
      final entry = await LogCraTransaction.call(transaction, repos.cipher, DateTime.now());
      repos.logs.record(entry);
    }
  }

  Future<List<CraComplianceRow>> loadRows() async {
    final rows = <CraComplianceRow>[];
    for (final entry in repos.logs.getAll()) {
      rows.add(CraComplianceRow(
        loggedAt: entry.loggedAt,
        counterpartyName: await repos.cipher.decryptField(entry.counterpartyNameEncrypted),
        amount: entry.amount,
        currency: entry.currency,
        exchangeRateAtSettlement: entry.exchangeRateAtSettlement,
        taxCategory: entry.taxCategory,
        transactionHash: entry.transactionHash,
        integrityValid: VerifyCraLogIntegrity.call(entry),
      ));
    }
    return rows;
  }
}
