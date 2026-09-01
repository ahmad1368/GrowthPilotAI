import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Priority Matrix: a Bar chart (Stacked) showing the distribution of
/// MoSCoW priorities across different stakeholders" (Issue #234).
class MoscowPriorityByStakeholderChart extends StatelessWidget {
  final Map<String, Map<RequirementMoscowPriority, int>> byStakeholder;

  const MoscowPriorityByStakeholderChart({super.key, required this.byStakeholder});

  static const _colors = {
    RequirementMoscowPriority.mustHave: Colors.red,
    RequirementMoscowPriority.shouldHave: Colors.orange,
    RequirementMoscowPriority.couldHave: Colors.blue,
    RequirementMoscowPriority.wontHave: Colors.grey,
  };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final stakeholders = byStakeholder.keys.toList();
    if (stakeholders.isEmpty) {
      return Text('No requirements yet.', style: TextStyle(color: colors.mutedForeground, fontSize: 12));
    }
    return SizedBox(
      height: 180,
      child: BarChart(BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                if (i < 0 || i >= stakeholders.length) return const SizedBox.shrink();
                return Text(stakeholders[i], style: TextStyle(color: colors.mutedForeground, fontSize: 9));
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < stakeholders.length; i++) _groupFor(i, byStakeholder[stakeholders[i]]!),
        ],
      )),
    );
  }

  BarChartGroupData _groupFor(int x, Map<RequirementMoscowPriority, int> tiers) {
    var cumulative = 0.0;
    final items = <BarChartRodStackItem>[];
    for (final priority in RequirementMoscowPriority.values) {
      final count = (tiers[priority] ?? 0).toDouble();
      if (count <= 0) continue;
      items.add(BarChartRodStackItem(cumulative, cumulative + count, _colors[priority]!));
      cumulative += count;
    }
    return BarChartGroupData(
        x: x, barRods: [BarChartRodData(toY: cumulative, rodStackItems: items, width: 18)]);
  }
}
