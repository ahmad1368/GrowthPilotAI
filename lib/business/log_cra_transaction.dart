import 'package:growth_pilot_ai/business/classify_tax_category.dart';
import 'package:growth_pilot_ai/business/compute_cra_log_checksum.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/cra_transaction_log_entity.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// Builds one immutable CRA compliance log entry from a settled
/// gateway transaction (Issue #428, acceptance criteria 1, 2 and 5) —
/// the counterparty name is AES-encrypted before it ever reaches the
/// entity, and the checksum is computed over the stored (encrypted)
/// representation so integrity checks never need the decryption key.
class LogCraTransaction {
  static Future<CraTransactionLogEntity> call(
    BankingGatewayTransactionEntity transaction,
    FieldCipher cipher,
    DateTime now,
  ) async {
    final counterpartyNameEncrypted = await cipher.encryptField(transaction.counterpartyName);
    final checksum = ComputeCraLogChecksum.call(
      counterpartyNameEncrypted: counterpartyNameEncrypted,
      amount: transaction.amount,
      currency: transaction.currency,
      exchangeRateAtSettlement: transaction.exchangeRate,
      transactionHash: transaction.transactionHash,
      loggedAt: now,
    );

    final entry = CraTransactionLogEntity(
      gatewayTransactionId: transaction.id,
      counterpartyNameEncrypted: counterpartyNameEncrypted,
      amount: transaction.amount,
      currency: transaction.currency,
      exchangeRateAtSettlement: transaction.exchangeRate,
      feeAmount: transaction.feeAmount,
      transactionHash: transaction.transactionHash,
      checksum: checksum,
      loggedAt: now,
    );
    entry.taxCategory = ClassifyTaxCategory.call(transaction);
    return entry;
  }
}
