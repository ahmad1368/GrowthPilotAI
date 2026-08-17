import 'package:flutter/foundation.dart';

/// AES-256 ciphertext for one transaction's sensitive fields (Issue
/// #262) — each string is `iv:ciphertext`, base64-encoded, per
/// [FieldCipher]'s format. [encryptedCategoryName] is null when the
/// transaction has no category.
@immutable
class EncryptedTransactionFields {
  final String encryptedAmount;
  final String encryptedDescription;
  final String? encryptedCategoryName;

  const EncryptedTransactionFields({
    required this.encryptedAmount,
    required this.encryptedDescription,
    this.encryptedCategoryName,
  });
}
