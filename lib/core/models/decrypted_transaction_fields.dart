import 'package:flutter/foundation.dart';

/// The plaintext recovered from [EncryptedTransactionFields] (Issue
/// #262).
@immutable
class DecryptedTransactionFields {
  final double amount;
  final String description;
  final String? categoryName;

  const DecryptedTransactionFields({
    required this.amount,
    required this.description,
    this.categoryName,
  });
}
