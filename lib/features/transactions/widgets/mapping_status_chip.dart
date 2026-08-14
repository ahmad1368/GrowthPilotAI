import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/mapping_result.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Color-coded confidence badge for a [MappingResult] (Issue #58). Always
/// pairs color with an icon + label so status reads for color-blind users.
class MappingStatusChip extends StatelessWidget {
  final MappingResult mapping;

  const MappingStatusChip({super.key, required this.mapping});

  @override
  Widget build(BuildContext context) {
    final (color, icon, label) = mapping.suggestedAccountId == null
        ? (Colors.red, Icons.error_outline_rounded, 'Unmapped')
        : mapping.confidence > 0.8
            ? (Colors.green, Icons.check_circle_outline_rounded, 'Suggested')
            : (Colors.amber, Icons.warning_amber_rounded, 'Review');

    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
