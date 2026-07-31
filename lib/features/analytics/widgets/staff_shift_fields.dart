import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The staff-name field plus start/end shift date-time pickers for a new
/// logged shift (Issue #379).
class StaffShiftFields extends StatelessWidget {
  final TextEditingController nameController;
  final DateTime? startTime;
  final DateTime? endTime;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;

  const StaffShiftFields({
    super.key,
    required this.nameController,
    required this.startTime,
    required this.endTime,
    required this.onPickStart,
    required this.onPickEnd,
  });

  String _label(DateTime? dt, String placeholder) => dt == null
      ? placeholder
      : '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} '
          '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Staff name'), controller: nameController),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickStart,
          child:
              Text(_label(startTime, 'Pick shift start'), style: TextStyle(color: fg)),
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickEnd,
          child: Text(_label(endTime, 'Pick shift end'), style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
