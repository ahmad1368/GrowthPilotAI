import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/analytics_dashboard_controller.dart';
import 'package:growth_pilot_ai/features/settings/widgets/feature_popularity_chart.dart';
import 'package:growth_pilot_ai/features/settings/widgets/funnel_step_row.dart';

/// "Setup Analytics Dashboard (Revenue & Retention)" (Issue #194) —
/// reads the local usage-event log instead of a Firebase/GA4
/// dashboard (no such account exists in this repo; see PR notes).
class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<AnalyticsDashboardController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Analytics'), backgroundColor: colors.background),
      body: Obx(() {
        final funnel = controller.funnel;
        final maxCount = funnel.isEmpty ? 0 : funnel.first.count;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text('Conversion Funnel', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final step in funnel) FunnelStepRow(label: step.label, count: step.count, maxCount: maxCount),
            const SizedBox(height: 24),
            Text('Feature Popularity', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            FeaturePopularityChart(entries: controller.featurePopularity),
          ],
        );
      }),
    );
  }
}
