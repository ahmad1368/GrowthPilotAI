import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';

/// The automated verification rule deciding whether a refund claim
/// can be resolved instantly or needs admin arbitration (Issue #415,
/// acceptance criteria 3-4) — damaged/spoiled/non-compliant are
/// well-defined categories the contract can auto-verify; anything
/// else is an ambiguous edge case reserved for a human.
class VerifyRefundClaim {
  static bool isAutoApprovable(EscrowClaimReason reason) {
    return reason != EscrowClaimReason.other;
  }
}
