import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_trend_direction.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/features/graph/widgets/stat_card.dart';

/// Builds the KPI [StatCard]s for the dashboard (Issue #234) — split
/// out of [DashboardStatGrid] to keep that file under the 50-line
/// guideline.
class DashboardStatCards {
  static List<StatCard> build(ProjectMetricsSnapshot current, ProjectMetricsSnapshot? previous) {
    return [
      StatCard(
        icon: Icons.list_alt,
        label: 'Requirements',
        value: '${current.totalRequirements}',
        accentColor: Colors.blueGrey,
      ),
      StatCard(
        icon: Icons.grade,
        label: 'Health Grade',
        value: current.healthGrade.letter,
        accentColor: current.healthGrade.score >= 80
            ? Colors.green
            : (current.healthGrade.score >= 60 ? Colors.orange : Colors.red),
      ),
      StatCard(
        icon: Icons.change_history,
        label: 'Volatility',
        value: '${(current.volatilityRate * 100).round()}%',
        accentColor: current.volatilityRate > 0.3 ? Colors.redAccent : Colors.blueGrey,
        trend: ComputeTrendDirection.call(previous?.volatilityRate, current.volatilityRate),
      ),
      StatCard(
        icon: Icons.task_alt,
        label: 'Completeness',
        value: '${(current.completenessRate * 100).round()}%',
        accentColor: Colors.green,
        trend: ComputeTrendDirection.call(previous?.completenessRate, current.completenessRate),
      ),
      StatCard(
        icon: Icons.groups,
        label: 'Engagement',
        value: '${(current.engagementRate * 100).round()}%',
        accentColor: Colors.indigo,
        trend: ComputeTrendDirection.call(previous?.engagementRate, current.engagementRate),
      ),
      StatCard(
        icon: Icons.warning_amber,
        label: 'Risk Score',
        value: current.riskScore.toStringAsFixed(0),
        accentColor: current.riskScore > 30 ? Colors.redAccent : Colors.blueGrey,
        trend: ComputeTrendDirection.call(previous?.riskScore, current.riskScore),
      ),
    ];
  }
}
