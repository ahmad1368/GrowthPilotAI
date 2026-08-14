import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Linked" badge for an Inbox row whose conversation is tied to a
/// transaction (Issue #72's contextual-linking requirement, built on the
/// Issue #70 data model). Always pairs color+icon+amount, matching
/// [MergedProviderBadge]'s convention.
class TransactionLinkBadge extends StatelessWidget {
  final double amount;

  const TransactionLinkBadge({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    const color = Colors.teal;
    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.link_rounded, size: 14, color: color),
          const SizedBox(width: 4),
          Text('\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
