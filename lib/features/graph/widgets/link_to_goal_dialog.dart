import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Link the `req_code` back to the `start_index`... from Issue 228"
/// (Issue #242) — picks an existing business goal to link the current
/// requirement to; returns the chosen goal id via [Navigator.pop].
class LinkToGoalDialog extends StatefulWidget {
  final TraceabilityController controller;

  const LinkToGoalDialog({super.key, required this.controller});

  @override
  State<LinkToGoalDialog> createState() => _LinkToGoalDialogState();
}

class _LinkToGoalDialogState extends State<LinkToGoalDialog> {
  int? _selectedGoalId;

  @override
  Widget build(BuildContext context) {
    final goals = widget.controller.goalList;
    return AlertDialog(
      title: const Text('Link to business goal'),
      content: goals.isEmpty
          ? const Text('No business goals yet — add one on the Traceability Navigator first.')
          : DropdownButton<int>(
              isExpanded: true,
              value: _selectedGoalId,
              hint: const Text('Choose a goal'),
              items: [for (final g in goals) DropdownMenuItem(value: g.id, child: Text(g.title))],
              onChanged: (id) => setState(() => _selectedGoalId = id),
            ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(
          onPressed: _selectedGoalId == null ? null : () => Navigator.of(context).pop(_selectedGoalId),
          child: const Text('Link'),
        ),
      ],
    );
  }
}
