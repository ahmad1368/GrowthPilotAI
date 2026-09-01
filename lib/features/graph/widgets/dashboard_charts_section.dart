import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/group_requirements_by_stakeholder_and_priority.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/features/graph/widgets/moscow_priority_by_stakeholder_chart.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_type_distribution_chart.dart';
import 'package:growth_pilot_ai/features/graph/widgets/volatility_trend_chart.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The three KPI charts (Issue #234) + "Drill-down... navigate to a
/// filtered view of the Requirements List" on the distribution chart.
class DashboardChartsSection extends StatelessWidget {
  final ProjectMetricsSnapshot snapshot;
  final ProjectMetricsController metricsController;
  final RequirementTriageController triageController;

  const DashboardChartsSection({
    super.key,
    required this.snapshot,
    required this.metricsController,
    required this.triageController,
  });

  void _drillDown(RequirementType type) {
    triageController.setTypeFilter(type);
    Get.toNamed('/requirements/triage');
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final byStakeholder =
        GroupRequirementsByStakeholderAndPriority.call(metricsController.sourceRequirements);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Functional vs Non-Functional', style: TextStyle(color: colors.foreground, fontSize: 13)),
        RequirementTypeDistributionChart(counts: snapshot.requirementCounts, onSliceTap: _drillDown),
        const SizedBox(height: 16),
        Text('MoSCoW Priority by Stakeholder', style: TextStyle(color: colors.foreground, fontSize: 13)),
        MoscowPriorityByStakeholderChart(byStakeholder: byStakeholder),
        const SizedBox(height: 16),
        Text('Volatility Over Time', style: TextStyle(color: colors.foreground, fontSize: 13)),
        VolatilityTrendChart(history: metricsController.history),
      ],
    );
  }
}
