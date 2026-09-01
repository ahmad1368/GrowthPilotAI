import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_entry_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showWasteEntryDialog] (Issue #377): owns the
/// text controllers and the selected reason.
class WasteEntryDialogContent extends StatefulWidget {
  const WasteEntryDialogContent({super.key});

  @override
  State<WasteEntryDialogContent> createState() => _WasteEntryDialogContentState();
}

class _WasteEntryDialogContentState extends State<WasteEntryDialogContent> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();
  WasteReason _reason = WasteReason.expiration;

  void _submit() {
    final value = double.tryParse(_valueController.text);
    if (_descriptionController.text.trim().isEmpty || value == null || value <= 0) return;
    Navigator.of(context).pop(WasteLogEntity(
      itemDescription: _descriptionController.text.trim(),
      estimatedValue: value,
      date: DateTime.now(),
    )..reason = _reason);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Waste Entry'),
      description: WasteEntryFields(
        descriptionController: _descriptionController,
        valueController: _valueController,
        reason: _reason,
        onReasonChanged: (r) => setState(() => _reason = r),
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
