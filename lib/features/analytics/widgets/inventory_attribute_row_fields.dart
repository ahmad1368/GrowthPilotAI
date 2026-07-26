import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One key/value input pair for a custom inventory item attribute (Issue
/// #438), e.g. "Size" -> "M", with a remove button.
class InventoryAttributeRowFields extends StatelessWidget {
  final TextEditingController keyController;
  final TextEditingController valueController;
  final VoidCallback onRemove;

  const InventoryAttributeRowFields({
    super.key,
    required this.keyController,
    required this.valueController,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: ShadInput(placeholder: const Text('Attribute'), controller: keyController),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ShadInput(placeholder: const Text('Value'), controller: valueController),
          ),
          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.close, size: 16),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
