import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/kpi_dashboard_export_controller.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/kpi_dashboard_body.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "High-Fidelity KPI Dashboard & Responsive Data Visualization"
/// (Issue #234) — reads live from the shared, app-level
/// [ProjectMetricsController]/[RequirementTriageController] (Issue
/// #233/#236's data), so it always reflects whatever was last analyzed
/// on the Requirement Triage screen. No dedicated nav shell (sidebar/
/// bottom-nav) is built here — this app already has its own navigation
/// system; see PR notes. #248 adds a high-resolution PNG export of the
/// whole dashboard.
class KpiDashboardScreen extends StatelessWidget {
  const KpiDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final metricsController = Get.find<ProjectMetricsController>();
    final triageController = Get.find<RequirementTriageController>();
    final exportController = Get.find<KpiDashboardExportController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('KPI Dashboard'),
        backgroundColor: colors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.image_outlined),
            tooltip: 'Export as Image',
            onPressed: exportController.exportPng,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: KpiDashboardBody(
          metricsController: metricsController,
          triageController: triageController,
          exportController: exportController,
        ),
      ),
    );
  }
}
