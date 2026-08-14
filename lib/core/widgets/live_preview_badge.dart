import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Live" badge for a widget currently showing unsaved preview data (Issue
/// #116), so the user can tell at a glance a chart isn't its saved state.
class LivePreviewBadge extends StatelessWidget {
  const LivePreviewBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return ShadBadge.raw(
      variant: ShadBadgeVariant.outline,
      backgroundColor: color.withValues(alpha: 0.12),
      foregroundColor: color,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: color),
          const SizedBox(width: 4),
          Text('Live', style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
