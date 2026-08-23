import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Message Editing" (Issue #317 feature #18) — a small sheet
/// pre-filled with the current body, rather than repurposing
/// [ChatInputBar] (which has no external prefill hook).
void showEditMessageSheet(
  BuildContext context, {
  required String currentBody,
  required void Function(String) onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) => Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
      ),
      child: _EditMessageForm(currentBody: currentBody, onSave: onSave),
    ),
  );
}

class _EditMessageForm extends StatefulWidget {
  final String currentBody;
  final void Function(String) onSave;

  const _EditMessageForm({required this.currentBody, required this.onSave});

  @override
  State<_EditMessageForm> createState() => _EditMessageFormState();
}

class _EditMessageFormState extends State<_EditMessageForm> {
  late final _controller = TextEditingController(text: widget.currentBody);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final text = _controller.text.trim();
    Navigator.of(context).pop();
    if (text.isNotEmpty) widget.onSave(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ShadInput(controller: _controller, placeholder: const Text('Edit message')),
      const SizedBox(height: 12),
      ShadButton(onPressed: _save, child: const Text('Save')),
    ]);
  }
}
