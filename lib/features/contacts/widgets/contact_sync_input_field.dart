import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Paste box for manually entering contact identifiers to sync
/// (Issue #541, acceptance criterion 2).
class ContactSyncInputField extends StatefulWidget {
  final void Function(String) onSync;
  const ContactSyncInputField({super.key, required this.onSync});

  @override
  State<ContactSyncInputField> createState() => _ContactSyncInputFieldState();
}

class _ContactSyncInputFieldState extends State<ContactSyncInputField> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextField(
        controller: _controller,
        maxLines: 3,
        style: const TextStyle(fontSize: 12),
        decoration: const InputDecoration(hintText: 'One phone or email per line...'),
      ),
      ShadButton.ghost(
          onPressed: () => widget.onSync(_controller.text), child: const Text('Find Friends')),
    ]);
  }
}
