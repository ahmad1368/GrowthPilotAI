import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_info_card.dart';
import '../../models/insight_model.dart';

/// [Issue #837] Summary row above the insight list — reuses the existing
/// (previously dead) InsightInfoCard tile instead of a new bespoke widget.
class InsightStatsHeader extends StatelessWidget {
  final List<InsightModel> insights;

  const InsightStatsHeader({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    final avgEfficiency = insights.isEmpty
        ? 0
        : insights
                .map((i) => double.tryParse(i.efficiency.replaceAll('%', '')) ?? 0)
                .reduce((a, b) => a + b) /
            insights.length;
    final categoryCount = insights.map((i) => i.category).toSet().length;

    return Row(
      children: [
        Expanded(
          child: InsightInfoCard(
            title: 'Total Insights',
            value: '${insights.length}',
            icon: Icons.lightbulb_rounded,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InsightInfoCard(
            title: 'Avg Efficiency',
            value: '${avgEfficiency.round()}%',
            icon: Icons.speed_rounded,
            color: Colors.greenAccent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: InsightInfoCard(
            title: 'Categories',
            value: '$categoryCount',
            icon: Icons.category_rounded,
            color: Colors.purpleAccent,
          ),
        ),
      ],
    );
  }
}
