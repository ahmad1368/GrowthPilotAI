import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showMerchantBranchDialog] (Issue #400): owns
/// the text controllers, picked status, and reported date.
class MerchantBranchDialogContent extends StatefulWidget {
  const MerchantBranchDialogContent({super.key});

  @override
  State<MerchantBranchDialogContent> createState() =>
      _MerchantBranchDialogContentState();
}

class _MerchantBranchDialogContentState
    extends State<MerchantBranchDialogContent> {
  final _branchNameController = TextEditingController();
  final _salesTotalController = TextEditingController();
  BranchInventoryStatus _status = BranchInventoryStatus.healthy;
  DateTime? _reportedAt;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _reportedAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _reportedAt = picked);
  }

  void _submit() {
    final salesTotal = double.tryParse(_salesTotalController.text);
    if (_branchNameController.text.trim().isEmpty ||
        salesTotal == null ||
        salesTotal < 0 ||
        _reportedAt == null) {
      return;
    }
    Navigator.of(context).pop(MerchantBranchEntity(
      branchName: _branchNameController.text.trim(),
      salesTotal: salesTotal,
      dbInventoryStatus: _status.index,
      reportedAt: _reportedAt!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Branch Snapshot'),
      description: MerchantBranchFields(
        branchNameController: _branchNameController,
        salesTotalController: _salesTotalController,
        status: _status,
        onStatusChanged: (value) {
          if (value != null) setState(() => _status = value);
        },
        reportedAt: _reportedAt,
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
