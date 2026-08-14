import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Invoice-match status badge for a goods receipt (Issue #444). [matched]
/// is null when the receipt isn't linked to a known purchase order. Always
/// pairs color with an icon + label so status reads for color-blind users.
class GoodsReceiptMatchBadge extends StatelessWidget {
  final bool? matched;

  const GoodsReceiptMatchBadge({super.key, required this.matched});

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = matched == null
        ? (Colors.grey, Icons.help_outline_rounded, 'No PO linked')
        : matched!
            ? (Colors.green, Icons.check_circle_outline_rounded, 'Matched')
            : (Colors.amber, Icons.warning_amber_rounded, 'Discrepancy');

    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: color, fontSize: 11)),
      ]),
    );
  }
}
