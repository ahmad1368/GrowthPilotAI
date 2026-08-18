import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/project_health_check_card.dart';
import 'package:growth_pilot_ai/features/graph/widgets/project_metrics_summary_card.dart';
import 'package:growth_pilot_ai/features/graph/widgets/risk_distribution_bar.dart';

/// Reactive wrapper around the KPI widgets (Issue #233/#236) — hidden
/// until the first [ProjectMetricsController.recompute] call.
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectHealthCheckCard(grade: snapshot.healthGrade),
            const SizedBox(height: 8),
            ProjectMetricsSummaryCard(snapshot: snapshot, requirements: controller.sourceRequirements),
            const SizedBox(height: 8),
            RiskDistributionBar(distribution: snapshot.riskDistribution),
          ],
        ),
      );
    });
  }
}
