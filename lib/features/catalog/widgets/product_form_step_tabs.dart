import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The "1. Basic & Pricing" / "2. Media" step switcher (Issue #140)
/// — split out of [ProductFormView] to stay under the file line cap.
class ProductFormStepTabs extends StatelessWidget {
  final void Function(int) onStepChanged;
  const ProductFormStepTabs({super.key, required this.onStepChanged});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ShadButton.ghost(onPressed: () => onStepChanged(0), child: const Text('1. Basic & Pricing')),
      ShadButton.ghost(onPressed: () => onStepChanged(1), child: const Text('2. Media')),
    ]);
  }
}
