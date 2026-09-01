import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Risk Distribution... Stacked Bar Chart where the area size
/// represents the number of risks and the color intensity represents
/// the severity" (Issue #236) — grouped by severity only (see
/// [ComputeBottleneckSeverityDistribution]'s own doc comment for why
/// stakeholder/business_module grouping isn't implemented).
class RiskDistributionBar extends StatelessWidget {
  final Map<BottleneckSeverity, int> distribution;

  const RiskDistributionBar({super.key, required this.distribution});

  static const _colors = {
    BottleneckSeverity.low: Colors.green,
    BottleneckSeverity.medium: Colors.orange,
    BottleneckSeverity.high: Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final total = distribution.values.fold(0, (a, b) => a + b);
    if (total == 0) {
      return Text('No bottlenecks detected.', style: TextStyle(color: colors.mutedForeground, fontSize: 12));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Row(
            children: [
              for (final severity in BottleneckSeverity.values)
                if ((distribution[severity] ?? 0) > 0)
                  Expanded(
                    flex: distribution[severity]!,
                    child: Container(height: 10, color: _colors[severity]),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 12,
          children: [
            for (final severity in BottleneckSeverity.values)
              Text('${severity.name}: ${distribution[severity] ?? 0}',
                  style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
          ],
        ),
      ],
    );
  }
}
