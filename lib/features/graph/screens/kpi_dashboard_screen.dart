import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dashboard_charts_section.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dashboard_stat_grid.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "High-Fidelity KPI Dashboard & Responsive Data Visualization"
/// (Issue #234) — reads live from the shared, app-level
/// [ProjectMetricsController]/[RequirementTriageController] (Issue
/// #233/#236's data), so it always reflects whatever was last analyzed
/// on the Requirement Triage screen. No dedicated nav shell (sidebar/
/// bottom-nav) is built here — this app already has its own navigation
/// system; see PR notes.
class KpiDashboardScreen extends StatelessWidget {
  const KpiDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final metricsController = Get.find<ProjectMetricsController>();
    final triageController = Get.find<RequirementTriageController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('KPI Dashboard'), backgroundColor: colors.background),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          final snapshot = metricsController.snapshot.value;
          if (snapshot == null) {
            return Center(
              child: Text('Analyze a document on the Triage screen to see KPIs here.',
                  style: TextStyle(color: colors.mutedForeground)),
            );
          }
          final history = metricsController.history;
          final previous = history.length >= 2 ? history[history.length - 2] : null;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardStatGrid(current: snapshot, previous: previous),
                const SizedBox(height: 20),
                DashboardChartsSection(
                  snapshot: snapshot,
                  metricsController: metricsController,
                  triageController: triageController,
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
