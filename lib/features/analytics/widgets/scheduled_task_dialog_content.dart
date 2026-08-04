import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/scheduled_task_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/scheduled_task_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showScheduledTaskDialog] (Issue #406).
class ScheduledTaskDialogContent extends StatefulWidget {
  const ScheduledTaskDialogContent({super.key});

  @override
  State<ScheduledTaskDialogContent> createState() =>
      _ScheduledTaskDialogContentState();
}

class _ScheduledTaskDialogContentState extends State<ScheduledTaskDialogContent> {
  final _taskNameController = TextEditingController();
  final _targetSegmentController = TextEditingController();
  final _intervalMinutesController = TextEditingController();

  void _submit() {
    final intervalMinutes = int.tryParse(_intervalMinutesController.text);
    if (_taskNameController.text.trim().isEmpty ||
        _targetSegmentController.text.trim().isEmpty ||
        intervalMinutes == null ||
        intervalMinutes <= 0) {
      return;
    }
    final now = DateTime.now();
    Navigator.of(context).pop(ScheduledTaskEntity(
      taskName: _taskNameController.text.trim(),
      targetSegment: _targetSegmentController.text.trim(),
      intervalMinutes: intervalMinutes,
      nextRunAt: now.add(Duration(minutes: intervalMinutes)),
      updatedAt: now,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Schedule Task'),
      description: ScheduledTaskFields(
        taskNameController: _taskNameController,
        targetSegmentController: _targetSegmentController,
        intervalMinutesController: _intervalMinutesController,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
