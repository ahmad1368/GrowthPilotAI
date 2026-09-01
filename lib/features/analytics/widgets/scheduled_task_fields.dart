import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Task name, target segment, and interval fields for a new scheduled
/// task (Issue #406, acceptance criterion 2).
class ScheduledTaskFields extends StatelessWidget {
  final TextEditingController taskNameController;
  final TextEditingController targetSegmentController;
  final TextEditingController intervalMinutesController;

  const ScheduledTaskFields({
    super.key,
    required this.taskNameController,
    required this.targetSegmentController,
    required this.intervalMinutesController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Task name (e.g. Monthly newsletter)'),
            controller: taskNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Target merchant segment'),
            controller: targetSegmentController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Repeat every N minutes'),
            controller: intervalMinutesController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
