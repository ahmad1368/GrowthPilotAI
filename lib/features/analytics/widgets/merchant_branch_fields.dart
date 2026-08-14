import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The branch name/sales/inventory-status fields plus reported-date
/// picker for a new logged branch snapshot (Issue #400).
class MerchantBranchFields extends StatelessWidget {
  final TextEditingController branchNameController;
  final TextEditingController salesTotalController;
  final BranchInventoryStatus status;
  final ValueChanged<BranchInventoryStatus?> onStatusChanged;
  final DateTime? reportedAt;
  final VoidCallback onPickDate;

  const MerchantBranchFields({
    super.key,
    required this.branchNameController,
    required this.salesTotalController,
    required this.status,
    required this.onStatusChanged,
    required this.reportedAt,
    required this.onPickDate,
  });

  String _label(DateTime? d, String placeholder) => d == null
      ? placeholder
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Branch name'),
            controller: branchNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Sales total (\$)'),
            controller: salesTotalController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadSelect<BranchInventoryStatus>(
          initialValue: status,
          options: BranchInventoryStatus.values
              .map((s) => ShadOption(value: s, child: Text(s.name)))
              .toList(),
          selectedOptionBuilder: (context, value) => Text(value.name),
          onChanged: onStatusChanged,
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(reportedAt, 'Pick reported date'),
              style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
