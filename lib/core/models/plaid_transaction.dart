import 'package:flutter/foundation.dart';

/// A transaction as returned by the Plaid fetch layer (client DTO). [amount] is
/// in CAD by default; [pending] marks uncleared bank entries.
@immutable
class PlaidTransaction {
  final String transactionId;
  final double amount;
  final String merchantName;
  final String isoCurrencyCode;
  final bool pending;
  final String? category;

  const PlaidTransaction({
    required this.transactionId,
    required this.amount,
    required this.merchantName,
    this.isoCurrencyCode = 'CAD',
    this.pending = false,
    this.category,
  });
}
