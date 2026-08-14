import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/business/verify_refund_claim.dart';

/// Files a buyer's refund claim against a held escrow account (Issue
/// #415, acceptance criteria 3-4) — an auto-verifiable reason
/// executes the refund instantly; an ambiguous one escalates to
/// [EscrowStatus.disputed] for admin arbitration instead.
class FileEscrowClaim {
  static EscrowAccountEntity call(EscrowAccountEntity account, EscrowClaimReason reason) {
    final autoApproved = VerifyRefundClaim.isAutoApprovable(reason);
    return EscrowAccountEntity(
      id: account.id,
      buyerName: account.buyerName,
      sellerName: account.sellerName,
      itemDescription: account.itemDescription,
      amount: account.amount,
      dbStatus: (autoApproved ? EscrowStatus.refunded : EscrowStatus.disputed).index,
      createdAt: account.createdAt,
    );
  }
}
