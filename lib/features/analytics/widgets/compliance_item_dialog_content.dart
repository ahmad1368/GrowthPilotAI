import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_item_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showComplianceItemDialog] (Issue #392): owns
/// the name controller and the picked expiry date.
class ComplianceItemDialogContent extends StatefulWidget {
  const ComplianceItemDialogContent({super.key});

  @override
  State<ComplianceItemDialogContent> createState() => _ComplianceItemDialogContentState();
}

class _ComplianceItemDialogContentState extends State<ComplianceItemDialogContent> {
  final _nameController = TextEditingController();
  DateTime? _expiryDate;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (picked != null) setState(() => _expiryDate = picked);
  }

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty || _expiryDate == null) return;
    Navigator.of(context)
        .pop(ComplianceItemEntity(name: name, expiryDate: _expiryDate!));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Add Compliance Item'),
      description: ComplianceItemFields(
        nameController: _nameController,
        expiryDate: _expiryDate,
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
