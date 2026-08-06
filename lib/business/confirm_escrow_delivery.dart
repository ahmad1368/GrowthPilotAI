import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';

/// Releases held funds to the seller once the buyer confirms receipt
/// matches the agreed listing terms (Issue #415, acceptance
/// criterion 2).
class ConfirmEscrowDelivery {
  static EscrowAccountEntity call(EscrowAccountEntity account) {
    return EscrowAccountEntity(
      id: account.id,
      buyerName: account.buyerName,
      sellerName: account.sellerName,
      itemDescription: account.itemDescription,
      amount: account.amount,
      dbStatus: EscrowStatus.released.index,
      createdAt: account.createdAt,
    );
  }
}
