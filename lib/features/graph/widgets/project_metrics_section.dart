import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/project_metrics_summary_card.dart';

/// Reactive wrapper around [ProjectMetricsSummaryCard] (Issue #233) —
/// hidden until the first [ProjectMetricsController.recompute] call.
class ProjectMetricsSection extends StatelessWidget {
  final ProjectMetricsController controller;

  const ProjectMetricsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final snapshot = controller.snapshot.value;
      if (snapshot == null) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ProjectMetricsSummaryCard(snapshot: snapshot),
      );
    });
  }
}
