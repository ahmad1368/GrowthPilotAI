import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/document_processing_orchestrator_controller.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/document_processing_stepper.dart';
import 'package:growth_pilot_ai/features/graph/widgets/project_metrics_section.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_batch_action_bar.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_document_input.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_source_split_view.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_undo_banner.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "User Validation Interface & Source Traceability" screen (Issue
/// #231/#232/#233) — ties together Issue #227's sanitization, #228/
/// #229's extraction/triage, #231's selection-highlighting/batch/undo,
/// #232's local processing orchestrator, and #233's KPI summary into
/// one navigable screen.
class RequirementTriageScreen extends StatelessWidget {
  const RequirementTriageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final triageController = Get.find<RequirementTriageController>();
    final orchestrator = Get.find<DocumentProcessingOrchestratorController>();
    final metricsController = Get.find<ProjectMetricsController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Requirement Triage'), backgroundColor: colors.background),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequirementDocumentInput(
                orchestrator: orchestrator,
                triageController: triageController,
                metricsController: metricsController,
              ),
              const SizedBox(height: 8),
              DocumentProcessingStepper(controller: orchestrator),
              const SizedBox(height: 16),
              ProjectMetricsSection(controller: metricsController),
              RequirementUndoBanner(controller: triageController),
              RequirementBatchActionBar(controller: triageController),
              const SizedBox(height: 12),
              RequirementSourceSplitView(controller: triageController),
            ],
          ),
        ),
      ),
    );
  }
}
