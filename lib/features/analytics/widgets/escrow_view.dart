import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_escrow_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/dispute_evidence_type.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_view_state.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a new-escrow button, every account card, and a summary
/// narrative (Issue #415). Purely presentational.
class EscrowView extends StatelessWidget {
  final EscrowViewState state;
  final VoidCallback onCreate;
  final void Function(EscrowAccountEntity) onConfirmDelivery;
  final void Function(EscrowAccountEntity, EscrowClaimReason) onFileClaim;
  final void Function(EscrowAccountEntity, bool) onResolveDispute;
  final void Function(EscrowAccountEntity, String, DisputeEvidenceType, String) onSubmitEvidence;
  const EscrowView({
    super.key,
    required this.state,
    required this.onCreate,
    required this.onConfirmDelivery,
    required this.onFileClaim,
    required this.onResolveDispute,
    required this.onSubmitEvidence,
  });
  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        ShadButton.outline(
            onPressed: onCreate, child: Text('+ Open Escrow', style: TextStyle(color: fg))),
      ]),
      for (final account in state.accounts)
        EscrowRow(
          account: account,
          evidence: state.evidenceByAccount[account.id] ?? const [],
          onConfirmDelivery: () => onConfirmDelivery(account),
          onFileClaim: (reason) => onFileClaim(account, reason),
          onResolveDispute: (approve) => onResolveDispute(account, approve),
          onSubmitEvidence: (by, type, desc) => onSubmitEvidence(account, by, type, desc),
        ),
      const SizedBox(height: 8),
      Text(BuildEscrowNarrative.call(state.accounts)),
    ]);
  }
}
