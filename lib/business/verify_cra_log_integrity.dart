import 'package:growth_pilot_ai/business/compute_cra_log_checksum.dart';
import 'package:growth_pilot_ai/core/data/entities/cra_transaction_log_entity.dart';

/// Recomputes a log entry's checksum and compares it to the stored
/// value (Issue #428, acceptance criterion 5) — a mismatch means the
/// row was altered or corrupted after logging, since this is the same
/// canonical hash [LogCraTransaction] computed at write time.
class VerifyCraLogIntegrity {
  static bool call(CraTransactionLogEntity entry) {
    final recomputed = ComputeCraLogChecksum.call(
      counterpartyNameEncrypted: entry.counterpartyNameEncrypted,
      amount: entry.amount,
      currency: entry.currency,
      exchangeRateAtSettlement: entry.exchangeRateAtSettlement,
      transactionHash: entry.transactionHash,
      loggedAt: entry.loggedAt,
    );
    return recomputed == entry.checksum;
  }
}
