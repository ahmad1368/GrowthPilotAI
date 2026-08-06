import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';

/// Admin arbitration for a disputed escrow account (Issue #415,
/// acceptance criterion 4) — the only manual-intervention path,
/// reached solely when [VerifyRefundClaim] couldn't auto-resolve a
/// claim.
class ResolveEscrowDispute {
  static EscrowAccountEntity call(EscrowAccountEntity account, {required bool approveRefund}) {
    return EscrowAccountEntity(
      id: account.id,
      buyerName: account.buyerName,
      sellerName: account.sellerName,
      itemDescription: account.itemDescription,
      amount: account.amount,
      dbStatus: (approveRefund ? EscrowStatus.refunded : EscrowStatus.released).index,
      createdAt: account.createdAt,
    );
  }
}
