import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/dispute_evidence_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_dispute_dossier.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_evidence_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Dossier, evidence submission, and admin ruling for one disputed
/// escrow account (Issue #427, acceptance criteria 2 and 5) — split
/// out of [EscrowRowActions] to stay under the file line cap.
class EscrowDisputedActions extends StatelessWidget {
  final EscrowAccountEntity account;
  final List<DisputeEvidenceEntity> evidence;
  final void Function(bool approveRefund) onResolveDispute;
  final void Function(String, DisputeEvidenceType, String) onSubmitEvidence;

  const EscrowDisputedActions({
    super.key,
    required this.account,
    required this.evidence,
    required this.onResolveDispute,
    required this.onSubmitEvidence,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      EscrowDisputeDossier(evidence: evidence),
      EscrowEvidenceInput(account: account, onSubmit: onSubmitEvidence),
      Row(children: [
        ShadButton.ghost(
            onPressed: () => onResolveDispute(true), child: const Text('Admin: Approve Refund')),
        ShadButton.ghost(
            onPressed: () => onResolveDispute(false), child: const Text('Admin: Release to Seller')),
      ]),
    ]);
  }
}
