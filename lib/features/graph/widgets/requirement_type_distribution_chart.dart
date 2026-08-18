import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Distribution Chart: a Doughnut or Pie chart... Functional vs.
/// Non-functional" (Issue #234) — via fl_chart (already a repo
/// dependency), not the issue's named Syncfusion (commercial license;
/// see PR notes). Tapping a slice drills down via [onSliceTap].
class RequirementTypeDistributionChart extends StatelessWidget {
  final Map<RequirementType, int> counts;
  final ValueChanged<RequirementType>? onSliceTap;

  const RequirementTypeDistributionChart({super.key, required this.counts, this.onSliceTap});

  static const _colors = {
    RequirementType.functional: Colors.blue,
    RequirementType.nonFunctional: Colors.purple,
    RequirementType.technical: Colors.teal,
    RequirementType.businessRule: Colors.amber,
  };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final entries = counts.entries.where((e) => e.value > 0).toList();
    if (entries.isEmpty) {
      return Text('No requirements yet.', style: TextStyle(color: colors.mutedForeground, fontSize: 12));
    }
    return SizedBox(
      height: 160,
      child: PieChart(PieChartData(
        centerSpaceRadius: 32,
        sectionsSpace: 2,
        pieTouchData: PieTouchData(touchCallback: (event, response) {
          if (event is! FlTapUpEvent || onSliceTap == null) return;
          final index = response?.touchedSection?.touchedSectionIndex;
          if (index != null && index >= 0 && index < entries.length) onSliceTap!(entries[index].key);
        }),
        sections: [
          for (final entry in entries)
            PieChartSectionData(
              value: entry.value.toDouble(),
              title: '${entry.value}',
              color: _colors[entry.key],
              radius: 40,
              titleStyle: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
            ),
        ],
      )),
    );
  }
}
