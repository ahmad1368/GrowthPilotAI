import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_claim_input.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_disputed_actions.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Status-specific action area for one escrow account (Issue #415) —
/// split out of [EscrowRow] to stay under the file line cap.
class EscrowRowActions extends StatelessWidget {
  final EscrowAccountEntity account;
  final List<DisputeEvidenceEntity> evidence;
  final VoidCallback onConfirmDelivery;
  final void Function(EscrowClaimReason reason) onFileClaim;
  final void Function(bool approveRefund) onResolveDispute;
  final void Function(String, DisputeEvidenceType, String) onSubmitEvidence;

  const EscrowRowActions({
    super.key,
    required this.account,
    required this.evidence,
    required this.onConfirmDelivery,
    required this.onFileClaim,
    required this.onResolveDispute,
    required this.onSubmitEvidence,
  });

  @override
  Widget build(BuildContext context) {
    if (account.status == EscrowStatus.held) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ShadButton.ghost(onPressed: onConfirmDelivery, child: const Text('Confirm Delivery')),
        EscrowClaimInput(onFileClaim: onFileClaim),
      ]);
    }
    if (account.status == EscrowStatus.disputed) {
      return EscrowDisputedActions(
        account: account,
        evidence: evidence,
        onResolveDispute: onResolveDispute,
        onSubmitEvidence: onSubmitEvidence,
      );
    }
    return const SizedBox.shrink();
  }
}
