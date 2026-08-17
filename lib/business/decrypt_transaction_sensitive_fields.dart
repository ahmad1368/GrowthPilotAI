import 'package:growth_pilot_ai/business/deserialize_amount_from_encryption.dart';
import 'package:growth_pilot_ai/core/models/decrypted_transaction_fields.dart';
import 'package:growth_pilot_ai/core/models/encrypted_transaction_fields.dart';
import 'package:growth_pilot_ai/core/utils/transaction_field_cipher.dart';

/// Reverses [EncryptTransactionSensitiveFields] (Issue #262).
class DecryptTransactionSensitiveFields {
  static Future<DecryptedTransactionFields> call(
      EncryptedTransactionFields fields, TransactionFieldCipher cipher) async {
    final amountText = await cipher.decryptField(fields.encryptedAmount);
    final description = await cipher.decryptField(fields.encryptedDescription);
    final categoryName = fields.encryptedCategoryName == null
        ? null
        : await cipher.decryptField(fields.encryptedCategoryName!);

    return DecryptedTransactionFields(
      amount: DeserializeAmountFromEncryption.call(amountText),
      description: description,
      categoryName: categoryName,
    );
  }
}
