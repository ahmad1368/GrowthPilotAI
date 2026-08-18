import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/process_analysis_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/bottleneck_insight_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Native "Health Check" panel (Issue #223, AC: "user sees a list of
/// Top 3 Bottlenecks with actionable suggestions") — the Flutter-side
/// analytical overlay, since no WebView Heatmap/Critical-Path visual
/// overlays exist yet (see PR notes: no React Flow app to render them
/// in).
class HealthCheckPanel extends StatelessWidget {
  final ProcessAnalysisController controller;

  const HealthCheckPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      if (controller.topBottlenecks.isEmpty) {
        return Text('No issues detected in this process.',
            style: TextStyle(color: colors.mutedForeground, fontSize: 12));
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final insight in controller.topBottlenecks) BottleneckInsightRow(insight: insight),
        ],
      );
    });
  }
}
