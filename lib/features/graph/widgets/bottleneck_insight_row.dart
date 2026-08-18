import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/bottleneck_severity.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One row in the "Health Check" panel (Issue #223) — flat, severity
/// color-coded.
class BottleneckInsightRow extends StatelessWidget {
  final BottleneckInsight insight;

  const BottleneckInsightRow({super.key, required this.insight});

  Color _severityColor() => switch (insight.severity) {
        BottleneckSeverity.high => Colors.red,
        BottleneckSeverity.medium => Colors.orange,
        BottleneckSeverity.low => Colors.blueGrey,
      };

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(insight.issueLabel,
              style: TextStyle(color: _severityColor(), fontSize: 13, fontWeight: FontWeight.w600)),
          Text(insight.reason, style: TextStyle(color: colors.foreground, fontSize: 12)),
          Text(insight.suggestion, style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
        ],
      ),
    );
  }
}
