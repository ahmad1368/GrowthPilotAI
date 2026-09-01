import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/goal_coverage_section.dart';
import 'package:growth_pilot_ai/features/graph/widgets/suggestion_review_section.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_add_goal_row.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_goal_list.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_requirement_panel.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Traceability Navigator: a tree or matrix-style interface allowing
/// analysts to click a goal and view all linked requirements and test
/// cases" (Issue #238).
class TraceabilityNavigatorScreen extends StatefulWidget {
  const TraceabilityNavigatorScreen({super.key});

  @override
  State<TraceabilityNavigatorScreen> createState() => _TraceabilityNavigatorScreenState();
}

class _TraceabilityNavigatorScreenState extends State<TraceabilityNavigatorScreen> {
  int? _selectedGoalId;

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final controller = Get.find<TraceabilityController>();

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Traceability Navigator'),
        backgroundColor: colors.background,
        actions: [
          IconButton(
            icon: const Icon(Icons.grid_on_outlined),
            tooltip: 'Matrix View',
            onPressed: () => Get.toNamed('/requirements/traceability/matrix'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GoalCoverageSection(controller: controller),
              SuggestionReviewSection(controller: controller),
              const SizedBox(height: 16),
              TraceabilityAddGoalRow(controller: controller),
              const SizedBox(height: 12),
              TraceabilityGoalList(
                controller: controller,
                selectedGoalId: _selectedGoalId,
                onSelect: (id) => setState(() => _selectedGoalId = id),
              ),
              const SizedBox(height: 16),
              if (_selectedGoalId != null)
                TraceabilityRequirementPanel(controller: controller, goalId: _selectedGoalId!),
            ],
          ),
        ),
      ),
    );
  }
}
