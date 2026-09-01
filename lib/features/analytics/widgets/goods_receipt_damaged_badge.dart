import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Flags a goods receipt that had damaged or missing items noted at intake
/// (Issue #444).
class GoodsReceiptDamagedBadge extends StatelessWidget {
  const GoodsReceiptDamagedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: Color(0x1FEF4444),
      foregroundColor: Color(0xFFEF4444),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.report_problem_outlined, size: 12, color: Color(0xFFEF4444)),
        SizedBox(width: 4),
        Text('Damaged/Missing', style: TextStyle(color: Color(0xFFEF4444), fontSize: 11)),
      ]),
    );
  }
}
