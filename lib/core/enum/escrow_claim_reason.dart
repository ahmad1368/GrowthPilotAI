/// A buyer's stated reason for filing a refund claim against a held
/// escrow account (Issue #415, acceptance criteria 3-4). The first
/// three are well-defined categories the smart contract can verify
/// automatically; [other] is inherently ambiguous and always
/// escalates to admin arbitration — see [VerifyRefundClaim].
enum EscrowClaimReason { damaged, spoiled, nonCompliant, other }
