import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Merged" badge for the Transaction Details screen (Issue #69): shows one
/// icon per provider behind a duplicate-detected transaction. Always pairs
/// color+icon+label, matching [IntegrationStatusChip]'s convention.
class MergedProviderBadge extends StatelessWidget {
  final List<String> originSources; // e.g. ["plaid:tx1", "quickbooks:tx2"]

  const MergedProviderBadge({super.key, required this.originSources});

  @override
  Widget build(BuildContext context) {
    const color = Colors.deepPurple;
    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final origin in originSources)
            Icon(_iconFor(origin.split(':').first), size: 14, color: color),
          const SizedBox(width: 4),
          const Text('Merged', style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }

  IconData _iconFor(String source) => switch (source) {
        'plaid' => Icons.account_balance_rounded,
        'quickbooks' => Icons.receipt_long_rounded,
        'xero' => Icons.calculate_rounded,
        _ => Icons.link_rounded,
      };
}
