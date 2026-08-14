import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Floating bottom toolbar shown while the Inbox is in multi-select mode
/// (Issue #76): selection count, "Select All", "Cancel" and "Archive".
class SelectionToolbar extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onSelectAll;
  final VoidCallback onArchive;
  final VoidCallback onCancel;

  const SelectionToolbar({
    super.key,
    required this.selectedCount,
    required this.onSelectAll,
    required this.onArchive,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF18181B)
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text('$selectedCount selected'),
            const Spacer(),
            ShadButton.ghost(onPressed: onSelectAll, child: const Text('Select All')),
            const SizedBox(width: 8),
            ShadButton.ghost(onPressed: onCancel, child: const Text('Cancel')),
            const SizedBox(width: 8),
            ShadButton(onPressed: onArchive, child: const Text('Archive')),
          ],
        ),
      ),
    );
  }
}
