import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Edit: Fine-tune the AI's wording" (Issue #228) — returns the edited
/// text via [Navigator.pop], or null if cancelled.
class RequirementEditDialog extends StatefulWidget {
  final String initialDescription;

  const RequirementEditDialog({super.key, required this.initialDescription});

  @override
  State<RequirementEditDialog> createState() => _RequirementEditDialogState();
}

class _RequirementEditDialogState extends State<RequirementEditDialog> {
  late final _controller = TextEditingController(text: widget.initialDescription);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit requirement'),
      content: ShadInput(controller: _controller),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
        ShadButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
