import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';

/// Deposits buyer funds into a new held escrow account (Issue #415,
/// acceptance criterion 1) — pure construction, the caller persists it.
class OpenEscrowAccount {
  static EscrowAccountEntity call({
    required String buyerName,
    required String sellerName,
    required String itemDescription,
    required double amount,
    required DateTime now,
  }) {
    return EscrowAccountEntity(
      buyerName: buyerName,
      sellerName: sellerName,
      itemDescription: itemDescription,
      amount: amount,
      createdAt: now,
    );
  }
}
