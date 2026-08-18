import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "business_goals: high-level project goals" input row (Issue #238).
class TraceabilityAddGoalRow extends StatefulWidget {
  final TraceabilityController controller;

  const TraceabilityAddGoalRow({super.key, required this.controller});

  @override
  State<TraceabilityAddGoalRow> createState() => _TraceabilityAddGoalRowState();
}

class _TraceabilityAddGoalRowState extends State<TraceabilityAddGoalRow> {
  final _textController = TextEditingController();

  void _add() {
    final title = _textController.text.trim();
    if (title.isEmpty) return;
    widget.controller.addGoal(title);
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShadInput(controller: _textController, placeholder: const Text('New business goal...')),
        ),
        const SizedBox(width: 8),
        ShadButton(onPressed: _add, child: const Text('Add Goal')),
      ],
    );
  }
}
