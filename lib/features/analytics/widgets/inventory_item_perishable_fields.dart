import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Expiry-date picker + serial-number input for perishables/high-value
/// parts (Issue #438).
class InventoryItemPerishableFields extends StatelessWidget {
  final DateTime? expiryDate;
  final VoidCallback onPickExpiryDate;
  final TextEditingController serialNumberController;

  const InventoryItemPerishableFields({
    super.key,
    required this.expiryDate,
    required this.onPickExpiryDate,
    required this.serialNumberController,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    final label = expiryDate == null
        ? 'Pick expiry date (optional)'
        : '${expiryDate!.year}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadButton.outline(
          onPressed: onPickExpiryDate,
          child: Text(label, style: TextStyle(color: fg)),
        ),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Serial number (optional)'),
            controller: serialNumberController),
      ],
    );
  }
}
