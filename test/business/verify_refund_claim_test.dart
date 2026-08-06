import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/verify_refund_claim.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';

void main() {
  test('well-defined claim reasons are auto-approvable', () {
    expect(VerifyRefundClaim.isAutoApprovable(EscrowClaimReason.damaged), true);
    expect(VerifyRefundClaim.isAutoApprovable(EscrowClaimReason.spoiled), true);
    expect(VerifyRefundClaim.isAutoApprovable(EscrowClaimReason.nonCompliant), true);
  });

  test('an ambiguous "other" reason is never auto-approvable', () {
    expect(VerifyRefundClaim.isAutoApprovable(EscrowClaimReason.other), false);
  });
}
