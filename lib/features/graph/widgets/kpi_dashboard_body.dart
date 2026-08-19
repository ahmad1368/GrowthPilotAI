import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/kpi_dashboard_export_controller.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dashboard_branding_footer.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dashboard_charts_section.dart';
import 'package:growth_pilot_ai/features/graph/widgets/dashboard_stat_grid.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The KPI Dashboard's scrollable, exportable content (Issue #234/
/// #248) — split out of [KpiDashboardScreen] to keep it under the
/// 50-line guideline. Wrapped in a [RepaintBoundary] keyed by
/// [KpiDashboardExportController.captureKey] so the whole section can
/// be rasterized to PNG as-rendered.
class KpiDashboardBody extends StatelessWidget {
  final ProjectMetricsController metricsController;
  final RequirementTriageController triageController;
  final KpiDashboardExportController exportController;

  const KpiDashboardBody({
    super.key,
    required this.metricsController,
    required this.triageController,
    required this.exportController,
  });

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
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
        child: RepaintBoundary(
          key: exportController.captureKey,
          child: Container(
            color: Colors.transparent,
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
                const DashboardBrandingFooter(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
