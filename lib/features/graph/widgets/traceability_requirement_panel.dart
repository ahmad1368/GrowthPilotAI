import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/traceability_requirement_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The selected goal's linked requirements (Issue #238's "click a goal
/// and view all linked requirements and test cases").
class TraceabilityRequirementPanel extends StatefulWidget {
  final TraceabilityController controller;
  final int goalId;

  const TraceabilityRequirementPanel({super.key, required this.controller, required this.goalId});

  @override
  State<TraceabilityRequirementPanel> createState() => _TraceabilityRequirementPanelState();
}

class _TraceabilityRequirementPanelState extends State<TraceabilityRequirementPanel> {
  final _textController = TextEditingController();

  void _link() {
    final description = _textController.text.trim();
    if (description.isEmpty) return;
    widget.controller.linkRequirementToGoal(description, widget.goalId);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Obx(() {
      final requirements = widget.controller.requirementsForGoal(widget.goalId);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ShadInput(
                    controller: _textController, placeholder: const Text('Link requirement text...')),
              ),
              const SizedBox(width: 8),
              ShadButton(onPressed: _link, child: const Text('Link')),
            ],
          ),
          const SizedBox(height: 12),
          if (requirements.isEmpty)
            Text('No requirements linked to this goal yet.',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12))
          else
            for (final r in requirements)
              TraceabilityRequirementCard(controller: widget.controller, requirement: r),
        ],
      );
    });
  }
}
