import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/insight_category_style.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_category_badge.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_efficiency_ring.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_text_column.dart';
import '../../models/insight_model.dart';

/// [Issue #837] Badge + text column + efficiency ring row; split out of
/// InsightListItem to stay under this repo's per-file line cap.
class InsightCardContent extends StatelessWidget {
  final InsightModel data;
  final InsightCategoryVisual visual;
  final double percent;
  final Color descriptionColor;

  const InsightCardContent({
    super.key,
    required this.data,
    required this.visual,
    required this.percent,
    required this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsightCategoryBadge(visual: visual),
          const SizedBox(width: 12),
          Expanded(
            child: InsightTextColumn(
              category: data.category,
              title: data.title,
              description: data.description,
              categoryColor: visual.color,
              descriptionColor: descriptionColor,
            ),
          ),
          const SizedBox(width: 8),
          InsightEfficiencyRing(percent: percent, color: visual.color),
        ],
      ),
    );
  }
}
