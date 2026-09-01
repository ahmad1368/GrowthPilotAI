import 'package:growth_pilot_ai/business/serialize_amount_for_encryption.dart';
import 'package:growth_pilot_ai/core/models/encrypted_transaction_fields.dart';
import 'package:growth_pilot_ai/core/utils/transaction_field_cipher.dart';

/// AES-256 encrypts one transaction's sensitive fields (Issue #262) via
/// [TransactionFieldCipher]. Operates on plain values, not a live
/// [TransactionEntity] (see PR notes on why the entity itself isn't
/// modified in this PR).
class EncryptTransactionSensitiveFields {
  static Future<EncryptedTransactionFields> call({
    required double amount,
    required String description,
    String? categoryName,
    required TransactionFieldCipher cipher,
  }) async {
    return EncryptedTransactionFields(
      encryptedAmount: await cipher.encryptField(SerializeAmountForEncryption.call(amount)),
      encryptedDescription: await cipher.encryptField(description),
      encryptedCategoryName:
          categoryName == null ? null : await cipher.encryptField(categoryName),
    );
  }
}
