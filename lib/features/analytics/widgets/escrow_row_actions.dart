import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_claim_input.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Status-specific action area for one escrow account (Issue #415) —
/// split out of [EscrowRow] to stay under the file line cap.
class EscrowRowActions extends StatelessWidget {
  final EscrowAccountEntity account;
  final VoidCallback onConfirmDelivery;
  final void Function(EscrowClaimReason reason) onFileClaim;
  final void Function(bool approveRefund) onResolveDispute;

  const EscrowRowActions({
    super.key,
    required this.account,
    required this.onConfirmDelivery,
    required this.onFileClaim,
    required this.onResolveDispute,
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
      return Row(children: [
        ShadButton.ghost(
            onPressed: () => onResolveDispute(true), child: const Text('Admin: Approve Refund')),
        ShadButton.ghost(
            onPressed: () => onResolveDispute(false), child: const Text('Admin: Release to Seller')),
      ]);
    }
    return const SizedBox.shrink();
  }
}
