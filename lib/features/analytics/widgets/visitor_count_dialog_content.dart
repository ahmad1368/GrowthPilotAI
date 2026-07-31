import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/visitor_count_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showVisitorCountDialog] (Issue #387): owns
/// the count controller and picked date.
class VisitorCountDialogContent extends StatefulWidget {
  const VisitorCountDialogContent({super.key});

  @override
  State<VisitorCountDialogContent> createState() =>
      _VisitorCountDialogContentState();
}

class _VisitorCountDialogContentState
    extends State<VisitorCountDialogContent> {
  final _countController = TextEditingController();
  DateTime? _date;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    final count = int.tryParse(_countController.text);
    if (count == null || count < 0 || _date == null) return;
    Navigator.of(context)
        .pop(VisitorCountEntity(visitorCount: count, date: _date!));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Visitor Count'),
      description: VisitorCountFields(
        countController: _countController,
        date: _date,
        onPickDate: _pickDate,
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
