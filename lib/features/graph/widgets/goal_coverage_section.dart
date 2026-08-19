import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/goal_coverage_gauge.dart';
import 'package:growth_pilot_ai/features/graph/widgets/uncovered_goals_warning.dart';

/// Reactive wrapper composing [GoalCoverageGauge] + [UncoveredGoalsWarning]
/// (Issue #243) — hidden until the controller has computed a report.
class GoalCoverageSection extends StatelessWidget {
  final TraceabilityController controller;

  const GoalCoverageSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final report = controller.coverageReport.value;
      if (report == null) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoalCoverageGauge(coverage: report.overallCoverage),
            const SizedBox(width: 12),
            Expanded(child: UncoveredGoalsWarning(uncoveredGoals: report.uncoveredGoals)),
          ],
        ),
      );
    });
  }
}
