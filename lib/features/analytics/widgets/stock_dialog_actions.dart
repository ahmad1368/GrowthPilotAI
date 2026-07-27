import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Cancel/submit action row shared by the stock-movement and
/// stock-reservation dialogs (Issue #445).
class StockDialogActions extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final String submitLabel;

  const StockDialogActions(
      {super.key, required this.onCancel, required this.onSubmit, required this.submitLabel});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      ShadButton.outline(onPressed: onCancel, child: const Text('Cancel')),
      const SizedBox(width: 8),
      ShadButton(onPressed: onSubmit, child: Text(submitLabel)),
    ]);
  }
}
