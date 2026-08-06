import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_claim_reason.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_row_actions.dart';

/// One escrow account card (Issue #415) — header info and
/// status-specific actions from [EscrowRowActions].
class EscrowRow extends StatelessWidget {
  final EscrowAccountEntity account;
  final VoidCallback onConfirmDelivery;
  final void Function(EscrowClaimReason reason) onFileClaim;
  final void Function(bool approveRefund) onResolveDispute;

  const EscrowRow({
    super.key,
    required this.account,
    required this.onConfirmDelivery,
    required this.onFileClaim,
    required this.onResolveDispute,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: scheme.onSurface.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${account.itemDescription} — ${account.buyerName} → ${account.sellerName}'),
          Text('\$${account.amount.toStringAsFixed(2)} — ${account.status.name}',
              style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          EscrowRowActions(
            account: account,
            onConfirmDelivery: onConfirmDelivery,
            onFileClaim: onFileClaim,
            onResolveDispute: onResolveDispute,
          ),
        ],
      ),
    );
  }
}
