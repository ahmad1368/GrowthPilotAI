import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/insight_category_style.dart';

/// [Issue #837] Colored circular icon badge for an insight's category —
/// replaces the single generic icon every card used to share.
class InsightCategoryBadge extends StatelessWidget {
  final InsightCategoryVisual visual;

  const InsightCategoryBadge({super.key, required this.visual});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: visual.color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(visual.icon, color: visual.color, size: 22),
    );
  }
}
