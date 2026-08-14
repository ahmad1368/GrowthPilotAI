import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The name field + expiry-date picker button for a new compliance item
/// (Issue #392).
class ComplianceItemFields extends StatelessWidget {
  final TextEditingController nameController;
  final DateTime? expiryDate;
  final VoidCallback onPickDate;

  const ComplianceItemFields({
    super.key,
    required this.nameController,
    required this.expiryDate,
    required this.onPickDate,
  });

  @override
  Widget build(BuildContext context) {
    final label = expiryDate == null
        ? 'Pick expiry date'
        : '${expiryDate!.year}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}';
    final fg = Theme.of(context).colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('License/permit name'), controller: nameController),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(label, style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
