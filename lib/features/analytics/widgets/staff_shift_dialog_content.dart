import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_shift_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showStaffShiftDialog] (Issue #379): owns the
/// name controller and picked start/end shift date-times.
class StaffShiftDialogContent extends StatefulWidget {
  const StaffShiftDialogContent({super.key});

  @override
  State<StaffShiftDialogContent> createState() =>
      _StaffShiftDialogContentState();
}

class _StaffShiftDialogContentState extends State<StaffShiftDialogContent> {
  final _nameController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;

  Future<DateTime?> _pick(DateTime initial) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) return null;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _pickStart() async {
    final picked = await _pick(_startTime ?? DateTime.now());
    if (picked != null) setState(() => _startTime = picked);
  }

  Future<void> _pickEnd() async {
    final picked = await _pick(_endTime ?? DateTime.now());
    if (picked != null) setState(() => _endTime = picked);
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty ||
        _startTime == null ||
        _endTime == null ||
        _endTime!.isBefore(_startTime!)) {
      return;
    }
    Navigator.of(context).pop(StaffShiftEntity(
      staffName: _nameController.text.trim(),
      startTime: _startTime!,
      endTime: _endTime!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Staff Shift'),
      description: StaffShiftFields(
        nameController: _nameController,
        startTime: _startTime,
        endTime: _endTime,
        onPickStart: _pickStart,
        onPickEnd: _pickEnd,
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
