import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dashboard_stat_cards.dart';

/// "Responsive Layout: switch between a Grid-based layout (Web/Tablet)
/// and a Single-column list (Mobile)" (Issue #234), applied to the
/// [DashboardStatCards.build] list.
class DashboardStatGrid extends StatelessWidget {
  final ProjectMetricsSnapshot current;
  final ProjectMetricsSnapshot? previous;

  const DashboardStatGrid({super.key, required this.current, this.previous});

  @override
  Widget build(BuildContext context) {
    final cards = DashboardStatCards.build(current, previous);
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth >= 800 ? 3 : (constraints.maxWidth >= 500 ? 2 : 1);
      return GridView.count(
        crossAxisCount: columns,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.4,
        children: cards,
      );
    });
  }
}
